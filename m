Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E685861E964
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKGDPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiKGDOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8E71261D;
        Sun,  6 Nov 2022 19:13:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FB8BB80D92;
        Mon,  7 Nov 2022 03:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049AC43141;
        Mon,  7 Nov 2022 03:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790794;
        bh=VuNnQKYThnBK9z3zO/CI43DuaPMKOazjjt6IfMOPodo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hz/30DQGV5kU11tcAWXMhersziNCnHe7E1B/iaDvOH7y6LIu6oc8FPFjVjGAg2Zk0
         X/0R1znhm5Zj/9O7RKxoZYt4J1g2uloTqh/6rpxWicKoEmp7EHyTI/W0D87j5nZUYt
         7K3g9ZydkWmsx2qJAD/IliM+aDIwRgB56pqyjWVqckhjDpa33WMiiYM/oSISZQPgfC
         KJVRK7ijhFIFTrg6IWqMi2DUI3vSKOCyehYmZIPaAdiBuxxKOJoaRX3md+Hi0bq4nK
         WrQtFMgZCn/o2ltoxFNTdSejakpWhQjT+519Ge9dagIeVmfX14QF6XBgsIYBSJJ/Cx
         V8+6ftS0EwxIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org,
        Rob Herring <robh+dt@kernel.org>, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org,
        lee@kernel.org, Andy Gross <agross@kernel.org>,
        neil.armstrong@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/5] arm: qcom: mdm9615: second round of bindings and DT fixes
Date:   Sun,  6 Nov 2022 21:12:31 -0600
Message-Id: <166779074263.500303.1566494509148180650.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
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

On Fri, 21 Oct 2022 17:27:52 +0200, Neil Armstrong wrote:
> This is a second round of bindings & DT fixes for the MDM9615 platform.
> 
> This second round focuses on less trivial changes like pinctrl & regulators bindings,
> the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
> add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.
> 
> Dependencies:
> - patch 1,3-4: None
> - patch 2: bindings dependency on 20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org
> 
> [...]

Applied, thanks!

[1/5] arm: dts: qcom: mdm9615: align pinctrl subnodes with dt-schema bindings
      commit: fadae8fe73c6b30f759189209c24746a1dae7b1a
[2/5] arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq node names and probe-reset property
      commit: c7e34943d909f1a7872603d834347b478466cb09
[5/5] arm: dts: qcom-msm8660: align RPM regulators node name with bindings
      commit: 85055a1eecc17f38d92b36f6b774bb37a1cc7a53

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
