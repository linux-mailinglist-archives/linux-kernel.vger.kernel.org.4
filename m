Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B42867821C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjAWQsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjAWQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:48:08 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC729169
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:48:06 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id B24B760004;
        Mon, 23 Jan 2023 16:48:04 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        open list <linux-kernel@vger.kernel.org>,
        Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] pcmcia:sa11xx_base: Fix full name of the GPL
Date:   Mon, 23 Jan 2023 17:47:52 +0100
Message-ID: <40886758.5lCLt2Url2@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122183119.55801-1-didi.debian@cknow.org>
References: <20230122183119.55801-1-didi.debian@cknow.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3948724.lmpU4KXG6H";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3948724.lmpU4KXG6H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: [PATCH] pcmcia:sa11xx_base: Fix full name of the GPL
Date: Mon, 23 Jan 2023 17:47:52 +0100
Message-ID: <40886758.5lCLt2Url2@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <20230122183119.55801-1-didi.debian@cknow.org>
References: <20230122183119.55801-1-didi.debian@cknow.org>
MIME-Version: 1.0

On Sunday, 22 January 2023 19:31:17 CET Diederik de Haas wrote:
>      Alternatively, the contents of this file may be used under the
> -    terms of the GNU Public License version 2 (the "GPL"), in which
> -    case the provisions of the GPL are applicable instead of the
> +    terms of the GNU General Public License version 2 (the "GPL"), in
> +    which case the provisions of the GPL are applicable instead of the

Please disregard this patch.

I was wrong to initially see this as a spelling error and I now see that my 
change would actually change the license, which I can't do (afaik).

It might be seen as a reasonable assumption that the GNU *General* Public 
License was meant, when it comes to legal/license material, one should not do 
that. 
See https://lore.kernel.org/lkml/2281101.Yu7Ql3qPJb@prancing-pony/ for details

Apologies for the noise.

Diederik
--nextPart3948724.lmpU4KXG6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY866OAAKCRDXblvOeH7b
blXfAP467iLLFbM16oT9cYmeQA0TDVO05sIFacg4cS2GZamPkAD/ZBsjJ7JF2KA+
vfiRCuBjPvLwxZvFroiiZKegK22uRw0=
=jtZg
-----END PGP SIGNATURE-----

--nextPart3948724.lmpU4KXG6H--



