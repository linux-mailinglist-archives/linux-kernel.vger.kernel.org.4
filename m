Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AEA63F1B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiLANeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiLANeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:34:09 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900CAAC1A3;
        Thu,  1 Dec 2022 05:34:08 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p0jhW-000077-00; Thu, 01 Dec 2022 14:34:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E6226C1EF5; Thu,  1 Dec 2022 14:32:56 +0100 (CET)
Date:   Thu, 1 Dec 2022 14:32:56 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     John Thomson <git@johnthomson.fastmail.com.au>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        John Crispin <john@phrozen.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mips: ralink: mt7621: define MT7621_SYSC_BASE with
 __iomem
Message-ID: <20221201133256.GA10560@alpha.franken.de>
References: <20221114015658.2873120-1-git@johnthomson.fastmail.com.au>
 <20221114015658.2873120-2-git@johnthomson.fastmail.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114015658.2873120-2-git@johnthomson.fastmail.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 11:56:56AM +1000, John Thomson wrote:
> So that MT7621_SYSC_BASE can be used later in multiple functions without
> needing to repeat this __iomem declaration each time
> 
> Signed-off-by: John Thomson <git@johnthomson.fastmail.com.au>
> ---
>  arch/mips/include/asm/mach-ralink/mt7621.h | 4 +++-
>  arch/mips/ralink/mt7621.c                  | 7 +++----
>  2 files changed, 6 insertions(+), 5 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
