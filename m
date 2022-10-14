Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DF95FE9D4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 09:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJNHuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 03:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiJNHut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 03:50:49 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA6710DE5C;
        Fri, 14 Oct 2022 00:50:46 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id l32so2606023wms.2;
        Fri, 14 Oct 2022 00:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFmh108wZNWwhA1RKIQKFbOOcCbpOXk6hBvMipGxkBQ=;
        b=U4rQWATqAoa86GV6EmufFyVghaKe0bzkKqHtV6W/dRzSgR94LxO+SjM6cm0qwdhLpo
         Q6bq78PEJeK7qq5IcF7UcZ38mlrut5K5ar8kQu9wS3rVhwQl2bGLdjACpg1b8fs3pAm9
         NbUCLIWq+eU5kU3SqAzc4+nSBDtfofKzs/a2fi8k7aTSqFCDo+frX5Pr8x0xWJ/R6Bs1
         KN+jkVkOsToObKuYIG9kBe18R7p5Kfx73uy909+AgeGpEPDhF2H9o3ej0esn24wWcIP7
         uHyUCvxj2s9A6zUO2gkilR9qsvXx/sJ8rbmgQ+cv+TI7gucbcQPFXcAjBII0fltddKRK
         +oyQ==
X-Gm-Message-State: ACrzQf0Zw9luj7Uo1GyueXglJtu04/SXsx55RcTUWZjhdplsxjXI0KNd
        giplKUJgM7JvwnFiXC/+h+o=
X-Google-Smtp-Source: AMsMyM6LCeuoLOedEG8cIi/NYPlv6vKBhTiHzvucFE2Ql/YrLjdgc5hS23ffTLoRaYhK2TzKBfKSXg==
X-Received: by 2002:a05:600c:3781:b0:3b4:63c8:554b with SMTP id o1-20020a05600c378100b003b463c8554bmr9216920wmr.25.1665733844686;
        Fri, 14 Oct 2022 00:50:44 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id h10-20020a5d504a000000b0022a9246c853sm1327366wrt.41.2022.10.14.00.50.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 00:50:43 -0700 (PDT)
Message-ID: <58855ea9-0d89-e17d-349a-657512068663@kernel.org>
Date:   Fri, 14 Oct 2022 09:50:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 2/2] platform/x86/intel: pmc/core: Add Raptor Lake
 support to pmc core driver
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, irenic.rajneesh@gmail.com,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Box <david.e.box@intel.com>
References: <20220912233307.409954-1-gayatri.kammela@linux.intel.com>
 <20220912233307.409954-2-gayatri.kammela@linux.intel.com>
 <3537fa63-9015-c63d-2321-a77062e24d6f@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <3537fa63-9015-c63d-2321-a77062e24d6f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 09. 22, 13:41, Hans de Goede wrote:

> On 9/13/22 00:33, Gayatri Kammela wrote:
>> Add Raptor Lake client parts (both RPL and RPL_S) support to pmc core
>> driver. Raptor Lake client parts reuse all the Alder Lake PCH IPs.
>>
>> Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: David Box <david.e.box@intel.com>
>> Acked-by: Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
>> Acked-by: Hans de Goede <hdegoede@redhat.com>
>> Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
>> ---
>> Changes since v1:
>> 1) Added a dependency patch- ea902bcc1943f7539200ec464de3f54335588774 :
>>   "x86/cpu: Add new Raptor Lake CPU model number".
>> 2) Rebased the above patch on v6.0-rc1 with "Acked-by" from Hans and
>>   Rajneesh.
> 
> I still cannot take this, since patch 1/2 is *already merged* through
> another tree, so me cherry-picking it leads to potential conflicts.
> 
> As I have already explained twice you need to submit this upstream
> throuh the same tree which has the original merge of patch 1/2.

Hi, friendly ping: has this ever happened, Gayatri?

thanks,
-- 
js
suse labs

