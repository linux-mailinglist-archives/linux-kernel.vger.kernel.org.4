Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7611B73CABE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 14:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjFXMQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 08:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjFXMQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 08:16:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB81BFC;
        Sat, 24 Jun 2023 05:16:04 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so1395399b3a.2;
        Sat, 24 Jun 2023 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687608964; x=1690200964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q5gqXPV4PTFmPbh9Zh+d+AFfgDSYPHvyuQvmSWXaCHM=;
        b=GSlyV/6jSVuH94sgYqU5l2hZ/vFLVm17jC73az92Vrcd2d/BFlXXxFFxzf6Vp30FCx
         tVRrSaAozJxD7ShYaUpUlNDY7siYc3h8j9GhCsVR6eCxllgrTEWB0U7uzwfTTYVI6W7x
         AZbfqlbw9T8QYbUXWyw6VwUByWJZcodGY9vyeASiKn2e9Di8ypFNy1fgw4BBjstTdrzn
         xCeqoyS/osXPg4iWIkkCAtppNK12CFynje23SverEgCXnwis39rppObDTejJyCXqTh1s
         CmVAglsURQcjwkjzADdbhyt1JRDe0FI6ASOdtcXJ0akfAeNh/nzjQx8y2KlFhcvajhb+
         TpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687608964; x=1690200964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5gqXPV4PTFmPbh9Zh+d+AFfgDSYPHvyuQvmSWXaCHM=;
        b=Awi2QLudna7leKo3WY9dMUSZZ41cSL8de/RzArkMDrfypfpNuX/Mb8vqZswVnlJzmB
         NEURqPr5mEgoX/gL2KZ8v9VuVhVeoSGgofnkE/CuJrkUZWyLoCFZTZ4V7f6a6CspfwyX
         /QX3xvFLZrLr13i7Kr9ljkn6H7FjKnGsqlYIi2m7UViCd25muqWCt1iPtuqOIxw7gAJ8
         6izPSEIXNg2fQg7s4wMni9umLOu2uJP2IM9z2eo2ZLEVYmG7DarXwqq2duEdCdlpQ+fc
         KVi8vgMbXYT8Sec/iCbSt/86sz7OsbaXsx4dRrJ6PDUdLu9j2h1ifzTg2aBtp0nyO4G2
         RfSg==
X-Gm-Message-State: AC+VfDx355Ju6dJvirTvZRckvefSwiGDyYUD3Hxz+Y3qMcAXkjsWSx9i
        dL7jhQMgOBa+hd3Nj+7JVp07SCIy9JSiig==
X-Google-Smtp-Source: ACHHUZ5EpQ65SR/LaXzT/XybSAMzramJefXD9F0LO3L1KAkTP0j347Sr+AXCX1XFPm90SaCzHiVC4A==
X-Received: by 2002:a05:6a00:1a53:b0:66a:6339:e8f6 with SMTP id h19-20020a056a001a5300b0066a6339e8f6mr8131229pfv.10.1687608963801;
        Sat, 24 Jun 2023 05:16:03 -0700 (PDT)
Received: from [192.168.0.103] ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b0065418efa5ebsm991442pfn.155.2023.06.24.05.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Jun 2023 05:16:03 -0700 (PDT)
Message-ID: <c125ec63-f7ba-3fd6-c286-05854fa1a07a@gmail.com>
Date:   Sat, 24 Jun 2023 19:15:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Fwd: kernel fault on hibernation: get_zeroed_page/swsusp_write
To:     Elmar Stellnberger <estellnb@elstel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management <linux-mm@kvack.org>,
        Linux Stable <stable@vger.kernel.org>
References: <5d4959b7-61da-8ab0-6bc6-21305d37c7aa@gmail.com>
 <ZJXFgfldS6W_LCiI@mail.dotplex.com> <ZJZGE4ZxJzrhRznA@debian.me>
 <ZJbDqStCNfdpwObE@mail.dotplex.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZJbDqStCNfdpwObE@mail.dotplex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/23 17:21, Elmar Stellnberger wrote:
> Hi Bagas S., Hi all
> 
> concerns: Bug 217544 - kernel fault on hibernation: get_zeroed_page/swsusp_write 
> https://bugzilla.kernel.org/show_bug.cgi?id=217544
> 
>   Bisection does not make sense here, since I can not reproduce the
> issue. Packing the kernel binaries and symbol files was meant to invoke
> gdb directly on the kcore:
>  

Thorsten: Should this be marked as invalid/inconclusive?

> Am Sat, Jun 24, 2023 at 08:25:39AM +0700 schrieb Bagas Sanjaya:
>> On Fri, Jun 23, 2023 at 06:17:05PM +0200, Elmar Stellnberger wrote:
>> Can you attach [1] to your Bugzilla report? Also, any report on bisection?
> 
> Pardon, what is [1]?
> 

Your kcore dump.

-- 
An old man doll... just what I always wanted! - Clara

