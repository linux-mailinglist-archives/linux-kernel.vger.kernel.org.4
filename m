Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9019A729CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbjFIOUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjFIOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:20:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3623C30E5;
        Fri,  9 Jun 2023 07:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686320442; x=1717856442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KygAYWp1IXX26i2WNOBztQci6E+XF/eMw6ckvbNgMvI=;
  b=2U92q9bvDq95qy7nAxFjNZ7dxHug/C+EfJvDhGLYOWT984S/vCDy3v7L
   fGjEYbZFr+9VWQFhfy8FJ2PIInNpVB5ozTrDDMoP96IT4XHSiS+AOFNKK
   77UoqHaz4B+9CVQ8szNCzR8Cwf6cR2IzMFUvskxwGvyG+tHnr5YG1QdMA
   AC2k5nRWfSiSpk8/5VsudJLoy2sZutCGuRYqpgpzld61katNvr4GFXcqq
   42pBbFZWsDYEO9dgtT7oj0KBUXYix3ZmHESgo5cy9I4q+ZHTxpixWuc4r
   QCwX735k/jRTfPiSOer6Ngy2kQ7protQJWo2PFb+U2oYOZy+KDI6p+8QA
   A==;
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="asc'?scan'208";a="156290892"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2023 07:20:40 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 9 Jun 2023 07:20:36 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 9 Jun 2023 07:20:33 -0700
Date:   Fri, 9 Jun 2023 15:20:09 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksii <oleksii.kurochko@gmail.com>,
        Anup Patel <apatel@ventanamicro.com>, <qemu-riscv@nongnu.org>,
        <u-boot@lists.denx.de>, Andrew Jones <ajones@ventanamicro.com>,
        <palmer@dabbelt.com>, Atish Patra <atishp@atishpatra.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Rick Chen <rick@andestech.com>, <linux-kernel@vger.kernel.org>,
        Leo <ycliang@andestech.com>
Subject: Re: [PATCH v2] dt-bindings: riscv: deprecate riscv,isa
Message-ID: <20230609-glamour-immovable-4211c564745d@wendy>
References: <20230608-sitting-bath-31eddc03c5a5@spud>
 <168624654839.3085745.9088493205796442132.robh@kernel.org>
 <20230608-unlucky-carpenter-b3a95f269712@spud>
 <CAL_JsqK8pr5itTr8xTOf=h7zOan6giGsQcwQ-zUCbjtpUsosfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NHIeqlNPMBycrKLW"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK8pr5itTr8xTOf=h7zOan6giGsQcwQ-zUCbjtpUsosfw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--NHIeqlNPMBycrKLW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 09, 2023 at 08:03:44AM -0600, Rob Herring wrote:

> Nope, vendor prefixes don't go in node names. That's not explicit
> anywhere, but goes against using generic node names.

Yeah, that makes sense.

> Also, note that looking at the DT spec, there's already prior art here
> with PPC. See "power-isa-*". Though that appears in .dts files, but no
> kernel code. Maybe you already saw that as your v1 is similar. There's
> not really much advantage to align with it, but also not much reason
> to deviate.

I went back and forth on riscv-isa- versus riscv,isa-, picking the , for
consistency with other properties in the file. I thought that doing it
like power would be frowned upon & that it might've been done like that
for historic reasons, especially given existing properties we have for
riscv ISA related things are vendor properties w/ the comma.

I don't have strong feelings either way though, so if you say s/,/-/
then that's good by me!

Cheers,
Conor.

--NHIeqlNPMBycrKLW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIM1GAAKCRB4tDGHoIJi
0iJ5AQC4YXI2egYa7v+UQPBEhR84/skUnWg8zWRti453CRoG9gEAs/ydmwxka2yf
TYI7LPHSIav0274f4+OcOXgyL+YNXAc=
=XW8B
-----END PGP SIGNATURE-----

--NHIeqlNPMBycrKLW--
