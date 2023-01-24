Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DB46799AF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbjAXNlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXNlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:41:00 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DC31BE5;
        Tue, 24 Jan 2023 05:40:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A47E1FDAB;
        Tue, 24 Jan 2023 13:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674567658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abri0zFA+xjooP9Ux7FyiMJ1tEcfHRQmA6ycin20OiU=;
        b=2bZMNHzl2etHCSdbjIvf9JPvQRmje+DRWoIA59q9l0qb3e/pSIkNnMbbogxfeua2Nq4jNN
        q9sU+KwAAx8V8s143WDCb1EkL7EYCBQyf6QKspa8kd138NZjC1dRhfKltiuLj0mYjaQYOe
        W29fte9MKLw0VUqbZtITDa13cTbvM7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674567658;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abri0zFA+xjooP9Ux7FyiMJ1tEcfHRQmA6ycin20OiU=;
        b=z42iM2O16v7RZ9l2xP6I7NGba8aNNuxfmNysErxOtpoz7jZfs1W8OgwfHV+g/Swc0HwL38
        VZQcFpFxo+JYpcCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6C9513487;
        Tue, 24 Jan 2023 13:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id m9xBNunfz2NHZwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Jan 2023 13:40:57 +0000
Date:   Tue, 24 Jan 2023 14:40:54 +0100
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Mike Rapoport <rppt@kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/1=5D_docs/mm=3A_Physical_Memory=3A_ad?= =?US-ASCII?Q?d_structure=2C_introduction_and_nodes_description?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Y8++BJcHgfzuoURl@kernel.org>
References: <20230115184212.996298-1-rppt@kernel.org> <20230115184212.996298-2-rppt@kernel.org> <bea284c3-fe7c-f55a-449d-07f47a364c1c@suse.cz> <Y8++BJcHgfzuoURl@kernel.org>
Message-ID: <AC10188D-6728-478F-A95D-1A460958533A@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 24, 2023 12:16:20 PM GMT+01:00, Mike Rapoport <rppt@kernel=2Eor=
g> wrote:
>On Tue, Jan 24, 2023 at 12:00:07PM +0100, Vlastimil Babka wrote:
>> On 1/15/23 19:42, Mike Rapoport wrote:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel=2Eorg>
>> >=20
>> > Add structure, introduction and Nodes section to Physical Memory
>> > chapter=2E
>> >=20
>> > As the new documentation references core-api/dma-api and mm/page_recl=
aim,
>> > add page labels to those documents=2E
>> >=20
>> > Reviewed-by: Bagas Sanjaya <bagasdotme@gmail=2Ecom>
>> > Reviewed-by: Lorenzo Stoakes <lstoakes@gmail=2Ecom>
>> > Acked-by: Michal Hocko <mhocko@suse=2Ecom>
>> > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel=2Eorg>
>>=20
>> Acked-by: Vlastimil Babka <vbabka@suse=2Ecz>
>>=20
>> A small bug to fix below?
>>=20
>> <snip>
>>=20
>> > +
>> > +Along with the node structures, kernel maintains an array of ``nodem=
ask_t``
>> > +bitmasks called ``node_states``=2E Each bitmask in this array repres=
ents a set of
>> > +nodes with particular properties as defined by ``enum node_states``:
>> > +
>> > +``N_POSSIBLE``
>> > +  The node could become online at some point=2E
>> > +``N_ONLINE``
>> > +  The node is online=2E
>> > +``N_NORMAL_MEMORY``
>> > +  The node has regular memory=2E
>> > +``N_HIGH_MEMORY``
>> > +  The node has regular or high memory=2E When ``CONFIG_HIGHMEM`` is =
disabled
>> > +  aliased to ``N_NORMAL_MEMORY``=2E
>>=20
>> Noted=2E
>>=20
>> > +``N_MEMORY``
>> > +  The node has memory(regular, high, movable)
>> > +``N_CPU``
>> > +  The node has one or more CPUs
>> > +
>> > +For each node that has a property described above, the bit correspon=
ding to the
>> > +node ID in the ``node_states[<property>]`` bitmask is set=2E
>> > +
>> > +For example, for node 2 with normal memory and CPUs, bit 2 will be s=
et in ::
>> > +
>> > +  node_states[N_POSSIBLE]
>> > +  node_states[N_ONLINE]
>> > +  node_states[N_NORMAL_MEMORY]
>> > +  node_states[N_MEMORY]
>> > +  node_states[N_CPU]
>>=20
>> Should it be set also in node_states[N_HIGH_MEMORY]?
>=20
>You mean because of the aliasing of N_NORMAL_MEMORY and N_HIGH_MEMORY?

No I meant due to "The node has regular or high memory=2E" Or do I misunde=
rstand? 
