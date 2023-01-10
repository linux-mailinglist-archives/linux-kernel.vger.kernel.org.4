Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C82663953
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjAJG1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 01:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234661AbjAJG1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:27:19 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874163E6;
        Mon,  9 Jan 2023 22:27:18 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h26so10180734qtu.2;
        Mon, 09 Jan 2023 22:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bu0dAR79Mb4CN2oYveZXSb6tDGeEyXga5U4Gx/6ltc0=;
        b=mQc12BjcAc5NjZTTLv8+eBwCLCn3X5DKZpVIAXIZqqoSptGAvuSZDqiCBxstp/u5bR
         nhfkhhFLqdv0DtUbZAHcesKl3jQhjO7n7MgeHAS4/BS3PCwCpGIpACIPaWW6lu7NVmbD
         xLaB3s7Gp8sBWVwvabSpd3tMBmmenQFyeOBy+vYmFVKtp/Oa8Sm1qqN0n4P/OMcQwM0i
         LHQKnPmZn470B7856OHgnQJ/SxoNMEQ2nngbzZqRlLm6zyRDYY+zR3plr9r4oT0UVjn6
         KejxgJ2BoB+B8hyBkt9Fsro6edju5heJJkJig3pwn87UqK+ujhvmml5mXIaRba+63Y53
         CnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bu0dAR79Mb4CN2oYveZXSb6tDGeEyXga5U4Gx/6ltc0=;
        b=KS8a5DmE2PTkg1E8VdA/DvoE9PtSNnWkQaMPd98YhhumftlkcUQwj9GbJw2Ay8DiX6
         iJoFDMX9M5osHqxBarv9C3d/Q0qcnTi3ZWP5cIiFYUwNG6KlSW3DAO1P1MA7zDWEKdVm
         avEqyUQ1rt5uEEJFFC143WP00rGQwmKLNIFjCpeiV+yjRfinkuyOirmOBnNCSQCVBtjB
         C+WMqv7bMuHYWojiMvR/pOHBdZBHkHCpFrUO9jvnbcBZBZoJjxG78CFP1q+owHUUWGoy
         ZIkmm5sOHfvBOpUluZME/bCuQvroM14/S3MjpNWZ4xrcMbLP9AHk2qQqH5vG7HqCU5ZH
         XShA==
X-Gm-Message-State: AFqh2krRvfr0ka7NV26xHiGM70UtG5bonhtcIaSI/j7IorsVMOjd7xi5
        +ac/2cYKWuoye9a1PdfOmb8=
X-Google-Smtp-Source: AMrXdXt0K9JVybvOn35L/t7XeK3xtEUcOik04AmZP4zqBmPC54tN64ZuscOwaYNKHGfnmJEKuZ+4Dw==
X-Received: by 2002:ac8:4a97:0:b0:3a8:1ca1:b489 with SMTP id l23-20020ac84a97000000b003a81ca1b489mr81091464qtq.60.1673332037938;
        Mon, 09 Jan 2023 22:27:17 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:cc93:35ee:990:f219? ([2600:1700:2442:6db0:cc93:35ee:990:f219])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a448a00b006faa2c0100bsm6687307qkp.110.2023.01.09.22.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 22:27:17 -0800 (PST)
Message-ID: <907b6b75-55bc-b38c-442b-4ccb036a3690@gmail.com>
Date:   Tue, 10 Jan 2023 00:27:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/2] of: create of_root if no dtb provided
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20220624034327.2542112-1-frowand.list@gmail.com>
 <20220624034327.2542112-2-frowand.list@gmail.com>
 <20220624141320.3c473605@fixe.home>
 <6d40876c-2751-01bb-94ab-7c9ab90e636f@gmail.com>
 <20221011092654.6c7d7ec3@fixe.home> <20230109094009.3878c30e@fixe.home>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20230109094009.3878c30e@fixe.home>
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

On 1/9/23 02:40, Clément Léger wrote:
> Le Tue, 11 Oct 2022 09:26:54 +0200,
> Clément Léger <clement.leger@bootlin.com> a écrit :
> 
>> Le Fri, 24 Jun 2022 11:44:07 -0500,
>> Frank Rowand <frowand.list@gmail.com> a écrit :
>>
>>> On 6/24/22 08:13, Clément Léger wrote:  
>>>> Le Thu, 23 Jun 2022 22:43:26 -0500,
>>>> frowand.list@gmail.com a écrit :
>>>>     
>>>>>  
>>>>> +/*
>>>>> + * __dtb_empty_root_begin[] magically created by cmd_dt_S_dtb in
>>>>> + * scripts/Makefile.lib
>>>>> + */
>>>>> +extern void *__dtb_empty_root_begin;
>>>>> +
>>>>>  /*
>>>>>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>>>>>   * @limit: maximum entries
>>>>> @@ -1332,8 +1338,13 @@ bool __init early_init_dt_scan(void *params)
>>>>>   */
>>>>>  void __init unflatten_device_tree(void)
>>>>>  {    
>>>>   
>>
>>
>> Any news on this series ?
>>
> 
> Hi Frank,
> 
> Do you plan on resubmitting this series ? If not, could I resubmit it
> after fixing problems that were raised in the review ?
>> Thanks,
> 

Thanks for the prod.  I'll re-spin it.

If I properly captured all the comments, I'll have to implement
Rob's suggestion:

  "either CONFIG_OF_FLATTREE or CONFIG_OF_EARLY_FLATTREE will need 
  to become user selectable."

-Frank
