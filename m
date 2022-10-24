Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4AB609E00
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiJXJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJXJ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:29:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448E11A1E
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:29:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id p3so7023613pld.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 02:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yd+fxQKSE026OpZCfef536OFjJNo72Gu5e08Gc6kKHs=;
        b=iIvkvtlGpeDGszoMl3nRMlQ6N3mHCjIPx4UmJus9Z2sHCWiZWQmNAaORPdX9Dl4stS
         ZSexmfE6i/lOLfg/uvfl3CbhLSamiv4wgHMrU2a/UMdZ7eQKP5yL9HgYOhW7flDtKFu1
         ToPqqJy1aGENjH56jzo8d/9V6X7NfW5ACBfn5VkPRBpqANjnpZWNMEtuFCqAEMBU1LlJ
         xGDxIjBoSE4weWYR0PvWL/at3+EKA6iWXPeYww/ODaZKuheb03a4BHOo/TCWgcYxdtil
         Y8Bix4WsWICuRyMKwvU5qA2ImVTO89jh48n1pyJhXVM+QbnXup5UU79LbrgAlKjfhbmt
         T64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yd+fxQKSE026OpZCfef536OFjJNo72Gu5e08Gc6kKHs=;
        b=GuANp54qVBEJQjZ0IR4PD5smDJexbbtaQn6g+RAk/8aEQIRjclhEqyQAgzuFIG6hCP
         SZchcyaCWVuPXEMRwMNZfxbQAyG00YqjLhP7CpEioW/AgVV5PfNIgUyxxd/yd42Cz2g3
         Z05NpCgDXsSC83mypucpf3/cDksn4s7mABBYgS2fYyGVR8JVbPT7PgnpRQHZ/Rww2YBA
         tltBzVVQELCIRR8zc8oZWbUnzQpKNsTakZqekNGOg92FE7gzzoarHhT7ufp5OWoPz0Yv
         55fbnZn3aPrgSOS9KZxFkdGgPVLhHRywXp0OJ92T2RNGz0Q1B8aWszw4GdeQQoU/4/D6
         xdAA==
X-Gm-Message-State: ACrzQf2w+PDYOmr+R3Io6E/SMQwfhinhGSeCSSOfI0NuktAbFjo2bOFl
        fynQSeFUs5cTAkePJzbmEmY=
X-Google-Smtp-Source: AMsMyM6zJqhF6xDUC1q2Ge13+fjfRRKEzGnErz5sBFySzImcI8S5J6i/bwBfZ415pSVcgKEe7C11pg==
X-Received: by 2002:a17:90b:3a90:b0:20d:a54c:e5cd with SMTP id om16-20020a17090b3a9000b0020da54ce5cdmr64819255pjb.183.1666603772445;
        Mon, 24 Oct 2022 02:29:32 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id l64-20020a622543000000b0056b1ecef957sm5123696pfl.37.2022.10.24.02.29.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:29:32 -0700 (PDT)
Message-ID: <85af6032-020b-e406-672f-c4e13ab7f1ad@gmail.com>
Date:   Mon, 24 Oct 2022 16:29:29 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2] staging: wlan-ng: remove commented debug printk
 messages
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Deepak R Varma <drv@mailo.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <Y1L0FiKvrM9jjZG9@debian-BULLSEYE-live-builder-AMD64>
 <Y1VDM2kWIi1I5dqI@debian.me> <Y1VL/wITM64U6qLi@kroah.com>
 <4863c6d7-ffdd-1304-981b-9b0644a87f4e@gmail.com> <Y1YPypVbN5v18uni@kroah.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y1YPypVbN5v18uni@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 11:08, Greg KH wrote:
>>>> Shouldn't these printks be guarded under CONFIG_DEBUG_KERNEL instead?
>>>
>>> No, they should just be removed as was done here.
>>>
>>
>> What if in case of debugging without these printks?
> 
> I can not parse this line, sorry.

OK.

Ah, I mean I have to see Documentation/dev-tools/kgdb.rst and
Documentation/dev-tools/gdb-kernel-debugging.rst.

-- 
An old man doll... just what I always wanted! - Clara

