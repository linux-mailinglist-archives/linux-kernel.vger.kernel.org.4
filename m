Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C409A6615FA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbjAHO5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjAHO5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:57:20 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5910F616A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:57:19 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id B6BB992009C; Sun,  8 Jan 2023 15:57:17 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id B35E692009B;
        Sun,  8 Jan 2023 14:57:17 +0000 (GMT)
Date:   Sun, 8 Jan 2023 14:57:17 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH][PATCH] parport_pc: Limit the number of PCI BAR pairs to
 2
In-Reply-To: <CADVatmOArD_fSU4cG__DZ2HUqH9m3hf=+aOoYUqQjY31Sfb9qQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2301081456430.2259@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk> <alpine.DEB.2.21.2301060111330.54090@angie.orcam.me.uk> <CADVatmOArD_fSU4cG__DZ2HUqH9m3hf=+aOoYUqQjY31Sfb9qQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Jan 2023, Sudip Mukherjee wrote:

> > > Decrease the number of PCI BAR pair slots allocated for port subdrivers
> > > from 4 to 2 as none wants more than 2 at this time, reducing the memory
> > > footprint a little.  No functional change.
> >
> >  Ping for:
> > <https://lore.kernel.org/lkml/alpine.DEB.2.21.2209260132340.29493@angie.orcam.me.uk/>.
> 
> Sorry for the delay. Had to dig out my hardwares for the other series.
> This and the other series
> looks ok. Will test tonight and I will send it to Greg.

 No worries, and thank you for your review!

  Maciej
