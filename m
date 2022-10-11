Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F05F5FB841
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 18:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJKQ0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 12:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJKQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 12:26:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686BF9B867
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:26:07 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id 187so11242304iov.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 09:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BcuXX3q54AIQQlX1+hQrsBzqHD7HfWkF6TuzwcEC6yc=;
        b=yKWNjStLhM+J8LWSuTFi0G+YgK5GH1jgvNcS5zMhandAOdcWvvP7UfBaO6WVPFtHzK
         /ypSm6T44wYn0/uteX6Bwg8JVH3etMj2AzSO5l2CmV3Tu28ytMKNfHTwPbqh5iVlEyef
         cI0S9DF8xyc8a/SPiQCF8TrynoEfzZZRx3eYvPoF1CPe9jhL0RYizx75w6IXPe8itZOM
         TQiQB8naYiQS6CAPLnLoHLgrtIeRQ91pq8v5xB3XGeNYITARVXGr6UlQhYDibO7Qk9Yt
         x3KuYQ7efRv5MR/wX5KTk+EUflkQfB8ZmqK1SaXPP7v7pPbatMyplkhLBDOIGaje1+AL
         N2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BcuXX3q54AIQQlX1+hQrsBzqHD7HfWkF6TuzwcEC6yc=;
        b=7FC/8bX7azLIAordcl56M3eIXhfE3VOAGj940fhsgXg7/275jqDtbXzcpDdldSXYQU
         NibOlbhIqwTdisJS3r9H1gvMZRN9fCVKYIyeGDHCvVyUE7YsAMw+bc0ZsmuPJGKG90nb
         si5miE2YW5a2rgrIDRMNFdM+hichM03A4MIUKb6JILbl3iopdyqpcMXrBWdCY59uZmpm
         30ILJgdeY2e8FMdLSUgJm9ISVkCiV7qOIqsp1euPYHXkLznO04oAzkfVQ8J6TYcsBtNi
         GgPDEztRLTRZnHE2xQc+ypNdAcM8lqdMmqMKOLhRkdhCdcOzPhtn79OHkk/pO0MqQl/p
         q6WA==
X-Gm-Message-State: ACrzQf3g3AO2SPqBQsuabTD+gNsKLYJJK5vbv6iNORBKkdaPQFVP888f
        8q64jzcF5mzUKT/ikzUDAOkVGw==
X-Google-Smtp-Source: AMsMyM7sNHjwSDvWOU6zdxTPQoesPx6zJH1N9XQoI1cI1aUpuo7/2H2TzJx3FWWqSIx+kLUnqpAOSA==
X-Received: by 2002:a05:6638:3044:b0:35b:ac10:53be with SMTP id u4-20020a056638304400b0035bac1053bemr12879227jak.17.1665505566388;
        Tue, 11 Oct 2022 09:26:06 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c3-20020a0290c3000000b00363b8ef4bc5sm2375329jag.71.2022.10.11.09.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 09:26:05 -0700 (PDT)
Message-ID: <eb59cf48-03c8-7ce9-7e00-4b824cef150d@kernel.dk>
Date:   Tue, 11 Oct 2022 10:26:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] block, bfq: remove unused variable for bfq_queue
Content-Language: en-US
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 7:29 AM, Yuwei Guan wrote:
> it defined in d0edc24, but there's nowhere to use it,
> so remove it.

A few things wrong with this patch:

1) It's whitespace damaged, and hence will not apply directly.
2) It should have a fixes tag, and the sha used should be 12
    chars. 8 is too short.

Can you resend it?

> Disclaimer?The information transmitted is intended only for the person
> or entity to which it is addressed and may contain confidential and/or
> privileged material. Any review, retransmission, dissemination or
> other use of, or taking of any action in reliance upon, this
> information by persons or entities other than the intended recipient
> is prohibited. If you received this in error , please contact the
> sender and delete the material from any computer .

And please get rid of this, it's just spam and doesn't apply on a public
mailing list.

-- 
Jens Axboe
