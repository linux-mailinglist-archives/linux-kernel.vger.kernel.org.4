Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684667713D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAVRuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 12:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjAVRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 12:50:18 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E70D13D51
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 09:50:15 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 2BC9C40002;
        Sun, 22 Jan 2023 17:50:12 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] scripts/spelling.txt: add more spelling corrections
Date:   Sun, 22 Jan 2023 18:50:01 +0100
Message-ID: <2156966.lfXbyN6JY9@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
References: <20230122173256.52280-1-didi.debian@cknow.org>
 <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2803979.rY76GUrOam";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2803979.rY76GUrOam
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Cc: linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Date: Sun, 22 Jan 2023 18:50:01 +0100
Message-ID: <2156966.lfXbyN6JY9@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <f564c135-b03c-6673-d71e-369048b1f8b3@infradead.org>
MIME-Version: 1.0

On Sunday, 22 January 2023 18:45:37 CET Randy Dunlap wrote:
> > Current Debian lintian tool flagged several (more) spelling errors, so
> > add them so they can hopefully prevented in the future.
> > 
> > Signed-off-by: Diederik de Haas <didi.debian@cknow.org>

.. add them so they can hopefully *be* prevented in the future.

*facepalm*
--nextPart2803979.rY76GUrOam
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY813SQAKCRDXblvOeH7b
bmSTAP4jozJ94pUtueB7FatVw7W7WlcA/1W+quO7+WMiCRofaQEAkow6KmbNM73l
Lwl87M6PDGMr6XDqtklw3VgbC1SuNAE=
=GeQm
-----END PGP SIGNATURE-----

--nextPart2803979.rY76GUrOam--



