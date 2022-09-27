Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBE05EB97A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 07:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiI0FQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 01:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiI0FQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 01:16:31 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBA70E44
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:16:30 -0700 (PDT)
Received: by mail-wr1-f52.google.com with SMTP id bk15so5449652wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 22:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ga0RqLSliNP+FJ4Tb+3ocnOsXESUJGK7r7heBZyk+1Y=;
        b=K8QV0mzaUaV0OPGHYEhh/jeQHAszFG/JXIHfWYlL7vgL/DqcIQlnbxQCRTymcXRFE2
         issKwLgd7ly8jxT5oPF2cG44FD6MYbro40asPuToPcOGsN2/Z6TRlrdCW13ACFfXm9qV
         hVpYQ2eL36p/ueJZrWssAZYf1ycxYj/Ok3KGxT3cXZ6SQdMmPLwN5tBEkJxa/wkbHYWI
         8T/AI4OieqN9ogw7StFHmMKU35XGxG7WUrjNCA5Lo0rOzZ3wfDmDjC8SXFwhyqEB8SkM
         T69o/VQTBfw2A++CmEX6QA4mERC8PFzpw9UwpVJoNAhloploqOs3pj9ylDS94cg447oO
         i9ew==
X-Gm-Message-State: ACrzQf3H8LMNn/gD6xvHuygsmkfyN4d3qtPlS0WSZc2Uc/QpBC3L9rdf
        agAv5L35fGwFupUCCW0fptg=
X-Google-Smtp-Source: AMsMyM5j8scNA4LbI8bOpHR25FRlO79A8GbXN5CnZxpwLovxU0sMEaw4Wxx3n4DnzXZMndCTIdDLIw==
X-Received: by 2002:adf:f4cf:0:b0:228:63bd:da33 with SMTP id h15-20020adff4cf000000b0022863bdda33mr15305324wrp.181.1664255788858;
        Mon, 26 Sep 2022 22:16:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b00225307f43fbsm708147wrs.44.2022.09.26.22.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 22:16:26 -0700 (PDT)
Message-ID: <0432cfc3-88e2-5d36-539a-757017b3089d@kernel.org>
Date:   Tue, 27 Sep 2022 07:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] serial: Convert serial_rs485 to kernel doc
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20220926123735.50804-1-ilpo.jarvinen@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220926123735.50804-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26. 09. 22, 14:37, Ilpo Järvinen wrote:
> Convert struct serial_rs485 comments to kernel doc format.

It'd be nice if you referenced the struct from Documentation/, so that 
it is: 1) checked, and 2) rendered somewhere.

> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> ---
>   include/uapi/linux/serial.h | 61 +++++++++++++++++++++++++++++----------------
>   1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index cea06924b295..67d4bc663521 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -107,37 +107,56 @@ struct serial_icounter_struct {
>   	int reserved[9];
>   };
>   
> -/*
> +/**
> + * struct serial_rs485 - serial interface for controlling RS485 settings.
...
thanks,
-- 
js
suse labs

