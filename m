Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EC65F97E8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 07:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbiJJFkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 01:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiJJFk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 01:40:27 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDF53027;
        Sun,  9 Oct 2022 22:40:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 908F7C01F; Mon, 10 Oct 2022 07:39:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665380356; bh=H3f6zoTlgCXWKuinDdyMvbb46LHLZXiKju7XvZ3MtXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=JmxoPmPPd0AtI0VH+O9x/OXkckFDch5vib6DTgzyPF9S1+rAJdotDTSG5rBrFRWgl
         cmQ8/K66lgouW6U+cMbHNgbWywk8mGpw8rAyNKA2uTGgK5LBQYEMXEsoH57CqlR9nY
         +fxdnDeRCQSjqykb9Ia5ctiHcpHB9hxhY36cWxjI+8D5I8zJyb2MTLyEa8hqV3f5/R
         Y02nPIUa4ePobbZuDYW0oXeyCIYRYWBx4m21pI2rIBXw8+KOxKJvdEJ42J7YPvDlRA
         lAvuS7L0augMrHT40GqKIM2PLVP2nnCAz0JzTtvpjlq851zCRdKv8vzrzSPF49ogRI
         aVCUlIO8S+Y7A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 8E529C009;
        Mon, 10 Oct 2022 07:39:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1665380355; bh=H3f6zoTlgCXWKuinDdyMvbb46LHLZXiKju7XvZ3MtXk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=tF8Wsw/sswfvgYgTTwi6kZquMBcnz1mfpURreyJgkrU6yV7/dzvTvLK5vMFByvuI+
         Hfgr4jpKPORH/XuofaikqIIYBVbelFwkjOaJGXA/2iE2lV9j5XjKF3bDU5BQgYhSJd
         JD3dR4/dffMDmdP9bcmJiM5vTi4JH1G0O3+WkUz1ZkN7OhF2V73Z3JVPpt+1pdJrTo
         Ij8HXR6Tv3pra6aQcZXeKgR2X3vFGeGPLYybNLnbvrdvNiEjOOODBir5mYZF8EPieW
         SWcDApBaWL02RfwUeTKgyBuYqzY7azSqJCv3V2dD/VUN6NekPtrDwdxsoghK+flTsm
         S+u1r95/JuvJw==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 0b55c371;
        Mon, 10 Oct 2022 05:39:09 +0000 (UTC)
Date:   Mon, 10 Oct 2022 14:38:54 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <Y0Ov7hSuWQJlYAdW@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP-5=fXgNTW1eXRZhz-s_AfP+v1Oyx1zdksm-Q0B4YVPAgjKxw@mail.gmail.com>
 <YsLOKEqzp0Syz/Rt@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri, Ian,

Jiri Olsa wrote on Mon, Jul 04, 2022 at 01:25:28PM +0200:
> > If you're ok with that I can resend this as three patches: my original
> > patch, a patch with your diff and test_event() keeping current
> > behaviour, and a last patch adding that last flag and testing 9p without
> > format check.
> > 
> > (and if you don't think it's worth checking probe existence same thing
> > but even simpler)
> 
> I have that patch split into 2 separated changes,
> I'll try to send it later today

It's been a while (I had totally forgotten), but I don't think I saw
this patch.

For reminder you've requested that I add some test for a tracepoint
starting with digits e.g. 9p:9p_client_res but there's nothing commonly
available to use there, so you added a way to only check without
checking if a backing tracepoint exist, but I see no trace of the update
you sent here:
https://lore.kernel.org/all/YsGduWiTvkM2/tHv@krava/

Should I take it, do the split you suggested and send it together with a
resend of my original patch and new test?


Ian Rogers wrote on Mon, Jul 04, 2022 at 02:39:05PM -0700:
> > diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
> > index 5b6e4b5249cf..4133d6950d29 100644
> > --- a/tools/perf/util/parse-events.l
> > +++ b/tools/perf/util/parse-events.l
> > @@ -211,7 +211,7 @@ bpf_source  [^,{}]+\.c[a-zA-Z0-9._]*
> >  num_dec                [0-9]+
> >  num_hex                0x[a-fA-F0-9]+
> >  num_raw_hex    [a-fA-F0-9]+
> > -name           [a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > +name           [a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> 
> Perhaps this would be cleaner as:
> name           [a-zA-Z0-9_*?\[\]!]+
> except that would allow a name to start with an exclamation. Would
> that be an issue?

Sorry for the lack of reply -- I have no opinion on this as long as we
can use digits.
I can't imagine any probe starting with . or !, but that does not seem
to create any ambiguity with the rest of the grammar that I can see
either so I think it'd be fine, but I'm not comfortable deciding.


Thanks,
--
Dominique
