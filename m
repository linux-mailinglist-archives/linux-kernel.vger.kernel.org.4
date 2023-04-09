Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CFA6DC003
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 15:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjDINcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 09:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjDINcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 09:32:33 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF013599;
        Sun,  9 Apr 2023 06:32:32 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id g19so46561616lfr.9;
        Sun, 09 Apr 2023 06:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681047150; x=1683639150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2OwlGcOxlJlN3MIUaRMj/bpmF1BMiMrIYCbEpNuZpqI=;
        b=FnDCAnPk1QMeGGkItp3mZTwuQWT8ViMPWxedYv6BSzXp2wayH4Dm0zeISrNN2b4bZj
         Wh3owmlZod2AplRR7/0ZdFlTTbfRTOOb9swkRUZPctUzKIQDWF7CxwpH8udeHGfevYNU
         kh8jYzW5DHK6ae2kTkse5g87Fn1IMorT5NLIheVL5bTx595qGQLEP6/oXlu488ml3Q4f
         p00nfLESHPVIzl25cwAApk3E04YW45Y1gY5zlWdempWG/U8rZZCd+PHAjczmFJnf/YLL
         NcTk4baptK0nTGRvtfMYQa8IvR8Ar1eumG3Elhfg/6Bx4mG6ouznEuThO2/3r6dEdj4K
         j/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681047150; x=1683639150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OwlGcOxlJlN3MIUaRMj/bpmF1BMiMrIYCbEpNuZpqI=;
        b=YltNtgxFkFtZpEnICz5rU5c7wQz2nGAX3qrnFgHt6NUgcx5R35bK2DORJZxjGWC+qK
         fMKibrO3z8kvoHPKCUGt2wF92eNoPt60XtfVkeHq7G6Pof6xtwDbs0cP+tRLzq0u1ELR
         9hcySry5p+gp1Ve0jSJUfA0n+fL/YddqwwDxk6Ddkvi2ld6YKsFI07PTaKzzaTgDV2Yk
         i+Vs8p4yK43bZMcRjqf9qSsd3vZQIRDopO+rK+eHQsWf9PpUrLIR4P7R4r2nTJX1rGN7
         /2AnRekJNLTAM9Jl3Uh/SK4K5Vh1Q5/ILHXlk5y5yag3tcVvV/XIrUMtjgcG92aKAaOD
         R/gg==
X-Gm-Message-State: AAQBX9fJqmW9xFxDo1YkEP3jn+W+6ByIc5ykStMmkdkVDCdCWdPVQAVB
        FHaUA2uuINvAbh1yRYC3rVQ=
X-Google-Smtp-Source: AKy350bix1b3DMlJK9+vyuOd62RoWfeZNF6BH+0X4TDDpyFCQiNNS3eOugX8Iw1egN3tajdtsR8E+Q==
X-Received: by 2002:ac2:4d03:0:b0:4eb:3fb2:c56d with SMTP id r3-20020ac24d03000000b004eb3fb2c56dmr2803384lfi.12.1681047150024;
        Sun, 09 Apr 2023 06:32:30 -0700 (PDT)
Received: from [192.168.171.122] ([46.211.100.81])
        by smtp.gmail.com with ESMTPSA id v11-20020ac2560b000000b004d58e782886sm1608274lfd.303.2023.04.09.06.32.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 06:32:29 -0700 (PDT)
Message-ID: <f9c8e0d4-1d0c-cefc-866c-046d4d374576@gmail.com>
Date:   Sun, 9 Apr 2023 16:32:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/5] Input: add driver for Focaltech FTS touchscreen
Content-Language: en-US
To:     Joel Selvaraj <joelselvaraj.oss@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-3-joelselvaraj.oss@gmail.com>
 <68b05c43-5808-5792-9b57-aeafffe84149@gmail.com>
 <d40faca2-fe5d-5b5a-eefe-68eb3e5e8125@gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <d40faca2-fe5d-5b5a-eefe-68eb3e5e8125@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

Sorry for responding late:

On 3/13/23 00:21, Joel Selvaraj wrote:
> Hi Markuss,
>
> Thanks for the quick review! I agree with most of your comments and will
> fix them in a v2 soon. I have a few doubts as discussed below.
>
> On 12/03/23 15:40, Markuss Broks wrote:
>
>> Why is the _ratelimited variant necessary?
> I assumed in case of the interrupt working, but i2c reads fail for some
> reason, it would spam a lot of error messages if the user touches the
> screen continuously, like a swipe up gesture or something.
>
> I referred to ad7879 touchscreen's irq handling code [1] and thought
> it's probably best to do this, to be on the safe side. I will remove
> this if it's not needed in v2.
>
>> Overall, I think it's better to cast the data type to a struct, which
>> would make this seem with less random.
> Sorry, I am not sure I got this right. Do you mean I create an array of
> struct called say "fts_point" that stores the x, y, type, etc. info of
> all the points, then report it separately. Like similar to something
> done by the auo-pixcir touchscreen driver [2]?

By that I meant doing something like the Zinitix driver[1] does. It has 
a struct data type for whatever you read from hardware, e.g.

struct point_coord {
     __le16    x;
     __le16    y;
...
};

from that driver. That way you can cast the data read to that struct and 
have it look a bit nicer.

This is just a suggestion though, you have the final choice in what 
design you choose for your code :)

>
> If I didn't get this correctly, can you show me some code in mainline,
> that does it? It would be very helpful.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/ad7879.c?h=v6.3-rc1#n250
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/auo-pixcir-ts.c?h=v6.3-rc1#n162
>
>> - Markuss
> Thanks,
> Joel
[1]
https://elixir.free-electrons.com/linux/v6.3-rc5/source/drivers/input/touchscreen/zinitix.c


- Markuss

