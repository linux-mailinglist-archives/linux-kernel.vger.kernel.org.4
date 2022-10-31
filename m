Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE82613173
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiJaIFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaIFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:05:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0945C9FF8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:05:15 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id v4-20020a17090a088400b00212cb0ed97eso9622070pjc.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a3mltGBO5/lAarkXVK/V/79Pr2NEHJtbOoZuSin9YbQ=;
        b=WHf1X0+EpYOrptMQ21sy3RoYOEekhsn2cVdToTzmhKA+4+rxicXwSMGQEOlrY+1ln3
         vLtBZU/fUp9mUvx8+2riIKREEW0ZyrEklKaKYYo4e6cCfrbgs5tIhWvLq28qMbH5JHiH
         gvBhL0d/HVTD2dqIXuqi8b19jjkOLiYW8d9U4Ks9+lw0PHUU8hkowOyl/ywd1jQRo2rc
         eS0D3vzwSGHhhszxsyMnvahFJm70knTmFsM740DbOsX7Gi/plBWLXvdeNwLj+8YHD2Zd
         sY3gl8ie8MxVl7MP06CAe2PBZr6PmF/ylT0ldeAKJDcsWQdP3pvouX/YiEd97g9Ev7rT
         wr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3mltGBO5/lAarkXVK/V/79Pr2NEHJtbOoZuSin9YbQ=;
        b=XZ3r1fk3Z5z6+OwEWcvJIo/PY5JDWptjPuRUcxwyCFXKkmuAjn2GR1FpQX2AQC6vuh
         J/IBcMQPSoWmoArcHszDDMPcDVDqW1Sb4D4ZokQv3+3z8R34plQWqwJ7oWTlbQ6tFIoT
         BZ1L5RxGL8jIPa/OwQQcm/yIiZuXV3/QMOkxHHX9FGyLMr/6xMOaxWZ6auduw2Tvi+dM
         D6yMG9zB/j/BYb2xTIhaU+3Lm33EGicdflJtnKlp1CMh32i5LCeEI4NUxsn/nZuLYCWX
         GtMrROhjH8XYZCnX9apj0Tg86828354HcBdSYCb4hg8AuR5JqPxHeBQeKjDfXNaek2nc
         9UXg==
X-Gm-Message-State: ACrzQf3vESv1VqlRUaGLhzviNgjBHcLWz5Li8gNUzKNGPeGmUN1cw18f
        ewzHMTYpLU4lGSVkZr8Ti74dIA==
X-Google-Smtp-Source: AMsMyM6mxCv+BsCVn3561zIAqJ39MWgR894VJm3Gd3pe43O8WJNL70RBJIQGNzoRHha1KcT5k/GAXg==
X-Received: by 2002:a17:902:ec92:b0:186:de89:7f67 with SMTP id x18-20020a170902ec9200b00186de897f67mr13418848plg.166.1667203514518;
        Mon, 31 Oct 2022 01:05:14 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id a19-20020aa795b3000000b005636326fdbfsm3914318pfk.78.2022.10.31.01.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 01:05:13 -0700 (PDT)
Message-ID: <3152c290-8aca-b91a-df20-335c33395835@9elements.com>
Date:   Mon, 31 Oct 2022 13:35:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
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
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <CAL_JsqKT52ULEZjKo9emEAt74nH2OpMO8ymLLKM_T-NzAwqGog@mail.gmail.com>
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

On 26-10-2022 07:07 pm, Rob Herring wrote:
> fanc: fan-controller {
>    #pwm-cells = <3>;
>    ...
> 
>    fan {
>      pwms = <&fanc 0 500000  PWM_POLARITY_INVERTED>;
>      ...
>    };
> };
> 
> 0 is PWM number and 500000 is the PWM frequency. The 3rd cell are per
> consumer flags. See pwm.txt for more details.

Did the implementation & while testing getting the below err:
[63.626505] max6639 166-002e: failed to create device link to 166-002e
