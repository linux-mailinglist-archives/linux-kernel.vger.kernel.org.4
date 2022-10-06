Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EC55F70F0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiJFWFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbiJFWFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:05:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5097A63EA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:05:35 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id w2so1849800qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 15:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FL68dpL42Mx7JqcV5yKNfqU/nz0e+Ht7vuoz3H5+fH8=;
        b=CYw8nJyMYNGQx30NInvL0gFMxLXWLoeaO1xSfNo86ZXoBAd8FkIwCcpt2e7icOQm3v
         brj2RADHXp81YIdXfuwtRmGARdrgxdKgCTnogfmLm/kGVuFxE6pTLO9lBLczflLpN1B9
         yBh3CrXs3ulqbosnvtvGg3OApZNKqvSkDVXP+/DpvEoGh13DMQYx4ogAOsHMc29UoDA1
         OIa7BXEqATaHH+wJZkvttMLiI5XFAqMn78S3iGgLvEc9AbsJtIzvxYCGTcv4spVA6Cn2
         nMmbjcBxMKyfq2F7/HjsB0QIZ6dwBCBwEbYNd4uWNZpdo7JUqpt+DOp1TnJizi9Nzime
         Tysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FL68dpL42Mx7JqcV5yKNfqU/nz0e+Ht7vuoz3H5+fH8=;
        b=c2WqevVKq7ZDsTScPX04wvq+CUPmOYfrtS33UxsuhJHqZEEroZGotz1ST2T5Ri9MQ6
         gflJ4mqo6wH7XhJNj4hdAnxv+ItP8AK3mg3GjkfOXaex683Td8XMrlP7XNJj+2/AYXWT
         T5r/x/JhQM3X0oLXVUSrpRkOntTMvBdC5gczvr4sDdkACX2FUyhL4kqPurxPok8O1C91
         LXyY8rVPsaKrl3zWErG4RtpNy7Fyt/0J4iq1iwm57b5rBuBHbPjvDE60Kud+gHniG+bQ
         Ev7cdyS8xZJf5ZQ16VXU2N+KF58JZzpC/ACdLd4yFMuDUqTXdtrk0GDTzqypInrHVgy6
         geUw==
X-Gm-Message-State: ACrzQf2IkAnNse3q5nsNLw16j4s4Pmgyw+ZBCM3SuXSLNNwaDf9b8fNt
        4EEekU4tBTiVBctphSPsqrU=
X-Google-Smtp-Source: AMsMyM4LZmjtm8c5rvioDH4agVn5OahC2HCCf4dpI0h6oKVKCT1q7YPRJYVvN3lM+JrH5CuqUo8cOw==
X-Received: by 2002:ac8:58ce:0:b0:35c:d69a:9311 with SMTP id u14-20020ac858ce000000b0035cd69a9311mr2069612qta.367.1665093934301;
        Thu, 06 Oct 2022 15:05:34 -0700 (PDT)
Received: from [192.168.1.102] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b006cf3592cc20sm309737qkn.55.2022.10.06.15.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 15:05:32 -0700 (PDT)
Message-ID: <29803905-d0e2-3efb-e249-fd745f9abcf0@gmail.com>
Date:   Thu, 6 Oct 2022 15:05:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 1/6] phy: usb: Improve port mode selection
Content-Language: en-US
To:     justinpopo6@gmail.com, alcooperx@gmail.com, kishon@ti.com,
        vkoul@kernel.org, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
 <1665005418-15807-2-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <1665005418-15807-2-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2022 2:30 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> Split port modes into two different variables. Supported port modes
> is what the hardware supports. While port mode is how the hardware
> is currently configured and can be dynamically changed through the
> sysfs. We initialize all supported port modes on init even though
> the port mode may not be selected because we cannot guarantee the
> downstream interface from the phy will be active or not.
> 
> This also fixes an issue where port modes selected via sysfs were
> not being saved through suspend/resume.
> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
