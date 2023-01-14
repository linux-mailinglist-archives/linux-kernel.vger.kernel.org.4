Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99966AA2E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 09:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjANIr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 03:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjANIr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 03:47:26 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57DEF4EC2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 00:47:25 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30E8lJUw006072;
        Sat, 14 Jan 2023 09:47:19 +0100
Date:   Sat, 14 Jan 2023 09:47:19 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Michal Simek <michal.simek@amd.com>,
        Kris Chaplin <kris.chaplin@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <20230114084719.GA6057@1wt.eu>
References: <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
 <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu>
 <20230114071412.GB5088@1wt.eu>
 <Y8JnHyKNTHMjsHSb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8JnHyKNTHMjsHSb@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 09:26:07AM +0100, Greg KH wrote:
> On Sat, Jan 14, 2023 at 08:14:12AM +0100, Willy Tarreau wrote:
> > On Fri, Jan 13, 2023 at 04:40:19PM -0500, Theodore Ts'o wrote:
> > > On Fri, Jan 13, 2023 at 05:22:56PM +0100, Greg KH wrote:
> > > > > I am just saying that developers/driver owners can simple do calculation to
> > > > > identify LTS version. When they know it they also know time when their
> > > > > deadline is for upstreaming work. It means if patch is accepted between
> > > > > 6.0-r1 and 6.0-rc5/6 they know that it will get to 6.1 merge window.
> > > > 
> > > > That is what I am afraid of and if it causes problems I will purposfully
> > > > pick the previous release.  This has happened in the past and is never
> > > > an excuse to get anything merged.  Code gets merged when it is ready,
> > > > not based on a LTS release.
> > > 
> > > This is probably the best reason not to preannounce when the LTS
> > > release will be ahead of time --- because it can be abused by
> > > developers who try to get not-ready-for-prime-time features into what
> > > they think will be the LTS kernel, with the result that the last
> > > release of the year could be utterly unsitable for that perpose.
> > 
> > We know this risk exists but since Greg never makes promises on any
> > version, it remains reasonable.
> 
> I have to _not_ make promises because in the past when I did, people
> threw crap into the kernel with the "justification" that they had to get
> it in this specific kernel because it was going to be the LTS one.
> 
> We can't have nice things, because people abuse it :(

Absolutely, that was exactly my point :-)

And quite frankly it's better the current way, because you have the
flexibility to change your mind on a given version if during the first
months you discover it's too crappy and will be a maintenance nightmare.

Willy
