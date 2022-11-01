Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1C5615237
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiKATW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiKATWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:22:55 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB9B1EC6D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 12:22:54 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 128so14283415pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 12:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eEtZo/a1sd1wcSWZKkoCrX1avRUJt1UjkNS0NlZQL/4=;
        b=QEA1iXc37I5rzSs5hKflQbAc2y8xw0vwFh2PE/vObyapp49iv5wDtqXSZ2s+okrFcV
         gyuGIG29rF1qYFGN9vB0i4BdahCR4D2AZVB7MZ+X+lYggJKjfOHgIvLd9JTq0BZfG10i
         17xgpZAPG3HAGMGnDSlqeQ/+LzNSazkJFQCdTxWpKfNqFH9WIgLM1OYC2zXERuVLJYlb
         O+Om0cNyMMG6jo0GcspPvpvx7bXKxcA9lUqnqKJUKnXHMEXZatGjrTR/bbNe2dq58cpJ
         0o8ka+lGLBr4d8Uj2uC3kp4phufIRlupcic3UfKS5rjfLf26UbkerewjEr84Y/tCa/g6
         nRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eEtZo/a1sd1wcSWZKkoCrX1avRUJt1UjkNS0NlZQL/4=;
        b=Ms97Vg7pNPEV+EY5cEaZUyCBHLrpAc9I08rpcv+33F/c1sUhvPMoOR4Y4dV3X1Bsnd
         DL8+kio+ndJqKr/4noOE/YmTNFRpiodOFnT1NBL+61U8eCI7x8a5+JbWusx+O4dQh2b7
         82//+NJX7dCFntbmRyPKPnkLqVW1TQOaXSiyFxMy1G/8BMA5V3LyVh8d4TJ7cinPwOqB
         MEXvdPhO1zwiPRVmQXwB0BxQeKBCSFm/dEzAHR0ck5twI4GXdb4q5ZOUoAEsc9JhYe32
         myZGoHMMZ1xqFXPXQKBtiaQAUTQkw3YNN9csY4ZmyzgpWIbhgwyrULxhN1UTjtDgTPKh
         hb3A==
X-Gm-Message-State: ACrzQf3UrP0QdP+0nDPtN69yp3SnYH1fBjwbN9lEPFeujVbuIjhQRJs/
        yeZUn+w8aBZBcdhTiXBof/e/+g==
X-Google-Smtp-Source: AMsMyM4uxb/DbCv9KgzTqU7n0Ij38fHEqA9N+MdGN8qw+d1O/PEts1FOLgUcQX0ndANjcIiYy+nd3w==
X-Received: by 2002:a05:6a00:810:b0:56c:df84:1b2d with SMTP id m16-20020a056a00081000b0056cdf841b2dmr21622827pfk.66.1667330573898;
        Tue, 01 Nov 2022 12:22:53 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id m14-20020a63fd4e000000b00460c67afbd5sm6279892pgj.7.2022.11.01.12.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Nov 2022 12:22:53 -0700 (PDT)
Message-ID: <2cad1cb4-b16f-201e-0593-2599ec8abf8f@9elements.com>
Date:   Wed, 2 Nov 2022 00:52:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221013094838.1529153-1-Naresh.Solanki@9elements.com>
 <20221013094838.1529153-2-Naresh.Solanki@9elements.com>
 <20221024161806.GA1855651-robh@kernel.org>
 <dcd22f70-e51c-290e-c11f-9a5ce32748c1@9elements.com>
 <CAL_JsqKT52ULEZjKo9emEAt74nH2OpMO8ymLLKM_T-NzAwqGog@mail.gmail.com>
 <3152c290-8aca-b91a-df20-335c33395835@9elements.com>
 <20221101184402.GA1884153-robh@kernel.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221101184402.GA1884153-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 02-11-2022 12:14 am, Rob Herring wrote:
> Does turning off fw_devlink help (fw_devlink=off)?
This didn't bring any difference for the error.
Failing due to same consumer & supplier.
Returning from here:
https://github.com/torvalds/linux/blob/master/drivers/base/core.c#L702
Also this can cause return:
https://github.com/torvalds/linux/blob/master/drivers/base/core.c#L732

Regards,
Naresh
