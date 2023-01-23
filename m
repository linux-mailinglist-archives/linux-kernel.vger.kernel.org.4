Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341C8677BCE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjAWMyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjAWMyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:54:07 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6093E23C43
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 04:53:55 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id AF2B7FF804;
        Mon, 23 Jan 2023 12:53:52 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 13:53:51 +0100
Message-ID: <18246331.B5QXJUBsVf@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122191047.58769-1-didi.debian@cknow.org>
References: <20230122191047.58769-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14116726.01SpmRQWAs";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart14116726.01SpmRQWAs
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Fix full name of the GPL
Date: Mon, 23 Jan 2023 13:53:51 +0100
Message-ID: <18246331.B5QXJUBsVf@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122191047.58769-1-didi.debian@cknow.org>
References: <20230122191047.58769-1-didi.debian@cknow.org>
MIME-Version: 1.0

On Sunday, 22 January 2023 20:10:47 CET Diederik de Haas wrote:
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>  drivers/staging/wlan-ng/hfa384x.h          | 4 ++--
>  ...
>  drivers/staging/wlan-ng/prism2sta.c        | 4 ++--
>  21 files changed, 42 insertions(+), 42 deletions(-)

Please disregard this patch.
Next to 'style' issues, I now consider my initial view of the issue as a 
spelling error, incorrect. I would be changing the license and IANAL. I'm also 
not the copyright holder which I believe is needed to change the license.

Apologies for the noise.
--nextPart14116726.01SpmRQWAs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY86DXwAKCRDXblvOeH7b
brraAQCIOPwlTSoqolrKKXtf0E+9+a6QTOvMNXcguwRS1aS2PAD/W/YdL4NpdoHA
YhwkNiGoYpYZmZMmGDllFZAjaiaXogc=
=aVxP
-----END PGP SIGNATURE-----

--nextPart14116726.01SpmRQWAs--



