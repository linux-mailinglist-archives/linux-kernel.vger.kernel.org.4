Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313247397E9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFVHMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjFVHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:12:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC02C1BD2;
        Thu, 22 Jun 2023 00:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687417949; x=1718953949;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iiKG2Nc97I/QEfTHupxvuEuFIeC9zZ8TZ7uChT3UV6k=;
  b=jkyJeMGFgTRI7m0N9dJRkaMcBNaz8vjIGLetzuEy5y+DFZ16csSa5z/8
   FM55JFcWbiYGEsRiWGS/Yb19TPZT38GDbUKPOW6eCXa45y1M186IAUFkZ
   s17wDzQD0ru1sfluImoB2eAHDE+59buwHcwH/0KgIQsvYAYFRjXbp+iW6
   ynqW2mcW11rCo6TKE30xYYNHPK/3XAs79dG2ZQNXijxHeKhwxHe55tOMq
   zT8PBn8pqN2GAlzGZBstW5Bhz0u68MFSPYtgkNBtsFCIu/RTgsSF6iGYX
   k/aI1gv7gs+lPqKv1LU+7I1YLc6zy9/cArnKWlv3N+cMfBORBUhJccaVe
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,262,1681196400"; 
   d="asc'?scan'208";a="231524607"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Jun 2023 00:12:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 22 Jun 2023 00:12:28 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 22 Jun 2023 00:12:26 -0700
Date:   Thu, 22 Jun 2023 08:11:59 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Lucas Tanure <tanure@linux.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: serial: amlogic,meson-uart: Add
 compatible string for T7
Message-ID: <20230622-hardhat-elitism-26f0d0df204f@wendy>
References: <20230621133215.109254-1-tanure@linux.com>
 <20230621133215.109254-3-tanure@linux.com>
 <20f25e98-d02e-f914-c4e7-72bb9ddb1ae5@linaro.org>
 <20230621-uncaring-impeding-15cfbe8e0e7c@spud>
 <CAJX_Q+342dx9S4C2C814uQgOj_QR3EBKhETH9eVZOm7PtzFAVQ@mail.gmail.com>
 <e4c993e1-8409-1ec0-c1b2-175603052e46@linaro.org>
 <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7wAwkGZijd5j48sc"
Content-Disposition: inline
In-Reply-To: <CAJX_Q+09WLqmnWwOL7QESEuDzwZvVVzbtg9Upd5j2LOAYs=vmA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7wAwkGZijd5j48sc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2023 at 07:43:31AM +0100, Lucas Tanure wrote:
> On Thu, Jun 22, 2023 at 7:05=E2=80=AFAM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> > On 22/06/2023 07:32, Lucas Tanure wrote:
> > > On Wed, Jun 21, 2023 at 7:12=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > >> On Wed, Jun 21, 2023 at 03:53:04PM +0200, Krzysztof Kozlowski wrote:
> > >>> On 21/06/2023 15:32, Lucas Tanure wrote:
> > >>>> Amlogic T7 SoCs uses the same UART controller as S4 SoCs and G12A.
> > >>>> There is no need for an extra compatible line in the driver, but
> > >>>> add T7 compatible line for documentation.
> > >>>>
> > >>>> Signed-off-by: Lucas Tanure <tanure@linux.com>
> > >>>> ---
> > >>>>  .../devicetree/bindings/serial/amlogic,meson-uart.yaml          |=
 2 ++
> > >>>>  1 file changed, 2 insertions(+)
> > >>>>
> > >>>> diff --git a/Documentation/devicetree/bindings/serial/amlogic,meso=
n-uart.yaml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.y=
aml
> > >>>> index 01ec45b3b406..860ab58d87b0 100644
> > >>>> --- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.=
yaml
> > >>>> +++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.=
yaml
> > >>>> @@ -33,6 +33,7 @@ properties:
> > >>>>                - amlogic,meson8b-uart
> > >>>>                - amlogic,meson-gx-uart
> > >>>>                - amlogic,meson-s4-uart
> > >>>> +              - amlogic,meson-t7-uart
> > >>>>            - const: amlogic,meson-ao-uart
> > >>>>        - description: Always-on power domain UART controller on G1=
2A SoCs
> > >>>>          items:
> > >>>> @@ -46,6 +47,7 @@ properties:
> > >>>>            - amlogic,meson8b-uart
> > >>>>            - amlogic,meson-gx-uart
> > >>>>            - amlogic,meson-s4-uart
> > >>>> +          - amlogic,meson-t7-uart
> > >>>
> > >>> It does not look like you tested the DTS against bindings. Please r=
un
> > >>> `make dtbs_check` (see
> > >>> Documentation/devicetree/bindings/writing-schema.rst or
> > >>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetr=
ee-sources-with-the-devicetree-schema/
> > >>> for instructions).
> > >>
> > >> Check back on the previous version, I should've posted an untested
> > >> version of what you need to add.
> > > I saw that, but adding a S4 doesn't make sense to me. And you didn't
> > > show the entire change, so I can't understand what you want there.
> >
> > For sure you need something which does not trigger errors. If you claim
> > adding S4 as fallback does not make sense, then why did you use it?
> > Sending a code which is clearly incorrect does not make sense.
> >
> Sorry, I think we are talking about different things. It does not make
> sense to me to add an S4 line in the documentation when it is already
> there. So I could not understand or make sense of the patch Conor sent
> in reply to my V2.

That is just how it works. You need to spell out exactly which
combinations are permitted. The current entry for s4 says that s4 is
only permitted in isolation.
Since you are adding "amlogic,meson-t7-uart", "amlogic,meson-s4-uart"
you need to explicitly allow that combination. You'll notice if you look
at the file that the gx uart appears more than once.

Given the g12a was the most recently added compatible, it might make
sense to follow the pattern that it had set, given the thing your
original patch copied the match data from was the g12a. That change to
the dt-binding would look like:
diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.ya=
ml b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
index 01ec45b3b406..eae11e87b88a 100644
--- a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml
@@ -50,6 +50,13 @@ properties:
         items:
           - const: amlogic,meson-g12a-uart
           - const: amlogic,meson-gx-uart
+      - description:
+          Everything-Else power domain UART controller on G12A compatible =
SoCs
+        items:
+          - enum:
+              - amlogic,meson-t7-uart
+          - const: amlogic,meson-g12a-uart
+          - const: amlogic,meson-gx-uart
=20
   reg:
     maxItems: 1

/I/ don't really care whether you do that, or do the s4 version of it,
but following the most recent pattern might make more sense. When I
suggested s4, it was because I only looked at the driver patch rather
than the code itself.

> Krzysztof, I will check again with dtbs_check and re-send.

Cheers,
Conor.

--7wAwkGZijd5j48sc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJP0OgAKCRB4tDGHoIJi
0q6WAP9XGs4Pi8Gamw+GyApCv+GY203fgy/Z6D7WVqAyiPyfAgD9FcOdHANKxIe9
0wdzlANzNI58TqJ+gy5bdFdmXmcuPAA=
=Fm11
-----END PGP SIGNATURE-----

--7wAwkGZijd5j48sc--
