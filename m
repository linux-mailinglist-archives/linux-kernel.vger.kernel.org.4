Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAAC729317
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjFII1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241413AbjFIIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:52 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 11DEB3C0B;
        Fri,  9 Jun 2023 01:24:51 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-03; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 89068C02EE; Fri,  9 Jun 2023 10:21:25 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:21:25 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>,
        Ladislav Michl <oss-lists@triops.cz>
Subject: Re: [PATCH v2] mips: Fix spacing issue
Message-ID: <20230609082125.GD8160@alpha.franken.de>
References: <20230530065949.22247-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530065949.22247-1-franziska.naepelt@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 08:59:49AM +0200, Franziska Naepelt wrote:
> Fix some indentation issues and remove the following checkpatch issue:
> - ERROR: need consistent spacing around '-' (ctx:WxV)
> 
> Co-Developed-by: Ladislav Michl <oss-lists@triops.cz>
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
> v2:
>  - Apply review remarks
> 
>  arch/mips/sibyte/swarm/platform.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
> index 484969db7713..339d77a0a08f 100644
> --- a/arch/mips/sibyte/swarm/platform.c
> +++ b/arch/mips/sibyte/swarm/platform.c
> @@ -88,15 +88,15 @@ device_initcall(swarm_pata_init);
>  #define sb1250_dev_struct(num) \
>  	static struct resource sb1250_res##num = {		\
>  		.name = "SB1250 MAC " __stringify(num),		\
> -		.flags = IORESOURCE_MEM,		\
> -		.start = A_MAC_CHANNEL_BASE(num),	\
> -		.end = A_MAC_CHANNEL_BASE(num + 1) -1,	\
> +		.flags = IORESOURCE_MEM,			\
> +		.start = A_MAC_CHANNEL_BASE(num),		\
> +		.end = A_MAC_CHANNEL_BASE(num + 1) - 1,		\
>  	};\
>  	static struct platform_device sb1250_dev##num = {	\
> -		.name = "sb1250-mac",			\
> -	.id = num,					\
> -	.resource = &sb1250_res##num,			\
> -	.num_resources = 1,				\
> +		.name = "sb1250-mac",				\
> +		.id = num,					\
> +		.resource = &sb1250_res##num,			\
> +		.num_resources = 1,				\
>  	}
> 
>  sb1250_dev_struct(0);
> 
> base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> --
> 2.39.2 (Apple Git-143)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
