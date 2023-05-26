Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3436471274B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243579AbjEZNOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbjEZNOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:14:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E852A12C;
        Fri, 26 May 2023 06:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685106872; x=1716642872;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TaKFmPvcaWxL63IETqF5z2dA8t53A2LsdWOk3sZfXkU=;
  b=eliijqDHfpkXIfz0x3Oi03fik49GAKI3iH2adKScOuGRXZ14xQq10nkW
   CPO3aSjUuNpSnHvBs6chMvyO7ASlaAdVq2Ku0hvaV0N47GhUq1opFseGt
   5sjTggGVFyvJ66iPwkxjInezVQUUeEDhRzKadYmR6SPGnYlQroDWCY6M5
   AZ9eeqNUn9BAppmHf3/5Ytdf3r88FG5KeM8QNpRhW30ldGRk+vgoBk+XW
   K781v3pHM3fJvfsHXg805cNuzxqOqtCwoaJlDSpktTcabw9U2RGt50JSK
   EJX3WSi2Sl47WEtpKMeFN/MBX6g88dMSNj2IZD+gQ3P+wtXP2m5b5c4QX
   w==;
X-IronPort-AV: E=Sophos;i="6.00,194,1681196400"; 
   d="asc'?scan'208";a="217467764"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2023 06:14:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 26 May 2023 06:14:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 26 May 2023 06:14:12 -0700
Date:   Fri, 26 May 2023 14:13:50 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Minda Chen <minda.chen@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v6 5/7] dt-bindings: usb: Add StarFive JH7110 USB
 controller
Message-ID: <20230526-grain-cubical-e0af96202007@wendy>
References: <20230518112750.57924-1-minda.chen@starfivetech.com>
 <20230518112750.57924-6-minda.chen@starfivetech.com>
 <20230525-shopper-handbrake-27fc06aede32@spud>
 <5124e6a8-8ca6-71a5-19d6-8c15e954c458@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Bn+39uGEqQUGUUq"
Content-Disposition: inline
In-Reply-To: <5124e6a8-8ca6-71a5-19d6-8c15e954c458@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2Bn+39uGEqQUGUUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 06:24:48PM +0800, Minda Chen wrote:

> >> +title: StarFive JH7110 wrapper module for the Cadence USBSS-DRD contr=
oller
> >=20
> > I think you told Krzysztof you'd rename this to "StarFive JH7110 Cadence
> > USBSS-DRD SoC controller"?
> >=20
> The previous title describe whole USB controller for previous dts node is
> merged. Now the dts node is split.=20
> "starfive,jh7110-usb" just contain starfive wrapper layer dts configurati=
on.

Okay, I must have misunderstood the conversation on the previous
version. Sorry about that.

> > Otherwise, it looks like all the stuff from him and Rob have been sorted
> > out, so other than $title this is
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


--2Bn+39uGEqQUGUUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHCwjgAKCRB4tDGHoIJi
0mgJAQClJBlPXs7N2vOvkTGSfZFOb6z47yAgyiaqavdIEp2UTQD9EB9gGDPr2W/F
lNVtNtC8iRhO7w0elIt9BCJHjRITMwc=
=AQaH
-----END PGP SIGNATURE-----

--2Bn+39uGEqQUGUUq--
