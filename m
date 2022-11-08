Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D716219B3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbiKHQmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbiKHQmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:42:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1EF458024;
        Tue,  8 Nov 2022 08:42:10 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1osRfm-0002pj-00; Tue, 08 Nov 2022 17:42:02 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D0E19C1156; Tue,  8 Nov 2022 17:41:39 +0100 (CET)
Date:   Tue, 8 Nov 2022 17:41:39 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 07/15] MIPS: IP27: clean out sn/nmi.h
Message-ID: <20221108164139.GA3277@alpha.franken.de>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <534e0e7e4f2b0cc1cb35d5024192473635ed1b94.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <20221104145002.GA16099@alpha.franken.de>
 <20221108153820.fp5du7p7zr7pc7cs@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221108153820.fp5du7p7zr7pc7cs@tarta.nabijaczleweli.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:38:20PM +0100, наб wrote:
> On Fri, Nov 04, 2022 at 03:50:02PM +0100, Thomas Bogendoerfer wrote:
> > On Wed, Nov 02, 2022 at 12:05:30AM +0100, Ahelenia Ziemiańska wrote:
> > > The only user is arch/mips/sgi-ip27/ip27-nmi.c; this file was imported
> > > wholesale in 2.3.99pre9-1, and received only whitespace updates since
> > > then.
> > > 
> > > NMI_MAGIC isn't a magic number; it's unclear if it's actually used by
> > > the firmware in some capacity or if it's a holdover from copying the SGI
> > > code, but in the former case it's API and in the latter it's dead cruft.
> > 
> > it's used by firmware and Linux code to register the NMI exception
> > handler.
> Great, I'll put that in the message.
> 
> > Please leave arch/mips/include/asm/sn/nmi.h untouched as
> > it's documents firmware NMI handler usage (even when we don't use it, yet).
> "Yet".
> This file appeared in 2.3.99pre9-1, and hasn't changed since.
> I removed hard-coded assembly struct offsets, which we'll never use,
> because we /haven't/ used them, and this part is implemented in C.
> This file's my age, and these parts have been dead for just as long.
> 
> Yet.

it might be never used, but what's the problem with them ? Those
files came from IRIX and "document" the firmware interface. And me
as the MIPS maintainer wants to keep it there.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
