Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BB6651E26
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiLTJ5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiLTJ47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:56:59 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F2F19027;
        Tue, 20 Dec 2022 01:54:21 -0800 (PST)
Received: from [192.168.231.135] (unknown [213.194.155.136])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B7D326602CAF;
        Tue, 20 Dec 2022 09:54:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671530060;
        bh=hGDOLF1RyGRcC3iX5uCk+dEsXvStRSEoO8MB9kbk4uc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hi3q6NMex3dFB8xrlrmd0eXb5H8vjTGkxGdBjOK5iW78R5BRQf1eDsSzSrPFziNYP
         zN/WIRc1nzGGpIPKPHbEzyD1wtSH6k7Hw7x7S8ObdFquKhxIqHiwvgUFwO0z82YtEf
         r1TsNNITanfsXFxb9UgTzOSbd13U5zZILfjGhgrgkNlxO84zAg7vmJrwUyNGaAXn27
         OUVuFbClmt5vp2U0DqqIG7Bb3m0oWD3Jj9O5za3BZpZzRrtU/ae1mXUA3WBTQz907v
         ZvZX+tQHCz4Le4dpXOmpT3FKAle72pHGYHVQUDJhoaWYD2MRnMrqObo2ZkuXqw/bDC
         7M7yjiAusFI7Q==
Message-ID: <bf9bd0ba-c703-1903-7df2-ac95dea0f3e8@collabora.com>
Date:   Tue, 20 Dec 2022 10:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] virtio: fix virtio_config_ops kerneldocs
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, mst@redhat.com
Cc:     sfr@canb.auug.org.au, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
References: <20221220073709.2687151-1-ricardo.canuelo@collabora.com>
 <Y6F8dlRQbOzIvJff@debian.me>
From:   =?UTF-8?Q?Ricardo_Ca=c3=b1uelo?= <ricardo.canuelo@collabora.com>
In-Reply-To: <Y6F8dlRQbOzIvJff@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

Thanks for the review, some comments below:

On 20/12/22 10:12, Bagas Sanjaya wrote:> On Tue, Dec 20, 2022 at 08:37:09AM +0100, Ricardo Cañuelo wrote:
> Describe the steps needed to fix both warnings above. I see in the diff that:
> 
>    * move vq_callback_t() declaration above;
>    * match entity type of virtio_config_ops; and
>    * reformat @finalize_features description.

I wouldn't like to add redundant info in the commit message for
such a trivial patch. The commit message describes _what_ the
patch does. The _how_ is just as clear in the patch itself as in
this description, IMO.

> 
>> Signed-off-by: Ricardo Cañuelo <ricardo.canuelo@collabora.com>
> 
> You need to add appropriate tags:
> 
> Link: https://lore.kernel.org/linux-next/20221220105956.4786852d@canb.auug.org.au/
> Fixes: 333723e8bc393d ("docs: driver-api: virtio: virtio on Linux")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

Thanks for the tip although, actually, it's not that commit that
needs to be fixed but the kerneldoc itself. The warnings were
made visible after that commit but not introduced by it. I'll add
the Reported-by tag in v2.

Cheers,
Ricardo
