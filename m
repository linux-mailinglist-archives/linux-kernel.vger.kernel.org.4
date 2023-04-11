Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153E56DD43D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjDKHbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 03:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjDKHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 03:31:20 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFCD30FE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:31:19 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id h24so7171897plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 00:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681198279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GzxsqcD6Sc+PmDKvNFlBYwFz6G7VU/UIKdRlK8mGXOM=;
        b=GRxxPaU22umS1uYCV+9yikXUTklhnJwXYsFyC7Ty2O1dg5zmMg2kENcTCdlrPLiXPt
         sMk+n2UUh2nEEhR6eKCuOYB2E/FwmkdR6s8zMeiADGzaIs1NsvobqoO28c3zk0KI3v6z
         70otlDgu1WUGcdQk5zkwC+W2OLkB+3fGpJL3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681198279;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GzxsqcD6Sc+PmDKvNFlBYwFz6G7VU/UIKdRlK8mGXOM=;
        b=cB5KnXUoX79ujQsxQce982fPK2f5H/UfUSPFKEdbsbWFuVXl9OgQbHaT53W2R7TKII
         jqiGSBxK221TXGVCt5f4jrl1tftIJZzrNgEMNOCuwYu4NejL+qskBU7UyaEVHY4MRvi+
         CyT5lc68kUi37mhfcsPMv8r4qHetnmW+PmIdgXaq4XPJ79tM/kJtvgSpShdJIrkMzmLn
         ceJttCoccwzjV9sF+uvbMuglAKwNd3a2EQk96Yst327Zca1Y/b+XjjqBtsb7D/lAQJ4X
         YoizJczcP1m0zTaewTK3fh4MHQ8orgckR0S8W79ZS8i9l0LnHHokJeYraaVGe/5ms2OG
         cyhA==
X-Gm-Message-State: AAQBX9fWPCgr1LKJm8fE+bVjFMJQesFNDArOYRsV2swUtP4e6EBskFYR
        LPsRrR1XVJpZhU6oD0Jgwcbfjg==
X-Google-Smtp-Source: AKy350aM66w5ZHFyQ8qUOmWgv3xl6EqbRj5xvGyndQBvZSs7W3lqF5xWQPnEQ0eXwHqWO2Gb0/KXQQ==
X-Received: by 2002:a17:90b:3b85:b0:23e:7254:e319 with SMTP id pc5-20020a17090b3b8500b0023e7254e319mr16975542pjb.39.1681198278987;
        Tue, 11 Apr 2023 00:31:18 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:44a9:ac98:7606:2cd0? ([2401:fa00:8f:203:44a9:ac98:7606:2cd0])
        by smtp.gmail.com with ESMTPSA id w2-20020a170902a70200b001a04d27ee92sm7082700plq.241.2023.04.11.00.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 00:31:18 -0700 (PDT)
Message-ID: <c6d5be4c-42c9-b8fa-fbd7-108c5da694bc@chromium.org>
Date:   Tue, 11 Apr 2023 16:31:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Content-Language: en-US
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
 <20230410102350.382f7d02@sal.lan>
 <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
 <6ee01cf1-5a8b-081f-e218-8c7da39343bc@xs4all.nl>
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <6ee01cf1-5a8b-081f-e218-8c7da39343bc@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 16:26, Hans Verkuil wrote:
> I think we either use this bandwidth option and calculate the max fps based on
> that (basically the bandwidth divided by (image_size + some blanking factor)),
> or we keep it simple and instead of going down two steps in fps we allow up to
> 60 fps up to 720p, then 30 fps for 1080p and 15 fps for 4k.
> 
> The fps values currently used are a bit outdated w.r.t. modern webcams, so
> upgrading it wouldn't hurt. And this is a lot simpler than doing bandwidth
> calculations.

Do I understand you correctly, are you suggesting to simply update the 
FPS limits to a new fixed schema, and not have an option at all?

I'm happy to prepare an alternative patch for that, too.



Max

