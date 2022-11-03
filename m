Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC8F618043
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 15:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiKCO4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 10:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKCOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 10:55:47 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322F5111B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 07:55:25 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gw22so1879624pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 07:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDZXj8GxjjLzzwnzzLDMimDqIgBJg1GXsbBMV5BLFZk=;
        b=DAX5Ib72zbcXbDQV1g+lVn1hDwjULe0CH9/YMVCG1hQbvZjWdFqaHBOR0N7iB3YYqj
         /JgecYOLDCYGoENGa9cUPmL5ou3S/ybeaekN4mZv5f9hhUOKFBRFkFAvyTOmrYif+bFE
         m2ABXFYvyZBQkqYgwz/xXvIgElZGBdYa14IBZcrTMor/6XYL8IYvIJK7zmJ2Pt34B+Al
         bVtx/CJB07Yq/6fZd5EQ+V7V3pkiyCyoVsLrpjMouY/ZfUtGUuFm/H6Yp1FlwCAjJ5Ol
         5nlZKi5QTxRFkmHrirau/2KGnIf+pTmWTgIZayuIeVehSKS2D2LLLR/PoUSS78PmWEUT
         BQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DDZXj8GxjjLzzwnzzLDMimDqIgBJg1GXsbBMV5BLFZk=;
        b=NMOT+OoJqpXIQ5SCcVuxPWDsOMJFhrKkq9G6afu3/VBroB15HK/whaGDnJAN6hEZZi
         bPP3lc3+5UQT26m2St1xVgdkXwYpFdBlxZDvLfLLezb3b77eGFEbRu/j4FbwFbqs7V80
         T63DBSWf7uqZGcpcmvSCjCz611bnpJs+8K0cemfl4JTNWkY8zjBp23KUaB7k4XvILeGq
         tb84GkwXZgvy7wUwU/hEJtSoklH5sYRCH0Gf1fp6a7vxof7FO9yYP5MexTEJIbt/By3C
         BiwYaxFzZ+naFmSr+G9j1+sLRmKh9d3bul5Tl0HOQJyTYfa2csItuOdJ6TtRiu4EJvuh
         4aMQ==
X-Gm-Message-State: ACrzQf1dPnVrE67uyy1ZD/3eQUIupV1m5jKJyp3Cbs3jSX0w7cdRHUvF
        am+u5RMNQFPA77BB0vcwz6Q7Ow==
X-Google-Smtp-Source: AMsMyM7E9oRN01SfGdM6D4I2DLXL6UNTenOwUZMM+VatfZSgZRUKDHoyGD6dHUiqEi4SkFHi8GMeKA==
X-Received: by 2002:a17:90b:3690:b0:213:c985:b5ee with SMTP id mj16-20020a17090b369000b00213c985b5eemr26277194pjb.192.1667487324534;
        Thu, 03 Nov 2022 07:55:24 -0700 (PDT)
Received: from [10.12.136.34] ([143.92.127.224])
        by smtp.gmail.com with ESMTPSA id y3-20020a17090a1f4300b002135fdfa995sm78693pjy.25.2022.11.03.07.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 07:55:24 -0700 (PDT)
Message-ID: <830cdb70-2823-9c46-1986-2801023353d0@shopee.com>
Date:   Thu, 3 Nov 2022 22:55:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
Subject: Re: [PATCH] cgroup: Simplify code in css_set_move_task
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221020074701.84326-1-haifeng.xu@shopee.com>
 <20221027080558.GA23269@blackbody.suse.cz>
 <adb7418c-39a2-6202-970a-a039ad8201dd@shopee.com>
 <20221031131140.GC27841@blackbody.suse.cz>
 <25f6a188-4cc6-dace-1468-fd5645711515@shopee.com>
 <Y2MoBeJGU1Exg6cX@slm.duckdns.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Y2MoBeJGU1Exg6cX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/3 10:31, Tejun Heo wrote:
> On Thu, Nov 03, 2022 at 10:13:22AM +0800, Haifeng Xu wrote:
>> I understand your worries. Can I just check the populated state of
>> css_set in 'css_set_update_populated' and don't change the order any
>> more? I think it can also streamline 'css_set_move_task' a bit.
> 
> FWIW, I don't see much value in the proposed change. The resulting code
> isn't better in any noticeable way. Even if the change were straightforward,
> the value of the patch would seem questionable. There's no point in creating
> code churns like this. Nothing is improved in any material way while
> creating completely unnecessary risk for subtle breakages.
> 
> Thanks.
> 
Got it, thanks.
