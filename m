Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5D26C01C2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjCSMw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCSMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:52:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFCE1C5BC;
        Sun, 19 Mar 2023 05:52:25 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id c18so9796446ple.11;
        Sun, 19 Mar 2023 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679230345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sx3R8+4eXcBfWk/kEKY5/xAPakgQR9ddZb5g/YyPWv4=;
        b=I37KCPzSG6H64xonNrJ5rCOPsuWrec4JBJpTWx/Az/+IfD4RfvpFyP2LzK//35QaD7
         4/2rAJdFpKMA5bkNMF6V/Te0ShH7GojvxpRjFS7CoCIjzdwkm9HZguldFOSYrqca7ASC
         bZkHZNKEif/i/rGWhBoVHJFX/cN/59TzP+Dju3XaXsnem8Bz82gM0b8l9kSyYhCNlcZn
         ZBMvtdca3PI1BNlz6fjFwsSxKskoOCQzyPIiAMgpDtkf/KPqLlZHX8o2oTE7KKVCKxu8
         2TQTO1J6rM2dGIPh5ghjvVnoBVTxbCmCUGJvDmFzaWyf4Bzzn4rsdoCQfg7/adh8f58c
         B0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679230345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sx3R8+4eXcBfWk/kEKY5/xAPakgQR9ddZb5g/YyPWv4=;
        b=fXNwtw8233yMFR9h7CpazUmzCPKIqhg8VwftHstuJSmbkhot2JxsErW260irpYorhA
         vDpolBoxjSfH4vQJ0tQPbNpQS/YZrZHImXGe+OQZEvHbPR6az6D3OfDgPcze8NQe2Qpm
         Qs9lu9RVLuHjsH8BwAJfSyXdm/jAaNcILfAxZcKrSLUafxmGQg5QDjxxN+aMs/tTJuDv
         mpfKhN5AwOJ58+wAo+VubkQhXEPyawhMVFmqlhwdjhTyYOYunYlusQDetS6eHDaH6bvz
         s0AOC0OQPlA6UwiasYdrA+cuMw/GkxmGhrQwMzksFgbdcjB88faZ++GxWFAVfrNx4Ugh
         qh0A==
X-Gm-Message-State: AO0yUKVj62zMf8yk+3DH3lWGcGfxcI3aVVhqIZTOO1ttEJ6U8qLk7XhC
        6IJ5QrUMad2c9o0kDAoTyYk=
X-Google-Smtp-Source: AK7set8rbtsa+y0IukuFAqizrLvWMnwirw/hWnmcny3Y9VWHyk7GL5IOCRZkTM34Z0vhJLZtoUeCqQ==
X-Received: by 2002:a17:902:fac3:b0:19e:76b7:c7d2 with SMTP id ld3-20020a170902fac300b0019e76b7c7d2mr12248682plb.26.1679230345011;
        Sun, 19 Mar 2023 05:52:25 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709029a8d00b0019a9436d2a0sm4713018plp.89.2023.03.19.05.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:52:24 -0700 (PDT)
Message-ID: <df9e53ac-be69-60a6-9782-73165873d28b@gmail.com>
Date:   Sun, 19 Mar 2023 19:52:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ELF: document some de-facto PT_* ABI quirks
Content-Language: en-US
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <2acb586c-08a9-42d9-a41e-7986cc1383ea@p183>
 <e262ea00-a027-9073-812e-7e034d75e718@infradead.org>
 <ZBQjRLiXOwfmoIs+@debian.me> <cc449f31-071c-48b8-a6a8-7b91f205c3c6@p183>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <cc449f31-071c-48b8-a6a8-7b91f205c3c6@p183>
Content-Type: text/plain; charset=UTF-8
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

On 3/17/23 23:53, Alexey Dobriyan wrote:
>> The current doc path is Documentation/ELF/ELF.rst, which means that
>> readers expect to find general info about the executable format, not
>> some sort of trivia/niche like this.
> 
> General info is in ELF spec. This document is intended to be Linux
> specific stuff you won't find anywhere but source.
> 
> I'll write down overmapping rules as well.

In the same Documentation/ELF/ELF.rst?

And thus, the doc title should be "Linux-specific ELF notes", right?

-- 
An old man doll... just what I always wanted! - Clara

