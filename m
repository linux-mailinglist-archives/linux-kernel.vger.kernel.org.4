Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C9569D1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 18:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjBTRQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 12:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjBTRQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 12:16:17 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5835720D0A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:16:14 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CAF323C0FAA
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5F7B53C13FD
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:16:13 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1676913373; a=rsa-sha256;
        cv=none;
        b=l8y73v1kQHKYz1V6IIrqO17lu3AcuglL9JGyHW/eIeEmHAO8IhsV8Id8fEDLDzELN2o11D
        cW0tAAl/m1rHTE3n0QIwM/bbXBQ6EdQB3HxirvmZryNh4bJ8f28faHXbr8P+z4LnNhMcF8
        AO1IGEiYEJ3GKXthZkIqh2nqlWtbq8JRpVMIE4/LE/jLswzENFwnf/1PE/0za5ovEzQGsB
        yB/zYAHsKf3c2zSupQonnzmfUxc+NHUsQHizcro0AzNRCV+5KVlBatKCgS/7ek8u2YimhE
        N0mMs2q91ooneKXI5pGPyaEKPjMw1XlYy5/A1WyeRfQvOwwr6mMqQR6M+pgxJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1676913373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=whX2ZzDG1ObOudLbNNnBksBTqM5gR0iYyizYBnUIlGo=;
        b=aewUVKddZBMj0ilHT5hkdvrfMdL5IXRWgaruZJ3T+h6pvFK3uJ5Ctu9aAy+CdApSFOIrSu
        1h/9v9G92JKFBFVPYNpuJshaKV/DaFcLkfqw1INWQKEUQaTMe6LlFSNH/uY6NjsWAJWxKA
        jKnuNth7plrkW23cSFeTKXXcYeix8eljsqr5YClzsQHahhkbDVk9A4HzIG6XwIQTCl21CQ
        s3Vd4db8S8yZg5UypE9n0nukSB7SmhLgmP1edkIrZscxjgz6AeBLOhKruEenMvr1cJjEym
        ugkzt06AkT9zIEFgYkP3dgMU1yrciUNiliLKsfuZj9HIirMpK9NhWzm3srjrMA==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-ngd69;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Trade-Bubble: 7464ea4a1faa1cd6_1676913373646_2557769322
X-MC-Loop-Signature: 1676913373646:2053306584
X-MC-Ingress-Time: 1676913373646
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.99.229.15 (trex/6.7.1);
        Mon, 20 Feb 2023 17:16:13 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4PL8G36jnNzvT
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 09:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1676913372;
        bh=whX2ZzDG1ObOudLbNNnBksBTqM5gR0iYyizYBnUIlGo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=E5RyGqxK4GSP2iCeUVhwcQCq55mWBmxqxX1OBVPzBhJa+YfWXXtIPNVIg/LB9+Jkf
         LURa74yeVqek7y3qm34Xx8iZzawf2Drdni0+KKFovZgbiikPzq6/jA2TlyGcoGpK4j
         jU3P7snzWhNxhPRX4DiLS6NJpbhg71k92zhr8qNo=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0067
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 20 Feb 2023 09:16:08 -0800
Date:   Mon, 20 Feb 2023 09:16:08 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>
Subject: Re: [PATCH v2] perf/util: Symbol lookup with kcore can fail if
 multiple segments match stext
Message-ID: <20230220171608.GA1993@templeofstupid.com>
References: <20230124223531.GB1962@templeofstupid.com>
 <20230125183418.GD1963@templeofstupid.com>
 <7b5f872a-f52e-7129-e956-90e97ec7d911@intel.com>
 <Y9sLQ1Iy5LJAaJ8L@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9sLQ1Iy5LJAaJ8L@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 10:00:51PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 30, 2023 at 03:29:54PM +0200, Adrian Hunter escreveu:
> > On 25/01/23 20:34, Krister Johansen wrote:
> > > This problem was encountered on an arm64 system with a lot of memory.
> > > Without kernel debug symbols installed, and with both kcore and kallsyms
> > > available, perf managed to get confused and returned "unknown" for all
> > > of the kernel symbols that it tried to look up.
> > > 
> > > On this system, stext fell within the vmalloc segment.  The kcore symbol
> > > matching code tries to find the first segment that contains stext and
> > > uses that to replace the segment generated from just the kallsyms
> > > information.  In this case, however, there were two: a very large
> > > vmalloc segment, and the text segment.  This caused perf to get confused
> > > because multiple overlapping segments were inserted into the RB tree
> > > that holds the discovered segments.  However, that alone wasn't
> > > sufficient to cause the problem. Even when we could find the segment,
> > > the offsets were adjusted in such a way that the newly generated symbols
> > > didn't line up with the instruction addresses in the trace.  The most
> > > obvious solution would be to consult which segment type is text from
> > > kcore, but this information is not exposed to users.
> > > 
> > > Instead, select the smallest matching segment that contains stext
> > > instead of the first matching segment.  This allows us to match the text
> > > segment instead of vmalloc, if one is contained within the other.
> > > 
> > > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > 
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> Thanks, applied.

Thanks, Arnaldo.  If it's not too late, would you be willing to tag this
one as:

Fixes: 5654997838c2 ("perf tools: Use the "_stest" symbol to identify the kernel map when loading kcore")
Cc: <stable@vger.kernel.org>

So that it makes it to the right stable branches?  I meant to do this
prior to sending it along.

-K
