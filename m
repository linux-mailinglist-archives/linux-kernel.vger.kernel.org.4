Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2815BFA0D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiIUJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiIUJEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:04:12 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAFA844F7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:04:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so12133575ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=K3i2fg7vMM7UlC2wuIrKX4hyxkogLfXc573OhDqcaes=;
        b=OxFhTIMR/HQv2erN8faakUuzBpfKE4FIqMx2gUyA8n8Z9irNnHmiX1UhsdymQe6/dp
         x3sT1HxUQEd4grlAJNCwy4oCg8OiNj8tYsQ4n19IZmQ+Etf4/p9p3Byk/CfmmF6aH5T6
         27weKQW33OWcNOFbJ9Pz820Dj08b2K6oNc1dwo+PyvHQOqBzfhmLtqtRebluMz8mblwo
         Vz7ZHQENgBtQk4jLV9UFoH5GnEyNqWrNDrkviKmVL1geVxCdTaEvxt47pMy88q0D+ePt
         oaJyiKHhdNF/Bm7fOezFxReal0YN9zPSb7/2uPBDvblxLMx6tbP7anzwxSRYfiF/WnG2
         tYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=K3i2fg7vMM7UlC2wuIrKX4hyxkogLfXc573OhDqcaes=;
        b=lrn4cMdhudfB91SWwFdQYG7XdUcM9aRcPqOmylIKH2uLqfpbQgzlPrPC2gcrsGRX/a
         bRyyMz/jzUIV9VLe471y8FoDWqS4uCe7pUmax4T/oly4ptjTor3hfUVlWIOO9pzcjI9z
         oNLg4p27LH5vslrSbvSyvAiQGQGLGqLRqD6spwfe8DBvH+5kDNv4JkamNnSNc6m39P5z
         lXQXwogJSnFN3v8M46SEg+/PWZ3cWLVTVS4N3gMy0JS3+ff0ag/DllOC6H9Iv6gQ6g/j
         QrnJlltmA7SsaT8CPdMvyJTdSMn+xOevD+CRRNnG8/r+aXYiB+oA9bawca8tvroYwwoN
         kA7A==
X-Gm-Message-State: ACrzQf0AL/0sRXm1ERrl+Dbs2HJzoZdMo8WLIWo69SWK8tRYg9qwBTmW
        /q9aLNOXTP1EY5i5Lbw5IZ1XZA==
X-Google-Smtp-Source: AMsMyM4QLuRr9Tx8KRrtESiDpZLnQmD9UPc6aiFauykm6hRCCSam+02DJxU2vae0EUdO3q/6vhqhIA==
X-Received: by 2002:a17:906:cc4a:b0:779:ed37:b5a3 with SMTP id mm10-20020a170906cc4a00b00779ed37b5a3mr19848052ejb.626.1663751048731;
        Wed, 21 Sep 2022 02:04:08 -0700 (PDT)
Received: from [192.168.1.70] (32.31.102.84.rev.sfr.net. [84.102.31.32])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906945a00b0077016f4c6d4sm1017632ejx.55.2022.09.21.02.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:04:08 -0700 (PDT)
Message-ID: <05c0501f-9843-88df-0a55-1ce4969df2f1@baylibre.com>
Date:   Wed, 21 Sep 2022 11:04:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v5 0/5] Add support for Counter array components
To:     William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        gwendal@chromium.org, bleung@chromium.org, groeck@chromium.org,
        jic23@kernel.org, david@lechnology.com, robertcnelson@gmail.com
References: <cover.1663693757.git.william.gray@linaro.org>
Content-Language: en-US
From:   Julien Panis <jpanis@baylibre.com>
In-Reply-To: <cover.1663693757.git.william.gray@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi William,

On 20/09/2022 19:21, William Breathitt Gray wrote:
> Changes in v5:
>   - Introduce the Count capture component
>   - Add DEFINE_COUNTER_ARRAY_CAPTURE macro and COUNTER_COMP_ARRAY_CAPTURE
>     for Counter arrays of capture elements
>   - Fix Counter array handling in counter-chrdev.c; previously
>     misinterpreted component id for COUNTER_COMPONENT_EXTENSION type when
>     Counter array components were present

This v5 works with TI ECAP capture driver !

Tested-by: Julien Panis <jpanis@baylibre.com>

Julien

