Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CE064E7FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:00:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPIAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:00:41 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C0DBE;
        Fri, 16 Dec 2022 00:00:39 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 52DE93200906;
        Fri, 16 Dec 2022 03:00:37 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 03:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671177636; x=1671264036; bh=5gJEzTEVlD
        vy8Tq4Os1u/SyKmtOlFe98ZaBLVtWSjLo=; b=mpPkOVZpl8rf1pwDwWPS4bqcU0
        VndnE7TSqW4XXlPbyMN44J+1DRleuFK3oNGVJ/cFtbOWbyyPtlJZaGanI5CK7jdL
        Jci/x9KgM20GTcHGynN7GCCdYfpf82wus43jLCkMGDqXiKbdImyukuo+P7EwtuBi
        XWUhFjwXbxzggkRA+wfHitPY4/A8lw+dZFZuN2HHD8JVBxKa3949pb89p3aDbprw
        HB7EYcf1IGbm+HTp7XJhzgOx5TfTWA+EfBH9AqYfB7PPqAZ3vJ5jnKkstW2taB+V
        PgPdQ0rhGXqVIj3ASh2qqhMTGgb26AUA8RayfuF/lMfkjYRuTDpM4U4kTetQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671177636; x=1671264036; bh=5gJEzTEVlDvy8Tq4Os1u/SyKmtOl
        Fe98ZaBLVtWSjLo=; b=cQyLeyayy261CDcbjVHQ+p4UD5lwwMTO22x2L90jU/n4
        lyFK0Y9RMZb6CtTPoiweojIUfogCrY6hhbiduYD1efsvnZpa2rrL93JuRApuXnKE
        7wiq4/2z+mlc70LkIyIE08rNdqsZSAwUGsaeUGRerJ0Fhv64CFiNoasBUlrkcUR8
        pQw6MPnQNL8N3EE+KDOUofR+vSqHLnNuidyfrUU8jMY5BSZiunsf6wPhCyssDl6I
        tcBvgDSiE5FUMuhJQ/UgdeEubHDlg3JAi3ws0scPifQjoB/doolLipqndn80kkx/
        yDlLcFRRD8YEA0ZbA2RyYL3YrwQGAGRt9JxhrhKxnw==
X-ME-Sender: <xms:pCWcY70WpATPd3k_REhSyBXYV1spxwKgibZGybQZo_BA2zMWPFyi4A>
    <xme:pCWcY6GYfYoTJLY2M9GLL92yIHBY1vw30K5Y3bCv3cviyYhIsJVbLNq8FN7B91hf9
    Etbofz2Z0qaIpDNq-Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeigdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesth
    dtredtreertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnuges
    rghrnhgusgdruggvqeenucggtffrrghtthgvrhhnpeffheeugeetiefhgeethfejgfdtue
    fggeejleehjeeutefhfeeggefhkedtkeetffenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:pCWcY776ZhiXpOx9HkTnz2_hrZ8ob1ILPrgn7sjkYsFqrhYjYdWerg>
    <xmx:pCWcYw3jKhlqRPMoM-cynhC-EteKV3WNCG2B6qy0A-6beKl0Is4tkQ>
    <xmx:pCWcY-EegBEpzWP3PZ5hjb9l2wbRoTX55i-7luqJNQGdCbZKXeZ0Mg>
    <xmx:pCWcYzTHAcdNY89Ag62Wl0NeSvkg5ptt30dz71fwN3xcXV5RJSLuTA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8BF00B60086; Fri, 16 Dec 2022 03:00:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <9355f758-9d06-4de8-85f7-e6ad870e784b@app.fastmail.com>
In-Reply-To: <202212160636.H31oByti-lkp@intel.com>
References: <20221215162759.3883282-1-arnd@kernel.org>
 <202212160636.H31oByti-lkp@intel.com>
Date:   Fri, 16 Dec 2022 09:00:16 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Arnd Bergmann" <arnd@kernel.org>, reiserfs-devel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: avoid objtool warning after panic
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022, at 23:31, kernel test robot wrote:
> Hi Arnd,
>
> I love your patch! Perhaps something to improve:
>
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> fs/reiserfs/namei.o: warning: objtool: reiserfs_rename+0x212: unreachable instruction
> --
>>> fs/reiserfs/ibalance.o: warning: objtool: balance_internal_when_delete+0x44c: unreachable instruction
> --
>>> fs/reiserfs/stree.o: warning: objtool: reiserfs_cut_from_item+0x17a: unreachable instruction
> --
>>> fs/reiserfs/journal.o: warning: objtool: do_journal_end+0x4af: unreachable instruction
> --
>>> fs/reiserfs/item_ops.o: warning: objtool: direntry_check_left+0x65: unreachable instruction

Ok, I'll have to revisit this one. I think I tried something similar
before and ran into the same problem but I though I had figured
it out this time.

The problem apparently is that the patch to shut up the objtool
warning with clang in turn adds a different objtool warning with
gcc...

    Arnd
