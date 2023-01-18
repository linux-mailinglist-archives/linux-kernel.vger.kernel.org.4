Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4EE672318
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjARQ0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjARQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:25:58 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6C84ABED;
        Wed, 18 Jan 2023 08:24:21 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-15f83e0fc63so2541440fac.11;
        Wed, 18 Jan 2023 08:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2rLwuf63DKqeRzuEIPgeHxHUXMffvC0Q/6C0HbGG2l0=;
        b=fp5w8dDAo8PcR2gAq+x8TXIuhyBNhbkoBuW3KCxbpX6ktPiIvyPpGVp9Tsr61GR7Cv
         BPkIV4Ccwmo0TivETldYWr4lFZw+rFC1BJ1H8rpiwf4hX4V69xbQ+c9WWIx5J/lT7If3
         M+S8Dt7+nnaLDgkTEN0SYSh/gFDOvmK229GQqFVlH7+Il3f/kOnwxVGkNxOIC1UKmhee
         SvuJHajCsZFtnMqSXLf+zumbvcuE6KyTcck/9/VTS2pK4/YWX+hlYxHViZloOWcrcm3M
         WCVjVbTm9/VNDqpd47s/pp0vLndJQ/KJP0VeGFuPukexaQ1Opl01x7eXna5KgWltl0Bq
         MEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rLwuf63DKqeRzuEIPgeHxHUXMffvC0Q/6C0HbGG2l0=;
        b=NhuMF8yh3xuba5GPlF2TO/1Khmbvagk/JMskO3DN2Ht9S+uf405EzK7AQIrpScRLNL
         smYyoW1c0hBwO+RH89+5jNhuFNxOLsLhlk2VvUdzCeCEfYIK7ZGoTujZUYmDMsif67CT
         5/C/6kNG+Ka63vKmxQFYUj8up2Qnfhxe9+mgpiTsa/hreAW5W28jDy/hOOWXHAfGlJi9
         /vhQszEWt6iXisALw0r0coqCHTPv1XEj+srwXikOpsj5niYZA1rBgnW9qcruIRNwzzn+
         zaqS1GoomtkjYFQhA9+U/yP7EPdFsiDHOZhTP/EvBd1rInv68gHn9dfFyyuVbJu/1PnQ
         BQxA==
X-Gm-Message-State: AFqh2kqXn7CMU8pt1SYXXYvFVKTO3CMiHvw/uXeupYyO9a+c7jwT64ph
        bnLc7KXX490ewpU8Xllxnah6gTB34Gg=
X-Google-Smtp-Source: AMrXdXsRe3r2sDO3d2ivafZ9J1nokHATTsehBcJTg6uMjdH96f1O/v+RI9eFgQI3FlvRocDFNXuF1w==
X-Received: by 2002:a05:6870:588b:b0:15f:2c6a:1ef9 with SMTP id be11-20020a056870588b00b0015f2c6a1ef9mr7049763oab.53.1674059060647;
        Wed, 18 Jan 2023 08:24:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cv29-20020a056870c69d00b001576d0c1196sm17849100oab.51.2023.01.18.08.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 08:24:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c136cef0-273c-4018-238c-6901da86b2d8@roeck-us.net>
Date:   Wed, 18 Jan 2023 08:24:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] hwmon: (pmbus/core): Generalize pmbus status flag map
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118111536.3276540-1-Naresh.Solanki@9elements.com>
 <f9a47a1a-dcce-87e1-be4e-4f62f8e60c78@roeck-us.net>
 <e20695a6-0c48-4131-cf7d-111f727f07e6@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <e20695a6-0c48-4131-cf7d-111f727f07e6@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 06:36, Naresh Solanki wrote:
> Hi Guenter,
> 
> On 18-01-2023 07:13 pm, Guenter Roeck wrote:
>> On 1/18/23 03:15, Naresh Solanki wrote:
>>> Move the PMBus status flag map (pmbus_regulator_status_flag_map)
>>> outside of the regulator #if block and update the associated
>>> variable/struct name to reflect a generic PMBus status. Also retain
>>> the regulator error flag for use in determining regulator specific error.
>>>
>>> This will make the PMBus status flag map more versatile and easier to
>>> incorporate into different contexts and functions.
>>>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>
>> Sorry, I don't see the point of moving a structure including
>> regulator error codes outside regulator code.
> I'm working on adding pmbus irq handler.
> Since irq handler is regulator independent, this change is needed.
> 

Please submit the necessary patches together. I can not accept patches
introducing structural changes like this without use case.

Thanks,
Guenter

