Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDE667C360
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbjAZDR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZDR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:17:26 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33CF66ECE;
        Wed, 25 Jan 2023 19:16:44 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id d10so291175pgm.13;
        Wed, 25 Jan 2023 19:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=krR/vR8E6IDtNS5LBWmpX1AevXufMeL6ex2h2vIBpwM=;
        b=InSDjEaNKAQIhVurZGpOu19GpSqoissPVnvn7Idtqq7uFOEM5CmeoggPh2fyIvwPb+
         FwV1nRRRgVsWQDO4lWfN3QzjEeIe5HSwCV7nwhT7Ke0Wnx02MbDCQsHPf79c4hKq6zQz
         bqYQXn7GaI2m8mk3Fc5pcB20YrxIHB3qe0WkTfsnYrG+4z3yc6cOZhpjpgOfPU2OXsqb
         M9HnpCtwhV7AMIqWo5qAeUmXWBwOuz2NZU5F3LllLMI0xkTI+BauC9ACdoOUxFpL2UCh
         sGltVhi5mtxmZewYMQd33lo5arjA3tbGXW9yTuo5bd8zWCkHdLj/dU+dJuh6XsVdMDwA
         sD0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krR/vR8E6IDtNS5LBWmpX1AevXufMeL6ex2h2vIBpwM=;
        b=DWLO2rWzfz5F9037a1yIHy4QWZruOsJu6P0FyGt53VADsK3H493mJQol6Q06dBY8TP
         0ZGtV29Lu13/EgoiXVMju33GVfKWAEIrxuaH67dCP5TKQNiJ+HZ8r5vv72VedO0KV/Oz
         5a6MqM7Sde1zRUPMLXP9yUgIoyoksYJBTzCejiuLLAcWjVZu0lf1FSfZehLtPUGDIEsR
         NipefmuqmFchMfdJw5fR1BEZoAWVwqNU0GFGptknX8ssFrTlLAEzUArLatX/DUEy6DGG
         aXUqLHzUkaG2FNv64uDC4fJilU4orYOsXHCyw4uiXMT7pAUzrlEjSWUwKML3bMAS0xDG
         BzHA==
X-Gm-Message-State: AFqh2kovwsfBNSivliGH5K4qNAb+XUEHnLOo5lZ4I4Sm9wStWiNbBlPt
        4Jvn/hflBwthmgt8w0PLZQ4=
X-Google-Smtp-Source: AMrXdXtne4U3rYnn4P5Cli+7bkK+iJUzLEwUExucynAjQERTHOWxueqGmK8DGrlbWeRDm0OCbGXGhw==
X-Received: by 2002:a05:6a00:2986:b0:58d:a7a7:580f with SMTP id cj6-20020a056a00298600b0058da7a7580fmr35505139pfb.19.1674702951481;
        Wed, 25 Jan 2023 19:15:51 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-30.three.co.id. [180.214.232.30])
        by smtp.gmail.com with ESMTPSA id m9-20020a62a209000000b005895f9657ebsm4363821pff.70.2023.01.25.19.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 19:15:51 -0800 (PST)
Message-ID: <5fd77765-4f55-f204-6aa0-963830cd13d8@gmail.com>
Date:   Thu, 26 Jan 2023 10:15:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] docs: leds: fix the following docu build warning
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230125154426.12464-1-skhan@linuxfoundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230125154426.12464-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 22:44, Shuah Khan wrote:
> Add leds-qcom-lpg to Documentation/leds/index.rst to fix the following
> doc build warning.
> 

The patch subject should have been "docs: leds: add missing documentation
to the toctree"

> Documentation/leds/leds-qcom-lpg.rst: WARNING: document isn't included in any toctree
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/leds/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/leds/index.rst b/Documentation/leds/index.rst
> index e5d63b940045..b9ca081fac71 100644
> --- a/Documentation/leds/index.rst
> +++ b/Documentation/leds/index.rst
> @@ -26,3 +26,4 @@ LEDs
>     leds-lp55xx
>     leds-mlxcpld
>     leds-sc27xx
> +   leds-qcom-lpg

Otherwise, LGTM.

Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

