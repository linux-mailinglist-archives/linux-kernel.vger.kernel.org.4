Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08AD361E0E8
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiKFImF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFImD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:42:03 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0578DEE2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:42:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y14so23018746ejd.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IedN9hGTjUJRM2QkZwLtvVtdrbrOyzLZkXMJyjsl+hA=;
        b=g+obRviENN53QePdR7rWfD4VqexqHxi++mvPGoZHbL+JzhjrpwZB+cfV9C7azOCYch
         oCdxuPHJ36o+qQAieEMvvx6LImmFSdXdOkisTvvVLsmZ0LxwwWKnmkZ7R60AxX5Dc8/k
         4BNFTXIJzG9513WV19xwuAyYwocdazDT8KhrFo94JK0fvwrA+Y3u/p7k1N7mytFts1Ze
         5B91MphoyrQ+k8ha3pM5qSnDLNf+tQSUpby6CmJb74nskXo4tNHrUmBoBWFQdzpGigRf
         ei3GYKirviw/dZe9q4KYQkmEiOJla3fPe+hJdnY5BLl0NugVEkiWrdHJE1C/NxeqCBwe
         VS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IedN9hGTjUJRM2QkZwLtvVtdrbrOyzLZkXMJyjsl+hA=;
        b=W9+SEldrSXBP57aTFC0bTHOgEtKX0nviHnfQN3Qsv03sh+rNYSZUojwQmcd8F1c2QQ
         1B2Jd2k2L2Hqb/5njPOSk67ODw3zGwA+NXf/VRWoAA9Y0q+/CJFfFw6fwI3OcRJmlMLc
         WtywKQK0r5NNTxsi7r76Ual5f2hp+h3g/h6+6+yafnzpE0BiyLZj2PBAi/v2hRZ1Do4G
         WMCYvypckAUDICm7860NCZKrnOQr2AHlG/TkQJf2sXBVkgZEfgi9MFBLyQogIMT+tkI6
         fLC5XIj82pxp8O7D+kpNSmakDJjHWLg3LR6n8YoahhXC4rrk9jhxWuOosbhgPnv8xb2X
         MOTw==
X-Gm-Message-State: ACrzQf2ciJH9hbsl4XGwrcC2mlWVTpPDeYNt3K8vx3aQvYrCK13yMG9Y
        VfS6fQG/me1XpSR2F3sOwY7PmhmJt/o=
X-Google-Smtp-Source: AMsMyM7u07RjQ3ASogJmMcT0hLRCJpmj2isSmn2b/XDouMeBcnXp38LkRVSuoOJ9amhzori9kW5QvA==
X-Received: by 2002:a17:907:1ddd:b0:7ad:8371:b59c with SMTP id og29-20020a1709071ddd00b007ad8371b59cmr41935954ejc.429.1667724119358;
        Sun, 06 Nov 2022 01:41:59 -0700 (PDT)
Received: from [192.168.1.101] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ku15-20020a170907788f00b007ae1ab8f887sm1918549ejc.14.2022.11.06.01.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:41:59 -0700 (PDT)
Message-ID: <d564a877-c2f1-20f7-90eb-d4ccfcb70277@gmail.com>
Date:   Sun, 6 Nov 2022 09:41:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 0/3] staging: rtl8192e: trivial code cleanup patches
Content-Language: en-US
To:     Jacob Bai <jacob.bai.au@gmail.com>, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1667723306.git.jacob.bai.au@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 09:31, Jacob Bai wrote:
> Rename few variables and source files to make it align with other
> rtlwifi drivers.
> The patches are required to be applied in sequence.
> 
> Changes in v4:
> 	1. missing vision number in the v3
> 
> Changes in v3:
> 	1.Patch 3: use ARRAY_SIZE() to replace macros, feedback from
> joe@perches.com
> 
> Changes in v2:
> 	1. Patch 2: modify r8192E_firmware.c to include table.h instead of
> r8192E_hwimg.h.
> 
> Jacob Bai (3):
>    staging: rtl8192e: rename tables in r8192e_hwimg.c
>    staging: rtl8192e: rename r8192E_hwimg.c/h to table.c/h
>    staging: rtl8192e: replace macro defines with ARRAY_SIZE
> 
>   drivers/staging/rtl8192e/rtl8192e/Makefile    |  2 +-
>   .../rtl8192e/rtl8192e/r8192E_firmware.c       |  2 +-
>   .../staging/rtl8192e/rtl8192e/r8192E_hwimg.h  | 33 ------------
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 54 +++++++++----------
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.h    | 20 -------
>   .../rtl8192e/{r8192E_hwimg.c => table.c}      | 34 +++++++-----
>   drivers/staging/rtl8192e/rtl8192e/table.h     | 33 ++++++++++++
>   7 files changed, 84 insertions(+), 94 deletions(-)
>   delete mode 100644 drivers/staging/rtl8192e/rtl8192e/r8192E_hwimg.h
>   rename drivers/staging/rtl8192e/rtl8192e/{r8192E_hwimg.c => table.c} (91%)
>   create mode 100644 drivers/staging/rtl8192e/rtl8192e/table.h
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
