Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCED70E625
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238331AbjEWT6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEWT6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:58:54 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2C9119;
        Tue, 23 May 2023 12:58:52 -0700 (PDT)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id C838220008;
        Tue, 23 May 2023 19:58:47 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        p.zabel@pengutronix.de, mchehab@kernel.org,
        m.szyprowski@samsung.com, m.tretter@pengutronix.de,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        regressions@lists.linux.dev
Subject: Re: [PATCH] media: verisilicon: Additional fix for the crash when opening the
 driver
Date:   Tue, 23 May 2023 21:58:38 +0200
Message-ID: <3187393.mvXUDI8C0e@bagend>
Organization: Connecting Knowledge
In-Reply-To: <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
References: <20230523162515.993862-1-benjamin.gaignard@collabora.com>
 <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12717958.O9o76ZdvQC";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart12717958.O9o76ZdvQC
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Date: Tue, 23 May 2023 21:58:38 +0200
Message-ID: <3187393.mvXUDI8C0e@bagend>
Organization: Connecting Knowledge
In-Reply-To: <c034db29-b664-793d-35e0-406fdfe2b145@collabora.com>
MIME-Version: 1.0

On Tuesday, 23 May 2023 18:36:09 CEST Benjamin Gaignard wrote:
> Diederik, Marek, Michael,
> I have tested this patch on my boards and I see no regressions on
> decoder part and no more crash when probing the encoder.
> Could you test it on your side to confirm it is ok ?

With this patch I'm (also) not seeing the crash

Tested-by: Diederik de Haas <didi.debian@cknow.org>
--nextPart12717958.O9o76ZdvQC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZG0a7gAKCRDXblvOeH7b
bj0yAP9KYJLoy9vZ9roO3p8+OR3Ir5PuJaJnsd/GM2+SOpRTCQD/S7jY/xWKhHDL
fZBXe5F+v3qj2eg2F5MF2Hf6WE44MwE=
=7jRZ
-----END PGP SIGNATURE-----

--nextPart12717958.O9o76ZdvQC--



