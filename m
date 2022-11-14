Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62A6274CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbiKNDCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235698AbiKNDCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:02:41 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A0013D7E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:02:40 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id n17so1527359pgh.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jNzjIIGaNWRSoePM8YAxJiE54VMGSbC0iksQUaSkt0=;
        b=FQkAN9AewYwroQ1aZJ1Yo5hDn/l4puoTTLKJ8wQmLSbxrzZT6I0MRz2o2cCrB1YZsE
         lW/C+yJRTYuwgSXPw1qBTG9AgoPBATarcFZndMv05skoGwHkvAJ7NZfSvQmSpVEz6Is1
         mtdUAliWGK+Kpr+Zd9ukxZ6BUUVZGKC1iUMVuYPFjW6HVxQgS+NqVyeQ+RHfsQD2eZvK
         BZ2o39Wb7UziqurPs2LptQyIyaPhudSqc4A2A0htOI9QuwlaKiKIU5J71NWTqRXNEvsT
         zcuS1zkmeB+FSbLQ4BSgyJZYGcV5PKHTSI9j4ywchJ3exkh/DZbuFJyzU98Q6/9odBfL
         vGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1jNzjIIGaNWRSoePM8YAxJiE54VMGSbC0iksQUaSkt0=;
        b=PXVXayspZAMrK83FrH1o0GvHneWrAOjSogBoGfKHG8hf7+iystN6S1ds4M8YAiKPoW
         Z1KXmoyAvcZp9UN5OFyTlC5E/wBDTIqXLmn/YXtO4o1TgSxYzF0f+DLjCBP3GWlz6NZ2
         Tvh19kLO9jRfnRM45H5xABIDW5T7ZGTRSMm3WIwtvFKmz0BwaDz/L5OC9tLKIsQbriDc
         vEHFj0yNSRlVcYglSLTslwBfXT/LMJElk3/DkhYd4zg9tyEbRHvvj7CcaPeeU8K6INGh
         eo9yXSnxvgvE0cBmSDUeVAKR8TLPiG46sHlOjmkCP0OwA/6+Cpa6TaefGoRjdCB8T4SN
         9TJQ==
X-Gm-Message-State: ANoB5pkIjFZTvzegxYUs6p/rFev3Kh238SiuXXwzlkwZYjRP5Ib1Kqqz
        174/dHj4fh8g12fyMOyclpc=
X-Google-Smtp-Source: AA0mqf4tYkipmJhdV7TI8IpfoVHr0ro+Fskvyq0Br7HeJD2vN+GpdEQC6nb5rzRIuba1QxRUCuHE/w==
X-Received: by 2002:a63:195c:0:b0:46f:b6e1:1966 with SMTP id 28-20020a63195c000000b0046fb6e11966mr9984215pgz.625.1668394960121;
        Sun, 13 Nov 2022 19:02:40 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h9-20020aa796c9000000b00571f4386697sm2373196pfq.24.2022.11.13.19.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 19:02:39 -0800 (PST)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     david@redhat.com
Cc:     akpm@linux-foundation.org, imbrenda@linux.ibm.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v3 2/5] ksm: support unsharing zero pages placed by KSM
Date:   Mon, 14 Nov 2022 03:02:36 +0000
Message-Id: <20221114030236.513178-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3e61fb01-5277-80a4-610e-0608475637f8@redhat.com>
References: <3e61fb01-5277-80a4-610e-0608475637f8@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> - * We use break_ksm to break COW on a ksm page: it's a stripped down
>>>> + * We use break_ksm to break COW on a ksm page or KSM-placed zero page (only
>>>> + * happen when enabling use_zero_pages): it's a stripped down
>>>>      *
>>>>      *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
>>>>      *		put_page(page);
>>>> @@ -434,7 +428,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>>>      * of the process that owns 'vma'.  We also do not want to enforce
>>>>      * protection keys here anyway.
>>>>      */
>>>> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>>> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>>>> +				     bool ksm_check_bypass)
>>>>     {
>>>>     	struct page *page;
>>>>     	vm_fault_t ret = 0;
>>>> @@ -449,6 +444,16 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>>>     			ret = handle_mm_fault(vma, addr,
>>>>     					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>>>>     					      NULL);
>>>> +		else if (ksm_check_bypass && is_zero_pfn(page_to_pfn(page))) {
>>>> +			/*
>>>> +			 * Although it's not ksm page, it's zero page as placed by
>>>> +			 * KSM use_zero_page, so we should unshare it when
>>>> +			 * ksm_check_bypass is true.
>>>> +			 */
>>>> +			ret = handle_mm_fault(vma, addr,
>>>> +						  FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>>>> +						  NULL);
>>>> +		}
>>>
>>> Please don't duplicate that page fault triggering code.
>>>
>>> Also, please be aware that this collides with
>>>
>>> https://lkml.kernel.org/r/20221021101141.84170-1-david@redhat.com
>>>
>>> Adjustments should be comparatively easy.
>> 
>> ... except that I'm still working on FAULT_FLAG_UNSHARE support for the
>> shared zeropage. That will be posted soonish (within next 2 weeks).
>> 
>
>Posted: https://lkml.kernel.org/r/20221107161740.144456-1-david@redhat.com
>
>With that, we can use FAULT_FLAG_UNSHARE also to break COW on the shared 
>zeropage.

Sounds a better way for breaking COW working with reliable R/O long-tern pinning.

>-- 
>Thanks,
>
>David / dhildenb
