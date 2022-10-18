Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0506026FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJRIdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJRIdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:33:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8100E10F5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:33:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id f140so13445655pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uTmm9dDQ2R4TsTNZChH1eu4CLKVneoMZu9n5+pM/NL8=;
        b=F/eoVMCX224ee9hY7jtJCvjukzZUwpY3HTDiLaIYavMgI2g9VhUY/FdC/QDtm59ECs
         qI/k4jjbbElQOQFQ/1p4GAJHabk2b9cFD6PCF4/uv+xTg1QX/QLYjR43to3On/UeFwvY
         kdY2IX1tIsHgOEQu4RatmfMTmQYOZFy8ACoNy+JEjHxSONbcwGDiYZpH55i0p3LG+nSA
         liI2XQ37DfQUgeOOBHUCSsC2UBvp7k7EqTsMKeeSx3SIhyES0iHvzI90R5E5bfSrvcwA
         ffvhVEio+sV41/nFRkxUFwdqypgrl1ksKSC1GFyf32fJTJsT4Mj5Zh2sDMVC/SVjy2Qb
         DBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uTmm9dDQ2R4TsTNZChH1eu4CLKVneoMZu9n5+pM/NL8=;
        b=s7Lsbm7SmIqGfBZD9ez8XvH/9umxn6UWTm166M/agSbO7P5SEeMTUNGbIeeYbHLxr0
         cvgCBaenSL7rGJvZpUI64kES7mJ7I+1kjsitk7+xUOn2e6htdF/PMUVQnO1UxpXJBKO1
         Vfux08lL6cBBQWzekBubac1ljQync183Hnr36y2rFxGUijaYKx9lU/ZkybmeguUCYyyb
         J6/4KR7u82xcQtytDO2T7xAqu94a5DMB+ulQBfVwccThqMP1Jy4aw9VYGJKsHrhOy7B7
         yEdatd1sDjmCIHCuLuuUOIBJbH6v8pckt/yJebOkDCdAak3TVu0ShR990Kw/8K9EdrYm
         ZOtA==
X-Gm-Message-State: ACrzQf19knWgLV00p37YqbPtNbAcoZRB6DotGzL9Yj4dE5/xsbUmURxb
        j9k7oPB4k8T1MA3DPvOArn8=
X-Google-Smtp-Source: AMsMyM4xUjWNUgR78GDaZTJkM/SnbAiaykX60PbHtCfTuA1PFGKBy3U94bgYV+EHcHc3H0EH+gVpQA==
X-Received: by 2002:a65:6148:0:b0:458:88cd:f46 with SMTP id o8-20020a656148000000b0045888cd0f46mr1702418pgv.303.1666082012029;
        Tue, 18 Oct 2022 01:33:32 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-76.three.co.id. [180.214.232.76])
        by smtp.gmail.com with ESMTPSA id nd16-20020a17090b4cd000b0020a821e97fbsm7481053pjb.13.2022.10.18.01.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:33:31 -0700 (PDT)
Message-ID: <d1f6c2da-4473-d0ae-88a2-dc379a9857e8@gmail.com>
Date:   Tue, 18 Oct 2022 15:33:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jintao Yin <nicememory@gmail.com>, phillip@squashfs.org.uk
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        mirsad.todorovac@alu.unizg.hr, regressions@leemhuis.info,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <20221015205936.5735-1-phillip@squashfs.org.uk>
 <20221018021507.612-1-nicememory@gmail.com>
 <2522e5d5-5f8a-c5e9-4864-a82f0e6d2512@gmail.com>
In-Reply-To: <2522e5d5-5f8a-c5e9-4864-a82f0e6d2512@gmail.com>
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

On 10/18/22 14:23, Bagas Sanjaya wrote:
> On 10/18/22 09:15, Jintao Yin wrote:
>> Hi Phillip,
>>   There is a logical bug in commit 8fc78b6fe24c36b151ac98d7546591ed92083d4f
>>   which is parent commit of commit b09a7a036d2035b14636cd4c4c69518d73770f65.
>>   
>>   In function squashfs_readahead(...),
>>   file_end is initialized with i_size_read(inode) >> msblk->block_log,
>>   which means the last block index of the file.
>>   But later in the logic to check if the page is last one or not the
>>   code is 
>>     if (pages[nr_pages - 1]->index == file_end && bytes) {
>>       ...
>>     }
>>   , use file_end as the last page index of file but actually is the last
>>   block index, so for the common setup of page and block size, the first 
>>   comparison is true only when pages[nr_pages - 1]->index is 0.
>>   Otherwise, the trailing bytes of last page won't be zeroed.
>>
>>   Maybe it's the real cause of the snap bug in some way.
>>
> 
> Hi Jintao, thanks for explaining the real culprit. However, I'd like to
> see the fixup patch from you so that we can test.
> 

Sorry for inconvenience. Hsin-Yi Wang have already submitted the candidate
fix at [1]. Thanks anyway.

[1]: https://lore.kernel.org/lkml/CAJMQK-hgQEkhgpO9VFOCgn-cKtVsr7Hb_58pAYiGoDi5SzGZtA@mail.gmail.com/

-- 
An old man doll... just what I always wanted! - Clara

