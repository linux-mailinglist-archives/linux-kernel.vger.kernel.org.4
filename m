Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D60C6DF74B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDLNeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDLNeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:34:17 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11BD1974B;
        Wed, 12 Apr 2023 06:33:41 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pmabN-0000FF-04; Wed, 12 Apr 2023 15:33:33 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3C019C2458; Wed, 12 Apr 2023 15:32:19 +0200 (CEST)
Date:   Wed, 12 Apr 2023 15:32:19 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH 0/2] Clean up uprobes for MIPS
Message-ID: <20230412133219.GE11717@alpha.franken.de>
References: <1681197468-20658-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1681197468-20658-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 03:17:46PM +0800, Tiezhu Yang wrote:
> When I read uprobes code of all archs, I found that some code for MIPS
> is useless, so do some cleanups.
> 
> Tiezhu Yang (2):
>   MIPS: Use def_bool y for ARCH_SUPPORTS_UPROBES
>   MIPS: Remove set_swbp() in uprobes.c
> 
>  arch/mips/Kconfig          |  3 +--
>  arch/mips/kernel/uprobes.c | 18 ------------------
>  2 files changed, 1 insertion(+), 20 deletions(-)

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
