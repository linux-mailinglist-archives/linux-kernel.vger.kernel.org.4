Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1AE62060B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiKHB3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKHB2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD8D2D1EA;
        Mon,  7 Nov 2022 17:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 199F96137F;
        Tue,  8 Nov 2022 01:28:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613E5C433C1;
        Tue,  8 Nov 2022 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870891;
        bh=MjWgzZTvSUk8TgzqmYGrkXIelBKih+2xhBR6vIwJ3C4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KDc/D7BnGsA8FPoAVPKCqZUHSrudEbLuFhznl+OzZ/COKNLTeomjzqmsP6Da+lRhP
         YVD8mYXbNEooCMhgyTe4ing3qZzuFM5a44rq+K4eerSVInZtSapznbGztsfklHyCge
         8vG/5PJ7cfJ54MAGwQ2DoRG3W0nOOPyJk5D+R5YbFIHd6Yk5X8OwUzr3zhoOP38cXo
         +gSMwXx8djuoB0mbuXtpVT8AqTVP7MpnhOcdCRq1sTjzDuaqbrS7CzO7quQ3hi2gwO
         Imsp2u+s6mCkS8sxkBQIBAiD1LGqh6luEpxradjvUBM/FQwnleM+QJpzbsDrIRpGo0
         S/GyRIfJAPEWg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     robimarko@gmail.com, mturquette@baylibre.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        tdas@codeaurora.org, linux-clk@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/3] clk: qcom: ipq8074: convert to parent data
Date:   Mon,  7 Nov 2022 19:27:40 -0600
Message-Id: <166787084683.599230.14468289826380167527.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221030175703.1103224-1-robimarko@gmail.com>
References: <20221030175703.1103224-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Oct 2022 18:57:01 +0100, Robert Marko wrote:
> Convert the IPQ8074 GCC driver to use parent data instead of global
> name matching.
> 
> Utilize ARRAY_SIZE for num_parents instead of hardcoding the value.
> 
> 

Applied, thanks!

[3/3] arm64: dts: qcom: ipq8074: pass XO and sleep clocks to GCC
      commit: 3aa0b8cd957b3e7806004c2150c61c85a606821a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
