Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5AA573ECF1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFZVcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjFZVcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:32:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4758E10C9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3WrV9FP4eW8Nnv/icMs114y+kK2oX4SvQP8ltNtE+5I=; b=yF8txQHE+JLtPnr/RSwcuSzZnC
        eEnAsz4U2YWpunoAyK5pJqyyG+WYpfWuzHhaZZ/HKebLX/nJ1xK05v6lfOlGYLswflyZaHsRUolmP
        wql48+oGq7ToJMBoMgTEIwX1kBxZrDghYRVTOrZHlH2WLlHDOdvmjShNJJ43wDhY+oNve91leQ+KB
        pdOw5mlN4+vZ36YmcH5OaiFNQnQWPJN7n8xN8iW+wH8tlKeqWsv6wVmiD0WlU3T9c/GswVXU6GBH2
        cFG5NrdEEUh/7EdqClshXDWBeSJTrkFbw1z0/jYAyG4oJnu9POSKDOlQAspBYmx+eQ1iqda1eCUoq
        SNd2Am7g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qDtoY-00B4pY-2A;
        Mon, 26 Jun 2023 21:32:02 +0000
Message-ID: <e7abf1dc-e37e-e819-1f73-6b33633e41ad@infradead.org>
Date:   Mon, 26 Jun 2023 14:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 1/1] drm/doc: Document DRM device reset expectations
Content-Language: en-US
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        Simon Ser <contact@emersion.fr>,
        Rob Clark <robdclark@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Stone <daniel@fooishbar.org>,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        =?UTF-8?Q?Timur_Krist=c3=b3f?= <timur.kristof@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
References: <20230626183347.55118-1-andrealmeid@igalia.com>
 <20230626183347.55118-2-andrealmeid@igalia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230626183347.55118-2-andrealmeid@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/26/23 11:33, André Almeida wrote:
> Create a section that specifies how to deal with DRM device resets for
> kernel and userspace drivers.
> 
> Signed-off-by: André Almeida <andrealmeid@igalia.com>
> ---
>  Documentation/gpu/drm-uapi.rst | 68 ++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 65fb3036a580..25a11b9b98fa 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,74 @@ for GPU1 and GPU2 from different vendors, and a third handler for
>  mmapped regular files. Threads cause additional pain with signal
>  handling as well.
>  
> +Device reset
> +============
> +
> +The GPU stack is really complex and is prone to errors, from hardware bugs,
> +faulty applications and everything in between the many layers. Some errors
> +require resetting the device in order to make the device usable again. This
> +section describes what is the expectations for DRM and usermode drivers when a

   sections describes the expectations for DRM and usermode drivers when a

> +device resets and how to propagate the reset status.
> +
> +Kernel Mode Driver
> +------------------
> +
> +The KMD is responsible for checking if the device needs a reset, and to perform
> +it as needed. Usually a hang is detected when a job gets stuck executing. KMD
> +should keep track of resets, because userspace can query any time about the
> +reset stats for an specific context. This is needed to propagate to the rest of
> +the stack that a reset has happened. Currently, this is implemented by each
> +driver separately, with no common DRM interface.
> +
> +User Mode Driver
> +----------------
> +
> +The UMD should check before submitting new commands to the KMD if the device has
> +been reset, and this can be checked more often if it requires to. After

                                       more often if the UMD requires it. After

> +detecting a reset, UMD will then proceed to report it to the application using
> +the appropriated API error code, as explained in the below section about

       appropriate                                  the section below about

> +robustness.
> +
> +Robustness
> +----------
> +
> +The only way to try to keep an application working after a reset is if it
> +complies with the robustness aspects of the graphical API that it is using.
> +
> +Graphical APIs provide ways to application to deal with device resets. However,

                               to applications

> +there is no guarantee that the app will be correctly using such features, and

                                      will use such features correctly, and a // or "and the"


> +UMD can implement policies to close the app if it is a repeating offender,
> +likely in a broken loop. This is done to ensure that it does not keeps blocking

                                                                    keep

> +the user interface from being correctly displayed. This should be done even if
> +the app is correct but happens to trigger some bug in the hardware/driver.
> +
> +OpenGL
> +~~~~~~
> +
> +Apps using OpenGL should use the available robust interfaces, like the
> +extension ``GL_ARB_robustness`` (or ``GL_EXT_robustness`` for OpenGL ES). This
> +interface tells if a reset has happened, and if so, all the context state is
> +considered lost and the app proceeds by creating new ones. If is possible to

                                                              If it is possible to

> +determine that robustness is not in use, UMD will terminate the app when a reset

                                            the UMD

> +is detected, giving that the contexts are lost and the app won't be able to
> +figure this out and recreate the contexts.
> +
> +Vulkan
> +~~~~~~
> +
> +Apps using Vulkan should check for ``VK_ERROR_DEVICE_LOST`` for submissions.
> +This error code means, among other things, that a device reset has happened and
> +it needs to recreate the contexts to keep going.
> +
> +Reporting resets causes

That's an awkward heading. How about:
Reporting causes of resets
--------------------------

> +-----------------------
> +
> +Apart from propagating the reset through the stack so apps can recover, it's
> +really useful for driver developers to learn more about what caused the reset in
> +first place. DRM devices should make use of devcoredump to store relevant
> +information about the reset, so this information can be added to user bug
> +reports.
> +
>  .. _drm_driver_ioctl:
>  
>  IOCTL Support on Device Nodes

thanks for the documentation.
-- 
~Randy
