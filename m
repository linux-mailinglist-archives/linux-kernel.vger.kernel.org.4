Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05635FF2DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiJNRUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJNRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:20:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EC474C8;
        Fri, 14 Oct 2022 10:20:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y8so5460306pfp.13;
        Fri, 14 Oct 2022 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8fPATVudPSO8kPCMernk2QpFo+S936O55u8ii3pliT8=;
        b=Yb1g2J3WyyLaHftxPyVqzcvJFeRCCS/ltPklCPgWW4ho9ldmCbVtfj0YZ1A9sowbI1
         tkjrZPZLQi7GZ55jrd9Fc/qdaDHwQnFwx8W6ffa0v3nC2/XoOeIvAbT4k0QrqW364Orw
         RuILkjYGbeoUZM5ZVcYoxIBKtpdospnzfSq2+Dfs7m5Qa5tyjYBOQQrTne5+vhaSmKW5
         JV44cLlEP73eU5tf1bDXdc7zmqKsWbLIA3OK/MYojmg7HTLIdG8oOi0p49wvyNDHpbm6
         ImtG+xCvSqfhKorDMOGiVxDoJb9KAl14UGTRJPPR1t1z6dQWTNtTgmtflzsJCvyZzDZV
         vfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8fPATVudPSO8kPCMernk2QpFo+S936O55u8ii3pliT8=;
        b=uq5zRKhBNPwWqq1MZjZG4i3xnE4sFJKeOPYGIe/EbMjHMuHGCoTxgw5lfhcmd2EXAh
         Zrbv8Jr+4VJ3Upv72L5rUzMZ76dEkA04CNGfnSQ0LaqT51EYHCPOVCmMvDGZ4VuWYEnc
         SiT8GHMZGCopP7Si7w88wCeuCA2l3F6a/usubnRVU1NoNee5j/UZGomVpmdHXsCFflTI
         Ds3bqHsSZyIj2I0mpbj2hER4slyq26+Jj2fesnMFyD9eLkGmN4I7R05NnF/upcoYH/EP
         2dJy82FW4Fc0F0CGJhl0swOOqPxxQkcfiJzWD0W1oM6cznMzW3K/Xrk5SzOeEQg7wje9
         4v8w==
X-Gm-Message-State: ACrzQf1l0TU4yQyouXR/Aj9/4JCPrxAA9hzYKOQ0CT3Bv8mAneCoyfjn
        QP0yUOXaaOwEN4ETZBBSLmOSNQAu5ZM=
X-Google-Smtp-Source: AMsMyM5ewOIFNBJTWOZa+ubmmdVyGYhR8cPMq/e0Hz0ynxbPZJiac9+bq8Oud3TxWBLqDpyvKGLZCA==
X-Received: by 2002:a63:5547:0:b0:456:c63b:7139 with SMTP id f7-20020a635547000000b00456c63b7139mr5502466pgm.179.1665768031920;
        Fri, 14 Oct 2022 10:20:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g186-20020a6252c3000000b0055f98a2c64bsm2068276pfb.142.2022.10.14.10.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 10:20:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ed901a64-7002-4a4e-1342-c06f9a398fd1@roeck-us.net>
Date:   Fri, 14 Oct 2022 10:20:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V4 1/4] hwmon/coretemp: Rename indx to index
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        jdelvare@suse.com, len.brown@intel.com
References: <20221014090147.1836-1-rui.zhang@intel.com>
 <20221014090147.1836-2-rui.zhang@intel.com>
 <ad558e83-3e42-aefd-754d-e71f49dda206@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ad558e83-3e42-aefd-754d-e71f49dda206@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 10:12, Dave Hansen wrote:
> On 10/14/22 02:01, Zhang Rui wrote:
>> Use variable name 'index' instead of 'indx' for the index in the
>> core_data[] array.
>>
>> No functional change expected.
>>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Ingo Molnar <mingo@kernel.org>
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> 
> Hi,
> 
> Thanks for paring this series down.
> 
> I think I'm also going to pull this patch out of the series before I
> apply it and just rework 2/4 to apply cleanly without it.  I just can't
> put this in our "urgent" fixes pile and keep the stable@ tag on such a
> trivial rename and keep a straight face.
> 

To be fair, this patch was only submitted as a prerequisite to the next
patch in the series because someone had objected to the use of both 'indx'
and 'index' in the driver.

Guenter

