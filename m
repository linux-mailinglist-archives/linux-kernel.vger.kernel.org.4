Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7B74028B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjF0Rrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjF0Rrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:47:48 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02F5297D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:47:45 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98e1b1d1698so429356866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687888064; x=1690480064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZDCbtO++1Sx9t7C/B2TxgxH7taGxg4fU7YSpb4v+4s=;
        b=l19IV8djnVEYl157H2WJJf5XotIHTI04GrdF9If2UXrG/PLw0TxamMYG6X9opBgZYo
         jx5KOEue0E3s9PWOIvZsWlFvkzwAeMOV60EslKp8At+ENLc2j3tVlEO2jTJGn5QjQ8ZE
         UheK0a47VxaG8YjVyO8idkn6RhHh+Q2Ou/KEls7i+k6fHPin1r1nTm6XmOtB5phWv0P4
         XXMYzcWk45saDkOte7aZmXmDMbe/dPLuxpsgb2lDzoEucSlhx/rY4rptcLm+lFMH7jDg
         p09jN3B7430fnWqwD7N0nnr6Ks71ucHqY6XCPrnYc8tQyZJJzyTVJfJ2vB2UuKbUlYOA
         KGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687888064; x=1690480064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZDCbtO++1Sx9t7C/B2TxgxH7taGxg4fU7YSpb4v+4s=;
        b=km3F2p56i1e0pqaaiL+Q1gktnX12BCM1D59hy77iJD8QqidMSR0hSxYPgTIueePIax
         yPTAuxIox1dvRvuvsjxVgJrNKqixjz9R0vpZPC0EO+p+0WPYmEAuXALjeGDfwHWzCx7r
         tFyTBAQ9N3Sjf6ncvZwoM9cwSCs64kR+mLsNsmkaa9F7qKIzRLYhAXUpKaoyYAvrjV+u
         P81YwipgokEX09ZAPDaTVX8g20tLrptfB5O7pZIrld6RHyVZHKdWZLlNwvfGzJIDy7lj
         GGmRHBFizijJOoyf9px5qz+JFJhYa33zeeX0SebEXXIrQrn5zLVwcVAtfJFu7GfV4mD1
         VJMw==
X-Gm-Message-State: AC+VfDzBR3IJs5Yv4Uorc2VG2tOIwGGCyWQNCfng6eF9fZJxT5V7x1ev
        tYnQvzK8yzA4AEDaubpOqH8=
X-Google-Smtp-Source: ACHHUZ6XmiIudo0KOTOyVlYkzieAae5ZM7joTZHdN/6cj6UZpef0gKukCJFXmhBktvjcggsclz10sQ==
X-Received: by 2002:a17:907:97c6:b0:98e:35d1:993e with SMTP id js6-20020a17090797c600b0098e35d1993emr7915706ejc.5.1687888063978;
        Tue, 27 Jun 2023 10:47:43 -0700 (PDT)
Received: from ?IPV6:2a00:e180:1599:a100:929f:5de4:783e:4193? ([2a00:e180:1599:a100:929f:5de4:783e:4193])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906561500b0095807ab4b57sm4844371ejq.178.2023.06.27.10.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 10:47:43 -0700 (PDT)
Message-ID: <1dbeb507-3f18-1b5d-37be-fcfd60a1c0d4@gmail.com>
Date:   Tue, 27 Jun 2023 19:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 1/1] drm/doc: Document DRM device reset expectations
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     pierre-eric.pelloux-prayer@amd.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        Simon Ser <contact@emersion.fr>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Rob Clark <robdclark@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        kernel-dev@igalia.com, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        alexander.deucher@amd.com,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Dave Airlie <airlied@gmail.com>, christian.koenig@amd.com
References: <20230627132323.115440-1-andrealmeid@igalia.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230627132323.115440-1-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.06.23 um 15:23 schrieb André Almeida:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>
> v4: https://lore.kernel.org/lkml/20230626183347.55118-1-andrealmeid@igalia.com/
>
> Changes:
>   - Grammar fixes (Randy)
>
>   Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>   1 file changed, 68 insertions(+)
>
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..3cbffa25ed93 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a third handler for
>   mmapped regular files. Threads cause additional pain with signal
>   handling as well.
>   
> +Device reset
> +============
> +
> +The GPU stack is really complex and is prone to errors, from hardware bugs,
> +faulty applications and everything in between the many layers. Some errors
> +require resetting the device in order to make the device usable again. This
> +sections describes the expectations for DRM and usermode drivers when a
> +device resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to perform
> +it as needed. Usually a hang is detected when a job gets stuck executing. KMD
> +should keep track of resets, because userspace can query any time about the
> +reset stats for an specific context.

Maybe drop the part "for a specific context". Essentially the reset 
query could use global counters instead and we won't need the context 
any more here.

Apart from that this sounds good to me, feel free to add my rb.

Regards,
Christian.

>   This is needed to propagate to the rest of
> +the stack that a reset has happened. Currently, this is implemented by each
> +driver separately, with no common DRM interface.
> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the device has
> +been reset, and this can be checked more often if the UMD requires it. After
> +detecting a reset, UMD will then proceed to report it to the application using
> +the appropriate API error code, as explained in the section below about
> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to applications to deal with device resets. However,
> +there is no guarantee that the app will use such features correctly, and the
> +UMD can implement policies to close the app if it is a repeating offender,
> +likely in a broken loop. This is done to ensure that it does not keep blocking
> +the user interface from being correctly displayed. This should be done even if
> +the app is correct but happens to trigger some bug in the hardware/driver.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
> +interface tells if a reset has happened, and if so, all the context state is
> +considered lost and the app proceeds by creating new ones. If it is possible to
> +determine that robustness is not in use, the UMD will terminate the app when a
> +reset is detected, giving that the contexts are lost and the app won't be able
> +to figure this out and recreate the contexts.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
> +This error code means, among other things, that a device reset has happened and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting causes of resets
> +--------------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, it's
> +really useful for driver developers to learn more about what caused the reset in
> +first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.
> +
>   .. _drm_driver_ioctl:
>   
>   IOCTL Support on Device Nodes

