Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1112963C745
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbiK2Sic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiK2Sia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:38:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C0412751
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 10:38:29 -0800 (PST)
Received: from [192.168.2.15] (109-252-124-61.nat.spd-mgts.ru [109.252.124.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE5DE6602B2C;
        Tue, 29 Nov 2022 18:38:25 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669747107;
        bh=SMfclwv6QeX+nPT29Ty4W4fFsR6WCOe7dD5ldDTWBkI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dym7/QJw+bIu/OjIw8TjrDfCVAlijuJzbieOtAMrEXpEh459oT0YAoasyW130JQ5N
         wozf8QMdG1Mlw9apFEYKYyi0biskEfdgopRMUCHLSlEbuTKxlvkiK3FYLOBLXZfVlg
         LqAB+m2J9+SKpzfBa3xDSYVAnlTZLQjbcJO5qVNg7s2+8+GGNZgVR7djU/yTXo09m+
         LrSXKXf0FaVDqEd0o/krQFOlasvHuJaxTvMVCj94OpLmMtuXdbncTltxmzDvzPqc9H
         pCcxhRN6J/7pmOxNwjLquH6EZImqo0wmlB/7zP0jvFoKrStXK5aaNeNjmUAks+DCMz
         xDrHAj5e0F3pQ==
Message-ID: <887fa036-c370-c241-94c8-3cb7433e09f8@collabora.com>
Date:   Tue, 29 Nov 2022 21:38:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] drm/virtio: Spiff out cmd queue/response traces
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221129174330.262751-1-robdclark@gmail.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221129174330.262751-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 20:43, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add a sequence # for more easily matching up cmd/resp, and the # of free
> slots in the virtqueue to more easily see starvation issues.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h   |  3 +++
>  drivers/gpu/drm/virtio/virtgpu_trace.h | 20 ++++++++++++--------
>  drivers/gpu/drm/virtio/virtgpu_vq.c    | 13 ++++++++++---
>  3 files changed, 25 insertions(+), 11 deletions(-)

Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

-- 
Best regards,
Dmitry

