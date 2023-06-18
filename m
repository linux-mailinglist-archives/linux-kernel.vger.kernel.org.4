Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D407346CB
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 17:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFRPUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 11:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:19:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A44B4;
        Sun, 18 Jun 2023 08:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3HBZgG4qUmAQw7rnNcqZIFMEIP1Jfb39I+CcrLvxN8s=; b=L1vaeejODXSfzgPVkMZokxyZpZ
        8VFW8hL5X3zLpqTLr8cIwEaAdV9awxwfQgOINigw/grRAxCtPRdvHiiGtZr2ZZR7iR0BlxxDUtJxW
        t9H5BkVrr0SOQskE7UukU5tznTad0Bm9kI1SiGubKIGbsJzqmCskOW8YsYLFchnuRyF5nhhwgOKcK
        0j/qF6dB9XcsYUngPkMQb93AtYqfGS2l+UwDiVGgtT65/80RP0YdYZ4LAE5tlMU1zaw5FwWkIlgQ1
        9oZEpq49sCF0ciXkvWwosx5aS0HQT593OR99ehWKI23cC9HglBB5zAjSOQd8yhEK9bqzjpHMnTbZK
        d14RgkTg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qAuC0-0069Pb-0L;
        Sun, 18 Jun 2023 15:19:52 +0000
Message-ID: <c0c44b35-b55d-6965-7103-76d9a9bf5c0d@infradead.org>
Date:   Sun, 18 Jun 2023 08:19:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4] docs: consolidate storage interfaces
Content-Language: en-US
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>
References: <87h6rhoyag.fsf@meer.lwn.net>
 <20230618062937.481280-1-costa.shul@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230618062937.481280-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Costa,

On 6/17/23 23:29, Costa Shulyupin wrote:
> to make the page more organized as requested
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> 
> ---
> 
> Changes:
>  v4. rollback to single Storage category, add 'TCM Virtual Device'

What does the TCM Virtual Device comment refer to?

Otherwise LGTM.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

>  v3. add Integrity, Virtualization and Miscellaneous per Bagas Sanjaya
>  v2. add Core subsystems, Networking, Peripherals and Embedded
>  v1. add Storage category
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index 55c90d5383ef..b67a1b65855b 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -22,6 +22,18 @@ Human interfaces
>     gpu/index
>     fb/index
>  
> +Storage interfaces
> +------------------
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   filesystems/index
> +   block/index
> +   cdrom/index
> +   scsi/index
> +   target/index
> +
>  **Fixme**: much more organizational work is needed here.
>  
>  .. toctree::
> @@ -31,8 +43,6 @@ Human interfaces
>     core-api/index
>     locking/index
>     accounting/index
> -   block/index
> -   cdrom/index
>     cpu-freq/index
>     fpga/index
>     i2c/index
> @@ -44,7 +54,6 @@ Human interfaces
>     networking/index
>     pcmcia/index
>     power/index
> -   target/index
>     timers/index
>     spi/index
>     w1/index
> @@ -54,12 +63,10 @@ Human interfaces
>     accel/index
>     security/index
>     crypto/index
> -   filesystems/index
>     mm/index
>     bpf/index
>     usb/index
>     PCI/index
> -   scsi/index
>     misc-devices/index
>     scheduler/index
>     mhi/index

-- 
~Randy
