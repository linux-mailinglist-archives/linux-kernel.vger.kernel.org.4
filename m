Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE866A566B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjB1KON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjB1KOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:14:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C4D15CBE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:14:07 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id l25so9129976wrb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677579245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MtWOlYEzYU8o1W9I3L+KKLMvgELe3X6n/EypEh1Ozho=;
        b=EqU0CvkmhrcQh6b4eYrxlA+sRPKiVO/FUnlQQZeo28mMe1OUNewRvgu/OCO6tuAxte
         4L8UaCsqXrBvfCLDeSYFIEXjuYVaZDJXadKQhsc20qCm2n4f4CDonnw9TUMzln8ciecT
         H6U4TY5bxiCjzZvH6oHdRg6zJ4h1iVDlhCgIdYLaeZUEEakfMnFM0oEstIP5FKIGvmT9
         BZI6d6cWKvOv52AjNyoiDim4IWQW1ISgRUFYukiVWPn0P5nSOCAh9fjE0MDZ+n7RgThX
         xxJ2wCRde6aP+26W9Wc+jTOLlx2bm9bVeq02iXocoBXXKsxNv1NKfva7NNp5kcIZZ3nA
         6xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677579245;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtWOlYEzYU8o1W9I3L+KKLMvgELe3X6n/EypEh1Ozho=;
        b=W/h6OX+FfPUqslaSFTG8EwWFcVppk5Xyj1u558efkGKp1wHzRWSmF5ZaeuLkDuzOny
         9pC6htEHgL6CQ1q3qQ3lBP1FbbQUZYH8GPT5WhkfaZWD515GG07S5a62fw8iSaXHt+gd
         r7gKLHNutXZUZrpS78oL0NzLzR69SF0NV3rNrF9tngnviejS9qnptpeIypKqiFU0v6sc
         vjgA29gZLgHpMW0bsCIoDdbperMutGsF7224Mpzt68lMZwh9Znl3rubYd9dJeXIfCLOP
         fk+JvIrkB4p6uaM3tYf3n2doR4t0pqtPK/D8geVJJgSfzc8Yy6Oe5YSgRBUrskvhHdgH
         bwBw==
X-Gm-Message-State: AO0yUKUkD5qkLgYaCz33SQgTnPSJOnDO/eD/HGZAPEH2SeNZGLTKcA4u
        VkBBryR/EHVgb/uooQqfI3n/NQ==
X-Google-Smtp-Source: AK7set9palyPAQiOHfRloN7eMdX4WfhX5VAiXO20doqNN8f2VCpA3HoxVGJeVRdo21Gwxz8CMfW8Xg==
X-Received: by 2002:adf:ee85:0:b0:2c7:454:cee8 with SMTP id b5-20020adfee85000000b002c70454cee8mr2237439wro.1.1677579245409;
        Tue, 28 Feb 2023 02:14:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id i12-20020adfefcc000000b002c54f4d0f71sm9286387wrp.38.2023.02.28.02.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:14:05 -0800 (PST)
Message-ID: <7e9ffa10-d6e8-48b5-e832-cf77ac1a8802@linaro.org>
Date:   Tue, 28 Feb 2023 11:14:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nfc: fix memory leak of se_io context in nfc_genl_se_io
Content-Language: en-US
To:     Fedor Pchelkin <pchelkin@ispras.ru>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Guenter Roeck <groeck@google.com>,
        Martin Faltesek <mfaltesek@google.com>,
        Duoming Zhou <duoming@zju.edu.cn>,
        Samuel Ortiz <sameo@linux.intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org,
        syzbot+df64c0a2e8d68e78a4fa@syzkaller.appspotmail.com
References: <20230225105614.379382-1-pchelkin@ispras.ru>
 <b0f65aaa-37aa-378f-fbbf-57d107f29f5f@linaro.org>
 <20230227150553.m3okhdxqmjgon4dd@fpc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227150553.m3okhdxqmjgon4dd@fpc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 16:05, Fedor Pchelkin wrote:
>>> Fixes: 5ce3f32b5264 ("NFC: netlink: SE API implementation")
>>> Reported-by: syzbot+df64c0a2e8d68e78a4fa@syzkaller.appspotmail.com
>>> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
>>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>>
>> SoB order is a bit odd. Who is the author?
>>
> 
> The author is me (Fedor). I thought the authorship is expressed with the
> first Signed-off-by line, isn't it?

Yes and since you are sending it, then what is Alexey's Sob for? The
tags are in order...

> 
>>> ---
>>>  drivers/nfc/st-nci/se.c   | 6 ++++++
>>>  drivers/nfc/st21nfca/se.c | 6 ++++++
>>>  net/nfc/netlink.c         | 4 ++++
>>>  3 files changed, 16 insertions(+)
>>>
>>> diff --git a/drivers/nfc/st-nci/se.c b/drivers/nfc/st-nci/se.c
>>> index ec87dd21e054..b2f1ced8e6dd 100644
>>> --- a/drivers/nfc/st-nci/se.c
>>> +++ b/drivers/nfc/st-nci/se.c
>>> @@ -672,6 +672,12 @@ int st_nci_se_io(struct nci_dev *ndev, u32 se_idx,
>>>  					ST_NCI_EVT_TRANSMIT_DATA, apdu,
>>>  					apdu_length)
>> nci_hci_send_event() should also free it in its error paths.
>> nci_data_exchange_complete() as well? Who eventually frees it? These
>> might be separate patches.
>>
>>
> 
> nci_hci_send_event(), as I can see, should not free the callback context.
> I should have probably better explained that in the commit info (will
> include this in the patch v2), but the main thing is: nfc_se_io() is
> called with se_io_cb callback function as an argument and that callback is 
> the exact place where an allocated se_io_ctx context should be freed. And
> it is actually freed there unless some error path happens that leads the

Exactly, so why nci_hci_send_event() error path should not free it?

> timer which triggers this se_io_cb callback not to be charged at all.
> 


Best regards,
Krzysztof

