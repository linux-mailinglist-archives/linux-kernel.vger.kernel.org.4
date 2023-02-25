Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030A66A2BF6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjBYVvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 16:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 16:51:53 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89217CDC
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 13:51:52 -0800 (PST)
Received: from [192.168.2.94] (unknown [109.252.117.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E4F886602FA1;
        Sat, 25 Feb 2023 21:51:48 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677361909;
        bh=NcrrHsYtYSHOqzQyTcRyADSjQ71K3Dy7UShnCp0HyYc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f749W/mhEIbIMi2u0yybeoqTAxuRaia+z4oYfTVYHG1TaL7MEuJ2DBqrIUkwft4Ds
         MEP4IIaRZYsc93GMwvggRVtFRJQw09lEJc/0jiWmrBHojdUtL5v1dh/jEKlG/1xgOU
         N7k7IBHeiibzralvB8wmf+2gqq9/tq30szbPBFKzD44AbsqJb9gCrHAwK4yT38MrSS
         g2FHMrLaYZUwJuaTYbNyqheVisB7FXHLvjIPj7+fdqztlRpltVgIc5V+ec8cH8vZn0
         iVR8z5Et0dlufdEZyk32y0nSrFB99MzHTqNcHkEEv/UlGtiEkXdxsmSPLJI1PPM9hA
         QvR9Y24g8bc7g==
Message-ID: <eddfa36c-4553-d392-0047-313002c613d4@collabora.com>
Date:   Sun, 26 Feb 2023 00:51:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] drm/shmem-helper: Fix locking for
 drm_gem_shmem_get_pages_sgt()
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20230205125124.2260-1-lina@asahilina.net>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230205125124.2260-1-lina@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/23 15:51, Asahi Lina wrote:
> -EXPORT_SYMBOL_GPL(drm_gem_shmem_get_pages_sgt);
> +EXPORT_SYMBOL(drm_gem_shmem_get_pages_sgt);

Note it was a GPL symbol. I expect that all drm-shmem exports should be GPL.

-- 
Best regards,
Dmitry

