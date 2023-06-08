Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2FB727BFF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235657AbjFHJ4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjFHJ42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:56:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95D1E62;
        Thu,  8 Jun 2023 02:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686218188; x=1717754188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9lVx5Zi3oCwaUupShJGi/GS98sT22bCZFZU367TMAOA=;
  b=eEOXJvAxLbaZsO3ST6aXoUV0h1ZekbuO108F/i2uLxbPGiO4ZDrcqB+e
   W6CDcXQdvCdm7ArUcjPTqaD0qK1i/pHMptezyqJGNB2EgTxZEQ5t9LDSJ
   JLPq6WeY7tZ30SsK8fMdH5YzWtnE4ZsmGzjsX7htQyVwoXA3hQCXZakie
   1BTLy84J1YPEPanW3b9qKTrydgqqoI1HrgTdNzCQ+5c1/9EJCKlLbDOIj
   JbPET4KWBzoc9AhR0Y3xd5v/7BU6KveID+TbCIR3nknrFod1mGAi2n+kg
   3W8ynibtb8hpYZ2xV+BSGLGcgJjH46jErMEDoAz3yjkXKqRJZcKHMQdxj
   A==;
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="asc'?scan'208";a="215168914"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2023 02:56:27 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 8 Jun 2023 02:56:16 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 8 Jun 2023 02:56:15 -0700
Date:   Thu, 8 Jun 2023 10:55:51 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <linux-media@vger.kernel.org>, Conor Dooley <conor@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: Assign Shawn Tu's sensor drivers to
 myself
Message-ID: <20230608-blaspheme-goofball-8a11ac2c7118@wendy>
References: <20230608094257.4054914-1-sakari.ailus@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LBQ8WcS6L8fUGHPQ"
Content-Disposition: inline
In-Reply-To: <20230608094257.4054914-1-sakari.ailus@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--LBQ8WcS6L8fUGHPQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 08, 2023 at 12:42:57PM +0300, Sakari Ailus wrote:
> Shawn Tu's e-mail address is bouncing and he hasn't told he has a new one:
>=20
>    shawnx.tu@intel.com
>    Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound;
>    Recipient not found by SMTP address lookup'
>=20
> Assign the sensor drivers Shawn maintained to myself.

Sweet, much better than orphaning stuff, thanks!

> Reported-by: Conor Dooley <conor@kernel.org>

Not really important for a reported-by, but if someone gets the chance
while applying could please you do a
s/conor@kernel.org/conor.dooley@microchip.com/
Doesn't really matter if that isn't done though since it is just a
reported-by, so nw if not.

Cheers,
Conor.

--LBQ8WcS6L8fUGHPQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIGlpgAKCRB4tDGHoIJi
0oV0AP93H3LbPe3GoZ2cI9NH3MR/RVWjEH93ojclTb6QV/CxowD/YtO3Pg45M9b5
OxwDSRMm6ZFEjDlrw7R1/2p+nLU6Hg0=
=Zxil
-----END PGP SIGNATURE-----

--LBQ8WcS6L8fUGHPQ--
