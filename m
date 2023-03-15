Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FBA6BC16B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjCOXfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjCOXei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:34:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE12A8802;
        Wed, 15 Mar 2023 16:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2881B81FA0;
        Wed, 15 Mar 2023 23:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCC6C433D2;
        Wed, 15 Mar 2023 23:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923163;
        bh=gF5goOqVH8EoriNrX5raLPajBYmBjYY2eLzEXq6bOSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dcpw6DqU6bfHPFUSXBOzdcUIo1R/uuDHbKcOjxmnPTUX0/4nSNkaKnYtYR1UzmSpu
         e5Bwkzrordjd7EF7v3HJLWNQbsei5s+vHE4cON3TqQzVnPEZtLyn65nLsK/jhlem6l
         n/JMISR6mxBefYdQYf4Emgr6HeuQHmdy0N6rruJ7KzEEb7CYfaArT3ptLxNBDrQUOr
         JD052O+CEDSNIJh+Kn525ABoSOyo7dgLlfWiXwOFuYYneiChuDCy8gQyLEzr10HBOG
         fdvGt84A0h/+Th+XD6yacYQF6tzjxW9TxqxbJttKY15yTqKP4sqxJZM+eNLud0AaNr
         NZl19HEfu7baw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robh+dt@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
Date:   Wed, 15 Mar 2023 16:35:15 -0700
Message-Id: <167892332562.4030021.15165173431141413003.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307153201.180626-1-manivannan.sadhasivam@linaro.org>
References: <20230307153201.180626-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2023 21:02:00 +0530, Manivannan Sadhasivam wrote:
> The UFS controller on SM8350 supports cache coherency, hence add the
> "dma-coherent" property to mark it as such.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8350: Mark UFS controller as cache coherent
      commit: e607b3c1fa0e1579951acd00f9559a77f97d0927
[2/2] arm64: dts: qcom: sm8450: Mark UFS controller as cache coherent
      commit: 8ba961d4339c5db0e69ff6627606fe1f34c838e5

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
