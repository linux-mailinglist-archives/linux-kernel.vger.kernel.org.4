Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E563C621
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 18:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235786AbiK2RIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 12:08:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiK2RIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 12:08:36 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9F324BEB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:08:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id q12so10216445pfn.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 09:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
        b=aB+ZuGMOzbK18zkd0jlC4zEUTSM38tp9K/bCtuVmGeRWETnLRpEwg6Cfsis6G/o8YB
         2HqB7jorwoOw6h/LjLMxu5ed5EZE92927W/9yhpp/QruynXSUNxJp0OMoVkixJnRoaDz
         PSuOZAOkF9I4gSS32lclTss+2DBuTn/ncV2ntYH8YMzg9PF3tm8qf0hVKILYBg2UDCmD
         wbUFp/1Fi7NjOLDWJsNeD/wtnDvCVPYo4knWim39AeNTc1EFLvMkEGW6VYwyktGtW5Qx
         +UBWGG0y4yJft2CYMgbAUi9qHrNg41pvQg2NXxZ0NdMCIm2c1JLzlQ89YLhdvsbn7Bys
         PI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cfz3Mcgxkqb1OqUShW9AvM1bJWJ5IVPUimuhgnHTUfM=;
        b=6Xamzd8W0yGDyVLyyym43Z5suZ/HnbrFqJXVjkemFlJ+VlKOPizFj+MPAfZbb2loip
         y9k7LN968TuVpRa/GEIYGJUIwvvEyCzYQj2pWrd+IFUsyUEc9Us1CyXO1JJd0e8Ue0gs
         GAPluPjQ0WbA31eVa9XRhQKIyfaUhLBJ9gmTTxPDEi9e0OAbYgg5Z7bXbWDIyLlkbuLa
         Y1jGZeEvgPWx6ylnR0BNhdNAMauhAq5Q+tC+QczEI7JBfVlXx3bUh9eQG4DyQwg2XG+B
         nfrS2dK6ZfgpMLy2H8AYg3c7jxzjuU8IEq3UGvCldn/crGOQPJp9MIy3hGFx9LdZzLqj
         gChg==
X-Gm-Message-State: ANoB5pnpveZc9qs5d4txfLASV/BA2NvxsSF3BMso/uTQsDZA1ccB7i+4
        sQrdNEPxsB8kauI2jmtl6+F9kA==
X-Google-Smtp-Source: AA0mqf5swFLksPgiEDo6TRTvtGl0tdoW1L9fhbh0pRyA3vgdzDg/DHK7jSPhCQbx1VNNnHFBlq3wIw==
X-Received: by 2002:a63:ce58:0:b0:473:e2bb:7fc0 with SMTP id r24-20020a63ce58000000b00473e2bb7fc0mr33307253pgi.604.1669741713274;
        Tue, 29 Nov 2022 09:08:33 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h23-20020a63e157000000b00434272fe870sm8633883pgk.88.2022.11.29.09.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 09:08:32 -0800 (PST)
Message-ID: <9044e2b7-193f-ade4-b4a3-69e40b12088a@kernel.dk>
Date:   Tue, 29 Nov 2022 10:08:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 0/5] Fix probe failed when modprobe modules
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>
Cc:     st@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, airlied@redhat.com, kraxel@redhat.com,
        gurchetansingh@chromium.org, olvaffe@gmail.com, daniel@ffwll.ch,
        david@redhat.com, ericvh@gmail.com, lucho@ionkov.net,
        asmadeus@codewreck.org, linux_oss@crudebyte.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, pmorel@linux.vnet.ibm.com,
        cornelia.huck@de.ibm.com, pankaj.gupta.linux@gmail.com,
        rusty@rustcorp.com.au, airlied@gmail.com,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        v9fs-developer@lists.sourceforge.net, netdev@vger.kernel.org
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221129160615.3343036-1-lizetao1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221129160615.3343036-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 9:06 AM, Li Zetao wrote:
> This patchset fixes similar issue, the root cause of the
> problem is that the virtqueues are not stopped on error
> handling path.

Not related to just this patchset, but guys, Huawei really *REALLY* need
to get the email situation sorted. I'm digging whole/half patchsets out
of spam every morning.

This has been brought up in the past. And no, the cloud variant of
the email also doesn't work properly.

Talk to your IT department, get this sorted once and for all. You risk
your patches being dumped on the floor because people don't see them,
or only see small parts of a patchset. And it's really annoying to have
to deal with as a recipient.

-- 
Jens Axboe


