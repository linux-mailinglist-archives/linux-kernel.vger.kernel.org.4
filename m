Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA074EC7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGKLQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGKLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:16:13 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B754DBE
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8bd586086so41591215ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689074148; x=1691666148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=em9xgVa3hdk9NBQVYgyeIMHyNqzlL7w7PxEQ9l0udqc=;
        b=byFHlSTvLjX+wwzL1uvRmsJT9gApAjyX+arz4B0WuWLIPXf9adRD8JGCC0m5rpdMe9
         Rukv7xRdLlo5TDO474aEnxzG63b/BhXJkW5O4RfRWQCvj9Uc9DxxydaeT5APXWcdTzJL
         JpEIF92j/ko0dB3fiPlUgLJukl2johew+Z+rIH8MkWU6bmh0tk/5bm3qWKllXxSkGMWI
         P/DlqxcbxQIiygAcPMKj+x2/9j4ceknrwJLjoejsMqEfoa1fNcHpBTyc2+nsxoMIPaKI
         SdQYCKoSVvk9MqAyIX8fki/wYIypjuA0H9N+hS3B9i5HW2JSajuTBsM0em2NQgZii6sO
         yN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689074148; x=1691666148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em9xgVa3hdk9NBQVYgyeIMHyNqzlL7w7PxEQ9l0udqc=;
        b=WpWWUEr6VFA3Aazasr4Um2Yx1ZnHN39zAjhaJl+2rHfNOqgeekmjeEe5mdZlzIDyyY
         7Ploo1zUyD+GbG2DboOpWpJpUnM1rro772BqgkIXwsbVwA3esAkaGZ8bBfU8ES5E2aYc
         8Ve6p9XlPpSjzJE95Vg8erQVIhqb75XOl3zMJnkQbe/ulA5EJIKcJy+WdS/Xwq/QCKYA
         F1eHA167Bs9i3LiVfkdqxV3J+RrShtp9Wcj0ytucVwJHFZEksZe6Kh8EOC7/MhqcMqqk
         FULNiLpQJMECxdcIEVGupsbdBz/xnz67T2ClkxvnqiqVGtqD8K2xyFhZDf3baB9hvquw
         CROg==
X-Gm-Message-State: ABy/qLYpbtTelOIgm/CEANoD7jhgLr3JdxdCc3QKPtnCtMWiS7DDfcFW
        vSt/htrVJh1d4tMflTmf5+V4dA==
X-Google-Smtp-Source: APBJJlFbdvpSFJFyEKHvLn6aFsX3912I0T7xfw27aLE/jleSdcztYBOYpNDmwbR0v5hKNcPTbyO9/w==
X-Received: by 2002:a17:903:22c6:b0:1b8:72e2:c63 with SMTP id y6-20020a17090322c600b001b872e20c63mr18675118plg.8.1689074148225;
        Tue, 11 Jul 2023 04:15:48 -0700 (PDT)
Received: from [10.4.5.144] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b001b9f032bb3dsm1305219plb.3.2023.07.11.04.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 04:15:47 -0700 (PDT)
Message-ID: <d0e823d9-292d-932c-9849-1d4d08c9f4eb@bytedance.com>
Date:   Tue, 11 Jul 2023 19:15:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [External] Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for
 post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chengming Zhou <chengming.zhou@linux.dev>
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
 <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 19:06, Chengming Zhou wrote:
> On 2023/7/10 21:30, Christoph Hellwig wrote:
>> On Mon, Jul 10, 2023 at 02:47:04PM +0800, chengming.zhou@linux.dev wrote:
>>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>>
>>> If the policy == (REQ_FSEQ_DATA | REQ_FSEQ_POSTFLUSH), it means that the
>>> data sequence and post-flush sequence need to be done for this request.
>>>
>>> The rq->flush.seq should record what sequences have been done (or don't
>>> need to be done). So in this case, pre-flush doesn't need to be done,
>>> we should init rq->flush.seq to REQ_FSEQ_PREFLUSH not REQ_FSEQ_POSTFLUSH.
>>>
>>> Of course, this doesn't cause any problem in fact, since pre-flush and
>>> post-flush sequence do the same thing for now.
>>
>> I wonder if it really doesn't cause any problems, but the change for
>> sure looks good:
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>>
>> It should probably go before your other flush optimizations and maybe
>> grow a fixes tag.
> 
> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.
> 

Well, I should put it in that series before other flush optimizations instead.

