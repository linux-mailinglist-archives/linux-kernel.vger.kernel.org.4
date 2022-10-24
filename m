Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F31960BB67
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiJXU6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiJXU6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:58:23 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D32787095;
        Mon, 24 Oct 2022 12:04:07 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso7067758fac.13;
        Mon, 24 Oct 2022 12:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=H8i7U5bmMKO/8z/xC4NChgsxdHTmYMHq2WLzQcOksu4=;
        b=dPUXKTYiNvpyV/oK0w2Z+840q4ciXuOPb6P66JQaakBUBvfyiKOKMDYbwOnXTXvtpZ
         HOXhU2W+agoxJFZKi2WQVJ3CuifdKHR23nAqJIZED113Ptuyu99YmqW9I8EiDfbH8EXd
         Jh7chDuECzTosoXNty9NH+TgR5xZc+p/29KWrTan1T4K6jD7MqSHBzqm2v720ZM7psR+
         u7ViduNkkOCWpurn4v+bDMsa2ruLusIvicSSEEWJls1ncitrb1pwEKzi7UNU9GIMT/DZ
         bsDpB9BG/6Yl9ZTArhW4zC2inHSVwDYzWdaoLLLxtZeD4fFAZbC/iKgow8cpeKN3zvKN
         HhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H8i7U5bmMKO/8z/xC4NChgsxdHTmYMHq2WLzQcOksu4=;
        b=QWCBYHWzooTWUhtMZP62Ehs0MJr/bfleqX4ausCQbyWgCPyIcXr8SwkOBvKIW8xa3Y
         NQT7yFo3Sw44+og+x+YU/lhR7UHZkSmhwmnohfaBWou46h9eHE4ENoKUYUe4yeSB3NhX
         cw71SnaqL5xfBLE9lcbxxkQ/81cZwkHIEwAmTz9Qw7578Zf+ku4DrvirECD21uaAetQH
         wNxz6FTWqZHbgfAx2enm9OXs/vKITy/WfRyBeDUtPyO2iz3khUeuyFsqMMWRYczQ1O53
         V6fraYjC/t/sHqw96RicKOr+U72Cyyt835eatgW47Akb2Ik2BheOFRt3TxIokHIsFVpm
         8JwQ==
X-Gm-Message-State: ACrzQf3bGxnH2y3f4rlUTJm3qQZ2lFtqSQvLa2k788KEktYut6a95FGb
        0NTmH7nWeZmRqq/wFXnqzCI=
X-Google-Smtp-Source: AMsMyM4H5JWmW1ivLCPgGqI7B1uo7DYgBup/VLoraFetEljQEQzdMgP4Jefq4ToKDnv4e6dYgXOLPA==
X-Received: by 2002:a05:6870:4250:b0:13b:686b:af0d with SMTP id v16-20020a056870425000b0013b686baf0dmr6984899oac.34.1666638210138;
        Mon, 24 Oct 2022 12:03:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d22-20020a4ad356000000b004805e9e9f3dsm331882oos.1.2022.10.24.12.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:03:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <31046e78-840f-4c1a-3966-6cb539e11685@roeck-us.net>
Date:   Mon, 24 Oct 2022 12:03:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: aspeed: Document
 aspeed,pre-timeout-irq-us
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Eddie James <eajames@linux.ibm.com>
Cc:     linux-watchdog@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, wim@linux-watchdog.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org
References: <20221021151559.781983-1-eajames@linux.ibm.com>
 <20221021151559.781983-3-eajames@linux.ibm.com>
 <20221024184423.GA2023764-robh@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221024184423.GA2023764-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 11:44, Rob Herring wrote:
> On Fri, Oct 21, 2022 at 10:15:59AM -0500, Eddie James wrote:
>> Document this new property for the pre-timeout interrupt.
>>
>> Signed-off-by: Eddie James <eajames@linux.ibm.com>
>> ---
>>   Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> index a8197632d6d2..81d2c35ca7e3 100644
>> --- a/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> +++ b/Documentation/devicetree/bindings/watchdog/aspeed-wdt.txt
>> @@ -40,12 +40,17 @@ Optional properties:
>>   			specified no external signal is sent.
>>    - aspeed,ext-pulse-duration: External signal pulse duration in microseconds
>>   
>> -Optional properties for AST2500-compatible watchdogs:
>> +Optional properties for AST2500 and AST2600 compatible watchdogs:
>>    - aspeed,ext-push-pull: If aspeed,external-signal is present, set the pin's
>>   			 drive type to push-pull. The default is open-drain.
>>    - aspeed,ext-active-high: If aspeed,external-signal is present and and the pin
>>   			   is configured as push-pull, then set the pulse
>>   			   polarity to active-high. The default is active-low.
>> + - aspeed,pre-timeout-irq-us: If aspeed,pre-timeout-irq-us is non-zero, the
>> +			      pre-timeout interrupt will be enabled for the
>> +			      watchdog. The interrupt will fire the specified
>> +			      number of microseconds before the watchdog expires
>> +			      and trigger a kernel panic.
> 
> A pre-timeout interrupt is fairly common. Come up with a common property
> please. You'll need to be clear if the time is from wdog restart or time
> before final timeout.
> 

It would be nice if it would match the semantics of the existing
pretimeout attribute in the watchdog core.

Guenter

