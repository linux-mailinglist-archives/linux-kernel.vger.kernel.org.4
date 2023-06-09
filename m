Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78AA72931C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240631AbjFII1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241435AbjFIIZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:55 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D6E6C3C27;
        Fri,  9 Jun 2023 01:24:55 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-01; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 47F93C02EE; Fri,  9 Jun 2023 10:19:55 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:19:55 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips: asm-offsets: add missing prototypes
Message-ID: <20230609081955.GB8160@alpha.franken.de>
References: <20230516194000.548487-1-arnd@kernel.org>
 <20230516194000.548487-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516194000.548487-2-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:39:43PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with -Werror and W=1 fails entirely because of warnings in
> asm-offsets.c:
> 
> arch/mips/kernel/asm-offsets.c:26:6: error: no previous prototype for 'output_ptreg_defines' [-Werror=missing-prototypes]
> arch/mips/kernel/asm-offsets.c:78:6: error: no previous prototype for 'output_task_defines' [-Werror=missing-prototypes]
> arch/mips/kernel/asm-offsets.c:92:6: error: no previous prototype for 'output_thread_info_defines' [-Werror=missing-prototypes]
> arch/mips/kernel/asm-offsets.c:108:6: error: no previous prototype for 'output_thread_defines' [-Werror=missing-prototypes]
> arch/mips/kernel/asm-offsets.c:136:6: error: no previous prototype for 'output_thread_fpu_defines' [-Werror=missing-prototypes]
> 
> Nothing actually calls these functions, so just add prototypes to shut
> up the warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
