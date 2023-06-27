Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED073F59E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjF0H0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjF0H0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:26:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F32950;
        Tue, 27 Jun 2023 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687850736; x=1719386736;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xCt5P1Z0qnjM3jC6ioipHyN0GAsEKKE+YW2j5M5Y1fQ=;
  b=McaPlZJx5s8An163aft1FFpNKOXmZcpgp4cWQ+yGvXyhiMVyxOjOJbIQ
   ZaqsvudPjCi6SqZcdSKesXBy8UwIvzxwhnCEL/hDqN8L/cvNUk5ee1v7E
   T/9ajepmhGz1mCb7w9qf556bTkQqlzJQBLWaWEnIKQQKVj6kG2w27+vab
   uv+3iqDHf1z63+/gX4wtASsR73fIdfddTtDu3QD2up2eZdSBwmVXGFIhw
   aNhRCJCLdbwuXBvTe50qTQ8ywcfjm+W2UPrxjMOXmSGdhYZv/3kfHRUXy
   uvDNEf7SD3JgA1SwEhnmwRgIqC0dfqFCybwpRmPHVC+24X8kaIuMeI4jz
   w==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="asc'?scan'208";a="217800721"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2023 00:24:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 27 Jun 2023 00:23:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 27 Jun 2023 00:23:48 -0700
Date:   Tue, 27 Jun 2023 08:23:20 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lucas Tanure <tanure@linux.com>
Subject: Re: [PATCH 0/2] Baisc devicetree support for Amlogic T7
Message-ID: <20230627-unsure-uniformly-079cad2c26e6@wendy>
References: <20230626095223.721011-1-xianwei.zhao@amlogic.com>
 <20230626-viewless-marrow-17838c2172f6@wendy>
 <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="O2oh4OyqqOV39O13"
Content-Disposition: inline
In-Reply-To: <676db602-54d8-d6b0-274f-365e65a2102c@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--O2oh4OyqqOV39O13
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2023 at 02:13:34PM +0800, Xianwei Zhao wrote:
> Hi Conor,
>     Thanks for you reply.
> On 2023/6/26 18:02, Conor Dooley wrote:
>=20
>=20
> > [ EXTERNAL EMAIL ]
> >
> > Hey,
> >
> > On Mon, Jun 26, 2023 at 05:52:21PM +0800, Xianwei Zhao wrote:
> >> T7 is an advanced application processor designed for smart display.
> >>
> >> Add the new T7 SoC/board device tree bindings.
> >>
> >> Add basic support for the T7 based Amlogic AN400 board, which describes
> >> the following components: CPU, GIC, IRQ, Timer, UART. It's capable of
> >> booting up into the serial console.
> >
> > Lucas has already sent patches for the T7 SoC & is at v5:
> > https://lore.kernel.org/linux-devicetree/20230623081242.109131-1-tanure=
@linux.com/
> >
> > There's been a bit of discussion there, and there serial stuff in
> > particular is different in his series (it doesn't use always-on for
> > examples).
> > Could you please go and take a look at his series?
> >
> > Cheers,
> > Conor.
> >
> AN400 is the reference board designed by Amlogic, which is different from
> Khadas VIM4.

Yet you share the same dtsi, which he has got through several iterations
of before you arrived.

> And T7 serial is the same as S4, so I follow S4 serial.

Yeah, no. SoC specific compatible please.


--O2oh4OyqqOV39O13
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJqOaAAKCRB4tDGHoIJi
0iv7AP9iHb28BGoo1SFUjvKBfZyWwuJP5ySvXMR4mSMpiHCkfgD/e6idXs5Evq4s
kO+Q4o/Bdpx9rOrHrAWbC9LLfS3aSwg=
=f1Im
-----END PGP SIGNATURE-----

--O2oh4OyqqOV39O13--
