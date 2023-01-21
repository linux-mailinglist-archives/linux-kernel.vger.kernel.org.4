Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A3676973
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 21:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAUUyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 15:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjAUUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 15:54:10 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A061BACF;
        Sat, 21 Jan 2023 12:54:08 -0800 (PST)
Received: (Authenticated sender: didi.debian@cknow.org)
        by mail.gandi.net (Postfix) with ESMTPSA id A1261240002;
        Sat, 21 Jan 2023 20:54:00 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Edward <edward.baker@intel.com>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
Date:   Sat, 21 Jan 2023 21:53:51 +0100
Message-ID: <3632669.kckeHSHuci@prancing-pony>
Organization: Connecting Knowledge
In-Reply-To: <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
References: <20230121184648.38487-1-didi.debian@cknow.org>
 <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3011192.r6BZ94o73H";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3011192.r6BZ94o73H
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Edward <edward.baker@intel.com>, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
Date: Sat, 21 Jan 2023 21:53:51 +0100
Message-ID: <3632669.kckeHSHuci@prancing-pony>
Organization: Connecting Knowledge
MIME-Version: 1.0

On Saturday, 21 January 2023 20:25:46 CET Ian Rogers wrote:
> The JSON files are generated from Intel information here:
> https://github.com/intel/perfmon/
> Fixing the spelling in the tree means that when we update the
> incorrect spelling will be generated again. Intel are looking at the
> matter, I've added Edward Baker to the e-mail. To make it clearer,
> could you separate the JSON fixes from the tool fixes?

Yes, I'll send a v2 patch with the JSON files excluded.
And I'll send a PR to the GH repo.

> Could you also add the mistakes found by this list to:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scri
> pts/spelling.txt which will mean the checkpatch.pl tool will flag the
> mistakes should regressions happen.

Ha! That's based on Debian's lintian tool (too) :-D
I'll make/send a separate patch to include the ones lintian found.
Lintian found several more, but I filtered the list I send to belong to `tools/
perf` hoping/assuming the To list wouldn't be so long (which didn't work out 
as well as I hoped ;-)).

> Beside those 2 suggestions, the corrections look great and thank you
> for taking the time to do this.

Cool :-)

Cheers,
  Diederik
--nextPart3011192.r6BZ94o73H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCY8xQ3wAKCRDXblvOeH7b
btaFAP0aytxwzb1318rBtyA4fWX3O+MuUiW9DjObjWT1iTj5QgD+ItsnE9DSLTBH
TVIP87d6fJOpqWWuOnip2nxC2ZOOdQM=
=IdbN
-----END PGP SIGNATURE-----

--nextPart3011192.r6BZ94o73H--



