Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48FF06D76FF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237517AbjDEIdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236910AbjDEIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:33:33 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B15B22704;
        Wed,  5 Apr 2023 01:33:32 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pjyaC-0007rR-01; Wed, 05 Apr 2023 10:33:32 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 86A2EC2424; Wed,  5 Apr 2023 10:29:55 +0200 (CEST)
Date:   Wed, 5 Apr 2023 10:29:55 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MIPS: Remove no longer used ide.h
Message-ID: <20230405082955.GB6145@alpha.franken.de>
References: <20230403094113.6056-1-tsbogend@alpha.franken.de>
 <20230403094113.6056-2-tsbogend@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403094113.6056-2-tsbogend@alpha.franken.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 11:41:11AM +0200, Thomas Bogendoerfer wrote:
> There are only three drivers left using ide.h, which are all m68k only.
> 
> Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> ---
>  arch/mips/include/asm/ide.h              |  13 ---
>  arch/mips/include/asm/mach-generic/ide.h | 138 -----------------------
>  2 files changed, 151 deletions(-)
>  delete mode 100644 arch/mips/include/asm/ide.h
>  delete mode 100644 arch/mips/include/asm/mach-generic/ide.h

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
