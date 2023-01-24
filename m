Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E4967A211
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 20:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAXTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 14:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjAXTCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 14:02:10 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06B14FCD6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:01:49 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id e3so14836630wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 11:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S3KZqt7KtaJtK5kczaKVU8eo16OQrh5dnqNWX+toslk=;
        b=Gi2gSj1gTc6WPkN0ntPl1Hby13U0YA5+3kKr4ge/7rUybcXruohTyC4GRk9zSlvBwL
         5sEGcS26Od5vRzt6tfuXQFGxVKHjlFHR0X+jYnOrBn6CzNu8nr71EvzmNVvpqyeVT0I8
         /ymm9KO4qd1yY8OSImzKdNSEMwOeHvBP8f0roGLntqLYQX9WZqe+PZeKyNDm0ITgL1xZ
         YzQN++XUQ2xOggrvGU61/puwBoC0hYilPcHrxe+k7M6MIYUNIaiInwMhq4b7jikPUYtu
         fQ8cvO2j6ytCC5lyJaQDG+3cH9LsPXtLB7xUjUSohhXorj8pgpFj/eHho384S84mUjku
         HjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S3KZqt7KtaJtK5kczaKVU8eo16OQrh5dnqNWX+toslk=;
        b=HF5N5z7FW3LgHvl8Z259w5VGK+YYebnlYsaFvvJ8AhwRb5qxanO7pI+UIGoSgY3+AI
         8NsfagIfGYgSpB2DPxm0ysceja/3nRaboozcztKhAhhjcN9i5w3rZNSQw68wx/v9jG27
         9LJWGfa5B7tfE+q9MFWiBUiJ+DFjCxX6z+A5SuMtisLR9Vnyny+ra1zxFIlLZppoGKKM
         sybCm35ialoLg93J2cBHkNGZIIa9Qqea8+uYjYcbRYDIj+/Lnjvlop7BZF5SXyyRF9+A
         u502zYuHqysgmB/iWd8XNc4uNY0AeQ6E9xgFEDAjMeVRjF9qf+5rPOYv1yeRJdmde1oO
         De3Q==
X-Gm-Message-State: AFqh2koP4x+edQusZgEfk9dZ3/pOSzITImuR8VW1YXtYZAunrkNXxZcc
        srZvnT8Xek1af7tAQQuNyTI=
X-Google-Smtp-Source: AMrXdXux0xWZkh5VyjCZK+JTI7uxz2CN6V5IQ9/EHBMVf2Ua9yR9rJCYXjuI6Y8UbPIKCqkJcLBj/Q==
X-Received: by 2002:a5d:6b50:0:b0:2bd:e204:9165 with SMTP id x16-20020a5d6b50000000b002bde2049165mr5162055wrw.1.1674586908111;
        Tue, 24 Jan 2023 11:01:48 -0800 (PST)
Received: from [192.168.1.102] (p57935ca5.dip0.t-ipconnect.de. [87.147.92.165])
        by smtp.gmail.com with ESMTPSA id r3-20020a5d4e43000000b002be0b1e556esm2474097wrt.59.2023.01.24.11.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 11:01:47 -0800 (PST)
Message-ID: <4a827107-de14-f569-02fd-de7956317459@gmail.com>
Date:   Tue, 24 Jan 2023 20:01:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/23] staging: r8188eu: some more xmit cleanups
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230123205342.229589-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230123205342.229589-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 21:53, Martin Kaiser wrote:
> Here's another series with cleanups of the xmit part. Amongst other
> things, it replaces some __queue variables with standard list_heads.
> 
> This series also includes rebased versions of the patches that caused
> conflicts during the last review cycle.
> 
> Martin Kaiser (23):
>    staging: r8188eu: we use a constant number of hw_xmit entries
>    staging: r8188eu: pass struct adapter to usb_write
>    staging: r8188eu: remove struct intf_hdl
>    staging: r8188eu: remove struct intf_priv
>    staging: r8188eu: simplify the sta loop in rtw_dequeue_xframe
>    staging: r8188eu: simplify the code to initialise inx
>    staging: r8188eu: remove an obsolete comment
>    staging: r8188eu: remove unused function parameter
>    staging: r8188eu: remove dead assignment
>    staging: r8188eu: use list_empty
>    staging: r8188eu: simplify dequeue_one_xmitframe
>    staging: r8188eu: remove redundant parameter
>    staging: r8188eu: make rtw_chk_hi_queue_cmd a void function
>    staging: r8188eu: decrement qcnt in rtw_dequeue_xframe
>    staging: r8188eu: simplify dequeue_one_xmitframe
>    staging: r8188eu: use list_head for xmitframe list
>    staging: r8188eu: merge dequeue_one_xmitframe into its caller
>    staging: r8188eu: use lists for hwxmits
>    staging: r8188eu: fix rtw_xmitframe_enqueue error handling
>    staging: r8188eu: remove rtw_xmitframe_enqueue
>    staging: r8188eu: struct agg_pkt_info is unused
>    staging: r8188eu: apsd_setting is unused
>    staging: r8188eu: merge rtw_free_hwxmits into its only caller
> 
>   drivers/staging/r8188eu/core/rtw_cmd.c        |  16 +--
>   drivers/staging/r8188eu/core/rtw_xmit.c       | 119 +++++-------------
>   drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |   7 +-
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  18 +--
>   drivers/staging/r8188eu/include/drv_types.h   |   1 -
>   drivers/staging/r8188eu/include/osdep_intf.h  |  32 -----
>   .../staging/r8188eu/include/rtl8188e_xmit.h   |   3 +-
>   drivers/staging/r8188eu/include/rtw_cmd.h     |   2 +-
>   drivers/staging/r8188eu/include/rtw_io.h      |   8 --
>   drivers/staging/r8188eu/include/rtw_xmit.h    |  23 +---
>   drivers/staging/r8188eu/os_dep/usb_intf.c     |   6 -
>   11 files changed, 57 insertions(+), 178 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
