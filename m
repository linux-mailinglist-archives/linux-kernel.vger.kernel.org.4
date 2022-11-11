Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBC625B66
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 14:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbiKKNrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 08:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKKNrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 08:47:12 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D0B965E56;
        Fri, 11 Nov 2022 05:47:11 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1otUN0-0002Uo-00; Fri, 11 Nov 2022 14:46:58 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7CC48C115B; Fri, 11 Nov 2022 14:02:16 +0100 (CET)
Date:   Fri, 11 Nov 2022 14:02:16 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Cye Borg <cyborgyn@gmail.com>
Cc:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 08/15] MIPS: IP27: remove KV_MAGIC
Message-ID: <20221111130216.GA11187@alpha.franken.de>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
 <60f6526fffa99416d2429dfb0b454148170cce8a.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAD4NMuYU6+JYGwCwDqGW5bTN8Rgg4SwseH9JKzjPAzsujBuCEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD4NMuYU6+JYGwCwDqGW5bTN8Rgg4SwseH9JKzjPAzsujBuCEw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 06:39:10AM +0100, Cye Borg wrote:
> Just asking:
> This code in SGI seems to help bring online other CPUs.
> - Does it use the firmware to do it?
> - Is there a possibility that the magic number in this case is used by the
> firmware?
> - If yes: do we break multiprocessing on SGI if we delete this "useless
> relic", which is not referenced in the linux code elsewhere?

this magic is just for a internal struct not used by firmware. It came
from IRIX code, but there is no point in keeping it

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
