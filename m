Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F2710437
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237602AbjEYEvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjEYEu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A767B3;
        Wed, 24 May 2023 21:50:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B8C163798;
        Thu, 25 May 2023 04:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F765C433A1;
        Thu, 25 May 2023 04:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990257;
        bh=vLKoCdT5aSKffLJ8qjVP8oke7a+m02TATfV36+4JR5c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbV61zaI00rLZr8r38LGhaOA5FTQWIf3pDRYdbhTZd8UlGZaivOhJi+a8lZErsw1j
         gMPc0eBE1TBWWnkEynZmjRl3sBoSJcG/JV+UCaCf56GPBA/yLibl6eL7wAnze+GQZV
         bSJ31su2wGz+lzcqfEt5iqmp6Q7y4A58dUOxo5TnMq952roKPfECXqyT1q6CAqwi9/
         cmVgznlvsR2P/xsBeCc+yQAbl0bfg6q1wQ1xan/uXC0tZiZkx8x7oneR5lBP+gx0sU
         KRblafM2RAA+DY4ZoK2CleKRWAkXmKmp8YbOwQ2eTL3DcH7x2YWFz5s32Hwh2uo+QW
         vO5VkTN4OILUw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v3 1/4] arm64: dts: qcom: sa8155p-adp: Make compatible the first property
Date:   Wed, 24 May 2023 21:53:36 -0700
Message-Id: <168499048184.3998961.1091102608647335899.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230421205512.339850-1-ahalaney@redhat.com>
References: <20230421205512.339850-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 15:55:09 -0500, Andrew Halaney wrote:
> As stated at the below link in another review, compatible is always the
> first property.
> 
> Follow suit here to avoid copying incorrectly in the future.
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sa8155p-adp: Make compatible the first property
      commit: eee7369de0c3cca7aacab3874663d460fb7a5b06
[3/4] arm64: dts: qcom: sa8155p-adp: Remove unneeded rgmii_phy information
      commit: 0ff4f6a380214fcf85a5b5ad64ff481d9bd1dfc6
[4/4] arm64: dts: qcom: sa8155p-adp: Move mtl nodes into ethernet node
      commit: 93fe463652504bba298a68b56334729cdf92c0c3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
