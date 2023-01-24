Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9867A5F6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjAXWhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjAXWhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:37:09 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E359518D8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:36:36 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 843DC202048
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:35:35 +0000 (UTC)
Received: from pdx1-sub0-mail-a306.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 20421202101
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 22:35:35 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1674599735; a=rsa-sha256;
        cv=none;
        b=R1BQE9XcAbKUDd9zsZAVNOPXtyrJVs1NzpHjcXw76M0Yi+bGz4hIn2f4oZUCYYGiuHTm06
        t6CMI4HGqt3QK+x8FAiQScd6mGpz4qC8EazQVFjEXFgmWSuprFVje024C4J8nIlCJApMro
        zg/+NFJSmNiypZiIGWq9EnzfcYlR2uxMHQ4K7mY/YIpPCb9KqYftL4DeZKMAEd120X/7vQ
        TYDEgiArXI9OZnv918UsSDKzY03lsiGlEQt1mHDz+gHIzgm/3PTa155wQtrZXq8w4cF5aL
        PqpMrpSjDCv9HNTjQy8FWI/7lQkA8hj6MZcZ3jqMMQvHE8EUyRNynu3yRJmp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1674599735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=0+ddPJb+zJ+MbSfxufS7SFMyh6w2pn/FBUTVrzUXLsI=;
        b=bQ36b3aedpyaEICveV1NwOczYCt8lx5ZXGPraTgFYplFX5pqDS7RM5z0xJHRFiXfK2TZFT
        DACNxTQlhc9N0G/Mv0K05G/45OXGeRjEEEQ5JaJv0U5UwMSrQhcWm+SlVy0vqvIEF4L10x
        ubs2fqEyF96GQ5fj37h2kys3Q36RE+WhElF/pqGdpCE9t3yNdISu69XxH2ejj9ERXERIZb
        UTMj2jU2WStVa6hvFCp6HiVKda9GbNpELX/O/UIoMDImRhjZRMOFsR9oqSR591ToUXx4nG
        xQTK+CUOAbVLD2Vul+Pfrccc4SywUrRXG6H6JJqMiABQQ1sVLBk0k6VRLFF4lQ==
ARC-Authentication-Results: i=1;
        rspamd-55978756d7-gjlbd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Hysterical: 0a7459d816e67ede_1674599735361_3991415665
X-MC-Loop-Signature: 1674599735361:392477380
X-MC-Ingress-Time: 1674599735361
Received: from pdx1-sub0-mail-a306.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.116.179.120 (trex/6.7.1);
        Tue, 24 Jan 2023 22:35:35 +0000
Received: from kmjvbox (c-76-102-200-71.hsd1.ca.comcast.net [76.102.200.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a306.dreamhost.com (Postfix) with ESMTPSA id 4P1hd20MNWzQ3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1674599734;
        bh=0+ddPJb+zJ+MbSfxufS7SFMyh6w2pn/FBUTVrzUXLsI=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=AaFTNpWBxQPJHMXLLBcTebA4aRJ+hUQTYpRSjhlAoCif7jsgVkh9kEOwZKqCUGelU
         aHIvYUmHJnewioA+PH5fqjULC0J5dwyRj27/WY3+pR3HQHQwhNZ26U5kupPsTdZnpO
         pRCV0kL2OguWmeFyH5S6zk1T/OOUdvit4PtvxRdo=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e006a
        by kmjvbox (DragonFly Mail Agent v0.12);
        Tue, 24 Jan 2023 14:35:31 -0800
Date:   Tue, 24 Jan 2023 14:35:31 -0800
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        David Reaver <me@davidreaver.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf/util: Symbol lookup can fail if multiple segmets match
 stext
Message-ID: <20230124223531.GB1962@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This problem was encountered on an arm64 system with a lot of memory.
Without kernel debug symbols installed, and with both kcore and kallsyms
available, perf managed to get confused and returned "unknown" for all
of the kernel symbols that it tried to look up.

On this system, stext fell within the vmalloc segment.  The kcore symbol
matching code tries to find the first segment that contains stext and
uses that to replace the segment generated from just the kallsyms
information.  In this case, however, there were two: a very large
vmalloc segment, and the text segment.  This caused perf to get confused
because multiple overlapping segments were inserted into the RB tree
that holds the discovered segments.  However, that alone wasn't
sufficient to cause the problem. Even when we could find the segment,
the offsets were adjusted in such a way that the newly generated symbols
didn't line up with the instruction addresses in the trace.  The most
obvious solution would be to consult which segment type is text from
kcore, but this information is not exposed to users.

Instead, select the smallest matching segment that contains stext
instead of the first matching segment.  This allows us to match the text
segment instead of vmalloc, if one is contained within the other.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 tools/perf/util/symbol.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index a3a165ae933a..14ac4189eaff 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1368,10 +1368,16 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 
 	/* Find the kernel map using the '_stext' symbol */
 	if (!kallsyms__get_function_start(kallsyms_filename, "_stext", &stext)) {
+		u64 replacement_size = 0;
 		list_for_each_entry(new_map, &md.maps, node) {
-			if (stext >= new_map->start && stext < new_map->end) {
+			u64 new_size = new_map->end - new_map->start;
+
+			if (!(stext >= new_map->start && stext < new_map->end))
+				continue;
+
+			if (!replacement_map || new_size < replacement_size) {
 				replacement_map = new_map;
-				break;
+				replacement_size = new_size;
 			}
 		}
 	}
-- 
2.25.1

