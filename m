Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F9970B615
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjEVHOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjEVHOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:14:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC90510FA;
        Mon, 22 May 2023 00:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1684739614; x=1716275614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w/k9h1UfGfI/AZPgaI1qAV5bL2MNw9A/V2b2Qrn5ntY=;
  b=vfWcnD9ikzuedszlEx7TnQeBUbCPkMU2onoZ44NcypcHftX6lLMHfJnn
   datwA8ljFsrDlOXA+blGvfAd7HcLTegkEDzEe3ry2kxVG3rX7w41ZvTch
   3YvRQ7g4YQguD7qECb4rXgCn7czyDdhAtSsgRtFJQbSL5s27yts+NsSJP
   f8ZYAxdT1p8n3MYFne8YrA448SeZu2trSaJlhnlhY2Ig47x9yUdpX7xa2
   y1bH/p050gTq/TN1MXGgyExtDg3hBAGKL2/cj/ti/aalyL4ydtDwKkt2f
   XD3EJP72OTplCzjSTGd9s8TpFNIgBJUqtdu8PwQxiZpyjXqfiATMqq9TZ
   g==;
X-IronPort-AV: E=Sophos;i="6.00,183,1681196400"; 
   d="asc'?scan'208";a="214867004"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 May 2023 00:13:30 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 22 May 2023 00:13:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 22 May 2023 00:13:26 -0700
Date:   Mon, 22 May 2023 08:13:04 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Samuel Holland <samuel@sholland.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v4 03/10] dt-bindings: serial: add documentation for
 Bouffalolab UART Driver
Message-ID: <20230522-cedar-undertow-a4f274ef1cec@wendy>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-4-jszhang@kernel.org>
 <b5869cb0-1eab-4ab7-6dd7-16b06f91d93f@sholland.org>
 <ZGngwijxAKRpzmh7@xhacker>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1eDfFFL/98DJ7Ge8"
Content-Disposition: inline
In-Reply-To: <ZGngwijxAKRpzmh7@xhacker>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1eDfFFL/98DJ7Ge8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 21, 2023 at 05:13:38PM +0800, Jisheng Zhang wrote:
> On Thu, May 18, 2023 at 10:00:50PM -0500, Samuel Holland wrote:
> > On 5/18/23 10:22, Jisheng Zhang wrote:

> > This is not complete. There are separate APB and module (baud) clocks,
> > as well as a peripheral reset line. If we are going to keep the binding
> > stable, these need to be described up front.
>=20
> IIUC, the only requirement is to keep the driver compatible with both
> new dts and old dts. clk tree and reset can be added latter. I have seen
> sevral such examples from other SoCs' mainline progress.

It is generally preferred to add bindings in as complete a state as
possible. The driver doesn't need to actually make use of all of the
properties though, and can add the other bits as if/when they are
required.

Cheers,
Conor.

--1eDfFFL/98DJ7Ge8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGsWAAAKCRB4tDGHoIJi
0tUZAP4xFzpnPXGNvSX7grsLiurDrx4Hcr8BrIW1/vGAaKftmgEAurntuZJHchju
rEhU8AQ0jC/jDWmfjG4A+v/JrI1IxQM=
=em4o
-----END PGP SIGNATURE-----

--1eDfFFL/98DJ7Ge8--
