Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B8A73932F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjFUXnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6571730
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 16:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE83161708
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 23:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D870AC433CA;
        Wed, 21 Jun 2023 23:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687390988;
        bh=RoMKsAIPNmQwi8XbSHui64FM9FxWSSvleopyh2AgkRM=;
        h=In-Reply-To:References:Date:From:To:Subject:From;
        b=RKi6Ips4YOcbYcSL+N6hHAUWYJR6dKGoSb6XrgLAZZHGkQjJfQf1VPwVQfWN2Zg9p
         sWkKS9KCXft23kpaZG7HVrPM+0h3zRkveO6j1IzFPaKT85rVRTI7pubtWOYDlL5nAA
         2m+ylJBz1/dsFJEX3z+ZutLurK9Ai+osB9x1HXGq8RKBoHdIKj7yZJVWA+GxKlwpiB
         7GUwY1cdaJHgnP7scmNfiQzG5gAcV0pWiYAISwTH2XUn119UYQyrzIf8iGNskrlDop
         HojHFlz6lTvhrChkXd974yn9s1DvlZaln/siwyBn0UgeweX/ZoVo7xzIGzTSQy4+GL
         s1RFJL5M0051A==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id B90EA27C0054;
        Wed, 21 Jun 2023 19:43:06 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Wed, 21 Jun 2023 19:43:06 -0400
X-ME-Sender: <xms:CYuTZFAa6hQW_d42ApNMnsOzzM229EWsvjyeO6Yhq9Dsm6tKPId0AQ>
    <xme:CYuTZDgwByWAovgL8gv2kxdOB1mFofssm-NxewxM3JiORDuF2Y50AWHhm3vC75JzJ
    p50rGRcljbKGi_eux8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegtddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdelheejjeevhfdutdeggefftdejtdffgeevteehvdfgjeeiveei
    ueefveeuvdetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:CYuTZAkwYjTbT-0I6lmCvRq-yKXaUGs9x3_-SeWI2wOv0N2ZnfiEsQ>
    <xmx:CYuTZPz1JeAs_Wg7NKoa1mLqaJNSv3vANaW33SnEVZVSOe_OYqjgAA>
    <xmx:CYuTZKTovROWPa5HA8sZdk3gI_rWibusyDJTjM6YmhAF9lgRUAGRjA>
    <xmx:CouTZL-N1Ehe5PoxPWGKkMpxrzfjKCQY0Qjqe1HGaQdVTOP0iaoiLg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B529031A0063; Wed, 21 Jun 2023 19:43:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <0ff85b95-f4c7-445c-b0e0-7368c182ee0b@app.fastmail.com>
In-Reply-To: <333138f8-9fbe-be5b-d125-12c9d3ed3eda@citrix.com>
References: <20230621151442.2152425-1-per.bilse@citrix.com>
 <7fbad052-4c4a-4a49-913d-ea836c180dc2@app.fastmail.com>
 <333138f8-9fbe-be5b-d125-12c9d3ed3eda@citrix.com>
Date:   Wed, 21 Jun 2023 16:42:44 -0700
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Per Bilse" <Per.Bilse@citrix.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Juergen Gross" <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        "Oleksandr Tyshchenko" <oleksandr_tyshchenko@epam.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH] Updates to Xen hypercall preemption
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, Jun 21, 2023, at 12:05 PM, Per Bilse wrote:
> On 6/21/2023 5:27 PM, Andy Lutomirski wrote:
>> This code is a horrible mess, with and without your patches.  I think=
 that, if this were new, there's no way it would make it in to the kerne=
l.
>
> Hi Andy, and many thanks for your frank assessments.  Generally, this
> is indeed somewhat old code, first introduced in 2015 by way of commit
> fdfd811ddde3.  There's more information in the notes to that, and it's
> maybe worth noting that we're not trying to introduce anything new,
> merely fix what various commits since then have broken.
>
>> I propose one of two rather radical changes:
>>=20
>> 1. (preferred) Just delete all of it and make support for dom0 requir=
e either full or dynamic preempt, and make a dynamic preempt kernel boot=
ing as dom0 run as full preempt.
>
> Personally I think that's a good idea; a machine so limited in resourc=
es
> that a fully preemptible dom0 kernel would be a problem wouldn't work =
as
> a Xen server anyway.  Having said that, what to do about this isn't
> really in my hands; the issues came to light because the kernel for
> Citrix's XenServer product is being upgraded, and it was considered in
> everybody's interest to upstream the fixes.  I'll see what I can do.

This isn=E2=80=99t actually a resource thing. It=E2=80=99s a distro thin=
g.

Historically, full preempt was a config option only, and distros, for wh=
atever reason, often shipped kernels with full preempt disabled.  (There=
 we probably decent reasons. There may still be decent reasons.). And Xe=
n needed to work on these kernels.  Hence the mess.

But Linux recently gained the ability to build a kernel that, by default=
, is not full preempt but can be switched *at boot or runtime* to full p=
reempt. And distros should ship *that* (or a kernel that does have full =
preempt by default).

So let=E2=80=99s just make Xen PV dom0 depend on this. It wasn=E2=80=99t=
 an option a couple years ago. Now it is.

>
> Best,
>
>    -- Per
