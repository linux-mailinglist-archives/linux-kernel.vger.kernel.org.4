Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A55FC0AF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJLGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:31:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259DAC397;
        Tue, 11 Oct 2022 23:31:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id v10-20020a17090a634a00b00205e48cf845so1114404pjs.4;
        Tue, 11 Oct 2022 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3GR5go0ck5Qs0e0/T7kbb1mBxqLfRSLAKUeyU2WjNcU=;
        b=U2A+BYXl888GxHHPJeE8FG6KtfrDgplmxYum+0JhEevDa8bs0QZsBPIrtQMZRE/4sV
         nBnG9lCuQdKc9HIWYN+ZKNOxnK5QlG8+ZwatrWncUxeUmpfOywnGE3r0eFkk0Il3J7DC
         lLOqTU5auPaMuj0esMM0+NpiuYqf68KtNBlfMDbd8aBZ/ao13ksborDr0FmpxGHNXHmS
         hcB/a2XfwQbBNPQdxpUF7CKnTzQcOYPHdNnjZV4ux5vPOPI6pf1ZikIa++iRovwWv676
         RdmToGtvNMM9pFaG3MxL6BZq4EQZ1HM7OFzG3TRteHvrRfrsGAj8uX0nnZPbZBxaQ18V
         2yFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3GR5go0ck5Qs0e0/T7kbb1mBxqLfRSLAKUeyU2WjNcU=;
        b=pm2YOl8P+2Hv8DlY3SezKVMM34YUrs401/Z80NIDPYdTr8sXrinF1XVe9y5SXYwmfr
         k8ry4wF2YKCC+2MRqnAi5lgJLQDVAcA1Rd2aL5QifwUpEATggwlARd7F4w3dIIVM+KYi
         1zGE5/tJuVD2N29wTTF3ojO7CdywoDr/XZ3L7It1HfpYY68tbafRXNVZBdsiEevuOTDu
         k0CxAdYgr/ZW1+uhhBoLn4JsLZrAEz8RAcmOayP+9yAQ6h4eO/zUD/e7SQU02fTBLIVc
         rQUqygnd+kBSbOqi+o/lgkCMfScGeosrqrzCgu7gaB8HF3yD5Txw49qkFuRLAA4Tt8Yj
         UR7w==
X-Gm-Message-State: ACrzQf33Jq7NakFGwdExwtAqIH9D4387NO2ZqDEaax3VeaV1AvRdQJpQ
        ybCA3Poc/GwASLbhbSy5HGM=
X-Google-Smtp-Source: AMsMyM49qIov3tPxIY8VPEfjb4JSsPOJoaTOtk1CrTHk0MCGUXiNkqI2cLYrVKJ8yEdIHRjni03LTg==
X-Received: by 2002:a17:903:230b:b0:17e:f1e4:6a89 with SMTP id d11-20020a170903230b00b0017ef1e46a89mr28829830plh.118.1665556301707;
        Tue, 11 Oct 2022 23:31:41 -0700 (PDT)
Received: from [10.114.96.63] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id n15-20020a170902e54f00b001785fa792f4sm9874191plf.243.2022.10.11.23.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 23:31:41 -0700 (PDT)
Message-ID: <2590b78f-65ee-c4b1-7a18-870db7a5c733@gmail.com>
Date:   Wed, 12 Oct 2022 14:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] block, bfq: remove unused variable for bfq_queue
To:     Jens Axboe <axboe@kernel.dk>,
        Yuwei Guan <Yuwei.Guan@zeekrlife.com>, paolo.valente@linaro.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
 <eb59cf48-03c8-7ce9-7e00-4b824cef150d@kernel.dk>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <eb59cf48-03c8-7ce9-7e00-4b824cef150d@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/12 0:26, Jens Axboe wrote:
> On 10/10/22 7:29 AM, Yuwei Guan wrote:
>> it defined in d0edc24, but there's nowhere to use it,
>> so remove it.
> A few things wrong with this patch:
>
> 1) It's whitespace damaged, and hence will not apply directly.
> 2) It should have a fixes tag, and the sha used should be 12
>      chars. 8 is too short.
>
> Can you resend it?
Thanks for reviewing, sure, I will resend it.
>> Disclaimer?The information transmitted is intended only for the person
>> or entity to which it is addressed and may contain confidential and/or
>> privileged material. Any review, retransmission, dissemination or
>> other use of, or taking of any action in reliance upon, this
>> information by persons or entities other than the intended recipient
>> is prohibited. If you received this in error , please contact the
>> sender and delete the material from any computer .
> And please get rid of this, it's just spam and doesn't apply on a public
> mailing list.
Ok, I will send with gmail.
