Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7325E9C61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbiIZIru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiIZIrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:47:37 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9521EADD
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:47:36 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so6033991pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zx7C8hUC8uJlj/LCHHs+NE++TUFzrNQZEMGrjupRGvk=;
        b=cJO0Q8RYU1eD67h2oj6HcH/iziJoZ6USpaIH1IiQarytU6idHx8j/Omw8bQrsm5er4
         5LWNuQ4Fiqi6ndRYsjqBT6JDrSW/nEcID5oRXSuD9OGqpbrB6RqfiDnF6ocf5XBNlbRT
         0ah+BisXy/oF+XVBCUdMfh68Acus18622T4d29MAgJ8fMVYAGpDWqIcl8xLo4FG3ZqQX
         /oaWtzcOuvIfljt6cTUsAdaQt6rfCMIdDCOcCmYhc4ytYm89EB1JnqPsRVDt+XcLLqwp
         ILBRTWUu+7QO/NyXOQ/bQmd4jpJB1TjisGWrJpYl1P4PLAR9tRMdfXN+CCJCly7aL/M7
         G8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zx7C8hUC8uJlj/LCHHs+NE++TUFzrNQZEMGrjupRGvk=;
        b=UmYRRmx4qrGezsVUm9bYXAsNny/psKZPFaiaW71ygIp6sQTPWtfRZN4d2edGOyvhWW
         TjyE0KNsUNLKdbG0nkP2oNQ/a6shroXNpwAxhOIbUQTUOPL8YDD+dupZkHagJ6vVxKBi
         qflE2dyGZU3aTUhaZqK0fXTiFXaroN+FTTTMxVwRzrjQEvnZSvEYAX+jQYSOPsPvV7+9
         lsP2uVIemPcwhfggjnSFcGKK6mkoxR9MSbKTmOsYWE6KWbB8GrcV5d2XmJSYpjlrGFOT
         x7ovB7IZv6YERw/gtYSZbWVSO47cdgRGbvkClqxBdqI6+hoUT8l5QVcbTcjiWOwNqkvc
         CL2w==
X-Gm-Message-State: ACrzQf1pQLDCyZ1Ifc9IycSVGzf8vv231n8kCtJhb4Bdt2MufLj36+j9
        MlW+OWUGcaLvyGFp4q4A9ixxhQ==
X-Google-Smtp-Source: AMsMyM7q6yEkCdIIC7b0tutmfQi6J1GkVgDmKCmJjgiElePNYFll1wJn3zl4t0bPWSzziqcFHM9tJA==
X-Received: by 2002:a17:903:230b:b0:177:e667:7862 with SMTP id d11-20020a170903230b00b00177e6677862mr21151572plh.154.1664182055627;
        Mon, 26 Sep 2022 01:47:35 -0700 (PDT)
Received: from [10.255.6.155] ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id a8-20020a170902900800b00178acc7ef16sm10665577plp.253.2022.09.26.01.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 01:47:34 -0700 (PDT)
Message-ID: <babdbd1f-9629-c23a-f29f-7520ced3854b@bytedance.com>
Date:   Mon, 26 Sep 2022 16:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH] mm: fix misuse of update_mmu_cache() in
 do_anonymous_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Muchun Song <muchun.song@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        chris@zankel.net, jcmvbkbc@gmail.com, maobibo@loongson.cn
References: <20220924053239.91661-1-zhengqi.arch@bytedance.com>
 <3A09E40A-E2C5-4C6F-8550-DD0E17B7DAB9@linux.dev>
 <48590f80-fc58-bf67-5acf-082880a607b2@redhat.com>
 <e1a6007d-24f2-5153-5382-f66391cbd0cb@bytedance.com>
 <1a69af58-b9d2-6319-9db7-f92428b87612@redhat.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <1a69af58-b9d2-6319-9db7-f92428b87612@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/9/26 16:42, David Hildenbrand wrote:
> On 26.09.22 10:41, Qi Zheng wrote:
>>
>>
>> On 2022/9/26 16:32, David Hildenbrand wrote:
>>> On 25.09.22 03:43, Muchun Song wrote:
>>>>
>>>>
>>>>> On Sep 24, 2022, at 13:32, Qi Zheng <zhengqi.arch@bytedance.com> 
>>>>> wrote:
>>>>>
>>>>> As message in commit 7df676974359 ("mm/memory.c: Update local TLB
>>>>> if PTE entry exists") said, we should update local TLB only on the
>>>>> second thread. So fix the misuse of update_mmu_cache() by using
>>>>> update_mmu_tlb() in the do_anonymous_page().
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> The change looks good to me. However, I am not sure what is the
>>>> user-visible
>>>> effect to xtensa users. So Cc xtensa’s maintainer and the author of
>>>> 7df676974359
>>>> to double check this.
>>>
>>> And if there is one, do we have a fixes tag?
>>
>> IIUC, there's only a performance difference here, so maybe there's no
>> need to add the fixes tag?
> 
> Maybe be careful with the usage of "fix" in subject/description then and 
> point that out in the description :)

Ah, will change subject/description in the v2, thanks. :)

> 

-- 
Thanks,
Qi
