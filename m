Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C2D64FB13
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 17:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiLQQlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 11:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiLQQlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 11:41:09 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E09AE8FF2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 08:41:03 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 2BHGex6N004880;
        Sat, 17 Dec 2022 17:40:59 +0100
Date:   Sat, 17 Dec 2022 17:40:59 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <20221217164059.GA4724@1wt.eu>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
 <Y53BputYK+3djDME@kroah.com>
 <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDLWs_GZaL7m2YqyfRgJE_s8RaQ4fyWbJKF8iDWzWJs84SJiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 07:14:14PM +0530, Kaiwan N Billimoria wrote:
> :-) Got it.
> Taking your point into account, I'll rephrase: as the _convention_ is
> to mark the last release in the year as LTS, is there any visibility
> on when, or if, it comes about?

What Greg tried to explain to you is that the convention is to pick a
sufficiently well tested kernel to make sure its maintenance will not
become a huge burden, and that it cannot be a single-person effort,
testers are needed during that period. As such companies and/or users
engaging in investing some resources for testing are extremely
important and if some have a good reason to prefer investing that time
on a different kernel, their choice will count more than just a kind
request on the mailing list. Now you know how to make your voice count
if you want/need 6.1 to become LTS.

Regards,
Willy
