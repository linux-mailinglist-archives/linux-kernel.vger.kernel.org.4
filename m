Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5460368DC56
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 15:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbjBGO7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 09:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjBGO6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 09:58:51 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9BC13506
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 06:58:41 -0800 (PST)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4PB5qK6thNz9sjF;
        Tue,  7 Feb 2023 15:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1675781917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8pSud8m501Wt9iBbbyoSb9xtWR95MXuPDZJjmHVUQE=;
        b=W6sWaEhcvrkKUM9l+HGFmvwxOw1aIRqkJUcPcWp0od8bkjxalWfoNTtAMhE/ZtTuP41a5R
        QCL3E0o6j6tN+fjfqEC1BCkAZkvLcAxkoh18pLrNqkU1dQoqHWxDd5/BMXdgdQ3lzQi9fs
        gwlPg2nhnuTreTvGZWbwK0iVfvoOlUseYIUCtStSgtxS5zBiJtMDJr6KmoSm0Njn3qodw/
        bQULX50s49rdtjiSazfPcu4bBD0M7fruxr3AP38tP06B3pNfU9ar/zqWVCmrmCJozxoDSU
        jh2DvZzS1Wl/qfOBou6OnwG42tLU+ZiLJrEmVFmkmhwE5oX9bcC8avk0oqKwzA==
Message-ID: <2d8d962e-9fa3-7671-de05-8401a81b1356@mailbox.org>
Date:   Tue, 7 Feb 2023 15:58:33 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH] drm: Create documentation about device resets
Content-Language: en-CA
To:     Pekka Paalanen <ppaalanen@gmail.com>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
Cc:     pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?= <maraeo@gmail.com>,
        amaranath.somalapuram@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        kernel-dev@igalia.com, alexander.deucher@amd.com,
        contactshashanksharma@gmail.com,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
References: <20230123202646.356592-1-andrealmeid@igalia.com>
 <20230123202646.356592-2-andrealmeid@igalia.com>
 <37e78013-5ed6-e80f-4a1c-1e61bed59735@amd.com>
 <20230207153048.78697e7b@eldfell>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20230207153048.78697e7b@eldfell>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 305e7d2157b32886a42
X-MBO-RS-META: c74pzhf4mpjfpobjhsbsjrezdyyk7jzk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/23 14:30, Pekka Paalanen wrote:
> On Mon, 23 Jan 2023 21:38:11 +0100
> Christian König <christian.koenig@amd.com> wrote:
>> Am 23.01.23 um 21:26 schrieb André Almeida:
>>>
>>> diff --git a/Documentation/gpu/drm-reset.rst b/Documentation/gpu/drm-reset.rst
>>> new file mode 100644
>>> index 000000000000..0dd11a469cf9
>>> --- /dev/null
>>> +++ b/Documentation/gpu/drm-reset.rst
>>> @@ -0,0 +1,51 @@
>>> +================
>>> +DRM Device Reset
>>> +================
>>> +
>>> +The GPU stack is really complex and is prone to errors, from hardware bugs,
>>> +faulty applications and everything in the many layers in between. To recover
>>> +from this kind of state, sometimes is needed to reset the GPU. Unproper handling
>>> +of GPU resets can lead to an unstable userspace. This page describes what's the
>>> +expected behaviour from DRM drivers to do in those situations, from usermode
>>> +drivers and compositors as well.
>>> +
>>> +Robustness
>>> +----------
>>> +
>>> +First of all, application robust APIs, when available, should be used. This
>>> +allows the application to correctly recover and continue to run after a reset.
>>> +Apps that doesn't use this should be promptly killed when the kernel driver
>>> +detects that it's in broken state. Specifically guidelines for some APIs:
>>> +  
>>
>>> +- OpenGL: During a reset, KMD kill processes that haven't ARB Robustness
>>> +  enabled, assuming they can't recover.  
>>
>> This is a pretty clear NAK from my side to this approach. The KMD should 
>> never mess with an userspace process directly in such a way.
>>
>> Instead use something like this "OpenGL: KMD signals the abortion of 
>> submitted commands and the UMD should then react accordingly and abort 
>> the application.".
> 
> what Christian said, plus I would not assume that robust programs will
> always respond by creating a new context. They could also switch
> to a software renderer, [...]

That is indeed what Firefox does.


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

