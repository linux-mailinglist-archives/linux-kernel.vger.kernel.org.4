Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDED70D898
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbjEWJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjEWJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BE9713E;
        Tue, 23 May 2023 02:13:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q1O5K-0007MY-00; Tue, 23 May 2023 11:13:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id D9E9CC02E5; Tue, 23 May 2023 11:05:56 +0200 (CEST)
Date:   Tue, 23 May 2023 11:05:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Paul Burton <paulburton@kernel.org>,
        John Crispin <john@phrozen.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: Move initrd_start check after initrd address
 sanitisation.
Message-ID: <20230523090556.GA9484@alpha.franken.de>
References: <20230509172921.295700-1-liviu@dudau.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509172921.295700-1-liviu@dudau.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 06:29:21PM +0100, Liviu Dudau wrote:
> PAGE_OFFSET is technically a virtual address so when checking the value of
> initrd_start against it we should make sure that it has been sanitised from
> the values passed by the bootloader. Without this change, even with a bootloader
> that passes correct addresses for an initrd, we are failing to load it on MT7621
> boards, for example.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>  arch/mips/kernel/setup.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
