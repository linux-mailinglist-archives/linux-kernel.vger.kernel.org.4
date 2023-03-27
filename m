Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5FE6CA2A5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjC0Lj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjC0Ljz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:39:55 -0400
X-Greylist: delayed 163 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Mar 2023 04:39:53 PDT
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90AE119B6;
        Mon, 27 Mar 2023 04:39:53 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PlW7p05Hrz9sSs;
        Mon, 27 Mar 2023 13:39:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1679917190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7i/Qow4cXnooN4Gkoul4put24Qoc7GrPoB5sg4AHbF0=;
        b=c6q4yhU48RRNVJqmQKpxN5HK3aVpV38dfBiYy5LMgNrTE8g1zhPQMl5aPtqBQeBidBuI4w
        plu2OzwKnFXBGVBeDd2Uvaf31Us5dJtFbTYCxudjDAvoO0mmHAa6aP6RfBwbduooRRFWvR
        7sR0+/E9CC6sZJ3KiSumZU/bflxRt2athisj9CICj9SgyOzajlfH62ET2SbOusJk4fDdAq
        OMzvvOA3rStZZOkoOJ93p1yI2HPXQ19cKpjeIVPwPpObVwUIeCseAOWwZz1IdJUZZlVxHB
        1H50o87ZYxYurN5niMWP5mHEh8Xd1Yq8Da4kynoRTsY0eL8oteNjalM2xLFmiQ==
Message-ID: <fe83e6f62d802109024f6203cf0d50c1ef348da1.camel@dylanvanassche.be>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: qcom: adsp: add
 qcom,sdm845-slpi-pas compatible
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Date:   Mon, 27 Mar 2023 13:39:47 +0200
In-Reply-To: <8ab9d0c3-89f7-90f3-58d6-d2994d372518@linaro.org>
References: <20230325132117.19733-1-me@dylanvanassche.be>
         <20230325132117.19733-2-me@dylanvanassche.be>
         <8ab9d0c3-89f7-90f3-58d6-d2994d372518@linaro.org>
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

On Sun, 2023-03-26 at 10:53 +0200, Krzysztof Kozlowski wrote:
> On 25/03/2023 14:21, Dylan Van Assche wrote:
> > SLPI DSP remoteproc on DSP is defined by the 'qcom,sdm845-slpi-pas'
> > compatible in the qcom_q6v5_pas driver. Add this compatible to the
> > devicetree bindings.
> >=20
> > Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> > ---
> > =C2=A0Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml | 3
> > +++
> > =C2=A01 file changed, 3 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > index 643ee787a81f..175be01ecd1c 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,adsp.yaml
> > @@ -26,6 +26,7 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,sdm660-adsp-pas
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,sdm845-adsp-pas
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,sdm845-cdsp-pas
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - qcom,sdm845-slpi-pas
> > =C2=A0
> > =C2=A0=C2=A0 reg:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > @@ -63,6 +64,7 @@ allOf:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - qcom,msm8998-adsp-pas
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - qcom,sdm845-adsp-pas
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - qcom,sdm845-cdsp-pas
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - qcom,sdm845-slpi-pas
> > =C2=A0=C2=A0=C2=A0=C2=A0 then:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > @@ -104,6 +106,7 @@ allOf:
>=20
>=20
> You miss also if:then: for power-domains.

I am not sure what to put for the power-domains, newer remoteprocs from
SM8150/SM8250/SM8350 etc. are not in this binding either.

Could you elaborate a bit here? Thanks!

Kind regards,
Dylan Van Assche

>=20
> Best regards,
> Krzysztof
>=20

