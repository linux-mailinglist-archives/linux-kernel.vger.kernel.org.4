Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174E967E9F6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 16:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjA0PsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 10:48:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjA0PsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 10:48:05 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D40658B;
        Fri, 27 Jan 2023 07:47:47 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FFD65C0148;
        Fri, 27 Jan 2023 10:46:58 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 27 Jan 2023 10:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1674834418; x=1674920818; bh=tqkwOkU426
        Ma4OELw419T18bSnd7LNn3wn4cQLkxLOc=; b=KcWQcIix0NpAKy1hsvfJeOSBir
        MqKxQu0uvvDB4BL52vCuIFDSa7pvUsS3Z0DI8CnXp820xV5gg+ItdSl1Takr10+a
        6+iiwId841lND18sbe2YisDde/DCnNz1R00ZCJbpYyNxIEX3Vn8TlmOPCUSrSwTB
        IHyKHBz/2XhiotS/K0ukcyOcMSaE5Q85fAQbRpmDLJw0Mc60Nu8E/rOu0DbQEhBl
        h+Z/25+FQ/l0pgd4SHL7F01YgLLeeayHEWT8vXaV8/h/ONhyrTdkEx91rP0CQSeN
        K3V+1lashw4s7/iFISlmWixXM0jxNkcoHXESRG8yOBFVkdjW4+SzXRwlRVRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674834418; x=1674920818; bh=tqkwOkU426Ma4OELw419T18bSnd7
        LNn3wn4cQLkxLOc=; b=N6tCpjiAX10QjsR0kozskUb5S8CVnP8p6MbLRAnF1hUB
        CO6mYQ3jw5tM1JJMUC76qxdJcV1qJwFBnwMfz71zNkRc7Z7nC5s5kcjerSHfn7jI
        J4mNzYWfRrsTH+5olwK/3g8aJd1zxpfLv4zggtH+JnOwMAbUQpdv/GLSzPr7ftsV
        z6MFiANsGc6NXMt+Znsi0N+dSBAO9VqJtEcXEttBAcV9/207UfrpcxxWo9sUWN3O
        kaKnBOyiganr2mB6JAUcYXgFU7z2WTuGCNZnDYibJ7Z/DsjN4/xuJKs/7WMLeCOE
        CMv4VYwAIK9xfZvOWqQ0aWbYCeCtj6E5aL4gAX+ZRg==
X-ME-Sender: <xms:8fHTY90IqVMT7669I9Tcc9Viu1956S6u4w_aZ0SLxlBqRdX1VJD33A>
    <xme:8fHTY0FwoZbHXE21VvWNVhw7dcJp1pY64yJay3Is9c4UDL0rmMKucLMGMKO5fza2D
    TlAYI7wQlgFGNyLhKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:8vHTY96J4_5ITgnJQcOyZ7d5OJfeJVp3qfGFg8oKTanL3gQVrtpqmA>
    <xmx:8vHTY62TStYzTraxzNxDWRqKkUJBgem_UB7DaG90JAJn4F-nur0J3Q>
    <xmx:8vHTYwETLqSMhIiuefcFze8O08FFi_7v3CsqFZlMTYfgZRCRZuaG4g>
    <xmx:8vHTY15fjh-ALKJ2R5SRRFL6j1A58ed-6WkiXFdSgSoZuJTJLoxXvA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E780EB60086; Fri, 27 Jan 2023 10:46:57 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-85-gd6d859e0cf-fm-20230116.001-gd6d859e0
Mime-Version: 1.0
Message-Id: <54c8ecbd-1d6e-40f1-af30-7efd04c63a7e@app.fastmail.com>
In-Reply-To: <20230126175356.1582123-3-nphamcs@gmail.com>
References: <20230126175356.1582123-1-nphamcs@gmail.com>
 <20230126175356.1582123-3-nphamcs@gmail.com>
Date:   Fri, 27 Jan 2023 16:46:38 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Nhat Pham" <nphamcs@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Cc:     "Johannes Weiner" <hannes@cmpxchg.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        "Matthew Wilcox" <willy@infradead.org>, linux-api@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v8 2/3] cachestat: implement cachestat syscall
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023, at 18:53, Nhat Pham wrote:
>
> SYNOPSIS
>     #include <sys/mman.h>
>
>     struct cachestat {
>         __u64 nr_cache;
>         __u64 nr_dirty;
>         __u64 nr_writeback;
>         __u64 nr_evicted;
>         __u64 nr_recently_evicted;
>     };
>
>     int cachestat(unsigned int fd, off_t off, size_t len,
>           unsigned int cstat_version, struct cachestat *cstat,
>           unsigned int flags);

Is this "off_t off" argument intentionally limited to the old
32-bit type on 32-bit architectures? Unfortunately I fear 
there are no good options to pass an offset here:

- if you make it a 32-bit type, this breaks calling it from
  normal userspace that defines off_t as a 64-bit type

- if you change it to a 64-bit loff_t, there are three
  separate calling conventions for 64-bit, 32-bit with
  aligned register pairs and other 32-bit, plus you
  exceed the usual limit of six system call arguments

A separate problem may be the cstat_version argument, usually
we don't use interface versions but instead use a new
system call number if something changes in an incompatible
way.

       Arnd
