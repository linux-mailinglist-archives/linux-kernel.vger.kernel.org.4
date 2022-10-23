Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB776093DA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 16:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJWOUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 10:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJWOUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 10:20:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F5D6F543
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:20:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bu30so11819217wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 07:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/orQTBhmScBMes7cEg9o5UNm+NtQahGU/9bTdc+qHMc=;
        b=M40WNjmuZQ86ORS7qOwd3tLxZaGx73PsButnOh1stkRm7mWEL8BZEOTsaUdGWbhd84
         L3rA7bw/d5blYCaVfyRH8q8sODTRUgbblZC+67i9L7Q9aNTZzWWaa4WqkFEDKT4C5MmL
         6LqyhHLg0XzNrhnJZ7KEExaP5jRbciqimKMA/ijKR9qNMr+0mKkLmFEe2/qvn3iAtoVY
         ia7ZtBzd2ITtXGFKfEp0rSTohWanxPw3m9HQfI99va44UqA1cqYJbRVfT3Cdjl9TnbGT
         Klt2DDY6ZKNvpYv/QwbFfFRYto1RsGVCPDGye97NFLv3K53//HAXLc07YB8w18rE+CTC
         SN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/orQTBhmScBMes7cEg9o5UNm+NtQahGU/9bTdc+qHMc=;
        b=NrJx+GiOpqUF4iFHwx8t5uXv0aDJlDHokMFSZ0OYUrNefD2rev19EJxE3ZUHC2MI1H
         uIb5Rem0jBscYUoJn/L2IVpm46fCzYzkZL9xSukImhd0Dbd9c+C0LidoeaKUgDUJ/Y8H
         16KZJJnVdZyz1PxvfdU8zziAS1pkETRMYnOhR+ONxbGVPRzGqTwvCpj3xS4H+w0qRGC3
         fyIiEcaBEBwcuZDTw/bdXqOZZ1szG/yjQPLTEil0FgJLNzgow3bhDDPxScfEp1o6gXvp
         BY5EPWI0nrkW+vUxXMi5XE+0SLXm5OvK1t6sFNhzTiBBOjs0Wbha0d/ZJ6LSSDSL2at5
         QGgg==
X-Gm-Message-State: ACrzQf2s+7B3LtZ7ITvkuzkrtICe9A6plaDIAVSxohNg9HWfDCyIG8zL
        v3w1rbCnOvTclXfyoSDjGPjwmk6sMbw=
X-Google-Smtp-Source: AMsMyM4pdG6Ip1BZxSseQVyUtWoSxVYA+OhZxVwvHaYeS+1IT5EpgArkrpVHlV7ReM4pT3B/shhkpA==
X-Received: by 2002:a5d:4c43:0:b0:236:547f:bd3c with SMTP id n3-20020a5d4c43000000b00236547fbd3cmr8416119wrt.380.1666534848482;
        Sun, 23 Oct 2022 07:20:48 -0700 (PDT)
Received: from [109.186.183.118] (109-186-183-118.bb.netvision.net.il. [109.186.183.118])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003c6bbe910fdsm6718928wmq.9.2022.10.23.07.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 07:20:47 -0700 (PDT)
Message-ID: <9674abb2-b40c-3862-5272-58b643dc91e1@gmail.com>
Date:   Sun, 23 Oct 2022 17:19:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [PATCH] char: xillybus: Fix use-after-free in xillyusb_open()
To:     Hyunwoo Kim <imv4bel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
References: <20221022175404.GA375335@ubuntu>
Content-Language: en-US
In-Reply-To: <20221022175404.GA375335@ubuntu>
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

Hello, Hyunwoo.

> A race condition may occur if the user physically removes
> the USB device while calling open() for this device node.
> 
> This is a race condition between the xillyusb_open() function and
> the xillyusb_disconnect() function, which may eventually result in UAF.

Thanks a lot for pointing that out. In fact, this reveals two problems 
in the existing code:

(1) unit->private_data is accessed after the mutex has been released in 
xillybus_find_inode(), so there's no guarantee that it will be valid. 
This is what the test caught. This can however be fixed just by moving 
the release of the lock a few rows down.

(2) xillyusb_open() accesses @xdev without ensuring that it won't get freed.

Both of these two issues have a negligible probability of causing a 
visible problem, but this must be fixed, of course.

> 
> So, add a mutex to the xillyusb_open() and xillyusb_disconnect()
> functions to avoid race contidion.

I'm not very fond of this solution, partially because this mutex 
protects code and not data (There's this "Lock data, not code" rule, see 
[1]). Also, xillyusb_disconnect() can take a significant time to run, 
during which xillybus_open() for another (unrelated and still connected) 
XillyUSB device has to wait. I guess this demonstrates why protecting 
code with a mutex is considered bad practice.

Besides, there are already three mechanisms in place for preventing 
premature release of memory:

(1) @unit_mutex in xillybus_class.c, which protects @unit_list.
(2) @kref inside struct xillyusb_dev (xillyusb.c), which protects the 
structure it resides in.
(3) @error inside struct xillyusb_dev, which prevents xillybus_open() 
from opening a file that belongs to a device that is about to be released.

It's now apparent that they're not working well enough. Rather than 
adding another mutex, the existing mechanisms should be fixed.  Would 
you like to do this, or should I?

Thanks again,
   Eli

[1] Documentation/kernel-hacking/locking.rst in the kernel tree
