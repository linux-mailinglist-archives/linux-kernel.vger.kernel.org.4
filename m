Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250D6D4D74
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjDCQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjDCQW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:22:29 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031041FFE;
        Mon,  3 Apr 2023 09:22:28 -0700 (PDT)
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4Pqx4c1Qtvz9sVx;
        Mon,  3 Apr 2023 18:22:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680538944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IqsGAlOKDgMXPJVdU76RuqgAlnJFlh/BsAIGdRjS90w=;
        b=ed3eIAsMaw7HSDsIraOG/6swtIGagh0B7aDeFpe0V+pjj2REcr18/V4lnKXa7TK3kmCUIw
        lZnFECbfEN9ZMbC1TrV00ameGHAjiJJ5FSM5rxCKJ659mWsFHenvwExwsIVLBnzBnOsKZL
        oxQ6x8SD/m47IWQiMOcZpEQOMP1NAlvWZGP8I20A/JaCJ7zgPFlOASVo57uZZ2za1yWz5+
        4yazb8Ixs52uSotRPZba17we9dHvgNLRBT3bKuVNgr7rhuFldZ/8N4jMhH4je3GNmKxtns
        LcwANuEyTX7BOJUjrpHNg5UINsqMR/5WNZSKgjF21/M8fBvt2f5+O0l57xWNmw==
Message-ID: <744f2ddc80ba9d9216ecd90b97e08aa5bd5452cd.camel@dylanvanassche.be>
Subject: Re: [PATCH v4 4/6] dts: qcom: arm64: qcom: sdm845: use defines for
 VMIDs
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Mon, 03 Apr 2023 18:22:21 +0200
In-Reply-To: <bf7b5218-56ba-5525-fcb8-7be71b114a79@linaro.org>
References: <20230401173523.15244-1-me@dylanvanassche.be>
         <20230401173523.15244-5-me@dylanvanassche.be>
         <ea03bfb6-34c4-45e2-c179-74ecafad559f@linaro.org>
         <2d9d001f14036caf4f6d47448d4d2fdb0b188101.camel@dylanvanassche.be>
         <bf7b5218-56ba-5525-fcb8-7be71b114a79@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2023-04-03 at 17:47 +0200, Krzysztof Kozlowski wrote:
> On 03/04/2023 17:32, Dylan Van Assche wrote:
> > Hi Krzysztof,
> >=20
> > On Mon, 2023-04-03 at 11:20 +0200, Krzysztof Kozlowski wrote:
> > > On 01/04/2023 19:35, Dylan Van Assche wrote:
> > > > Use VMID defines for SLPI's FastRPC node in the Qualcomm SDM845
> > > > DTS
> > > > instead of hardcoded magic values.
> > > >=20
> > > > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > > > ---
> > > > =C2=A0arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
> > > > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > index 1f25a7f4e02b..dc4b553cbe2e 100644
> > > > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > > > @@ -13,6 +13,7 @@
> > > > =C2=A0#include <dt-bindings/clock/qcom,rpmh.h>
> > > > =C2=A0#include <dt-bindings/clock/qcom,videocc-sdm845.h>
> > > > =C2=A0#include <dt-bindings/dma/qcom-gpi.h>
> > > > +#include <dt-bindings/firmware/qcom,scm.h>
> > > > =C2=A0#include <dt-bindings/gpio/gpio.h>
> > > > =C2=A0#include <dt-bindings/interconnect/qcom,osm-l3.h>
> > > > =C2=A0#include <dt-bindings/interconnect/qcom,sdm845.h>
> > > > @@ -3372,7 +3373,8 @@ fastrpc {
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0qcom,glink-channels =3D
> > > > "fastrpcglink-apps-dsp";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0label =3D "sdsp";
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0qcom,non-secure-domain;
> > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0qcom,vmids =3D <0x3 0xF
> > > > 0x5
> > > > 0x6>;
> > >=20
> > > Didn't you just add it in previous patch? Don't add incorrect
> > > code
> > > which
> > > you immediately change.
> > >=20
> >=20
> > Both are similar, the code is in fact the same. I followed what
> > Konrad
> > suggested in v3 to make a patch on top:
>=20
> I don't understand. Device nodes are similar, but they are different?
> If
> you add a line in patch X and change it in patch X+1, then something
> is
> wrong. Isn't this the case here or these are different device nodes?
>=20

They are the same node.
In the original patch the values are hex values, but Konrad asked to
make a patch on top depending on the qcom scm header which has these
magic hex values with defines.
I can make the defines as default, no problem. Will do in v5.

Kind regards,
Dylan

>=20
> Best regards,
> Krzysztof
>=20

