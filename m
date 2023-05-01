Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410166F36B8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 21:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjEAT0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 15:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjEAT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 15:26:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD783585;
        Mon,  1 May 2023 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=31TjznsBOkdR5oAIp2LjKpSdXSSIBsN8UEHGaYYmYms=; b=oej7/PFu12q7bn/5uMLuk4bS6+
        QIKRq8APfLXPYOPK1MxNB1uw29L3Fbc6l5/840+cBCfloSpxZZ3ejNuWYmrRsxAJeZd7gbZaw5PfC
        iVStWNRATM6k81Qquj5tqJRADDDfFQl0nJNo8+/2FUHQ/R7SgrUUljdsrSVe2ZmXuDgkFsLeZWLq8
        mau4sP8SlpxEH2ilt+KvjSINmefWPlYeGH19zHQhReQYpmvCUb6R8nM2DfrdunEXE7b5V0Q/1Utuf
        77+t3Lro5e7VzCvka09gdIt4rY8OjdjEMR13JWCw4jAy2ff5n2BVWBXkEpyQOHDX3ut3N6lPbZCr0
        +ydRAfkg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptZ9t-00GgdA-2D;
        Mon, 01 May 2023 19:26:01 +0000
Message-ID: <0754e279-ae06-9b57-f655-cc7cc9eb6ecb@infradead.org>
Date:   Mon, 1 May 2023 12:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] docs: consolidate human interface subsystems
Content-Language: en-US
To:     87h6sw9iq0.fsf@meer.lwn.net, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Cc:     Costa Shulyupin <costa.shul@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230501154258.277866-1-costa.shul@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230501154258.277866-1-costa.shul@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/1/23 08:42, Costa Shulyupin wrote:
> to make the page more organized as requested
> 
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
> Changes:
> - fixed typo
> 
> ---
>  Documentation/subsystem-apis.rst | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/subsystem-apis.rst b/Documentation/subsystem-apis.rst
> index b51f38527e14..287799ee2419 100644
> --- a/Documentation/subsystem-apis.rst
> +++ b/Documentation/subsystem-apis.rst
> @@ -10,6 +10,18 @@ is taken directly from the kernel source, with supplemental material added
>  as needed (or at least as we managed to add it — probably *not* all that is
>  needed).
>  
> +Human interfaces
> +---------------

Did you test this?
I would expect a complaint about the underline not being long enough,
although I didn't test it either...

> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   input/index
> +   hid/index
> +   sound/index
> +   gpu/index
> +   fb/index
> +
>  **Fixme**: much more organizational work is needed here.
>  
>  .. toctree::
> @@ -22,9 +34,7 @@ needed).
>     block/index
>     cdrom/index
>     cpu-freq/index
> -   fb/index
>     fpga/index
> -   hid/index
>     i2c/index
>     iio/index
>     isdn/index
> @@ -40,12 +50,9 @@ needed).
>     w1/index
>     watchdog/index
>     virt/index
> -   input/index
>     hwmon/index
> -   gpu/index
>     accel/index
>     security/index
> -   sound/index
>     crypto/index
>     filesystems/index
>     mm/index

Thanks.
-- 
~Randy
