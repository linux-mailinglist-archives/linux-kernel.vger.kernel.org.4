Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CD677C23
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 14:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbjAWNKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 08:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjAWNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 08:10:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B1D23847
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 05:10:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41E64CE1234
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 13:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07986C433EF;
        Mon, 23 Jan 2023 13:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674479436;
        bh=iqfP9C9AnurE8CKbGVd5s0AuBVEbugAiIekImrTo8fo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IAqNkansKiPdbbWWrB+kbHs0W0eotZT/4Ch4+Mqh2xXWZ9/3LZHYrmsG2rGarMQHJ
         NG4U3on9ZLUUJLEUGfwHoY6O6I7aZIvCwLoPOG7zBZNYEyczuMuJmZkIbrfJJcT/qO
         DVskmLZWNdNxXvUKj9PvCMMs36Oci6DCHKd+3wRARP8jUagpX5N6rePXzDCxsYNFhY
         Mc1/iUul8rVT3RLc2rvuikKIdlj88bV4tbpS8MOTc0uo6erNp+w10dKghVwnHgu0eO
         0CG/AzjZ7T6HgEEccwjozCSB24dUSNpO2hAxNo4OJSc4Yn4oOnsA8sLivx+Tj2hfFu
         2hzAt+KjSy7xA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFCEA405BE; Mon, 23 Jan 2023 10:10:33 -0300 (-03)
Date:   Mon, 23 Jan 2023 10:10:33 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Diederik de Haas <didi.debian@cknow.org>
Cc:     Edward <edward.baker@intel.com>, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools/perf: Various spelling fixes
Message-ID: <Y86HSc3YlwrE4f4B@kernel.org>
References: <20230121184648.38487-1-didi.debian@cknow.org>
 <CAP-5=fX1-3ZnXk8G2fB0q9F3MjjA+zWWm1LbuYGc5nL5v3bXYg@mail.gmail.com>
 <3632669.kckeHSHuci@prancing-pony>
 <8858063.18A79QhPUa@prancing-pony>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8858063.18A79QhPUa@prancing-pony>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 22, 2023 at 01:37:11PM +0100, Diederik de Haas escreveu:
> Hi Ian,
> 
> On Saturday, 21 January 2023 21:53:51 CET Diederik de Haas wrote:
> > On Saturday, 21 January 2023 20:25:46 CET Ian Rogers wrote:
> > > The JSON files are generated from Intel information here:
> > > https://github.com/intel/perfmon/
> > > Fixing the spelling in the tree means that when we update the
> > > incorrect spelling will be generated again. Intel are looking at the
> > > matter, I've added Edward Baker to the e-mail. To make it clearer,
> > > could you separate the JSON fixes from the tool fixes?
> > 
> > Yes, I'll send a v2 patch with the JSON files excluded.
> > And I'll send a PR to the GH repo.
> 
> I just did send v2 of the patch with the following command:
> git send-email --annotate -v2 HEAD~1 --to-cmd=scripts/get_maintainer.pl

I just applied it, thanks.

- Arnaldo
 
> But that no longer included you(r email)*, so here's the link:
> https://lore.kernel.org/lkml/20230122122034.48020-1-didi.debian@cknow.org/

 
> The PR on GH is here: https://github.com/intel/perfmon/pull/44
> 
> *) Still need to figure out how to properly use `git send-email` as I find the 
> separation of the email contents and then only subsequently and separately 
> seeing the To/CC list rather inconvenient.
> Guess I'll just use --to=/--cc= manually for now.
> 
> Cheers,
>   Diederik
