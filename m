Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82FA65B3A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbjABO7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABO7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:59:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C229B65BD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:59:18 -0800 (PST)
Received: from [192.168.2.142] (109-252-113-89.nat.spd-mgts.ru [109.252.113.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B000B660036F;
        Mon,  2 Jan 2023 14:59:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672671557;
        bh=P6twPSAUn14MSaKncu4Q5IlCvYzqCSUxPdVT3emjtIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eiXb/uNl6OdbnvNa1TpajuzdJTUnkviFtgSQlA83EuxsK0IBdsUCmfw6IuWDgqUG2
         Oi7wbyVkaTjS0/dea17uYhzclwCCmSikoLYL6S8V7dt0Bubdr5i90byVz9vLAhpy81
         Pw62KiRi1wJ9V8r0buOko4jUYqMht+rORRSmf7fGgInJwMw5ymBUaQK0Hy/leBDTvA
         4FqRur1eWIW0yQ5GFwLPkktC0M8AB8UIQvgLCP+u5OtUajINEDZ6Ht8l+BQNdvfiBD
         IRm0jLGXv31e9nTg4NVMSZ0733UfC8YLxl7KffBhO5Rkq2UfOPYy4TsYFovQPWzQGb
         2fwc7RossPKXQ==
Message-ID: <f7bd13b1-67f1-da42-6bac-aa26ab309b5e@collabora.com>
Date:   Mon, 2 Jan 2023 17:59:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] drm/virtio: Spiff out cmd queue/response traces
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221130000841.318037-1-robdclark@gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221130000841.318037-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 03:08, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a sequence # for more easily matching up cmd/resp, and the # of free
> slots in the virtqueue to more easily see starvation issues.
> 
> v2: Fix handling of string fields as well
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
>  drivers/gpu/drm/virtio/virtgpu_trace.h | 26 +++++++++++++++-----------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
>  3 files changed, 28 insertions(+), 14 deletions(-)

Applied to drm-misc-next

-- 
Best regards,
Dmitry

