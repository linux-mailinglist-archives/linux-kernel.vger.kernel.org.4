Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CA606C06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 01:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJTXX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 19:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJTXXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 19:23:25 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5D81DC828
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:23:24 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h185so931690pgc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 16:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CE6evqtIX+07t9cXGQPGwOH1py4DcBmEiVntfTOE+UA=;
        b=DsYLC1odzvMybDOKm2hjUoY7g7UyfNQ9/CdHy1fupzg7ZV1mL78dpgznLgl5cEGy/1
         Luw4PGzTeGt54qhMOgg1z6CIBjQRmKSe5SQcETMiCH6pb9slYyicgODC2ZJri1ABEagg
         oiHmHrKwX/KamQtgITQVNGtoHIXfRtPqc5vBT0sqbC3rFF3ly++0dvKVweATlMftUf0T
         P7OeZn8SLxTsYltgV6ohukrXbxFD7Rky8jZ4Js3tHWARiOA54uDO4yVEfAgr5cXUPaTZ
         XXB7TQ/vaX2Tldv+2t1rHn881zREeW9LdbFgI2jLosEG5CpDg1d6DNEjwwT3lHVfz8Em
         FI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CE6evqtIX+07t9cXGQPGwOH1py4DcBmEiVntfTOE+UA=;
        b=B79N9cMuAnS2Cv+86rHOAhRjmrbt98QKXDu4k8hW6UkkIDR/j2EaiiIeW4eehcaJOb
         cDk5Zfmt+F4UqRL5tfQYm7tr1GBFqIF3rM8+kaP9pQlL+N4Nu8MKyPB12BVg1nBNTQdK
         pXt1OmJ6/buI7WFeHeTby8kDKoyJRvsj7K6Mh/EdsuhzFPpygiPbIquB6fso7X5y39WV
         iEegACBRc68kcfQCfN30SwwmTBUeBS3IB5YEPF748KzecraHxylUvpdDrlQoXnCsiTsh
         4+pK2+q14w4Vq7M88l0ZOuMeLCrDXbKQgP2eSQhD6VKdKWkWel2MeSRBMQ/eQXJ+RD2j
         uD+Q==
X-Gm-Message-State: ACrzQf3gnBMTRtA4rqTukF0vODYmhsbpmUqm9q0ByeLlgkGeXXKMj8h1
        s8RgBMgIAPikATevgBW+FEdmEi+Wmfqs2A==
X-Google-Smtp-Source: AMsMyM6SYRWDFAek8ZuBOMLzRnxVB7h7msJN8vNg0BbbLcyfagcKQhlV8lFGFt67DZf72OZkvjwlWA==
X-Received: by 2002:a63:fc12:0:b0:45f:a6e3:7559 with SMTP id j18-20020a63fc12000000b0045fa6e37559mr13797009pgi.237.1666308203894;
        Thu, 20 Oct 2022 16:23:23 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-32.three.co.id. [116.206.12.32])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001750361f430sm13341444pll.155.2022.10.20.16.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 16:23:23 -0700 (PDT)
Message-ID: <02b72b86-7240-5530-477a-c8bdcfd35ef5@gmail.com>
Date:   Fri, 21 Oct 2022 06:23:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Jintao Yin <nicememory@gmail.com>
Cc:     hsinyi@chromium.org, linux-kernel@vger.kernel.org,
        marcmiltenberger@gmail.com, mirsad.todorovac@alu.unizg.hr,
        regressions@leemhuis.info, regressions@lists.linux.dev,
        srw@sladewatkins.net
References: <20221018174157.1897-1-phillip@squashfs.org.uk>
 <20221020135545.586-1-nicememory@gmail.com>
 <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <41ef4b22-eea8-2d67-99d8-6aaae7d25ac1@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 22:45, Phillip Lougher wrote:
> On 20/10/2022 14:55, Jintao Yin wrote:
>> Hi all,
>>
>> After review the details of page actor, the tail bytes may be written to
>> a temp buffer instead the last used page. So before diff would wrongly
>> memzero a page which is not the tail bytes in.
>>
>> In this diff fixes it by caculation of the real index the trailing bytes
>> in and check if the last used page matches this index. If the page is
>> the real tail bytes in, then memzero the trailing bypte of the page.
>>
>> Please help test and any feedbacks are welcome.
>>
>> Thanks,
> 
> This is a rediculously complex patch.  Sorry, but, absolute NACK.
> 
> Additionally, it is poor etiquette and pointless to fix an
> already fixed issue with a _more_ complex patch.
> 

Ah! I was about to test his third fixup patch. I prefer to go
with your fix instead (as the formal patch).

-- 
An old man doll... just what I always wanted! - Clara

