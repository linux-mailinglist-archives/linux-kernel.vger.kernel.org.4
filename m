Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62196D1C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjCaJ2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbjCaJ2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:28:23 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64721BE9;
        Fri, 31 Mar 2023 02:27:55 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Pnw0t57d7z9sSK;
        Fri, 31 Mar 2023 11:27:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1680254830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0JPDI2TzKDsYAYsqmb12Xw6KXyZvLsYgDnAR16C/v4=;
        b=oBZFOSuLpaOvcia79JysCIPWebpTEUeuo5X4xg3M4mZ3xaHyrJ6CJu0xBIkTp+g3resmVx
        AOgjZOPFbIk376BMGGdiTXLRLFPM4fY4ICHADKswURgoDNAr5BkQGw4atTkt6WRvjKjMla
        0u803kTmrK6+KvtXcDHiZh8p9+MErTzjMy1ujeS52Fda+zMO6li/AtmrB1qLmQXUMWoetS
        evHZUJuTz+lIRPg6z+rZAehf4CKaD1bd2P+IcNtK5vcLWsDXa+WO9xglsrk5OcX2P0TSqw
        /Q7oB0R/SSDAGf6896bKoRM0DoMat2+TzZnfONR29Hvi+F9MAksUiXfKVg2EOA==
Message-ID: <e95d969eefc57afcc1a1b3c64540f37fc561c5f2.camel@dylanvanassche.be>
Subject: Re: [PATCH v3 1/4] dts: arm64: qcom: sdm845: add SLPI remoteproc
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
Date:   Fri, 31 Mar 2023 11:27:08 +0200
In-Reply-To: <6cab9930-1222-e715-be1d-ffdc44713aa8@linaro.org>
References: <20230330165322.118279-1-me@dylanvanassche.be>
         <20230330165322.118279-2-me@dylanvanassche.be>
         <6cab9930-1222-e715-be1d-ffdc44713aa8@linaro.org>
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

Hi Krzysztof,

On Fri, 2023-03-31 at 11:05 +0200, Krzysztof Kozlowski wrote:
> On 30/03/2023 18:53, Dylan Van Assche wrote:
> > Add the SLPI remoteproc to the SDM845 Qualcomm SoC which is
> > responsible
> > for exposing the sensors connected to the SoC. The SLPI
> > communicates
> > over GLink edge 'dsps' and is similar to other DSPs e.g. ADSP or
> > CDSP.
> > This patch allows the SLPI to boot and expose itself over QRTR as
> > service 400.
> >=20
> > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > ---
> > =C2=A0arch/arm64/boot/dts/qcom/sdm845.dtsi | 36
> > ++++++++++++++++++++++++++++
> > =C2=A01 file changed, 36 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 2f32179c7d1b..3b547cb7aeb8 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -3311,6 +3311,42 @@ glink-edge {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
};
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0slpi_pas: remoteproc@5c00000 {
>=20
> This does not look like correct place. Are you sure you followed the
> order by unit address?
>=20
>=20

I think I misunderstood...=20
I sorted them alphabetically by name, but it has to be unit address.
Will fix in v4.

>=20
> Best regards,
> Krzysztof
>=20

Kind regards,
Dylan
