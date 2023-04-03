Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9B6D4BF9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjDCPc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjDCPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:32:26 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63AB1BE1;
        Mon,  3 Apr 2023 08:32:24 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Pqvys1Crfz9sQh;
        Mon,  3 Apr 2023 17:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680535941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R40Rix/QmgERLDCtcuTTsrzPbEXoZNeuV8Sj3dITv3w=;
        b=SnMfsaQYEjQGTtwHiyel9wE0jWJzPmcxF/fEGDoRKO1szaY9G+b+13CZFKQUVkQVOcBUpY
        T1uQjzQDYn8nviqlduXWdkPJVUYu8ZUqKjt4TXsUPBtjlQqfcZp2mLyK4Nqpv3CaKridb4
        g5wPgNpJl5M5tUez+fiOMDaP3dhhA4IUfmFu5+17EaJu3HqiFQzB9I5wznFvSnW0w6pTZJ
        82aZU0F4+zUxI6WfohmmiMm9IoJjmmy7nLDG6MIH5u9qvl3Nw/so8IVzYpaZMEhVaOnTbQ
        AHZclSCpKsxrPOhLIvjPEdaDCa6DdsRyCu8Vy8MoJIMAvPQ+tGdjJas5NnWzVw==
Message-ID: <2d9d001f14036caf4f6d47448d4d2fdb0b188101.camel@dylanvanassche.be>
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
Date:   Mon, 03 Apr 2023 17:32:17 +0200
In-Reply-To: <ea03bfb6-34c4-45e2-c179-74ecafad559f@linaro.org>
References: <20230401173523.15244-1-me@dylanvanassche.be>
         <20230401173523.15244-5-me@dylanvanassche.be>
         <ea03bfb6-34c4-45e2-c179-74ecafad559f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4Pqvys1Crfz9sQh
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, 2023-04-03 at 11:20 +0200, Krzysztof Kozlowski wrote:
> On 01/04/2023 19:35, Dylan Van Assche wrote:
> > Use VMID defines for SLPI's FastRPC node in the Qualcomm SDM845 DTS
> > instead of hardcoded magic values.
> >=20
> > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > ---
> > =C2=A0arch/arm64/boot/dts/qcom/sdm845.dtsi | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 1f25a7f4e02b..dc4b553cbe2e 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -13,6 +13,7 @@
> > =C2=A0#include <dt-bindings/clock/qcom,rpmh.h>
> > =C2=A0#include <dt-bindings/clock/qcom,videocc-sdm845.h>
> > =C2=A0#include <dt-bindings/dma/qcom-gpi.h>
> > +#include <dt-bindings/firmware/qcom,scm.h>
> > =C2=A0#include <dt-bindings/gpio/gpio.h>
> > =C2=A0#include <dt-bindings/interconnect/qcom,osm-l3.h>
> > =C2=A0#include <dt-bindings/interconnect/qcom,sdm845.h>
> > @@ -3372,7 +3373,8 @@ fastrpc {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0qcom,glink-channels =3D
> > "fastrpcglink-apps-dsp";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0label =3D "sdsp";
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0qcom,non-secure-domain;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0qcom,vmids =3D <0x3 0xF 0x5
> > 0x6>;
>=20
> Didn't you just add it in previous patch? Don't add incorrect code
> which
> you immediately change.
>=20

Both are similar, the code is in fact the same. I followed what Konrad
suggested in v3 to make a patch on top:

> Please use the recently-introduced header and depend on (and
make a patch atop)

https://lore.kernel.org/linux-devicetree/20230330165322.118279-1-me@dylanva=
nassche.be/T/#mab3c3421157acb0a4811dad5bb62d7349a9d4008

I can squash this patch in the FastRPC node one, that would make it
disappear. Let me know what you prefer and I will do it in v5 :)

> Best regards,
> Krzysztof
>=20

Kind regards,
Dylan Van Assche
