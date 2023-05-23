Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F2F70E516
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjEWTFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjEWTF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:05:29 -0400
X-Greylist: delayed 1157 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 12:05:28 PDT
Received: from mx1.supremebox.com (mx1.supremebox.com [198.23.53.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5861791;
        Tue, 23 May 2023 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jilayne.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=t+H9Rtw1YMvfAwG8SQ51Xq058S4AzfCgWZgK3pTC+nI=; b=bLx0vJb/Mjs6VPpKfmNtiaCCR7
        uVcC6DIVWHRGhEvJItcx3aNPHX/zXavZ13CSRnK5L996SBTQweS0wk4oMbqfw5cfkVsJzMwIIiRsE
        N2AND5kyVcJt47NZKFXHjA4IUPORQIAmJ234Qsp6m4pn+SqbsVwOIAN0lwmcdKGgm0MI=;
Received: from 75-166-155-104.hlrn.qwest.net ([75.166.155.104] helo=[192.168.1.227])
        by mx1.supremebox.com with esmtpa (Exim 4.92)
        (envelope-from <opensource@jilayne.com>)
        id 1q1WF1-0000Am-AA; Tue, 23 May 2023 17:56:11 +0000
Message-ID: <6f2e13c1-6d99-f9a5-057c-e127efc69457@jilayne.com>
Date:   Tue, 23 May 2023 11:56:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] fs: udf: udftime: Replace LGPL boilerplate with
 SPDX identifier
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Eggert <eggert@twinsun.com>,
        Richard Fontana <rfontana@redhat.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
 <20230522005434.22133-3-bagasdotme@gmail.com>
From:   J Lovejoy <opensource@jilayne.com>
In-Reply-To: <20230522005434.22133-3-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Sender-Ident-agJab5osgicCis: opensource@jilayne.com
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/23 6:54 PM, Bagas Sanjaya wrote:
> Replace license boilerplate in udftime.c with SPDX identifier for
> LGPL-2.0.
>
> Cc: Paul Eggert <eggert@twinsun.com>
> Cc: Richard Fontana <rfontana@redhat.com>
> Cc: Pali Rohár <pali@kernel.org>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>   fs/udf/udftime.c | 18 ++----------------
>   1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
> index fce4ad976c8c29..758163af39c262 100644
> --- a/fs/udf/udftime.c
> +++ b/fs/udf/udftime.c
> @@ -1,21 +1,7 @@
> +// SPDX-License-Identifier: LGPL-2.0+
>   /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
>      This file is part of the GNU C Library.
> -   Contributed by Paul Eggert (eggert@twinsun.com).
> -
> -   The GNU C Library is free software; you can redistribute it and/or
> -   modify it under the terms of the GNU Library General Public License as
> -   published by the Free Software Foundation; either version 2 of the
> -   License, or (at your option) any later version.
> -
> -   The GNU C Library is distributed in the hope that it will be useful,
> -   but WITHOUT ANY WARRANTY; without even the implied warranty of
> -   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> -   Library General Public License for more details.
> -
> -   You should have received a copy of the GNU Library General Public
> -   License along with the GNU C Library; see the file COPYING.LIB.  If not,
> -   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> -   Boston, MA 02111-1307, USA.  */
> +   Contributed by Paul Eggert (eggert@twinsun.com). */
>   
>   /*
>    * dgb 10/02/98: ripped this from glibc source to help convert timestamps
Reviewed-by: Jilayne Lovejoy opensource@jilayne.com
