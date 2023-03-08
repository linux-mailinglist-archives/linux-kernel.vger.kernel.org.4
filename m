Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83126B0B1F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCHO2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbjCHO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:28:12 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40942C8092
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:27:43 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h14so15565112wru.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678285637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AaTfZTNRhFyM48e1bpAcZAo8m7slW8NTGkFf2XgdI8U=;
        b=bgKuuaowwIHuzWnG1NB96c5vbEtK9q7l8MOI0c1kzAL9Et9S2WG/LzlvUrNGB+ow9f
         xVHLZu/ztI4Ox4clHAmnMW4OqXaqQq5vF8wLjq6s/0yNpowQkZNJh30jABbQhBmz3dNX
         nf/LR74aeA7/rGTTX0X0gYJM6c8vO0BymmTewqq64N0oDpmvYHrhVvzLH1wYGraWnETY
         uG/RTe8b/G9NVYv7LzS3NaHKNHzSC3poA5A7asGr7F2ym/fwuRvgqFnQiwQ6ncSnShV1
         5K8+j0lXcazfLLd/dgQp/9eqllBny/Qvrtro11hUb8Dv6arZGjrFq10K3gQ8ypQ5ePWm
         j9IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285637;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaTfZTNRhFyM48e1bpAcZAo8m7slW8NTGkFf2XgdI8U=;
        b=GwcpIZrFwQZC3qkXbwAPLg7SQ8kRFqohchmRyxYsNl8xn36JrQ7cKw7oRffF0xnP/U
         F3CWXdMFPlSbD4oQo+ME7CJPSLjENRe+IgrQNu5wVxFozOxBvgvL7E8v1vfvWRak21Fb
         4KBaz8oWT+F+LvEkHKojYCPowJnuR4LvWYmkmkRcxzHeb110zT6pLeYQDxjneWRVas+2
         V0lFW4+a6aegnxdnxUA70ip6KVfrnE4bvcFEMryh70h9N0InoUJExBorbu65nhd9+IUK
         YpVrt5oexOmjN02Q2koMpoPUWHVObhMB1GslLzCRa91wEjuNtE59dkcCO1EZ5zs32CUx
         L80Q==
X-Gm-Message-State: AO0yUKWOKfFq/OkjwZjY3oFrpbdY6bKq5LQbSpN7pAKIH5altct201xH
        v9nNFXjqRUK2eWMm30t1j8HV+w==
X-Google-Smtp-Source: AK7set8bRTPcS9jKfQq8XHiz38+rHTpYtFofbjafhttmqipDm1uWNN+CE78jatnscVKtY0Lb8wqWCw==
X-Received: by 2002:a5d:61cd:0:b0:2cc:5ee8:feee with SMTP id q13-20020a5d61cd000000b002cc5ee8feeemr12293443wrv.33.1678285637601;
        Wed, 08 Mar 2023 06:27:17 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r1-20020a056000014100b002c5534db60bsm15739529wrx.71.2023.03.08.06.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 06:27:16 -0800 (PST)
Message-ID: <577a12a8-62c0-c3d0-0cf6-641c502734dd@linaro.org>
Date:   Wed, 8 Mar 2023 14:27:15 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/4] serial: qcom-geni: fix console shutdown hang
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230307164405.14218-1-johan+linaro@kernel.org>
 <CACMJSes3usJUvCsrMBR_9dDGCbo2y7JqA8-B5mP28H2Cjg-v6A@mail.gmail.com>
 <CACMJSesztZbB53QPaiLg+GKghJ-8MbiS60t8CbN_m8Wcph3-9g@mail.gmail.com>
 <ZAduTSTirQbqZlIg@hovoldconsulting.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <ZAduTSTirQbqZlIg@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 17:03, Johan Hovold wrote:
> On Tue, Mar 07, 2023 at 05:47:27PM +0100, Bartosz Golaszewski wrote:
>> On Tue, 7 Mar 2023 at 17:44, Bartosz Golaszewski
>> <bartosz.golaszewski@linaro.org> wrote:
>>>
>>> On Tue, 7 Mar 2023 at 17:43, Johan Hovold <johan+linaro@kernel.org> wrote:
>>>>
>>>> This series fixes some of the fallout after a recent series adding
>>>> support for DMA transfers to the Qualcomm geni serial driver.
>>>>
>>>> Most importantly it fixes a hang during reboot when using a serial
>>>> console and the getty is stopped during reboot.
>>>>
>>>> Doug just posted an equivalent fix here:
>>>>
>>>>          https://lore.kernel.org/lkml/20230307073155.1.Iaab0159b8d268060a0e131ebb27125af4750ef99@changeid
>>>>
>>>> but the commit message only mentions the regression with respect to
>>>> kgdb, which is not as widely used serial consoles generally, so I
>>>> figured I'd post my version for completeness.
>>>>
>>>> Either version of that fix should address the immediate regression, but
>>>> fixing the underlying problems which have been there since the driver
>>>> was first merged is going to be a bit more involved.
>>>>
>>>> The rest of the series fixes a few bugs in the new DMA support that I
>>>> found while investigating the console regression.
>>>>
>>>> Johan
>>>>
>>>>
>>>> Johan Hovold (4):
>>>>    serial: qcom-geni: fix console shutdown hang
>>>>    serial: qcom-geni: fix DMA mapping leak on shutdown
>>>>    serial: qcom-geni: fix mapping of empty DMA buffer
>>>>    serial: qcom-geni: drop bogus uart_write_wakeup()
>>>>
>>>>   drivers/tty/serial/qcom_geni_serial.c | 11 +++++++----
>>>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> --
>>>> 2.39.2
>>>>
>>>
>>> Hey Johan,
>>>
>>> Douglas and Srini beat you to these fixes but thanks!
> 
>> Nevermind, I read your other message now. And also patch 3/4 looks right.
> 
> Heh, this hang has been in linux-next for over a month and I've
> actively tried to not spend time on investigating it in the hope that
> someone else would be beat me to it before I moved to 6.3-rc. :)
> 
> Obviously I may be a bit biased, but I prefer this series over the
> alternate fixes as the commit messages are a bit more complete and my
> version of the empty DMA buffer fix is a bit cleaner.

I don't mind, as long as the bugs are fixed.


--srini
> 
> Johan