>
> The COUNTER_COMP_ARRAY Counter component type is introduced to enable
> support for Counter array components. With Counter array components,
> exposure for buffers on counter devices can be defined via new Counter
> array component macros. This should simplify code for driver authors who
> would otherwise need to define individual Counter components for each
> array element.
>
> Eight Counter array component macros are introduced::
>
>          DEFINE_COUNTER_ARRAY_U64(_name, _length)
>          DEFINE_COUNTER_ARRAY_CAPTURE(_name, _length)
>          DEFINE_COUNTER_ARRAY_POLARITY(_name, _enums, _length)
>          COUNTER_COMP_DEVICE_ARRAY_U64(_name, _read, _write, _array)
>          COUNTER_COMP_COUNT_ARRAY_U64(_name, _read, _write, _array)
>          COUNTER_COMP_SIGNAL_ARRAY_U64(_name, _read, _write, _array)
>          COUNTER_COMP_ARRAY_CAPTURE(_read, _write, _array)
>          COUNTER_COMP_ARRAY_POLARITY(_read, _write, _array)
>
> Eight Counter array callbacks are introduced as well::
>
>          int (*signal_array_u32_read)(struct counter_device *counter,
>                                       struct counter_signal *signal,
>                                       size_t idx, u32 *val);
>          int (*signal_array_u32_write)(struct counter_device *counter,
>                                        struct counter_signal *signal,
>                                        size_t idx, u32 val);
>          int (*device_array_u64_read)(struct counter_device *counter,
>                                       size_t idx, u64 *val);
>          int (*count_array_u64_read)(struct counter_device *counter,
>                                      struct counter_count *count,
>                                      size_t idx, u64 *val);
>          int (*signal_array_u64_read)(struct counter_device *counter,
>                                       struct counter_signal *signal,
>                                       size_t idx, u64 *val);
>          int (*device_array_u64_write)(struct counter_device *counter,
>                                        size_t idx, u64 val);
>          int (*count_array_u64_write)(struct counter_device *counter,
>                                       struct counter_count *count,
>                                       size_t idx, u64 val);
>          int (*signal_array_u64_write)(struct counter_device *counter,
>                                        struct counter_signal *signal,
>                                        size_t idx, u64 val);
>
> Driver authors can handle reads/writes for an array component by
> receiving an element index via the `idx` parameter and processing the
> respective value via the `val` parameter.
>
> For example, suppose a driver wants to expose a Count's read-only
> capture buffer of four elements using a callback
> `foobar_capture_read()`::
>
>          DEFINE_COUNTER_ARRAY_CAPTURE(foobar_capture_array, 4);
>          COUNTER_COMP_ARRAY_CAPTURE(foobar_capture_read, NULL,
>                                     foobar_capture_array)
>
> Respective sysfs attributes for each array element would appear for the
> respective Count:
>
> * /sys/bus/counter/devices/counterX/countY/capture0
> * /sys/bus/counter/devices/counterX/countY/capture1
> * /sys/bus/counter/devices/counterX/countY/capture2
> * /sys/bus/counter/devices/counterX/countY/capture3
>
> If a user tries to read _capture2_ for example, `idx` will be `2` when
> passed to the `foobar_capture_read()` callback, and thus the driver
> knows which array element to handle.
>
> In addition, this patchset introduces the Signal polarity component,
> which represents the active level of a respective Signal. There are two
> possible states: positive (rising edge) and negative (falling edge). The
> 104-quad-8 driver is updated to expose its index_polarity functionality
> via this new polarity component.
>
> Counter arrays for polarity elements can be defined in a similar
> manner as u64 elements::
>
>          const enum counter_signal_polarity foobar_polarity_states[] = {
>                  COUNTER_SIGNAL_POLARITY_POSITIVE,
>                  COUNTER_SIGNAL_POLARITY_NEGATIVE,
>          };
>          DEFINE_COUNTER_ARRAY_POLARITY(foobar_polarity_array,
>                                        foobar_polarity_states, 4);
>          COUNTER_COMP_ARRAY_POLARITY(foobar_polarity_read,
>                                      foobar_polarity_write,
>                                      foobar_polarity_array)
>
> The only component types supported for Counter arrays currently are
> COUNTER_COMP_U64 and COUNTER_COMP_SIGNAL_POLARITY.
>
> William Breathitt Gray (5):
>    counter: Introduce the Signal polarity component
>    counter: 104-quad-8: Add Signal polarity component
>    counter: Introduce the Count capture component
>    counter: Consolidate Counter extension sysfs attribute creation
>    counter: Introduce the COUNTER_COMP_ARRAY component type
>
>   Documentation/ABI/testing/sysfs-bus-counter |  19 ++
>   drivers/counter/104-quad-8.c                |  35 +++
>   drivers/counter/counter-chrdev.c            | 135 +++++++--
>   drivers/counter/counter-sysfs.c             | 304 ++++++++++++++++----
>   include/linux/counter.h                     | 147 ++++++++++
>   include/uapi/linux/counter.h                |   8 +
>   6 files changed, 581 insertions(+), 67 deletions(-)
>
>
> base-commit: f95ec98139dc58db72e4bd0df049a3097990a8e7

