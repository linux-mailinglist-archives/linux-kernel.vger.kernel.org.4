Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60B2B67B965
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235857AbjAYSci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 13:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjAYScg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 13:32:36 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AB410423
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:32:35 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id B2FFC920626
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:32:34 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 002AB9212E7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:32:33 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674671554; a=rsa-sha256;
        cv=none;
        b=BtDbI2R2XLd6eBw5G+IBNvb768fdQdkP1U5deNJT5N/PHVknUeePGej0IUuEWgo0PALBTK
        /02EIs5jNB8tpiCCO5wMSeLJxfestXiZXVwrfiIDXa1veUayNwhS4F80+MzdHAe8itf4gp
        jgSYeJLsSxhk21u09GlIu13JQ7xBQ3Dxm+mzUczU0L4rHIC+YedPpLlHYemY6xDcGv2UVa
        pj6/BexsAU+sNYi+GJaOo1QglDzlZG0qyZVdLdy8dKHlNSKpevTpQ3Nb5TUtKYYGrg2hk1
        jn52dSCvz5Xctayj3HWPj330/Upi4Oi2UwjggCvfPTBRVXE3cPlnWuUSqkE/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674671554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=RklJeSBsXo3eoBMozqg37WAfagKIJsfsLub9jJTlyS0=;
        b=VLbPo2n/njUZrvXU3fIXRwPTcU1ObmSar48bwv10Rp/gl3v2SSUpf+oKd43PbKteq3X+kZ
        tNRn/2cHqGtg8A8EkbBqOlFnMmCnE0a9VqP45bpFkpPqW3rIUIeVP/bMAidcU0zlFnn0z3
        iJFrWQJPgAQS3/vFELXPpYBXEfiINZiVOlOqr/GqXdj46c7bZi8CLv27HmdzXK7hhZQtPE
        MhRw0J/B7zfxrpP/RkqbWcWUukLcIr2YIXMrTLM4K8U4o3/d43EiHP9yBPca4LvV7J5NB2
        82S8FQ+XRx8QhtcLWobGLw3yTtnZdXK6rPE9XgdXCD/fHlZCpEGpoaXb4FN3ow==
ARC-Authentication-Results: i=1;
        rspamd-6989874cc5-4dw8b;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Shrill-Abaft: 611cd91253d2316a_1674671554254_2343272906
X-MC-Loop-Signature: 1674671554254:3707289730
X-MC-Ingress-Time: 1674671554254
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.83 (trex/6.7.1);
        Wed, 25 Jan 2023 18:32:34 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4P2CB93LKDzRn
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 10:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1674671553;
        bh=RklJeSBsXo3eoBMozqg37WAfagKIJsfsLub9jJTlyS0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=N/714JzxOON/lNp5Lt6uyGnicVW6JvwaCA6YQbKmc4DCcuKtK3cTWOyDCGP0gW219
         kLVElSeK0dBdv4Qry5EE10vpE/CaHFWD0JgR4g7GAHFLHpK9VE+ryBNWoJMIKg6it5
         5JMtkc+4WV1psHPnlsxKGS9cK0mGd3GhoGVL4otA=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00e2
        by kmjvbox (DragonFly Mail Agent v0.12);
        Wed, 25 Jan 2023 10:32:31 -0800
Date:   Wed, 25 Jan 2023 10:32:31 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf/util: Symbol lookup can fail if multiple segmets
 match stext
Message-ID: <20230125183231.GB1963@templeofstupid.com>
References: <20230124223531.GB1962@templeofstupid.com>
 <65cb75e0-4c0b-9384-1f6b-77a0053d8109@intel.com>
 <231b238b-d464-464e-01d1-a2d5374a79ea@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231b238b-d464-464e-01d1-a2d5374a79ea@intel.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Jan 25, 2023 at 09:37:59AM +0200, Adrian Hunter wrote:
> On 25/01/23 09:29, Adrian Hunter wrote:
> 
> Also subject line has spelling mistake, and should identify kcore
> as the issue e.g.
> 
> perf symbol: Symbol lookup with kcore can fail if multiple segments match stext
> 
> > On 25/01/23 00:35, Krister Johansen wrote:
> >> This problem was encountered on an arm64 system with a lot of memory.
> >> Without kernel debug symbols installed, and with both kcore and kallsyms
> >> available, perf managed to get confused and returned "unknown" for all
> >> of the kernel symbols that it tried to look up.
> >>
> >> On this system, stext fell within the vmalloc segment.  The kcore symbol
> >> matching code tries to find the first segment that contains stext and
> >> uses that to replace the segment generated from just the kallsyms
> >> information.  In this case, however, there were two: a very large
> >> vmalloc segment, and the text segment.  This caused perf to get confused
> >> because multiple overlapping segments were inserted into the RB tree
> >> that holds the discovered segments.  However, that alone wasn't
> >> sufficient to cause the problem. Even when we could find the segment,
> >> the offsets were adjusted in such a way that the newly generated symbols
> >> didn't line up with the instruction addresses in the trace.  The most
> >> obvious solution would be to consult which segment type is text from
> >> kcore, but this information is not exposed to users.
> >>
> >> Instead, select the smallest matching segment that contains stext
> >> instead of the first matching segment.  This allows us to match the text
> >> segment instead of vmalloc, if one is contained within the other.
> >>
> >> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> >> ---
> >>  tools/perf/util/symbol.c | 10 ++++++++--
> >>  1 file changed, 8 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> >> index a3a165ae933a..14ac4189eaff 100644
> >> --- a/tools/perf/util/symbol.c
> >> +++ b/tools/perf/util/symbol.c
> >> @@ -1368,10 +1368,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
> >>  
> >>  	/* Find the kernel map using the '_stext' symbol */
> >>  	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
> >> +		u64 replacement_size = 0;
> > 
> > We'd usually put a blank line here
> > 
> >>  		list_for_each_entry(new_map, &md.maps, node) {
> >> -			if (stext >= new_map->start && stext < new_map->end) {
> >> +			u64 new_size = new_map->end - new_map->start;
> >> +
> >> +			if (!(stext >= new_map->start && stext < new_map->end))
> >> +				continue;
> >> +
> > 
> > Really needs a comment, and please be specific e.g.
> > 
> >  ARM64 vmalloc segment overlaps the kernel text segment, so
> >  choosing the smaller segment will get the kernel text.
> > 
> > 
> > 
> >> +			if (!replacement_map || new_size < replacement_size) {
> >>  				replacement_map = new_map;
> >> -				break;
> >> +				replacement_size = new_size;
> >>  			}
> >>  		}
> >>  	}

Thanks for all the feedback.  I'll incorporate these changes and send
out a v2 shortly.

-K
