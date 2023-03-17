Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC886BE593
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCQJ2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCQJ2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:28:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E5FC48A4;
        Fri, 17 Mar 2023 02:28:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v21so4692353ple.9;
        Fri, 17 Mar 2023 02:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679045287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8LqT03HzqRZKjSDqL/i4TvoyMlrA9qMCZ206BpQZVo=;
        b=UhjGNFXazzUo+jepNWB6YPAMrbmXmW0oEHBmFm1ZC81EcW29aOR4+oWetmBi7qdcrf
         azA1y6bOZK6qdRinQ9Go5nTcMElTdlr4F28vYCvH94PGOa7sZde49n/nuNev5R3znB57
         fusvjyyqjzdk4ua9i5b82o5n2TP34/ee9zHA1qMSATtUU3LV+zvJFWlR9tDncAaDpruA
         HlK/kMqeXraybuK9R44jXpqnLh2m0ZzcRO29PbHqQParUziei/jXq4cK9H4f36llivmn
         rEj+VwonwLlafwORogfKYb+BZMd5QbMeqzKact8ttl4J+mlXt4/FSov0TvJbf48p8jve
         f0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679045287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8LqT03HzqRZKjSDqL/i4TvoyMlrA9qMCZ206BpQZVo=;
        b=QZ/kkbqfHMhwqjZI3ED0Ml8Dh1ojB7YJt1TtGHfJNE64l170YVU3H0iQK1kIA/dMh4
         Ba5wzlJvQPCieJ2FmLuQRd/zqB4xqTNes55IyNcJCdcKpTZMDUTLNPQ8lCZpGTe5KASg
         FNlNjprutU8scQHTp6binxnWahwf+8SviuDwwyGQUlWcE2E8Mu0mZiSQk7Wqr0FM/99h
         XaVgYTTWtao7ELODt1vxphaZD61o/8ur5WxR9VWLGrh9857wMrWI8rbfuBsVDC/v9zOk
         wWxWNv1StUGxqQOoTei9V2USsq+7QQ2Tbc3HmymjA8VZsRwjYxRfL+YETNjKhQWteU35
         EF2Q==
X-Gm-Message-State: AO0yUKWq2PjoPeT9OoX+/UXJ//T7eF50tT8EuVXS8LTjOg9ErXdYX1Ki
        Ix6YALuHU1KkPqdIe9KaQU0=
X-Google-Smtp-Source: AK7set9eu22SCZQs8yUTVpmrhShMwDYwfOgvFcsCnNHkDvEyH1gZNPjiwGpJ20koMB6S6n7wtkNi/w==
X-Received: by 2002:a17:902:d4cb:b0:19a:95ab:6b38 with SMTP id o11-20020a170902d4cb00b0019a95ab6b38mr8257544plg.1.1679045286859;
        Fri, 17 Mar 2023 02:28:06 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a170902988700b0019edd34dac9sm1121371plp.60.2023.03.17.02.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 02:28:06 -0700 (PDT)
Message-ID: <d5e18ffd-426f-79de-d8cc-7ee10b3dc110@gmail.com>
Date:   Fri, 17 Mar 2023 17:28:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/15] mfd: Add the header file of Nuvoton ma35d1 system
 manager
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-4-ychuang570808@gmail.com>
 <fa966844-2750-4951-9a40-ecc2653aab77@app.fastmail.com>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <fa966844-2750-4951-9a40-ecc2653aab77@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Arnd,

Thanks for your advice.


On 2023/3/16 下午 10:44, Arnd Bergmann wrote:
> On Wed, Mar 15, 2023, at 08:28, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> The system manager is a set of registers used for power control,
>> multi-function pin control, USB phy control, IP reset, and other
>> miscellaneous controls. It also contains some registers that
>> provide SoC information and status.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   include/linux/mfd/ma35d1-sys.h | 95 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>   create mode 100644 include/linux/mfd/ma35d1-sys.h
>>
>> diff --git a/include/linux/mfd/ma35d1-sys.h b/include/linux/mfd/ma35d1-sys.h
>> new file mode 100644
>> index 000000000000..dcd85231125d
>> --- /dev/null
>> +++ b/include/linux/mfd/ma35d1-sys.h
>> +
>> +#define REG_SYS_PDID		(0x000) /* Product and Device Identifier */
>> +#define REG_SYS_PWRONOTP	(0x004) /* Power-on Setting OTP Source */
>> +#define REG_SYS_PWRONPIN	(0x008) /* Power-on Setting Pin Source */
>> +#define REG_SYS_RSTSTS		(0x010) /* Reset Source Active Status */
> ...
>
> It is a bit odd to have a header file in include/linux/mfd/
> but only have the register numbers in there, and not an
> actual drivers/mfd/ driver to go along with them.
>
> I think what we often do is to just list the individual register
> numbers in the drivers that need them and not have the central
> header at all. On the other hand, I can see it's useful to
> have this documented in one place, and we clearly don't want
> to add a driver if none is needed.
>
> Maybe Lee has a suggestion for how he'd like to handle this.

Agree with this.
We will add #define of individual system control registers to the drivers
that have to use them.
So, I will remove this patch from the patchset in the next version.

>> +void ma35d1_reg_lock(void);
>> +void ma35d1_reg_unlock(void);
> These look like they were left over from an earlier version
> of the code. Since you use the regmap framework, I think this
> will take care of the locking for you.
>
>         Arnd

Best regards,

Jacky Huang


