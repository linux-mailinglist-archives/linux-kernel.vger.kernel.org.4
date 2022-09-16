Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6A95BAF0A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiIPONB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbiIPOMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:12:42 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593ABB0B38;
        Fri, 16 Sep 2022 07:12:27 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id t3so21563022ply.2;
        Fri, 16 Sep 2022 07:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y+pvksgyHzFkmjtCkJnj77yHoOwln/ZIIk7XhvsTNYQ=;
        b=7QYfgRhmh+qS93X3m8UZGru5K1JSXIklIFNp9zPrUSVvZWFlRvWYsWStuZYavwLNJj
         QB7dfIkJ3LMQykf865xpbp9hDnaIbd3iIpNmiRhXxU/W7cIXVODgS4L0SbT8o/hwN6xB
         CaUidztz1YESe4V+Bz6MxgHgAAG5pZYk7mqkIdZPCvmCvuhNpu+7Lm9GC7PiP+AeesgD
         CsKFrohs2Ak8WWMUrQWWRZa36E+Kv9ArKWh7/c++HZqWQ29U030HcCIfh2pfKoSbA4qf
         e2SGI4hkAVCXSpjorR2Da+jAdJl6VpVmuegDf+Kj18Wjv7qVInG+VneWVB5qUZqxDzYR
         Q0pw==
X-Gm-Message-State: ACrzQf1bfuCF19cZ6fDg/Wkwl2IntWYi7eFZdUC7uufyKMBGLGchLr87
        O8LuRbOZJPaWUBdj5bNQIew=
X-Google-Smtp-Source: AMsMyM7rJRm32BJuX2m12aOtMx+L72QYRIExIhzQO12myfiidHtpmXxaFYiOr4o2A8PWxDse1v94Yg==
X-Received: by 2002:a17:902:7082:b0:177:f7fc:5290 with SMTP id z2-20020a170902708200b00177f7fc5290mr21789plk.143.1663337545948;
        Fri, 16 Sep 2022 07:12:25 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id m17-20020a170902db1100b001782751833bsm11480486plx.223.2022.09.16.07.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 07:12:25 -0700 (PDT)
Message-ID: <f2b8a99d-f6bd-4581-c651-d5b62d6cff21@acm.org>
Date:   Fri, 16 Sep 2022 07:12:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO
Content-Language: en-US
To:     Li Jinlin <lijinlin3@huawei.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com, Jan Kara <jack@suse.cz>
References: <20220916023241.32926-1-lijinlin3@huawei.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220916023241.32926-1-lijinlin3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 19:32, Li Jinlin wrote:
> Since blk-ioprio handing was converted from a rqos policy to a direct call,
> RQ_QOS_IOPRIO is not used anymore, just delete it.

(+Jan Kara)

Jan, please Cc me on future blk-ioprio patches - I just noticed that I 
was not Cc-ed on commit 82b74cac2849 ("blk-ioprio: Convert from rqos 
policy to direct call").

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
