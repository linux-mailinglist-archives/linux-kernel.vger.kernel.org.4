Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37C5616659
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKBPlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiKBPle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:41:34 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9413613D14;
        Wed,  2 Nov 2022 08:41:32 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B8B3CD040B;
        Wed,  2 Nov 2022 15:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1667403689; bh=RuqBpuToNfX9aQJo+jvDaUshgEWM4c65xLKpXxJn/mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CDEeUieBEObtTZuIQaD5aqKjljCUkORnQ+yZvViilc1GdF0MfwP/huvfyJB3PnrYG
         NFPBhDxMmyE2DOGUgok22Yu5wTISlMHL4t9xd54LA5Cn8WA1DCtEvlQ7CkAmKR5pqj
         RR3EWtCU6oE8LRWtciP18GSf1agZKQpZxFyEWSn4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org, neil.armstrong@linaro.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator: change node name
Date:   Wed, 02 Nov 2022 16:41:28 +0100
Message-ID: <3196097.aeNJFYEL58@g550jk>
In-Reply-To: <ea0fd9da-4fdc-9d9b-f3ea-e74fae6d3723@linaro.org>
References: <20221031173933.936147-1-luca@z3ntu.xyz> <20221031173933.936147-2-luca@z3ntu.xyz> <ea0fd9da-4fdc-9d9b-f3ea-e74fae6d3723@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mittwoch, 2. November 2022 11:38:29 CET Neil Armstrong wrote:
> Hi,
> 
> On 31/10/2022 18:39, Luca Weiss wrote:
> > usb-vbus-regulator is a better generic node name than dcdc to change the
> > example to match.
> 
> Subject is wrong, should be something like:
> dt-bindings: regulator: qcom,usb-vbus-regulator: update example node name

I've followed the prefix style of recent commits in
Documentation/devicetree/bindings/regulator/

475043fabe8c regulator: Fix qcom,spmi-regulator schema
b0de7fa70650 regulator: pca9450: Remove restrictions for regulator-name
4c7da3741804 regulator: Add missing type for 'regulator-microvolt-offset'
91de5eb17c10 regulator: pwm: Update Lee Jones' email address
044750573903 regulator: qcom,spmi-regulator: add PMP8074 PMIC
0b3bbd7646b0 regulator: qcom,spmi-regulator: Convert to dtschema
8cbb948a7cc2 regulator: dt-bindings: qcom,smd-rpm: Add PM8909
a9369fd316cf regulator: dt-bindings: Convert pwm-regulator to DT schema

Regards
Luca



