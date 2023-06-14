Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F016372A561
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjFIVeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjFIVeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:34:08 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564B35BE
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:34:07 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 953252628B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 21:34:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 070CE2628BB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 21:34:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686346446; a=rsa-sha256;
        cv=none;
        b=i6vZyoRSH6b7K+0da2QjMcGjQ5EQxfpJEOregrFvqQxNTXkrw9u6/sKv1+6ortZUqqNITO
        PUMOu179dA1IKEQ033x9/aGAtb4Z4v54FcP1N9Pt8rz9Jv+NQq5uzpubZYjkPiIZ5lBsPw
        jUYveaWOfbnkhvllxd7dtUh/mCiptYH8l4dS5sQfZKaKzH7Em9bWFj9DZmvGG+GotdvY9A
        s9/oiF17GfHHNz0yNN5DaMOHO7ei4Jh9aNyVlv5m1aeBwWn7DkmGqBXPsHdxcTi3QVJLLR
        hmn1MMLff1lhVgu07fmV0DgSZN7Cvx/DOC09oY+TjMotSzY76LdwDkdnyZ/6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686346446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=fxwlvbyXKNrZMK8qWy80gqOtE0XbBieVWNfsEqWEyJo=;
        b=uxQ9dd8FVBTr7RV5E4u0ZkTG1dWkLhJ4i72vJtziDN1I5okgqoDZEgA38L9SbBS7tG5mH2
        kYNm5p/fnQqt+C+ABho3cqjAPpuQha3zowgC0zKpiitBYx58j1GU0bxi4/UdipU2qT9NJ6
        gXoNIIHFw7v1TO3RMrerHa4CYk8drJSsiVikCPzxTI/jDvvA+6rT49LV3HMiDJ8ZA2I+OJ
        Q6dJ7t9g3zWGdmeFTZnZSKTMvarDuUeRo6xN8a6Np1LoU3mcPaedzKvj5DinpPOGT29Log
        Z5/hC3vQo0RlRMbcAs7KvVu0R7YT45gwybeCRC8RnPhkkCot0KA622PvGOFqvA==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-xmgfj;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Industry-Bottle: 101cd3e31f36700f_1686346446273_1294083855
X-MC-Loop-Signature: 1686346446273:4028915134
X-MC-Ingress-Time: 1686346446272
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.98 (trex/6.8.1);
        Fri, 09 Jun 2023 21:34:06 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4QdDqK16LPzYS
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686346445;
        bh=fxwlvbyXKNrZMK8qWy80gqOtE0XbBieVWNfsEqWEyJo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=d4xbs/lUSZ5zBAPoQNm3fCRUAehyYkKI54h9OK9FsNdeg6lw3rWjaV+Kgv4S7nJsS
         y2UFBuxcVhBe/RffIbqR6PQcDEJ+QH/dNhQLUClHM3Ax/cDFzVDF4u1jVzcL1+QuTV
         pG3YFOlGzE5AwsLQC1euQ8e2QzISVrNeAkTreqnI=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e00d9
        by kmjvbox (DragonFly Mail Agent v0.12);
        Fri, 09 Jun 2023 14:34:04 -0700
Date:   Fri, 9 Jun 2023 14:34:04 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram
 extables
Message-ID: <20230609213404.GB2012@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
 <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
 <49a8216a-4333-a044-ceea-c59980913966@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49a8216a-4333-a044-ceea-c59980913966@meta.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 08:52:36PM -0700, Yonghong Song wrote:
> On 6/8/23 5:11 PM, Krister Johansen wrote:
> > In certain situations a program with subprograms may have a NULL
> > extable entry.  This should not happen, and when it does, it turns a
> > single trap into multiple.  Add a test case for further debugging and to
> > prevent regressions.  N.b: without any other patches this can panic or
> > oops a kernel.
> 
> It would be great if you can add the panic call stack in the commit message.
> 
> Please also mention that three identical bpf programs in the test
> significantly increased the 'oops' chance. Just one program may
> not be able to trigger the issue.

Apologies, I mistakenly put the oops in the cover letter when you did tell
me to put it in the commit message for this patch.  That is fixed now.

> > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > ---
> >   .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
> >   .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
> >   2 files changed, 77 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > new file mode 100644
> > index 000000000000..2201988274a4
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > @@ -0,0 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <test_progs.h>
> > +#include "test_subprogs_extable.skel.h"
> > +
> > +void test_subprogs_extable(void)
> > +{
> > +	const int READ_SZ = 456;
> 
> There is no need to use uppercase for READ_SZ.
> Just do
> 	const int read_sz = 456;
> is sufficient.
> 
> > +	struct test_subprogs_extable *skel;
> > +	int err;
> > +
> > +	skel = test_subprogs_extable__open();
> > +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> > +		return;
> > +
> > +	err = test_subprogs_extable__load(skel);
> > +	if (!ASSERT_OK(err, "skel_load"))
> > +		goto cleanup;
> 
> You can combine the above open and load with a single one
>    test_subprogs_extable__open_and_load().
> 
> > +
> > +	err = test_subprogs_extable__attach(skel);
> > +	if (!ASSERT_OK(err, "skel_attach"))
> > +		goto cleanup;
> > +
> > +	/* trigger tracepoint */
> > +	ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
> 
> I think we should at least ensure that the program is triggered. For
> example, add a global variable 'triggered' in the program and
> triggered will be set to 1 in the program if the program is running.
> Here check
> 	skel->bss->triggered
> must be 1.
 
Thanks for the additional feedback on cleaning this up.  I've
incorporated the requested changes and will send out a v4 shortly.

-K
