Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509CB69636A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjBNMUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjBNMUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:20:40 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0282D26CD1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:20:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id s13-20020a05600c45cd00b003ddca7a2bcbso6059241wmo.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sCIxUh1eU766A//XSAB+TWvAeHqZbImk0I/eg6f7t1s=;
        b=aTsWhC9Uyq5ROBYi3CsRQ+UznEB/uVmYbhyt5ohjq9dkh0LOJqZ8BQaA/F9a+M/gAU
         /Pt420uerg+q+xMQGNFcuZVdroGbjEPRjO+FhXx3xlkKJY/h+D+KFcom9mtl47gHHGR+
         LWPCtYHmtCe6o5KNNHpBuzvnz1+zEz0GviPeWV9pDdI9uLoRcE5FA7NpHZmwKrLPj/HE
         /Ga/x1D193vvTOo3ltcAdNQJsXSSXeS6MCGVs1zIgcC3Vo+b1qjKTRi84t13/zTCt+Qz
         qeGVhNJibYPz0O3Az8Z7nlzbtbYtpNPAFPeUbuKq7CzrNT4PSs2FfAMkLtUrkgqecVdj
         d8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sCIxUh1eU766A//XSAB+TWvAeHqZbImk0I/eg6f7t1s=;
        b=LyY1wE5uwutaDfv0zZEOGzI9dvaKADw9bvIsmbyNtVIr1PumlWktiOuKyC0Kz5nvdO
         cpK+LNFHnHY7gBmptv+wt09vWPYTDVZBfaUZZLyzBv45dLc+T6FLM35aFYa/J9gGDpLH
         fjcVmv1qZQWqglW8dyaOohh28vKiy11NLqNEq2pxT//vSxoTAZ+Zah6vZ31x6uVEb8X6
         ++/Htha5CIYugvAIvpjO9OFaenSSAxMfyRSK/HG4KO7KQuPLT/beLIGH+eDDqCdeqSbq
         hIS301hf/S/A5cbhfwweGO3poXufEdCkygPAdfh81Iwt226Z7zvzPXrD4MhFxS8AXZHW
         zlZg==
X-Gm-Message-State: AO0yUKV4MfhfmVTXhQEl6bFNBG8rAw2LkuL8D7bjTUUrXKh1yFFmANsM
        t50p8uLgOdf2lP/yQZYgklg3sQ==
X-Google-Smtp-Source: AK7set80bLYuKGSx7ScloB23a5E5LTeqEHXpYNonzK83aCuFDH1xuHZetUyhbwRxa1b+rffWA9gl6w==
X-Received: by 2002:a05:600c:13c5:b0:3dc:5b88:e6dd with SMTP id e5-20020a05600c13c500b003dc5b88e6ddmr2531182wmg.10.1676377209085;
        Tue, 14 Feb 2023 04:20:09 -0800 (PST)
Received: from ?IPV6:2003:f6:af20:a800:4c1e:9f81:fad8:f3dc? (p200300f6af20a8004c1e9f81fad8f3dc.dip0.t-ipconnect.de. [2003:f6:af20:a800:4c1e:9f81:fad8:f3dc])
        by smtp.gmail.com with ESMTPSA id g10-20020a05600c4eca00b003dec22de1b1sm18628266wmq.10.2023.02.14.04.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:20:08 -0800 (PST)
Message-ID: <ddd5d81c-abff-7195-2bf0-039147e3bd80@grsecurity.net>
Date:   Tue, 14 Feb 2023 13:20:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 3/5] KVM: Shrink struct kvm_mmu_memory_cache
Content-Language: en-US, de-DE
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20230213163351.30704-1-minipli@grsecurity.net>
 <20230213163351.30704-4-minipli@grsecurity.net> <Y+puefrgtqf430fs@google.com>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <Y+puefrgtqf430fs@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.02.23 18:08, Sean Christopherson wrote:
> On Mon, Feb 13, 2023, Mathias Krause wrote:
>> Move the 'capacity' member around to make use of the padding hole on 64
>> bit systems instead of introducing yet another one.
>>
>> This allows us to save 8 bytes per instance for 64 bit builds of which,
>> e.g., x86's struct kvm_vcpu_arch has a few.
>>
>> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
>> ---
>>  include/linux/kvm_types.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
>> index 76de36e56cdf..8e4f8fa31457 100644
>> --- a/include/linux/kvm_types.h
>> +++ b/include/linux/kvm_types.h
>> @@ -92,10 +92,10 @@ struct gfn_to_pfn_cache {
>>   */
>>  struct kvm_mmu_memory_cache {
>>  	int nobjs;
>> +	int capacity;
>>  	gfp_t gfp_zero;
>>  	gfp_t gfp_custom;
>>  	struct kmem_cache *kmem_cache;
>> -	int capacity;
>>  	void **objects;
> 
> If we touch this, I vote to do a more aggressive cleanup and place nobjs next
> to objects, e.g.
> 
> struct kvm_mmu_memory_cache {
> 	gfp_t gfp_zero;
> 	gfp_t gfp_custom;
> 	struct kmem_cache *kmem_cache;
> 	int capacity;
> 	int nobjs;
> 	void **objects;
> };

Ok
