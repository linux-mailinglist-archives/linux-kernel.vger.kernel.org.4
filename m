Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462C60B4A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 19:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJXR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 13:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiJXR6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 13:58:18 -0400
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4193AE7C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:38:28 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id t85so4164942vkb.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MEsL7GbLrX3WUEBmKekLTRaPE8tL9JC4qHnSEJvzbHY=;
        b=kbNzdGO1P0H9Vp7815DR3Ru36Md2jLdOFQaNkVS5lx5q5mRltCIan9YxjpJbudtBst
         50/9ewHrzS7KmPmJqEnCRKJS1W6Lj4KQOe9wdQgRm9bjtAPty/peHeoMh5LtJik67LYa
         RsLobPc3yV60dp2X61Lr0+/NBHQigQmjueBNsMvkHGuXH9dsfUPtmwFqNHTCum53qm9h
         3VO+r+JNPpxta8OOQXbuI7ZfjzPPPLrJcOTyGuvIKByMjKfe2ltzx/e6IDtYpMKlU+tT
         pE+Ec6d9kAiq9rBqPVGy4Rk5KIuSjfRng8aHkCv6aQZPl9US9a0xcST7BUQQ9hFOHNfJ
         zKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEsL7GbLrX3WUEBmKekLTRaPE8tL9JC4qHnSEJvzbHY=;
        b=IClvqvz7CCitUqOTTVviKQzszcxIhAbngc4qiyWcsqUe/Ux8QdWqJ7BvDTyLjWLJa8
         bZedzDnJHygvH6DGRiKSRvxu6/CtdB/hkIz1NuJfflheiLG10BmguhKKU8+Z4Oov1aXu
         uqm0L9YBW/j5bjdqwKaJcun/DiSv7tm5bSAByXYi1vQUwliCTh7mAjhTKMTFqt5+/iqC
         Rs/E8CtPZ2HkWdNpqleJEUKUBxk6YOO3WlFF1gU2Q9cZdeHRVRaAnsRbMf+nFH+cqD6P
         hMfiB1WowYou3VhmsC5l241jyuIYLJqPE4YhFYJpxQDUq8gVWRY6zBCtmqwtaIqgFDvM
         1A8g==
X-Gm-Message-State: ACrzQf2cpIRTgyadoQUTvyQodhXkP+wZ/UZHZnHbug99IFjZKB+hz0lq
        V74dpwCT3JydkY8GYxSVfZaue/F8nnOpfTgooszXjb3z
X-Google-Smtp-Source: AMsMyM5o70JuycrOFnPPgJBHTwneEZBvQyg1y9bHbhYLTowaDWTNmWA2QueVCe0nZeUEVWrSmau+fRc0ZNRjBHkpmz4=
X-Received: by 2002:a05:6102:224d:b0:3a7:68fc:9163 with SMTP id
 e13-20020a056102224d00b003a768fc9163mr17666133vsb.74.1666624508640; Mon, 24
 Oct 2022 08:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221022060417.55166-1-wangjianli@cdjrlc.com>
In-Reply-To: <20221022060417.55166-1-wangjianli@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Oct 2022 11:14:56 -0400
Message-ID: <CADnq5_PYbzXMptt8KebWuO5d8VErTkAB070Cp1AG88jHC8Xf+A@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix repeated words in comments
To:     wangjianli <wangjianli@cdjrlc.com>
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sat, Oct 22, 2022 at 2:06 AM wangjianli <wangjianli@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 15692cb241fc..ff52b5f4c1e6 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -1206,7 +1206,7 @@ static void radeon_check_arguments(struct radeon_device *rdev)
>   * @pdev: pci dev pointer
>   * @state: vga_switcheroo state
>   *
> - * Callback for the switcheroo driver.  Suspends or resumes the
> + * Callback for the switcheroo driver.  Suspends or resumes
>   * the asics before or after it is powered up using ACPI methods.
>   */
>  static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
> --
> 2.36.1
>
