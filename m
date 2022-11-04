Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE5619A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKDOyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbiKDOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:54:17 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 896652EF33;
        Fri,  4 Nov 2022 07:54:15 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oqy52-0003X5-00; Fri, 04 Nov 2022 15:54:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 5A5EEC0EF4; Fri,  4 Nov 2022 15:50:02 +0100 (CET)
Date:   Fri, 4 Nov 2022 15:50:02 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
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
Message-ID: <20221104145002.GA16099@alpha.franken.de>
References: <cover.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
 <534e0e7e4f2b0cc1cb35d5024192473635ed1b94.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <534e0e7e4f2b0cc1cb35d5024192473635ed1b94.1667330271.git.nabijaczleweli@nabijaczleweli.xyz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 12:05:30AM +0100, Ahelenia Ziemiańska wrote:
> The only user is arch/mips/sgi-ip27/ip27-nmi.c; this file was imported
> wholesale in 2.3.99pre9-1, and received only whitespace updates since
> then.
> 
> NMI_MAGIC isn't a magic number; it's unclear if it's actually used by
> the firmware in some capacity or if it's a holdover from copying the SGI
> code, but in the former case it's API and in the latter it's dead cruft.

it's used by firmware and Linux code to register the NMI exception
handler. Please leave arch/mips/include/asm/sn/nmi.h untouched as
it's documents firmware NMI handler usage (even when we don't use it, yet).

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
