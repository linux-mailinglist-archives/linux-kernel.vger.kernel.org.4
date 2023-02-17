Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78869AAE3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBQL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBQL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:58:28 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA11A644D6;
        Fri, 17 Feb 2023 03:58:27 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pSzNi-0000bS-01; Fri, 17 Feb 2023 12:58:26 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 562A6C28A2; Fri, 17 Feb 2023 12:58:12 +0100 (CET)
Date:   Fri, 17 Feb 2023 12:58:12 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        linux-kernel@vger.kernel.org, Song Liu <song@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] module: fix MIPS module_layout -> module_memory
Message-ID: <20230217115812.GB7701@alpha.franken.de>
References: <20230214005400.17137-1-rdunlap@infradead.org>
 <59c0ba61-c5d6-b74f-0fbd-844b08d13e5d@linaro.org>
 <2e17b8f6-0c2d-e705-63b9-47077b442d68@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e17b8f6-0c2d-e705-63b9-47077b442d68@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 08:52:04AM -0800, Randy Dunlap wrote:
> 
> 
> On 2/13/23 23:22, Philippe Mathieu-Daudé wrote:
> > Hi Randy,
> > 
> > On 14/2/23 01:54, Randy Dunlap wrote:
> >> Correct the struct's field/member name from mod_mem to mem.
> >>
> >> Fixes this build error:
> >> ../arch/mips/kernel/vpe.c: In function 'vpe_elfload':
> >> ../arch/mips/kernel/vpe.c:643:41: error: 'struct module' has no member named 'mod_mem'
> >>    643 |         v->load_addr = alloc_progmem(mod.mod_mem[MOD_TEXT].size);
> >>
> >> Fixes: 2ece476a2346 ("module: replace module_layout with module_memory")
> > 
> > On which tree is your patch based?
> 
> linux-next-20230213.

so I can't apply, because this is not in mips-next tree. It should be
applied to the tree, where this commit is coming from.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
