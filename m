Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70617623BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbiKJG0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 01:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232447AbiKJG0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 01:26:40 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280342D75C;
        Wed,  9 Nov 2022 22:26:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so3915757pjs.4;
        Wed, 09 Nov 2022 22:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bg2fwHDXpbz6kXvhQh/IXFOjIezcUhnTaWVp/eQou7k=;
        b=iehBS61IcxN/nvIwqQfXc8bibEjpINcIqpIW5PNSggb43qaa8KA6XHzy+ltnYcDj1D
         ei+iED6nxT99mBfpCgYmRTifJSDDGatv/frwAWQlj49TBl6FQCcY+oQBeU2+yewLEpRR
         50YpGQu+vtmHQduu7PeckKXrd8EbNVeRnsyjjAGH30rSDYqoWn/XdyL6mJj6utdpYFHb
         V9Jjlj45RZe/lmwIuPfN0niqUqQ2RmPL9GeGZMsRmbDo5m6Uf0BYLTiF9knyvHsuNIkl
         xHxh68IgCNAZELYcBtQmFurh7A6ZqwARYlPaRH3int14uYzSe/Knw8uXIUCkAEAEruyD
         1sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bg2fwHDXpbz6kXvhQh/IXFOjIezcUhnTaWVp/eQou7k=;
        b=URmF+qFTa122HIaYQmIVmjsykyXyqo1D9aZr1/g8hYwTcaxSsdCkc4oXAN9+3C5f66
         xCwft/0I9SP09vdxlHwEJGCF0OP/W+zLXL9xirI/8g6z1rdNT2bRW7XSPQcTONvDwj+b
         7sbKQYWiT3wVEbqobkBW1C11AdLM+3NW7civzXIChMf77pMK6md4Pq0fzQg5jgehbd74
         7BNBwIz+mAggwqbw/Pgvr1cADoLMqVOfTetfU62Drtc+L41V128ptD1Y/QrSi/MzWMHG
         SBUB/CkvX4Oo0y6KHgu0+LBajnQpx9qD+Ho8UuAI0Z87D/PuP/qCH2oM+myCuN9HKCOe
         AxmA==
X-Gm-Message-State: ACrzQf2yFm2e2P+9jkJWKZEQepZ3HFkTIUuifGmYcd7zSyjfOxsTTohd
        s+dS7r8FhWv6Mpmri805akg=
X-Google-Smtp-Source: AMsMyM6+vElG4xBAVjrGjFHfxFZvsCoNxs3fCh/BfCFV9EOgijHHVTV+0ShMlEZ/rEwsfK4cF8fuug==
X-Received: by 2002:a17:90b:3b84:b0:212:c06c:47ba with SMTP id pc4-20020a17090b3b8400b00212c06c47bamr1319847pjb.131.1668061599606;
        Wed, 09 Nov 2022 22:26:39 -0800 (PST)
Received: from [192.168.108.223] ([159.226.94.108])
        by smtp.gmail.com with ESMTPSA id m28-20020a634c5c000000b00451f4071151sm8315045pgl.65.2022.11.09.22.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 22:26:38 -0800 (PST)
Message-ID: <130cbc98-ef82-027e-d610-4273756d36ba@gmail.com>
Date:   Thu, 10 Nov 2022 14:26:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] module: Fix NULL vs IS_ERR checking for
 module_get_next_page
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221110025834.1624394-1-linmq006@gmail.com>
 <Y2x5a1YVbvmqrK9O@bombadil.infradead.org>
 <ffda7120-c2aa-d093-a2a5-f5d169c7651e@gmail.com>
 <Y2yUkxeBEF40olMD@bombadil.infradead.org>
From:   Miaoqian Lin <linmq006@gmail.com>
In-Reply-To: <Y2yUkxeBEF40olMD@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/10 14:05, Luis Chamberlain wrote:
> On Thu, Nov 10, 2022 at 12:18:50PM +0800, Miaoqian Lin wrote:
>> Hi,
>>
>> On 2022/11/10 12:09, Luis Chamberlain wrote:
>>> On Thu, Nov 10, 2022 at 06:58:34AM +0400, Miaoqian Lin wrote:
>>>> The module_get_next_page() function return error pointers on error
>>>> instead of NULL.
>>>> Use IS_ERR() to check the return value to fix this.
>>>>
>>>> Fixes: b1ae6dc41eaa ("module: add in-kernel support for decompressing")
>>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>>> ---
>>> Thanks queued up. How did you find out? Just code inspection? I see
>>> chances are low of this triggering, but just curious how you found it.
>> I found this by static analysis, specifically, I obtained functions that return error pointers and
>> inspected whether their callers followed the correct specification.
> Which one did you use?
I wrote custom checker based on the weggli tool (https://github.com/googleprojectzero/weggli).
>   Luis
