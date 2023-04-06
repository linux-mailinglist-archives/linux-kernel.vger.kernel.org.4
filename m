Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDFB06D98CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjDFN6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbjDFN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:58:08 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF09777
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:57:45 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-17786581fe1so42391536fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 06:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680789464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwjbDL5RnCNXJ7w11XcKwq0d9Uw54uiNfMuw1QQDbuU=;
        b=dAsAdK9V4ARLjY+zpgrgkhY7ni0OMNQFhBTsm/tVaLuPmWugXEVINMNvIWsTZcXpLL
         XwZjMz8BxHO28Ox6DxJriD0g3b+DnDP/llHPr99iQX5UdCydECkInG7AmpFE5SxCGTaR
         X2CGJF1VT6WeyH3W1YrlcRuOj4Qt1Oo0vO5aWsLbxzg9KSpbtJEnE9iLyDe2IHUzg7lh
         iSlNGIRNtOrdPdB9X9RDqCHSNQQUDmnfs1AyYv/gXtm2ndBHjcHRqbGYIUyn4O8eysim
         bVl7N1o50Wq+MeFrNX/zMDrjMZpezqPo/9AXMiojdxZGH+bL7px4YBU+nGfPIXSfddKH
         J3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680789464;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZwjbDL5RnCNXJ7w11XcKwq0d9Uw54uiNfMuw1QQDbuU=;
        b=WCMaklfVZd4TEPTxdHkSSqbM0CsL4sDA9OkGfHTHJePJrq7cYZOMb9X/H6IUJst+cH
         NK1wVR348Oe72DQmlUFJbqu65FZn6WjM6F7QDcWC3MPnxwGBozIonO4ry7thAOEPAAY1
         f+g7NYc20cX0RLnQcDeyf4Lo7n7KsjlhCxnsZlJtZ9sJ03Kx7MFhdJ4RvU+SZOFsyaT2
         lSkNlrXpg+kIxrxxFP2/duj4DgXV9mbfUJDScfSqsKrxf33RsMu3BVimg/2n2q2k4yVn
         dQuLlqnMxwajOr8xwichQtTvzInQZY+y6BfLu4yYbkYmyKFNsqyWjTylLN6bjwEIc3u+
         vqLg==
X-Gm-Message-State: AAQBX9fYOFjkt2oHTlG59V8uBnp6dpK4qmObzW5AW77CXDEkghb4BEkX
        k3QAMXzTbWz/RN6pw6cyl+G+rC2Ql50=
X-Google-Smtp-Source: AKy350ZG7Q26V9uIzMXnISrNBOoWfbciLp0ikFwAyPf6p8ameENR1AD1HDwtkd5TDO9VFK1RPauH4g==
X-Received: by 2002:a05:6870:b006:b0:17a:cd1e:b0d3 with SMTP id y6-20020a056870b00600b0017acd1eb0d3mr3261318oae.3.1680789464608;
        Thu, 06 Apr 2023 06:57:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id tk9-20020a05687189c900b0017ae6741157sm703896oab.4.2023.04.06.06.57.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 06:57:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <83e6bc46-dfc0-0e95-e69c-5b996af1e50b@roeck-us.net>
Date:   Thu, 6 Apr 2023 06:57:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm-treewide-redefine-max_order-sanely-fix.txt
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <9460377a-38aa-4f39-ad57-fb73725f92db@roeck-us.net>
 <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230406072529.vupqyrzqnhyozeyh@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/23 00:25, Kirill A. Shutemov wrote:
> On Wed, Apr 05, 2023 at 10:20:26PM -0700, Guenter Roeck wrote:
>> Hi,
>>
>> On Wed, Mar 15, 2023 at 06:38:00PM +0300, Kirill A. Shutemov wrote:
>>> fix min() warning
>>>
>>> Link: https://lkml.kernel.org/r/20230315153800.32wib3n5rickolvh@box
>>> Reported-by: kernel test robot <lkp@intel.com>
>>>    Link: https://lore.kernel.org/oe-kbuild-all/202303152343.D93IbJmn-lkp@intel.com/
>>> Signed-off-by: "Kirill A. Shutemov" <kirill@shutemov.name>
>>> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
>>> Cc: Zi Yan <ziy@nvidia.com>
>>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>>
>> This patch results in various boot failures (hang) on arm targets
>> in linux-next. Debug messages reveal the reason.
>>
>> ########### MAX_ORDER=10 start=0 __ffs(start)=-1 min()=10 min_t=-1
>>                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> If start==0, __ffs(start) returns 0xfffffff or (as int) -1, which min_t()
>> interprets as such, while min() apparently uses the returned unsigned long
>> value. Obviously a negative order isn't received well by the rest of the
>> code.
> 
> Actually, __ffs() is not defined for 0.
> 
> Maybe something like this?
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 7911224b1ed3..63603b943bd0 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2043,7 +2043,11 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>   	int order;
>   
>   	while (start < end) {
> -		order = min_t(int, MAX_ORDER, __ffs(start));
> +		/* __ffs() behaviour is undefined for 0 */
> +		if (start)
> +			order = min_t(int, MAX_ORDER, __ffs(start));
> +		else
> +			order = MAX_ORDER;
>   

Shouldn't that be
		else
			order = 0;
?

Guenter

