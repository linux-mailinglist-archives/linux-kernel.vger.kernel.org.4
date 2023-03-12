Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223736B6722
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 15:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCLOX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjCLOXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 10:23:54 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9B46170;
        Sun, 12 Mar 2023 07:23:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id d41-20020a05600c4c2900b003e9e066550fso6274480wmp.4;
        Sun, 12 Mar 2023 07:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678631031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6I/1/bpm4WqYeBDypKIrM3/PdgXx2vNAmzZwYoVrDU=;
        b=V0i4CHFM8pyM+NDjIDVpJQyYLtvh1+xRD2uQHQveabMY1JuaLM3jf6pzbiI9eeZXPO
         omjUy4TN5bFiQsOTEVG/fSazusz2oUkC63s308R95+kdI0GQS8rIx96fnMsw9EhZ3H4n
         pOqcYef1+aP5ZULfz8nl9CdnRvTS91KF56GOc32q2fC/mysseN6+L+spJ/XUibmI1gMA
         5uH2z+Qr4hlAt/duzlAS3CR8qNITld5JVS4lKBt4GRxp0ma4qxTcyoo3srtnpGmh83ys
         rnx/DBng9+NtL1Gjqs/Z7xtHdTrH4Hm3Ov5S6URsIHzXb6e1TSHSPLzV8BLNHCqf0dR+
         1T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678631031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6I/1/bpm4WqYeBDypKIrM3/PdgXx2vNAmzZwYoVrDU=;
        b=qXorVFqMCe6qPOAPDERxU+jEUJ7o3uZY2z7+H3dqKuW/+5CWTRIBecP+Csi/9dNDHL
         +aGch6czWHBJxq1IPqTo29v/zTibKzCoLQSL8RfnCTl97F3g6QNPaNBchXZzHM19KG+x
         60pd+oTNKfEB4jvRK9XixcJpA/qcbiRp14kSIydWQcITu8hMdY256RumDPI4FYtYBuFc
         GS+q2te6EC2bzskLG6sBCm7TK4H92E4of3LT17t/TslHO+nWLqiozt80SQet7cDyj+YK
         3Z+zZ3hJrZ8nMdrbuSB3ecrdzd+uQJKrgedW1gduLJ20l4tGHO+j68J3eBtnBUxZM1//
         GNug==
X-Gm-Message-State: AO0yUKWTk2SjHL9hjzqwe8lxOh/MgHemENU+Q1eJAvYHi7Crd+ufgzXI
        Vkjt+oVB5LvTkSltUyavqKw=
X-Google-Smtp-Source: AK7set9XCyNNapwq8rGccSEBUc3c4ZZeZxChUlk2eKakLQcKmOb3qucCbCpYV944pVV4Ok4BUShmKQ==
X-Received: by 2002:a05:600c:1e20:b0:3eb:376e:2bb7 with SMTP id ay32-20020a05600c1e2000b003eb376e2bb7mr8022920wmb.3.1678631030867;
        Sun, 12 Mar 2023 07:23:50 -0700 (PDT)
Received: from [192.168.1.16] ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id u10-20020a7bcb0a000000b003e11ad0750csm6016269wmj.47.2023.03.12.07.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 07:23:50 -0700 (PDT)
Message-ID: <174e4d14-8b3e-67f7-d901-bd77b054f7c3@gmail.com>
Date:   Sun, 12 Mar 2023 16:23:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: iio: meter: enclose Macros with complex values
 in parentheses
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230312133347.120944-1-eng.mennamahmoud.mm@gmail.com>
 <alpine.DEB.2.22.394.2303121507450.2865@hadrien>
Content-Language: en-US
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2303121507450.2865@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On ١٢‏/٣‏/٢٠٢٣ ١٦:١٢, Julia Lawall wrote:
>
> On Sun, 12 Mar 2023, Menna Mahmoud wrote:
>
>> enclose Macros with complex values in parentheses is especially useful
>> in making macro definitions “safe” (so that they
>> evaluate each operand exactly once).
> enclose -> Enclose, and Macros -> macros
>
> I don't understand the above comment though.  How does adding parentheses
> around the body of a macro cause the operands to be evaluated only once?
> And the macros that you have changed don't have any operands.
>
> The value of adding parentheses is normally to ensure that the body of the
> macro doesn't interact with the context in a weird way.  For example, you
> could have
>
> #define ADD 3 + 4
>
> Then if you use your macro as 6 * ADD, you will end up evaluating
> 6 * 3 + 4, ie 18 + 4, when you might have expected 6 * 7.  The issue is
> that * has higher precedence than +.


yes, I mean that but i couldn't explain it well, thanks for your feedback.


>
> But I don't think that such a problem can arise with a cast expression, so
> parentheses around it should not be necessary.


So, no need for this patch?


>> this error reported by chechpatch.pl
> this error is reported by checkpatch.
>
>> "ERROR: Macros with complex values should be enclosed in parentheses"
>>
>> for ADE7854_SPI_SLOW, ADE7854_SPI_BURST and ADE7854_SPI_FAST
>> macros and this error fixed by enclose these macros in parentheses.
> The last two lines aren't needed.  One can easily see that from looking at
> the patch.


Got it, Thank you.

Menna

> julia
>
>> Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
>> ---
>>   drivers/staging/iio/meter/ade7854.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
>> index 7a49f8f1016f..41eeedef569b 100644
>> --- a/drivers/staging/iio/meter/ade7854.h
>> +++ b/drivers/staging/iio/meter/ade7854.h
>> @@ -139,9 +139,9 @@
>>   #define ADE7854_MAX_RX    7
>>   #define ADE7854_STARTUP_DELAY 1000
>>
>> -#define ADE7854_SPI_SLOW	(u32)(300 * 1000)
>> -#define ADE7854_SPI_BURST	(u32)(1000 * 1000)
>> -#define ADE7854_SPI_FAST	(u32)(2000 * 1000)
>> +#define ADE7854_SPI_SLOW	((u32)(300 * 1000))
>> +#define ADE7854_SPI_BURST	((u32)(1000 * 1000))
>> +#define ADE7854_SPI_FAST	((u32)(2000 * 1000))
>>
>>   /**
>>    * struct ade7854_state - device instance specific data
>> --
>> 2.34.1
>>
>>
> >
