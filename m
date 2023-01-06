Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769DD65F9A4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 03:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjAFCn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 21:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAFCn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 21:43:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7416765AD0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 18:43:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBB661CD1
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 02:43:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC51C433EF;
        Fri,  6 Jan 2023 02:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1672973035;
        bh=WmNNxGj4cSqyKU6i+FHCVSPDnmXabZA7XDWvz/rOo6A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SJs6dY8jbeR1bjxa30qfx/BEjhaVK+OQAGCOAwaqhxcHZBmbWNTx2f4uUnlV57H5L
         qxVfOW0d49MABV71dnbiieb3NVP3ZYNy4xjrEd5Fcf9HgwJMDVB1Ki9Hgty9eohKNg
         y3WgEOIOXFUxPdFw5kk1U3c6ELo90MTbK7MkND3o=
Date:   Thu, 5 Jan 2023 18:43:54 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] util_macros.h: Add missing insclusion
Message-Id: <20230105184354.ea9a981aa8c76bbfd6a2c212@linux-foundation.org>
In-Reply-To: <20230103121937.32085-1-andriy.shevchenko@linux.intel.com>
References: <20230103121937.32085-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Jan 2023 14:19:37 +0200 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The header is the direct user of definitions from the math.h,
> include it.
> 
> ...
>
> --- a/include/linux/util_macros.h
> +++ b/include/linux/util_macros.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_HELPER_MACROS_H_
>  #define _LINUX_HELPER_MACROS_H_
>  
> +#include <linux/math.h>
> +
>  #define __find_closest(x, a, as, op)					\
>  ({									\
>  	typeof(as) __fc_i, __fc_as = (as) - 1;				\

Does this fix any known build errors, or was it an I-noticed-this thing?
