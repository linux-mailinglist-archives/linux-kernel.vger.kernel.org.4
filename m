Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400E363C3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbiK2P31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiK2P3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:29:14 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9D460EB4;
        Tue, 29 Nov 2022 07:29:13 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id e205so15545220oif.11;
        Tue, 29 Nov 2022 07:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vPDfCCPU9UwEojn/1/N+FwhKYPS8BLympxzgAuLGb5M=;
        b=oJhn0vcMdggKmNCuh6OVgFqQHohG1WtAmN0oLlNRr5q1lrjjabaF0GXgVO8cBHAK1r
         e1wBnVlB6+W20iwHXwbdaEhLVgBymFDnZSfEph8dID2BrS/NriXBeb72x3kyaI2QMc3z
         j3LtKgqWMmsRJxa7y+E1m70oxgbTX0/w/Mql7Om8Yg50b3GG2Aa8T/wyG9aZFeT42leu
         3PNf43FW0xid9LkuI1BP8fhc2R2Pl6UxjaJsqLOSgFHn914faBHl5ZZys/fT8DohvR23
         WWeuyupIawzxkIZ/bL5U3+oJNtK63G0/3oQq20GmJpMmNZkvkE3qaGM0fBjDrZENKI1O
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPDfCCPU9UwEojn/1/N+FwhKYPS8BLympxzgAuLGb5M=;
        b=40JJDXUGo0B7VP1LkxoI6voW5Z2vAKQMX2VImAJm4uRWgJyLlMkC2rstwrKr697htZ
         z////v+G2HJiPnrBYIViFTSOSbH2Kl9WvWcnQHr0jLrvAM541+HOTb3cKWQQRXtIwvCf
         qCiyViGd48yanA/x4u3LhVt6OK8Hfto4FeCZ8QkKhx0h1D6QEPadDTV1A1b63KNIV+05
         x6/af52B3970975YqNcbKuP1gxRgha2cv07+WZQEmhM/cwtnbbqv2/u5Qy1RlTPvjlpM
         B//k/boToF36QprnfgC0nRNPW+OPq76IB034e6/7gzTvzwNI0RlFOUFIzihduTW6Bwha
         gtXw==
X-Gm-Message-State: ANoB5pnbWUMd7KyUQ6CxiROXGHwRvw1qtJEb+fmjPDLwwS0g3cvGhXI6
        8EWk3BQ0aP9u/u8YNGksqevpNn2OrFQ=
X-Google-Smtp-Source: AA0mqf6tPdX7jAoEcpJbuJoFCsBye/iE3V37hAXr68PvRPH0lpRPOkLj7p5gv9d8Ao7ygVJQulLM4g==
X-Received: by 2002:a54:4891:0:b0:354:63ae:721c with SMTP id r17-20020a544891000000b0035463ae721cmr31159501oic.236.1669735753134;
        Tue, 29 Nov 2022 07:29:13 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r33-20020a056808212100b0035b99bbe30bsm4408300oiw.54.2022.11.29.07.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 07:29:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6522b785-9fcf-93ce-9a0d-6539ca8e18a2@roeck-us.net>
Date:   Tue, 29 Nov 2022 07:29:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 3/3] hwmon: (pmbus/core): Implement irq support
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20221128174715.1969957-1-Naresh.Solanki@9elements.com>
 <20221128174715.1969957-3-Naresh.Solanki@9elements.com>
 <bda19726-74f3-b76d-c30c-eb2543979690@roeck-us.net>
 <1b015a86-0d65-8597-0512-b313769e307b@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <1b015a86-0d65-8597-0512-b313769e307b@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 00:16, Naresh Solanki wrote:
> Hi Guenter,
> 
> On 29-11-2022 04:39 am, Guenter Roeck wrote:
>> On 11/28/22 09:47, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> Implement PMBUS irq handler to notify regulator events.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>
>> As I am sure I have mentioned before, this needs to primarily handle
>> sysfs notifications to hwmon status attributes and to generate kobject
>> events. Regulator events are secondary / optional.
> 
> Based on previous feedback, PMBus interrupt handler is made generic
> Based on the use case I have in my machine, my application need to monitor regulator event as soon as they occur and hence the patch.
> 

I understand, but this isn't just about your specific use case. Your use case is
what triggers the change, and ensures that the code change is tested, but the
impact by far reaches beyond your specific use case and needs to address other
(much more common) use cases as well. Interrupt support is needed in the pmbus
code, but it needs to address the common use case first, and that is reporting
the status via sysfs notifications and kobject events.

Thanks,
Guenter

