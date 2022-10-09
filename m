Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E765F88A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 02:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiJIAvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 20:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJIAvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 20:51:51 -0400
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Oct 2022 17:51:50 PDT
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0562736081;
        Sat,  8 Oct 2022 17:51:49 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1290415076C;
        Sat,  8 Oct 2022 20:46:14 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=64jcXFmbuY4KKMAxOmZKPu6bgcOLbUYmXjvBcK
        v0qDw=; b=CsWbubyGa+lnZ6ro0C0+hY3nPTMZeFkQBcJpHsnJXNMr+dJ5v8lIw3
        1QIWQ8mJiAFZaqlvCVaCou1pK6S6/2lWv9wCQaV0ZskEGSbpxXeMISa781nuY9dV
        9HcSmZamWfQQB1HTlYrIF9/NK2FFSi7vw1CAS6aJQoWgxqXXu2c90=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A13615076B;
        Sat,  8 Oct 2022 20:46:14 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=64jcXFmbuY4KKMAxOmZKPu6bgcOLbUYmXjvBcKv0qDw=; b=zDsU0sG2k9AZZlWR2MLRnLQw0rI0D9tK5tzKGNfCeaDkq7xVglDyyCDZ1Cyozv2byNQhJibNSW5vlka9AotycESMMKOh4fP1VPzPQS0fWRXaHHER1LjJ4pg0fpsWAZXhNfeeQhjvCW7n7xY04zmvRDzXxlWXIlwPtBiCHFlRVD0=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76552150769;
        Sat,  8 Oct 2022 20:46:13 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 57B494737A3;
        Sat,  8 Oct 2022 20:46:12 -0400 (EDT)
Date:   Sat, 8 Oct 2022 20:46:12 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cramfs: Kconfig: Fix spelling mistake "adressed" ->
 "addressed"
In-Reply-To: <20221007203644.2756986-1-colin.i.king@gmail.com>
Message-ID: <408r919-971-n7p6-517n-10no3sso97qp@syhkavp.arg>
References: <20221007203644.2756986-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C6752BBA-476B-11ED-BF37-307A8E0A682E-78420484!pb-smtp2.pobox.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022, Colin Ian King wrote:

> There is a spelling mistake in a Kconfig description. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
> index d98cef0dbb6b..a8af8c6ac15d 100644
> --- a/fs/cramfs/Kconfig
> +++ b/fs/cramfs/Kconfig
> @@ -38,7 +38,7 @@ config CRAMFS_MTD
>  	default y if !CRAMFS_BLOCKDEV
>  	help
>  	  This option allows the CramFs driver to load data directly from
> -	  a linear adressed memory range (usually non volatile memory
> +	  a linear addressed memory range (usually non volatile memory
>  	  like flash) instead of going through the block device layer.
>  	  This saves some memory since no intermediate buffering is
>  	  necessary.
> -- 
> 2.37.3
> 
> 
