Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511F169084E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBIMLa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjBIMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:11:01 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 475E711144;
        Thu,  9 Feb 2023 04:08:51 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pQ5jK-0008Pq-01; Thu, 09 Feb 2023 13:08:46 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 7C82EC26DF; Thu,  9 Feb 2023 13:07:49 +0100 (CET)
Date:   Thu, 9 Feb 2023 13:07:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     ye.xingchen@zte.com.cn
Cc:     john@phrozen.org, xkernel.wang@foxmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: =?iso-8859-1?Q?x?=
 =?iso-8859-1?Q?way=3A_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresou?=
 =?iso-8859-1?B?cmNlKCk=?=
Message-ID: <20230209120749.GB11168@alpha.franken.de>
References: <202302081045168463601@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202302081045168463601@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 10:45:16AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  arch/mips/lantiq/xway/dcdc.c | 5 +----
>  arch/mips/lantiq/xway/dma.c  | 4 +---
>  arch/mips/lantiq/xway/gptu.c | 5 +----
>  3 files changed, 3 insertions(+), 11 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
