Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 387AD6B710A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCMIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjCMIT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:19:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B78928D35;
        Mon, 13 Mar 2023 01:19:25 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s22so14568710lfi.9;
        Mon, 13 Mar 2023 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678695564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPFF8eK78hN85/Q0+xjshHxvOwhKM7iTq8jESS78JdU=;
        b=a4Y9A9zL2eg3hDruzkRayEbm1tTA6GQy/0ZGv0E8OEnh4umNi7GBfEXS8gytYRAi9n
         Xlip9PVgPxh5jCtSVaIO+FfsL51fmWMpVea0ubvFmdsCPX6Z2W1tnkYm2RdkOV6H9zHQ
         NH8Px4ii7RPgIilyM4c6SG6OYX0YMDGxLM86a1k6dBc97bPamEZGkTdV38Lj8hSKPyPE
         LQOdUKieuAjBaqcp1Ok4ME8uzgwWvB7tFK24+xnATiMRnuE1HJsj8CV6jycXUi+ijEka
         WBlgyUGdQqQZg/HP9XOYpsoUOr46CO5N7Fk59Wc/RPuUDFdeRZd91u4O59FP5ZjZmwss
         W9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678695564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xPFF8eK78hN85/Q0+xjshHxvOwhKM7iTq8jESS78JdU=;
        b=MJdo2tTzOiVu0Cz3clkF3lM8tVY+gdCLUR2o0nbIiMrPJqE+RPs6k3tA+rzEazQAQS
         t7wIeqG8HhuFlyqg3RWCklPLEmgcqKGHaOtvU1NctfEiOKu4xubVLqsaDz8x3Ei2jrEQ
         kgNyW8MzhMmsoLM45Wdr4uXwWr9G8KyfMY9Wvu4nx40ZAsREIDYQm+UvWpo7/M8UQe07
         XpfPIpCyH2+j2QMV9q9PIUaMBlGFiM11UCLrPphMiVmVlqSMZbfOcX38jxLpdg8t8bpR
         BlH/qBm4xtKoPWk6Sxt5ox8NtqIRpPsczpQ5aUhpMcj+aazAid8Xj2UVufL2JAW50Vxn
         6hCQ==
X-Gm-Message-State: AO0yUKVKH0OWDoPxG3KNEriLHxgDMTL53YaJ9hctncdQB+WDQlKVXMby
        Bq+D46OMpLXZhRs9CINyG1axcXVI5w0=
X-Google-Smtp-Source: AK7set84oAhVi77Hiq9CGiCUHBV5vqZqhB0mDNL5+hBZMVeA0xpscclSNX02Y+LsWEKZ8Wb22RmZfg==
X-Received: by 2002:ac2:4ac9:0:b0:4e1:b880:ba16 with SMTP id m9-20020ac24ac9000000b004e1b880ba16mr9643239lfp.18.1678695563904;
        Mon, 13 Mar 2023 01:19:23 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::6? (dc75zzyyyyyyyyyyyyydy-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::6])
        by smtp.gmail.com with ESMTPSA id f2-20020ac25322000000b004ccff7c56a8sm892042lfh.27.2023.03.13.01.19.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:19:23 -0700 (PDT)
Message-ID: <6e907769-18f6-d4fd-67b0-298a7f4425fa@gmail.com>
Date:   Mon, 13 Mar 2023 10:19:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCHv1 09/11] power: supply: generic-adc-battery: simplify
 read_channel logic
Content-Language: en-US, en-GB
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230309225041.477440-1-sre@kernel.org>
 <20230309225041.477440-10-sre@kernel.org>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230309225041.477440-10-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks good to me.

On 3/10/23 00:50, Sebastian Reichel wrote:
> Drop mostly useless gab_prop_to_chan() function by directly
> supplying the correct enum value to read_channel().
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

