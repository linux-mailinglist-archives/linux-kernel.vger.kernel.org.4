Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61A167FB32
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 22:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjA1Vnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 16:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjA1Vnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 16:43:49 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109A824C92;
        Sat, 28 Jan 2023 13:43:44 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 20CD0CC3A1;
        Sat, 28 Jan 2023 21:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1674942192; bh=9iikV1aWGTt9Mh+BoQkZ8MLRghcUR/xHdzBYyKknK3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=r96VFzjFyxTrWOeQl4TIxsKCSjynicL2byqQrIH88j+TgGhVbK816BGns0NFYSEQO
         qeRuRa0gMl/ajJTLjOcQN3KJThbStbuo+iXglXwfYdScWPjEKvxOJllGCPoy45XOe+
         hScL9sejbf1340Sj3lTGhffxi7RAn3+7N2zBlDoM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Stefan Hansson <newbyte@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        matti.lehtimaki@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: arm: qcom: Add MSM8926 and Samsung Galaxy Tab 4
 10.1 LTE
Date:   Sat, 28 Jan 2023 22:43:11 +0100
Message-ID: <1938307.usQuhbGJ8B@g550jk>
In-Reply-To: <05a6f073-7002-0156-1225-cd838e482307@linaro.org>
References: <20230122144749.87597-1-newbyte@postmarketos.org>
 <7c69e654-fe57-ad5c-9b41-15aaeaa73102@postmarketos.org>
 <05a6f073-7002-0156-1225-cd838e482307@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FROM_SUSPICIOUS_NTLD,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 23. J=E4nner 2023 19:08:03 CET Krzysztof Kozlowski wrote:
> On 23/01/2023 18:41, Stefan Hansson wrote:
> >>> 2. You base on other SoC but you do not include its compatibles. Why?=
 Is
> >>> it intended? None of the properties applicable to other SoC will match
> >>> here, thus I actually wonder if you run dtbs_check...
> >=20
> > Sorry, I forgot about running dtbs_check. However, I'm not sure I
> > understand the question. What do you mean by that I don't include its
> > compatibles?
>=20
> I understood you include the msm8226.dtsi which is a different SoC. If
> you include it, you get all of its content. We do it only for compatible
> devices, but your device does not indicate compatibility with msm8226.

Hi Krzysztof,

the way the earlier Qualcomm SoCs work, especially regarding naming scheme =
is=20
the following.

There's for example the msm8x74 family which includes msm8974, msm8674,=20
msm8274, and the a bit differently named apq8074 where the significant=20
different are the RF capabilities, I think with those only 8974 had LTE, 86=
74=20
and 8274 only 3G but different band support, and the apq8074 has no mobile=
=20
radio.

The same exists for sure also for 8x16 and 8x26, probably a bunch of other=
=20
SoCs as well.

So from software side (apart from modem firmware of course) it can be treat=
ed=20
in practise as the same SoC so that's why we included the dtsi in this case=
 in=20
msm8226 but also msm8926 and apq8026.

But the compatible on board-level is in practise (to my knowledge) not real=
ly=20
used for anything important other than having a nice string in the dts file=
=2E I=20
know some software uses compatible from user space but there for=20
differentiating between different devices and ignoring the SoC compatibles.

But while they are software-compatible for the most part, they *are* distin=
ct=20
SoCs with different capabilities and I just don't see the point in trying t=
o=20
establish some kinds of relationships between different SoCs that are somew=
hat=20
or very similar (msm8226 and msm8974 also share many components but are=20
obviously different SoCs).

And also e.g. (nearly) all apq* dts files we already have in mainline only=
=20
have apq compatible and not the corresponding msm* compatible. And I think=
=20
that's totally legitimate.

Regards
Luca

>=20
> > I ran `$ make dtbs_check DT_SCHEMA_FILES=3Dqcom.yaml` locally just now,
> > and it only gave me errors from the qcom-msm8974pro-oneplus-bacon dtb.
> > Maybe I'm running it wrong?
>=20
> No clue, I cannot test because your patches do not apply cleanly.
>=20
> Best regards,
> Krzysztof




