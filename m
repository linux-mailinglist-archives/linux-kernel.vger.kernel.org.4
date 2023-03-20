Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B13346C22C6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCTUdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCTUdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:33:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0095730B2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:33:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id cu12so2507616pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679344414;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=49AKY3rqJ2OWhv0n8y7iKbX1QNMwzFfzEmwn0Chzg2o=;
        b=CswtyLhoUZo6z9qGDQPiVknUnQmfov+uPUoUNH2B1VMc8ApS9znQcj/wUrJ6C40Ctn
         4vj79RtukFc587NoYRljeg8aKL1fQ6ZTr6RcTYT+PA3rBNn49bphBVOF67E/GWGOO4oO
         uqoE5kd8Fh0klUpCV6GaJsYfyE/EQg+NL89TbhfDM2mEmS8v69qi/tuSQnknOrYJ1s5H
         j1oQEGPXOcjWX6cw9N7jLo9bL89DCQt0uvsJqgEN9G6D+A649dglReJhsQpy8ZUD2nQT
         cc6WPJSbRL4hGU+NvOZL98gLD/TETwUmxThitpdCyB7/aR4eHAjr0gHhHbhWF+KMt219
         tDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679344414;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49AKY3rqJ2OWhv0n8y7iKbX1QNMwzFfzEmwn0Chzg2o=;
        b=gtwo5Dz1740rXilQoMC9MEf459nZzy8WkpXVQuNEH0RP0LbZQKni+zrv13WOwkrqyY
         6oAIPDXjcpjEy9zn8VLNX9O2h24HA/FD5Svb1gkL+KnAxhxVMo7GIEimS+ZBW0GeYuSg
         Sw/wK/ssYSMIiONA7i474vLnSk+4uX7NJOGNKngBjvO4W7EEHAy+aMH12svvYBrWVrKW
         e6jIAgmUYTqRWiArDIhSYEczSsWWT56iRWxu2qeutyga6pvPDOsZB4HuRiEIolNInL8f
         ueuW6OxFdFB45qaodnVIYf9MWIMWxAUnGuaurvNq18kAxhugpugw8lGOGCra/6ga2Ts3
         Ta/g==
X-Gm-Message-State: AO0yUKXPwxDjE9WA4BMVEkfEKbkxQkdYmkbAPT1iPSvicB4qmnzehLHR
        Vtl2eBdzjCA1+rP1fvU/U5wOSy9t9eo9CQ==
X-Google-Smtp-Source: AK7set+KjX48jABUhxbYOrNfyiK/W0Cqfxew887utj/XvB34vzMDAgFuXy3U+iecP3aaFQBHxhzJjw==
X-Received: by 2002:aa7:9423:0:b0:625:2ed6:9070 with SMTP id y3-20020aa79423000000b006252ed69070mr109346pfo.22.1679344413953;
        Mon, 20 Mar 2023 13:33:33 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id z18-20020a63e552000000b0050f6add54fcsm3305421pgj.44.2023.03.20.13.33.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 13:33:33 -0700 (PDT)
Message-ID: <e4285e0b-32a3-a12b-3d99-1846b79c2607@gmail.com>
Date:   Tue, 21 Mar 2023 05:33:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 0/3] Simplify extcon_dev_register function.
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org
References: <CGME20230320031947epcas1p1aa5b69c95a6f00400ca6cc78a5ddd17b@epcas1p1.samsung.com>
 <20230320031939.28862-1-bw365.lee@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230320031939.28862-1-bw365.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 20. 12:19, Bumwoo Lee wrote:
> It was modified to increase readability.
> 
> Changes from v4:
> added null checking of edev on each function.
> 
> Chages from v3:
> removed possibility of kfree(NULL).
> 
> Chages from v2:
> resolved possible memory leak of dev->cables.
> 
> Changes from v1:
> added return value handling.
> 
> Bumwoo Lee (3):
>   extcon: Add extcon_alloc_cables to simplify extcon register function
>   extcon: Add extcon_alloc_muex to simplify extcon register function
>   extcon: Add extcon_alloc_groups to simplify extcon register function
> 
>  drivers/extcon/extcon.c | 281 +++++++++++++++++++++++-----------------
>  1 file changed, 165 insertions(+), 116 deletions(-)
> 

Applied them. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

