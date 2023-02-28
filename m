Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98A6A622F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjB1WMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjB1WMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:12:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5584C21958
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:12:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECA27B80E67
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 22:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC5DC433D2;
        Tue, 28 Feb 2023 22:11:56 +0000 (UTC)
Message-ID: <6f6854e5-ffcf-5443-84b2-8cf73000e3c1@linux-m68k.org>
Date:   Wed, 1 Mar 2023 08:11:54 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] MAINTAINERS: drop uclinux.org
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     linux-m68k@lists.linux-m68k.org
References: <20230228163726.10984-1-rdunlap@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <20230228163726.10984-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/3/23 02:37, Randy Dunlap wrote:
> uclinux.org is dead. Drop it from the MAINTAINERS file.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Greg Ungerer <gerg@linux-m68k.org>
> Cc: linux-m68k@lists.linux-m68k.org

Thanks for doing this Randy.

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

I can take this via the m68knommu git tree if nobody else picks it up.

Regards
Greg



> ---
>   MAINTAINERS |    2 --
>   1 file changed, 2 deletions(-)
> 
> diff -- a/MAINTAINERS b/MAINTAINERS
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21384,10 +21384,8 @@ F:	include/uapi/linux/ublk_cmd.h
>   UCLINUX (M68KNOMMU AND COLDFIRE)
>   M:	Greg Ungerer <gerg@linux-m68k.org>
>   L:	linux-m68k@lists.linux-m68k.org
> -L:	uclinux-dev@uclinux.org  (subscribers-only)
>   S:	Maintained
>   W:	http://www.linux-m68k.org/
> -W:	http://www.uclinux.org/
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git
>   F:	arch/m68k/*/*_no.*
>   F:	arch/m68k/68*/
