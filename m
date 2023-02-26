Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2074A6A35B5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 00:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBZXvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 18:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjBZXvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 18:51:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B73C869C
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 15:51:38 -0800 (PST)
Received: from [192.168.2.206] (109-252-117-89.nat.spd-mgts.ru [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EBC06602DCD;
        Sun, 26 Feb 2023 23:51:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677455497;
        bh=j42W91BDA/HzPgVKrySGK5CNdsmZZvukLN7V+IbXt3c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Pgopsf0TFxrJjOQ+I+Dl166lURpTZha1/EBXUIt8mnCUcOL1kvRaxCHiyzMariZDs
         AZ+/20pmGsNRzu6wWpdS3Pnm5DMf2FdVafWleLGAWUjGCj47Y1GnK0q38VavwWAsvm
         c9aGkOP4MtFzojEH4VtoQWzN7sTZI3JY9Jf3BL6/9Lg/DNO314ffYJsi1iA9iEx9Jq
         nK9oh+ctmVPqAJWeesdaMJOuUVtEiMHbEDEtixVq1Tlue0i1eNY8xG+DaTFATG/L3E
         2kzvaTb7UoAF0ZPO0XfdM1GVNvedI0QHpA2lQQotnI1mGQLc0McepyLl8Bz5PiYZg+
         j2yful4OGUDVQ==
Message-ID: <74ae7a91-1dd3-06f1-2199-5c1a18ab7d50@collabora.com>
Date:   Mon, 27 Feb 2023 02:51:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] drm/shmem-helper: Remove another errant put in error
 path
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230108211311.3950107-1-dmitry.osipenko@collabora.com>
 <CAF6AEGtU_Af=2TJiZytTx3GHryFiefJNkmKzwk569RcJKD+9BA@mail.gmail.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAF6AEGtU_Af=2TJiZytTx3GHryFiefJNkmKzwk569RcJKD+9BA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 18:35, Rob Clark wrote:
> On Sun, Jan 8, 2023 at 1:13 PM Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> drm_gem_shmem_mmap() doesn't own reference in error code path, resulting
>> in the dma-buf shmem GEM object getting prematurely freed leading to a
>> later use-after-free.
>>
>> Fixes: f49a51bfdc8e ("drm/shme-helpers: Fix dma_buf_mmap forwarding bug")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> 
> Reviewed-by: Rob Clark <robdclark@gmail.com>

Applied to misc-fixes

-- 
Best regards,
Dmitry

