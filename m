Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C93863EE86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 11:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiLAK6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 05:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiLAK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 05:58:09 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4053483271;
        Thu,  1 Dec 2022 02:58:07 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p0hGS-0007Uq-05; Thu, 01 Dec 2022 11:58:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 65856C1EF5; Thu,  1 Dec 2022 11:53:45 +0100 (CET)
Date:   Thu, 1 Dec 2022 11:53:45 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Genjian <zhanggenjian123@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Genjian Zhang <zhanggenjian@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] MIPS: Restore symbol versions for copy_page_cpu and
 clear_page_cpu
Message-ID: <20221201105345.GE6569@alpha.franken.de>
References: <20221124055816.1803770-1-zhanggenjian@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124055816.1803770-1-zhanggenjian@kylinos.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 01:58:16PM +0800, Genjian wrote:
> From: Genjian Zhang <zhanggenjian@kylinos.cn>
> 
> The mips build generates two warnings:
> 
> WARNING: modpost: EXPORT symbol "clear_page_cpu" [vmlinux] version generation failed, symbol will not be versioned.
> WARNING: modpost: EXPORT symbol "copy_page_cpu" [vmlinux] version generation failed, symbol will not be versioned.
> 
> Add their prototypes to be defined in asm-prototypes.h, so that
> genksyms knows the types of these symbols and can generate CRCs for
> them.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Genjian Zhang <zhanggenjian@kylinos.cn>
> ---
>  arch/mips/include/asm/asm-prototypes.h | 3 +++
>  1 file changed, 3 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
