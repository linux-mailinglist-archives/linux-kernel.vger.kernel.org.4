Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD6915F4A3B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJDUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJDUW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:22:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E076958524
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 13:22:23 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id 8so6079927ilj.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 13:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=TelNLcm9wRWpRvZM6ui9GLROotn2S175JYIk0nIBYMU=;
        b=STF3cKzsEkNyiAc2Pp9U+acmfSoO9o9FviqJOu5GTx9ayQmChbBcWmh+30RVpI7ku1
         3TL9xHH/yeYsbts5GKYStMrmZKBWoSqUJcVo11VwATX5RUVZC8A84OMxJDVx14e+TRyI
         Nc+HPgOgpPIBtZ4N/ayYZN5MY7PKYBMkYHaKG8si2vVDgHorKdMRnlRkTc5LJuSWNLfA
         ReTIaqinJjqbLriC4pJucVuZlJspXBnej4Kw62tHQBPCt8yHRBKVJ2fJ+gnTO01TNopW
         IcSDYEs8muyxhocv8GCeFfIU+TsX6iI9/F+ON1DBd60ziUqQ2AcEFN1X6qCb6CqkKSym
         QqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=TelNLcm9wRWpRvZM6ui9GLROotn2S175JYIk0nIBYMU=;
        b=RiuLBCBMiA9k7UZbHp1XVBmI2x+uk3al0Hq8j5Fqm33hROc2QYyYTmY1O7EAKl/9Bo
         3pae38VyD8WPb77BZ32Nvpm43T2QRskAKIjds39fs8zcl2NIDRcMRSJHu8ztUyQeDNdB
         t9GrZtV6fsdjzkqbh4pZfPjjVyJJ/LOlB+srDTHqP8IoioDjU7DEGvxxCJDUb4gDquFg
         58fB6zBT3jMqfM+5H/FxezCubWXEdRPBXBgGttb7AiY8doUUhNxH2o101z2TfLx+IEGq
         UVjeeYAHgjnbqJKr8aa9BqZKgIgDCTy65VrzwTj5wCKdHo5dI11Fi6rbSjQx7edDCC1f
         8Rvg==
X-Gm-Message-State: ACrzQf09VPfkqeBPsiGzyrBp42V87NN+9jpl38ELITNtyuEejGa8cp5G
        vmh/9VMPVBaYbTPvFo7Ru1Ek6w==
X-Google-Smtp-Source: AMsMyM7nWfSuZ2bMHjHDOTAjPo4J9MaV6oNis+zZcdekiEkjOufbVl2foV4BfKsvvXRRUaad2rpNmg==
X-Received: by 2002:a05:6e02:194e:b0:2f8:fa94:9da1 with SMTP id x14-20020a056e02194e00b002f8fa949da1mr12747955ilu.102.1664914943271;
        Tue, 04 Oct 2022 13:22:23 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x2-20020a026f02000000b003583ae37f40sm5508319jab.153.2022.10.04.13.22.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 13:22:22 -0700 (PDT)
Message-ID: <736d9e73-8f19-cc21-375e-140e4ab61383@kernel.dk>
Date:   Tue, 4 Oct 2022 14:22:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] block: allow specifying default iosched in config
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Khazhismel Kumykov <khazhy@chromium.org>
Cc:     linux-block@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-kernel@vger.kernel.org
References: <20220926220134.2633692-1-khazhy@google.com>
 <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
In-Reply-To: <166490172029.91699.2910906888136711371.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/22 10:42 AM, Jens Axboe wrote:
> On Mon, 26 Sep 2022 15:01:34 -0700, Khazhismel Kumykov wrote:
>> Setting IO scheduler at device init time in kernel is useful, and moving
>> this option into kernel config makes it possible to build different
>> kernels with different default schedulers from the same tree.
>>
>> Order deadline->none->rest to retain current behavior of using "none" by
>> default if mq-deadline is not enabled.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] block: allow specifying default iosched in config
>       commit: ad9d3da2d07e0b2966e3ced843a0e2229410e26a

I'm going to drop this one for now since we still have
active discussion on it and it's very late (actually too late)
to be debating 6.1.

-- 
Jens Axboe


