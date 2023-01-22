Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD7676CE8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjAVMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjAVMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:37:28 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D765FC9
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:37:25 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id 58CA9E0003;
        Sun, 22 Jan 2023 12:37:20 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Edward <edward.baker@intel.com>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
Date:   Sun, 22 Jan 2023 13:37:11 +0100
Message-ID: <8858063.18A79QhPUa@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <3632669.kckeHSHuci@prancing-pony>
References: <20230121184648.38487-1-didi.debian@cknow.org>
 <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
 <3632669.kckeHSHuci@prancing-pony>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9559064.3StPvEHMl7";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart9559064.3StPvEHMl7
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Edward <edward.baker@intel.com>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
Date: Sun, 22 Jan 2023 13:37:11 +0100
Message-ID: <8858063.18A79QhPUa@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <3632669.kckeHSHuci@prancing-pony>
MIME-Version: 1.0

Hi Ian,

On Saturday, 21 January 2023 21:53:51 CET Diederik de Haas wrote:
> On Saturday, 21 January 2023 20:25:46 CET Ian Rogers wrote:
> > The JSON files are generated from Intel information here:
> > https://github.com/intel/perfmon/
> > Fixing the spelling in the tree means that when we update the
> > incorrect spelling will be generated again. Intel are looking at the
> > matter, I've added Edward Baker to the e-mail. To make it clearer,
> > could you separate the JSON fixes from the tool fixes?
> 
> Yes, I'll send a v2 patch with the JSON files excluded.
> And I'll send a PR to the GH repo.

I just did send v2 of the patch with the following command:
git send-email --annotate -v2 HEAD~1 --to-cmd=scripts/get_maintainer.pl

But that no longer included you(r email)*, so here's the link:
https://lore.kernel.org/lkml/20230122122034.48020-1-didi.debian@cknow.org/

The PR on GH is here: https://github.com/intel/perfmon/pull/44

*) Still need to figure out how to properly use `git send-email` as I find the 
separation of the email contents and then only subsequently and separately 
seeing the To/CC list rather inconvenient.
Guess I'll just use --to=/--cc= manually for now.

Cheers,
  Diederik


--nextPart9559064.3StPvEHMl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY80t9wAKCRDXblvOeH7b
bkUQAP4nTwQr0Ed3IVtAPibz/mZzrPMJ3D8sCflt9kShhB3XOwEAlBo9CpSgUFue
+cKv1BNPcMxIB0yAr6ri+0VK14iCEQo=
=p0nk
-----END PGP SIGNATURE-----

--nextPart9559064.3StPvEHMl7--



