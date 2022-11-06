Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6382B61E0D3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 09:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKFIVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 03:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKFIV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 03:21:28 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239E8DF31
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:21:27 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x2so13245876edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gB8/kLjDzYvH1OFObBtjT/KXWPSjKGugDqtND1QBAz0=;
        b=O3LkO5IBuPqt+6AczW0OZXWujDV9hNZ7NFBCy7c8NinLp/R11uqctZlUSZrCOoXAwJ
         QtCG8cFD66JijqJXoT9axTUGgycibPQpsMSaz5cxvrpBHzUjR9Jo5T7b6F6NVRm360yk
         un9nY2bz6uFMsIN+xe23Jbi6e3IrWx5I8Z68WrJ87kTOrZ/JwLE+ZJ2YzydqMHkxuEHW
         xvRgIzr9lSYdEPWt13mJmTaQtIzchXAB0xwXYIgbwngPs37xrFcHbKuZ4lJy0Of+2D9m
         H5Tn1Lvd3SdvfyF+aPEkU3RoVrqkcGvU6b3k9T+ufTVSSn9lSE1+ccsT/0Fy4SYr551v
         /s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gB8/kLjDzYvH1OFObBtjT/KXWPSjKGugDqtND1QBAz0=;
        b=x3hAz0/i1wXvw3VyL6vEWnx0W+VDdh8PXAfbOB3cLnbuyD9GYdcxVceJ4rwb/Wlf3S
         5SjGvYr8lk2PyqZh4ytCQC5dE88ha3qVpTYqOzad8rSw47/IW0cTaxrQ3/vf5MIGPNhW
         Spm+Qqq4CD9Jcig7FyqI/TXkEK3HpZRgmgtP1vo0OIo0KEsuBkEOK6QfCE1eI9tCB6w/
         EWTvV/5Y1EwZ7/oMr039o+UorIKOUO5rgAKzEiDX3rf43oh4ALiZ2VUMGE7afpw1IfGj
         kQ/zrLzQE/H4waNlKKKzh02dZqqH1aXMoknohsIStXK31GEonquEaDYgZs7V4QEv2CJf
         UfUA==
X-Gm-Message-State: ACrzQf2Fc69Ri9tRVF7Mjv+3Bf+9RW0eYTkDOBnvnT4Yl+RPHjHBXhys
        BvE3w7wV8mCams9TT7hNIHg=
X-Google-Smtp-Source: AMsMyM4f83PyWr9r/xHVlXmWyxOt8rjE3HUgRTRQdHG9fg0pbKHw3vvqm7DoriR/buvZQXCIEPH29g==
X-Received: by 2002:a05:6402:b0e:b0:461:f7a8:3e3a with SMTP id bm14-20020a0564020b0e00b00461f7a83e3amr43999512edb.372.1667722885427;
        Sun, 06 Nov 2022 01:21:25 -0700 (PDT)
Received: from [192.168.1.101] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id vv2-20020a170907a68200b007417041fb2bsm1845820ejc.116.2022.11.06.01.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:21:25 -0700 (PDT)
Message-ID: <5eda8c39-016e-fb1d-c403-08ffd13c2a90@gmail.com>
Date:   Sun, 6 Nov 2022 09:21:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: rtl8192e: trivial code cleanup patches
Content-Language: en-US
To:     Jacob Bai <jacob.bai.au@gmail.com>, joe@perches.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <cover.1667704057.git.jacob.bai.au@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1667704057.git.jacob.bai.au@gmail.com>
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

On 11/6/22 04:13, Jacob Bai wrote:
> Rename few variables and source files to make it align with other
> rtlwifi drivers.
> The patches are required to be applied in sequence.
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

The v3 is missing in the subject.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

Bye Philipp
