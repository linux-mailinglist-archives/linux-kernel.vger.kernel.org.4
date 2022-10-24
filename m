Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E139760B1AA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiJXQbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbiJXQau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:30:50 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECBA796A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:17:04 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id x13so5196736qvn.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J1gk2ep4Ye/CjOaUbmreqC0qY89txiP3E/LghUXF5LA=;
        b=akGSaltVfsVhRbxG28WOW2X8gO+wU+EznxNMhIIAuSXlPw266pmcqTSPvphoFig+GK
         6AkDGxqzK1FJuKj+gGU8trve6h7F9gHybwYtN75fdc3LfBH7MtfTgz8qxq8CwCYlUKal
         qB0wtDVINyoNPBAV7ld9nZCkIhvnRXn7C3L1qTuA5XRKM2DxzDG/oeeQnzEj+6QNCTQd
         vNLfsqXPGOM4aOHEVG5gnpMP0+cf59pB02DgvrSrhyyfGzlSYzh7CVf3kW35Vm5Ogkv1
         SK6c+++qFxQAwPO234SxMhd1pNZ7S9ZL1CmXsT/zlHHQCq6UIhy7FTARmx1QlC57pCeM
         0thg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J1gk2ep4Ye/CjOaUbmreqC0qY89txiP3E/LghUXF5LA=;
        b=CZV3YMGxlCz+M4Cfv0dj0QyYRJfIQ/6Hj01TfhQ3o2rElS6kOlDKOgyD0x4gyuUUFF
         rXIVPcu28UdDPFn9NMSxZQuoR0M/sUBI9nfhrwdeJeRch7DBk9QiSs4+V77T9VrvmrPC
         kGt+JvV9zAfc1v4/dE0Dw7Z1U6/tLUIbDXz5q3eG+7H5aTENMHbPncqB+1YIjBVzzkR3
         iI3Um0WrYdy4ViRuM1iNZ+nHs+RNOtqM0Loh7P73l6jvlxuTIByLV15lUSFOFhR9nczR
         Xrwq7NZSyKidYRxfRLLZar8tEjNhKaf1oegCbdXKUcWqTKu0IlKfYC5iUor1ytwTHyNg
         oUfw==
X-Gm-Message-State: ACrzQf3V3JtBFOta0v0h4QD3Y0erydFPbaSr0mdZFfKDUbXmKvGR5wRT
        Z44mfAgqfzFmbYb0Fu9E2dFNrfuMYPCXlxv+4QoAmvDD
X-Google-Smtp-Source: AMsMyM4fNurfiqwrnpgoMx2P1f9YHXMbFRfipOkR+eGaYvPpVD3TyOfVsYBQuM/D/H05sOmqp3j6d2uvYxO3EKWY1CI=
X-Received: by 2002:a67:b046:0:b0:3a7:965c:65f1 with SMTP id
 q6-20020a67b046000000b003a7965c65f1mr15621937vsh.40.1666624420991; Mon, 24
 Oct 2022 08:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20221022060155.52548-1-wangjianli@cdjrlc.com>
In-Reply-To: <20221022060155.52548-1-wangjianli@cdjrlc.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 24 Oct 2022 11:13:29 -0400
Message-ID: <CADnq5_OjwUOMa6RAfqT6B50wHQARtdL7uARcDzc+iMCthSsLgA@mail.gmail.com>
Subject: Re: [PATCH] amd/amdgpu: fix repeated words in comments
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

On Sat, Oct 22, 2022 at 2:02 AM wangjianli <wangjianli@cdjrlc.com> wrote:
>
> Delete the redundant word 'the'.
>
> Signed-off-by: wangjianli <wangjianli@cdjrlc.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index e9155dc1c30c..3de990bbbf2f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -1565,7 +1565,7 @@ static int amdgpu_device_check_arguments(struct amdgpu_device *adev)
>   * @pdev: pci dev pointer
>   * @state: vga_switcheroo state
>   *
> - * Callback for the switcheroo driver.  Suspends or resumes the
> + * Callback for the switcheroo driver.  Suspends or resumes
>   * the asics before or after it is powered up using ACPI methods.
>   */
>  static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
> --
> 2.36.1
>
