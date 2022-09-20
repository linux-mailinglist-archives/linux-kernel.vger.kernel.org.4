Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEB5BE863
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiITOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiITOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:15:38 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF0462A8F;
        Tue, 20 Sep 2022 07:13:12 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id u132so2864096pfc.6;
        Tue, 20 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=dqRGDbrWd1xgyDLxgRtjtXZqfquXEM+oB3Al0IMjKrA=;
        b=TMHA2hi58ob+XHXca4odB/qBviWLDfb0sxV1tVJOB2RZJcRud6bIn2OaYIF9g4/sry
         uHQ1fSobXvnvBfE8oVF7HpRrLmK4BkI8nqAI7fAmL8kNStPqjCe3nlRuI+h1kVnnIUuI
         ixvA6oN5E5eme10i5NiE663yYgg/rOnFRuFObt0yzmrX5TrXerp2MM34t+RmMiN6shyy
         LV2sEZNAp+6AMtH0bKvK0+pFF7eXnLKkgdfCtY3rvGGS44Px1E2721BiekKGfitlNgK1
         XhPT2GeT9fmHGHURiHc2rYuk6iCQKtimuVik9VUozjmGZEByma00buY/HaowE5oJ7BpF
         OtKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=dqRGDbrWd1xgyDLxgRtjtXZqfquXEM+oB3Al0IMjKrA=;
        b=KDmKEc8sPNCJCh5njW601Fnl+Rv+OqbtFIS3CrFvZjR0x9ab/z+q58Apt2pWY308OB
         Y2Abb7O6qU6+MD3g+wVMsEVv+wHZDG5ODhtvFt++9TFw0f0ql3RWFLPI8IbJCAob/dqK
         1Mf0VUezV+x80GZImZQVKrYFhZomoA4WUXc+H6uJwGUaQtmcmX2rkNJ6VcAmB+4Sj93R
         eUtjvK97PY1bwnABqnuqMR1x2D1M6d1VA0zhn44DDYujtyz5Hp8FoM7E/tLVzsYFnpzY
         Ke4s+FpnYpwmo7ShfmTYPMCGA9RH0kjWUtKwky1EtZg0xeokpJ1Mlaxl/aMsHFXoY6NT
         FfPQ==
X-Gm-Message-State: ACrzQf1FJlY0SIGbb5Ri5fcyR7eSke9Maj8v2dYPYoeCBRNJ0xR9VLtS
        NxVWRDc4a5hypNUn5fcCByI=
X-Google-Smtp-Source: AMsMyM70KEqEoHJ4mv7vPlCEVgsAHwRdImX7fkMfPNVbbE9/z9Aw0x11B7tAOc/h0NxnnbXpssLRfA==
X-Received: by 2002:a05:6a00:16d6:b0:53b:3e58:1c6f with SMTP id l22-20020a056a0016d600b0053b3e581c6fmr23836509pfc.7.1663683192034;
        Tue, 20 Sep 2022 07:13:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u185-20020a6279c2000000b0053651308a1csm1773081pfc.195.2022.09.20.07.13.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:13:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46c3fdc6-05bb-f67d-f199-1d9f2f1c332a@roeck-us.net>
Date:   Tue, 20 Sep 2022 07:13:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 0/4] hwmon: Add max31760 fan speed controller
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220910171945.48088-1-Ibrahim.Tilki@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220910171945.48088-1-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/22 10:19, Ibrahim Tilki wrote:
> changes in v9:
>    - return -EINVAL when writing fan_enable and pwm_enable
>    - fix dt-bindings errors
> 
> changes in v8:
>    - use sizeof(*)
>    - use DEFINE_SIMPLE_DEV_PM_OPS
>    - remove __maybe_unused
>    - remove of_match_ptr
>    - dt-bindings: style fixes
> 
> changes in v7:
>    - make max31760_read_string static
> 
> changes in v6:
>    - update description of hwmon documentation
>    - add hwmon documentation to index.rst
> 
> changes in v5:
>    - add dt-bindings documentation
>    - add maintainer
> 
> changes in v4:
>    - use sysfs_emit instead of sprintf
>    - use kstrtou8 for pwm
>    - use closest match for pwm1_auto_point_temp_hyst
> 
> changes in v3:
>    - add regmap cache
>    - remove pwm1_auto_point[1-48]_{temp,temp_hyst} attributes
>    - add pwm1_auto_point_temp_hyst attribute
> 
> changes in v2:
>    - remove pulse_per_rev variable in tach_to_rpm
>    - remove temperature max_hyst and crit_hyst
>    - strict value checking for fan_enable and pwm_enable
>    - do not clamp pwm value for Look-up table
>    - add sysfs_attr_init call
>    - add documentation
> 
> 
> Ibrahim Tilki (4):
>    drivers: hwmon: Add max31760 fan speed controller driver
>    docs: hwmon: add max31760 documentation
>    dt-bindings: hwmon: Add bindings for max31760
>    MAINTAINERS: Add maintainer for hwmon/max31760
> 
>   .../bindings/hwmon/adi,max31760.yaml          |  42 ++
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/max31760.rst              |  77 +++
>   MAINTAINERS                                   |   9 +
>   drivers/hwmon/Kconfig                         |  12 +
>   drivers/hwmon/Makefile                        |   1 +
>   drivers/hwmon/max31760.c                      | 596 ++++++++++++++++++
>   7 files changed, 738 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
>   create mode 100644 Documentation/hwmon/max31760.rst
>   create mode 100644 drivers/hwmon/max31760.c
> 

Series applied to hwmon-next.

Thanks,
Guenter
