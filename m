Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB575B5BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiILODO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiILOCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:02:54 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE4EC32B9A;
        Mon, 12 Sep 2022 07:02:46 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oXk1M-0007Yg-00; Mon, 12 Sep 2022 16:02:44 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 841D7C1275; Mon, 12 Sep 2022 15:39:18 +0200 (CEST)
Date:   Mon, 12 Sep 2022 15:39:18 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Shaomin Deng <dengshaomin@cdjrlc.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix comments typo
Message-ID: <20220912133918.GA9232@alpha.franken.de>
References: <20220827154640.9687-1-dengshaomin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220827154640.9687-1-dengshaomin@cdjrlc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 11:46:40AM -0400, Shaomin Deng wrote:
> Remove the repeated word "as" in comments.
> 
> Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
> ---
>  arch/mips/cavium-octeon/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 00bf269763cf..9ad12fb6a9a6 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -527,7 +527,7 @@ void octeon_user_io_init(void)
>  	/* Get the current settings for CP0_CVMMEMCTL_REG */
>  	cvmmemctl.u64 = read_c0_cvmmemctl();
>  	/* R/W If set, marked write-buffer entries time out the same
> -	 * as as other entries; if clear, marked write-buffer entries
> +	 * as other entries; if clear, marked write-buffer entries
>  	 * use the maximum timeout. */
>  	cvmmemctl.s.dismarkwblongto = 1;
>  	/* R/W If set, a merged store does not clear the write-buffer
> -- 
> 2.35.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
