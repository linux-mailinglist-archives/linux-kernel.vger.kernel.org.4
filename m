Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7CE720D29
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 04:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbjFCCLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 22:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCCLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 22:11:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAF0E4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 19:11:22 -0700 (PDT)
Received: from [192.168.2.99] (109-252-150-34.dynamic.spd-mgts.ru [109.252.150.34])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E24B56600010;
        Sat,  3 Jun 2023 03:11:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685758280;
        bh=AEiivb5STUIsnv46nBIbrOdDbVAIQqj2qIRUT1z+E1U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=mFShlImOeL/NAWI56P4wzSdK529nNkSIwJYFpygQ9my2QPRTHaeKwKzSG+S6dhn+L
         Ah1oTEY6MofA6LWr0LuPm0DsmQMtXuq6zkE2zuqVfzwyRovmuusUECgYC6WB6SNkDn
         KOBbE+raamIdVg3QHJalIG7Dw6bokc07rH3eAmuU19hdpmA2v/s2CjK7u9K8kyWIPD
         6VFDiUsWeHhN4eJqehfajX97dqldITPPKdW+Qk1qrfEJGJxq2WgFIFmIOio+nEw12E
         GiPX3ijhF7QUpFbYnA/WxFV9ZFbtyJ0QPJstpm0P8X4PBC5j9K3pLrRiWlAX+V8ekA
         k1+nLQAN+RIEw==
Message-ID: <0a45ae24-61e2-f691-6f72-42257084919f@collabora.com>
Date:   Sat, 3 Jun 2023 05:11:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v6 0/3] Add sync object UAPI support to VirtIO-GPU driver
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>,
        Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
        Emil Velikov <emil.velikov@collabora.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org
References: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <20230416115237.798604-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Dmitry Osipenko (3):
>   drm/virtio: Refactor and optimize job submission code path
>   drm/virtio: Wait for each dma-fence of in-fence array individually

Applied these two patches to misc-next. The syncobj patch will wait for
the turnip Mesa MR.

-- 
Best regards,
Dmitry

