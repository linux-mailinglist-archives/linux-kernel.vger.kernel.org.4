Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F9E659B2A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235304AbiL3R4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3R43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:56:29 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1739BE1B;
        Fri, 30 Dec 2022 09:56:27 -0800 (PST)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0005.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::5])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id A8F7ECA59D;
        Fri, 30 Dec 2022 17:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1672422986; bh=9SMJto/BbTzXNOAp7b3wav53yOz7csIc23s0OeluJrY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=boxv0jwrk7qJI2n/2Jy8o2f/Cn625a6JYc+epwjAOLmqEGhmLoEGRDm0HUiL2IrDg
         JsHmGheKyUgGM5I5BEangD0dVHym0bjVZgtbGL0rmjGKcaJ3+kdN+7xboIStw9Ssqo
         S7pD/dLisvEb61oCRte/ht/LowiJs3YRwwQiVAPY=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,usb-vbus-regulator: change node
 name
Date:   Fri, 30 Dec 2022 18:56:24 +0100
Message-ID: <4449469.LvFx2qVVIh@g550jk>
In-Reply-To: <167235422463.130576.13068228295548630470.b4-ty@kernel.org>
References: <20221229191542.123367-1-luca@z3ntu.xyz>
 <167235422463.130576.13068228295548630470.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Donnerstag, 29. Dezember 2022 23:50:24 CET Mark Brown wrote:
> On Thu, 29 Dec 2022 20:15:43 +0100, luca@z3ntu.xyz wrote:
> > usb-vbus-regulator is a better generic node name than dcdc to change the
> > example to match.
> 
> Applied to
> 
>    broonie/regulator.git for-next
> 
> Thanks!
> 
> [1/1] regulator: dt-bindings: qcom,usb-vbus-regulator: change node name
>       commit: d13da2f4c81602fc22cdf2cb13b15283b260e0d5
> 

Thank you and sorry about the mess on the v2.

Regards
Luca

> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark




