Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69BA6873DC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 04:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjBBDdi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Feb 2023 22:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjBBDdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 22:33:36 -0500
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27E93
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 19:33:34 -0800 (PST)
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 6E6081C62B4;
        Thu,  2 Feb 2023 03:33:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 02DBB20010;
        Thu,  2 Feb 2023 03:33:28 +0000 (UTC)
Message-ID: <38d7d022d6e88d643c8037e26707a719cb55ff1d.camel@perches.com>
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
From:   Joe Perches <joe@perches.com>
To:     "liaochang (A)" <liaochang1@huawei.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, heiko.stuebner@vrull.eu,
        ajones@ventanamicro.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        jszhang@kernel.org, vincent.chen@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 01 Feb 2023 19:33:28 -0800
In-Reply-To: <f161df27-f2d7-0367-33a0-9ff5e4b880d9@huawei.com>
References: <20230129094242.282620-1-liaochang1@huawei.com>
         <Y9fZ2ZxdMmXgO5aB@wendy> <9a4f98a7-fa03-7960-29ce-0bff018c0ac9@huawei.com>
         <Y9o0Bv7VBM74ePHH@wendy> <f161df27-f2d7-0367-33a0-9ff5e4b880d9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 02DBB20010
X-Stat-Signature: kqdcufit37jr4gn94rgi8udg8huhz5hp
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18bIU1jSvMh6AJHRm0Q4g5yth5TD5/ciRA=
X-HE-Tag: 1675308808-781017
X-HE-Meta: U2FsdGVkX1/e8lmauG6/WxAvOun5hiCOeoRKWJY/KDyYozD3YFRTRwrKnm25/U+dvIiLd9eUOyvjmQBdjz01ag==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-02-02 at 08:52 +0800, liaochang (A) wrote:
> 
> 在 2023/2/1 17:42, Conor Dooley 写道:
> > Hi,
> > 
> > On Wed, Feb 01, 2023 at 05:37:24PM +0800, liaochang (A) wrote:
> > > 在 2023/1/30 22:53, Conor Dooley 写道:
> > > > On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
> > > > > Add header include guards to insn.h to prevent repeating declaration of
> > > > > any identifiers in insn.h.
> > > > 
> > > > I'm curious, did you spot this "by hand" while doing other work, or do
> > > > you have a tool that found it for you?
> > > 
> > > I found this "by hand", inspired by scripts/checkdeclares.pl, i write a tiny tool
> > > to analyse the missing header guards in header file.
> > 
> > Ohh, cool! I'd love to add this one to the checks on patchwork so that
> > we do not end up adding any more of these. If this is based on
> > checkdeclares, is it GPLv2?
> 
> Definitely, it is GPLv2,i will appending licence identifier and copyright info later.
> 
> Hi，@Joe Perches, is it ok to integrate this tool to scripts?

Don't see why not.
Perhaps submit it as a real patch to Andrew Morton <akpm@linux-foundation.org>

Trivial notes below:

> > > #!/usr/bin/env perl
> > > use strict;
> > > 
> > > sub usage {
> > >         print "Usage: checkguards.pl file1.h ...\n";
> > >         print "Warn of missing header guards\n";
> > >         exit 1;
> > > }
> > > 
> > > if ($#ARGV < 0) {
> > >         usage();
> > > }
> > > 
> > > foreach my $file (@ARGV) {
> > >         open(my $f, '<', $file)
> > >             or die "Cannot open $file: $!.\n";
> > > 
> > >         my $scan_area = 1;
> > >         my $guards_warn = 0;
> > > 
> > >         # The lines of header file are divided into several areas as follows:
> > >         #
> > >         # ... area1 ...
> > >         # #ifndef _HEADER_GUARD
> > >         # ... area2 ...
> > >         # #define _HEADER_GUARD
> > >         # ... area3 ...
> > >         # #endif /* _HEADER_GUARD */
> > >         # ... area4 ...
> > >         # EOF
> > >         #
> > >         # If any statement is found in area1, area2, and area4, it
> > >         # throws a warning of illegal usage of header guard usage.

Not illegal, invalid

> > >         while (<$f>) {
> > >                 if (m/^(.*);\s*$/o) {
> > >                         if ($scan_area == 1 || $scan_area == 2 || $scan_area == 4) {
> > >                                 ++$guards_warn;
> > >                         }
> > >                 } elsif (m/^\s*(#ifndef\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
> > >                         ++$scan_area;
> > >                 } elsif (m/^\s*(#define\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
> > >                         ++$scan_area;
> > >                 } elsif (m/^\s*(#endif)\s*\/\*\s*[a-zA-Z0-9_]*_H[_]*\s*\*\/\s*$/o) {
> > >                         ++$scan_area;
> > >                 }
> > >         }
> > > 
> > >         close($f);
> > > 
> > >         if ($guards_warn) {
> > >                 print "Illegal usage of header guard found in $file.\n";

here too

There are also uses like #if !defined(FOO)
There can be spaces before and after the #

It might also be useful to have a check for missing header guards.



