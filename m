Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53EE6F6710
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjEDIOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjEDINM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:13:12 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D24B49D4
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:10:47 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-2f86ee42669so72488f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683187846; x=1685779846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AEAJhREXxkwkAjTPpZvPokj/zHXMm768UtibcSphYNk=;
        b=SqjBG+zFd6XMBtMilb+Gwi0u9nafhh3KXuO7ISOJsarAR/zv3ZYByiPrpVWhyGkKJZ
         hi95G8ZlaqOmjvUdp4f1BlxiVU9IOaatTlFylzbSLkfttqsrO04KDuqTgNLvYh8KDtXy
         bPmUlusPuEe2Qw8R4wE+ZaUtSzamBmkZk7kJ9FE/ER4mCOyDBqR1tNmoBgo/MayBtL2b
         gIQ2XDKgI0h6vSybtZiCjR7DIYy/BxxyhpBbepBq3iHyvF2eemvNxEB6CCzrcqZUWyLG
         CErKlb0ZcvsftbOrOOQq+mZ7g45h6gFdKhycA57YnpFjs2D7TQfuJg7eJw/I6u/fwMY3
         oM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683187846; x=1685779846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AEAJhREXxkwkAjTPpZvPokj/zHXMm768UtibcSphYNk=;
        b=ObJtFZGeFYjUVNcKNnsx2jg/XzLG3BWgk8ZtArWmFU2OGvsVMNGKYXG9y2IkH89/1a
         kgnH2aPpmkZ0XpqvGtBaIB/bG85Ao5AA2gtWbl60h9iQ1Vu8Je4DuyDCx5ec+gjLnJVX
         q1T0EGORkMY894MXX7tbrN3AK8LeMGai/CqLe/YzFlZFDeEOFNTvmeVT4up/8WdbC3cD
         inNpTs+HU01cNvkyUBDFOkPZXymT7rEjZ6uhkhJVVnjO5wwnzr9s+XSstxzPMaFL9LHr
         bTtqBTwlGh6YTPllgmX345Xo3E9+mkTLH+DR/0Vo9MEhnlZbDJcVwtlTUek7WnRUFPEs
         cTJQ==
X-Gm-Message-State: AC+VfDxa6/ISJFjwO/5qIY2SqjxjKnvfZzfIQrVWb458GGXwQBDhVDVY
        DYI5+ZdFxtNRikAixDl0Ha1lWg==
X-Google-Smtp-Source: ACHHUZ5sn6tdEm0Ok1suzCgkzUiI4xCKFXzlcJ/N/zGU0MzqTZuwH6EMDL6/PxsXnxR2Harp3+n45w==
X-Received: by 2002:a5d:4904:0:b0:306:2d36:c6d4 with SMTP id x4-20020a5d4904000000b003062d36c6d4mr1929128wrq.31.1683187845788;
        Thu, 04 May 2023 01:10:45 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.230])
        by smtp.gmail.com with ESMTPSA id p17-20020a056000019100b002fda1b12a0bsm36135718wrx.2.2023.05.04.01.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 01:10:45 -0700 (PDT)
Message-ID: <41ddc20d-8675-d8bc-18c6-2a26f0d6b104@linaro.org>
Date:   Thu, 4 May 2023 09:10:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] hwrng: virtio - Fix race on data_avail and actual data
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <ede92183-bef3-78a7-abae-335c6c5cca1e@linaro.org>
 <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <ZFMsvxW+pEZA2EZ7@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/23 04:55, Herbert Xu wrote:
> On Wed, May 03, 2023 at 12:19:30PM +0100, Tudor Ambarus wrote:
>>
>>> Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
>>
>> Link: https://syzkaller.appspot.com/bug?extid=726dc8c62c3536431ceb
>>
>> Please add the dashboard link if applying as searching for the syzbot ID
>> rarely gives meaningful results.
> 
> The syzbot ID is already present in the in the Reported-by tag.
> There is no reason to clutter up the commit message with redundant
> information.
> 

As you prefer. Theodore Ts'o encourages to add a dashboard link, here's
his reasoning:
https://github.com/google/syzkaller/issues/3393#issuecomment-1347476434

Cheers,
ta
