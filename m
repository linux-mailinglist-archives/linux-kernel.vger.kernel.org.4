Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019E570E251
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbjEWQoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237761AbjEWQoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:44:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71567196;
        Tue, 23 May 2023 09:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0465560EC0;
        Tue, 23 May 2023 16:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE951C433EF;
        Tue, 23 May 2023 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684860248;
        bh=N06Eu6OK78rr1ZOMhedZYvc3DjQZtjmDOFs9k7VPMhY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxonhLXBKBwPVvCUA6gVniy5pmwYkR8B2fHFmEebzLS88nJuzuR2Iph1LgWo6rYHU
         xNrI4lKworb8aRYAcOfS0u6cVzZyW9HF6GZOaJ2vCT9k4QAt/A9AYUluqw2s6QKzbE
         lX4VC2xeGrQJ549OLd6dZ5zCTzElAtn6W2FmvH1L9A8SeeffsT5UgCon4A/1BxxWCM
         Ty0EZLRVV9tac9OVl/Xp9kHP2qpjC2Z5fy1cJrLvNPjM+FIfMJxqdPEKjePoN5jItk
         F6pBbtojGBpNwkL5HTN2Ve0XleshbA3AJPgEH8Tik71N9de8DkSENnb38+9WfbSN9k
         zDYGr7ofJqqKw==
Date:   Tue, 23 May 2023 17:44:02 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: thermal: tsens: Add ipq9574
 compatible
Message-ID: <20230523-clergyman-reputably-21f69cd98797@spud>
References: <b7e749ff-f4f0-0e61-9aae-876db4278fbc@linaro.org>
 <20230516120426.GA1679@varda-linux.qualcomm.com>
 <1999753b-ceee-d66c-9a48-cbcbb8e6236e@linaro.org>
 <20230517055726.GA3165@varda-linux.qualcomm.com>
 <cfba78d7-e563-4544-00f3-0991b91eb1f3@linaro.org>
 <20230518054054.GA998@varda-linux.qualcomm.com>
 <fe1d81d2-52e6-7d2d-8d6c-ffdcbb8ccc89@linaro.org>
 <20230518090503.GA9173@varda-linux.qualcomm.com>
 <24b60ca3-b6b9-662f-03c8-df1536b52bc9@linaro.org>
 <20230523101903.GA31656@varda-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aCMJ73Cl1UZQpQ2E"
Content-Disposition: inline
In-Reply-To: <20230523101903.GA31656@varda-linux.qualcomm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aCMJ73Cl1UZQpQ2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2023 at 03:49:04PM +0530, Varadarajan Narayanan wrote:
> On Thu, May 18, 2023 at 01:06:49PM +0200, Krzysztof Kozlowski wrote:
> > On 18/05/2023 11:05, Varadarajan Narayanan wrote:
> > > On Thu, May 18, 2023 at 09:09:12AM +0200, Krzysztof Kozlowski wrote:
> > >> On 18/05/2023 07:40, Varadarajan Narayanan wrote:
> > >>> On Wed, May 17, 2023 at 09:00:49AM +0200, Krzysztof Kozlowski wrote:
> > >>>> On 17/05/2023 07:57, Varadarajan Narayanan wrote:

> > It's not true. The error you see is result because you removed something
> > you should not. I did not ask you to remove anything. So repeating -
> > "add new item". Adding is not "removal and adding". Adding is just "add=
ing".
>=20
> See below for the changes that were tried and the corresponding errors.
>=20
> (1) No lines removed
>=20
> 	@@ -66,6 +66,7 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens
>=20
> 	   reg:
> 	     items:
>=20
> 	dt_binding_check: No errors
>=20
> 	dtbs_check	:
> 		arch/arm64/boot/dts/qcom/ipq9574-rdp433.dtb: thermal-sensor@4a9000: com=
patible: 'oneOf' conditional failed, one must be fixed:
> 	        ['qcom,ipq9574-tsens', 'qcom,ipq8074-tsens'] is too long

Which I figure you understand makes sense.

> (2) No lines removed
>=20
> 	@@ -66,6 +66,8 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens
> 	+        - const: qcom,ipq8074-tsens
>=20
> 	   reg:
> 	     items:
>=20
> 	dt_binding_check: No errors
>=20
> 	dtbs_check	: Gives errors for all the DTS files that have tsens-v0_1, ts=
ens-v2, tsens-v1. Copy pasted a sample for each one of them
> 		arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dtb: /soc@0/thermal-sensor@4=
a9000: failed to match any schema with compatible: ['qcom,msm8916-tsens', '=
qcom,tsens-v0_1']
> 		arch/arm64/boot/dts/qcom/msm8953-xiaomi-tissot.dtb: /soc@0/thermal-sens=
or@4a9000: failed to match any schema with compatible: ['qcom,msm8953-tsens=
', 'qcom,tsens-v2']
> 		arch/arm64/boot/dts/qcom/msm8956-sony-xperia-loire-suzu.dtb: /soc@0/the=
rmal-sensor@4a9000: failed to match any schema with compatible: ['qcom,msm8=
956-tsens', 'qcom,tsens-v1']

I think you've missed an earlier error that points out the entire
binding is invalid.

> (3) No lines removed
> 	@@ -19,6 +19,7 @@
> 	 properties:
> 	   compatible:
> 	     oneOf:
> 	+      - const: qcom,ipq8074-tsens
> 	       - description: msm8960 TSENS based
> 		 items:
> 		   - enum:
> 	@@ -66,6 +67,8 @@
> 	       - description: v2 of TSENS with combined interrupt
> 		 enum:
> 		   - qcom,ipq8074-tsens
> 	+          - qcom,ipq9574-tsens
> 	+        - const: qcom,ipq8074-tsens
>=20
> 	   reg:
> 	     items:
>=20
> 	dt_binding_check: Same as above
>=20
> 	dtbs_check	: Same as above

Ditto here.

> (4) Change 8074 from enum to const
> 	@@ -19,6 +19,7 @@
> 	 properties:
> 	   compatible:
> 	     oneOf:
> 	+      - const: qcom,ipq8074-tsens
> 	       - description: msm8960 TSENS based
> 		 items:
> 		   - enum:
> 	@@ -64,8 +65,10 @@
> 		   - const: qcom,tsens-v2
>=20
> 	       - description: v2 of TSENS with combined interrupt
> 	-        enum:
> 	-          - qcom,ipq8074-tsens
> 	+        items:
> 	+          - enum:
> 	+              - qcom,ipq9574-tsens
> 	+          - const: qcom,ipq8074-tsens
>=20
> 	   reg:
> 	     items:
>=20
> 	dt_binding_check: No errors
>=20
> 	dtbs_check	: No errors
>=20
> But (4) doesn't seem acceptable. Any other alternative to resolve this?

It now has a "random" entry up at the top w/ no description, not
matching the existing style. Can you just fix that up & send a v(N+1)
so that the discussion can restart in a less confusing way? I am trying
to fill in for Krzysztof but I am struggling to follow the thread.

Thanks,
Conor.

--aCMJ73Cl1UZQpQ2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGztUgAKCRB4tDGHoIJi
0qdpAQCCsVo73rjFH+CdMwP4znZaebIHTbbkazo0j3Gfr7lNUQEA4/WZXHaoY+Me
8fElcfSD8GY/xR/uVRwv7KGZxWmlqQQ=
=u27Y
-----END PGP SIGNATURE-----

--aCMJ73Cl1UZQpQ2E--
