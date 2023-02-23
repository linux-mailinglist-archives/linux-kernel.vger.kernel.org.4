Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7FD6A0B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjBWNty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjBWNtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:49:46 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D7927491
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:49:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id t22so12724890oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EWQTfJ5YqMEb0/gtO5TDI9wfdh4CmPiWsPEKemNGlJk=;
        b=eURITKW8QYP9z92PoD7ZmDI2nN6q/tVUjqh4DU5g7kqwgmH0DJ+idqfmNyhvv7lQbp
         3eb+abJHt14JfyhHmXB/0dVfm/Oeh2xwUhZLk07+xIGuT1JaRLV1oQL/hHr6MVCyfH2K
         lByNBEJIJvIwi7fkOz7kDE0UXCEE732PJ4tL3dIETG+Wy/hOv5dX1tvsCL3resXFYrZw
         Nc3i4/NnPFah7Md9ZtOEMjfFs7d/GX4Czek8Yljmkt4OMuiSQmjeKxCHhRBOiYqt18mG
         n4cwyY89NB9RQZ5M/tBamhcXxVA4YE0p+rwps38LTEZN8c7+Kf2IHyXAiu3bv5eLWLxN
         5GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EWQTfJ5YqMEb0/gtO5TDI9wfdh4CmPiWsPEKemNGlJk=;
        b=7XGWPvX92wk1QSacvBAYS6vcxuEib4K+vqZAMwtbCjYOEt2WoVnSSta8ln5TQ5Sn13
         ae1pg3Z0d19DZTwPrc7QpV9opdvS8TiTFobvJmARNwtaFzXTMZG+WYPZ328xlMTfFkVI
         aEaINEcXf0inWwj0dmnUJjc/oOBrtWvNc/g9QO3/6r5YWqAWacjhruh5wUh/ZULv5uLG
         ulUXKbXKfRlUBHs+R3AbC9nxRR9b6yZVXnzfUbs2KRy8QG5IozZr4y2dlz45kd5IU/Ie
         8LUC9PyYwIGVlnq2Y9QL+4GvC070HvPl8CPI7T6FAl7SRqFRA3R4YuM/ADvHBdMOhYsb
         ycdg==
X-Gm-Message-State: AO0yUKWiwcUdKdqXyzfohyHZCyuy52dSfVCMP64sO82zuSwTLS5e8LXm
        X4cM7zs2Pa4Fia1huCdDV1vh/FiJyBT7ibgnNTn67g8P
X-Google-Smtp-Source: AK7set/2aMgF/LtaBUGb/KDdK5anSKBLMsRG6+EGNVCXpx0Q67zEslFcgOl1UjgJDQPL36+f5p7Oyzpjr86cKjsh3PE=
X-Received: by 2002:a05:6808:1690:b0:35b:d93f:cbc4 with SMTP id
 bb16-20020a056808169000b0035bd93fcbc4mr1087264oib.96.1677160178686; Thu, 23
 Feb 2023 05:49:38 -0800 (PST)
MIME-Version: 1.0
References: <20230221034445.60034-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20230221034445.60034-1-jiapeng.chong@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Feb 2023 08:49:27 -0500
Message-ID: <CADnq5_OnEHV4QzicX5zTu=QP3KjH0b1piweEhzkegSn0qXbvNw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Clean up some inconsistent indenting
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     patrik.r.jakobsson@gmail.com,
        Abaci Robot <abaci@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrong subject line?  Should be drm/gma500?

Alex

On Mon, Feb 20, 2023 at 10:45 PM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> No functional modification involved.
>
> drivers/gpu/drm/gma500/cdv_device.c:218 cdv_errata() warn: inconsistent indenting.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4126
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/gpu/drm/gma500/cdv_device.c | 27 ++++++++++++++++-----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_device.c b/drivers/gpu/drm/gma500/cdv_device.c
> index 3e83299113e3..765f359365b9 100644
> --- a/drivers/gpu/drm/gma500/cdv_device.c
> +++ b/drivers/gpu/drm/gma500/cdv_device.c
> @@ -78,7 +78,8 @@ static u32 cdv_get_max_backlight(struct drm_device *dev)
>         if (max == 0) {
>                 DRM_DEBUG_KMS("LVDS Panel PWM value is 0!\n");
>                 /* i915 does this, I believe which means that we should not
> -                * smash PWM control as firmware will take control of it. */
> +                * smash PWM control as firmware will take control of it.
> +                */
>                 return 1;
>         }
>
> @@ -149,6 +150,7 @@ static inline u32 CDV_MSG_READ32(int domain, uint port, uint offset)
>         int mcr = (0x10<<24) | (port << 16) | (offset << 8);
>         uint32_t ret_val = 0;
>         struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
> +
>         pci_write_config_dword(pci_root, 0xD0, mcr);
>         pci_read_config_dword(pci_root, 0xD4, &ret_val);
>         pci_dev_put(pci_root);
> @@ -160,6 +162,7 @@ static inline void CDV_MSG_WRITE32(int domain, uint port, uint offset,
>  {
>         int mcr = (0x11<<24) | (port << 16) | (offset << 8) | 0xF0;
>         struct pci_dev *pci_root = pci_get_domain_bus_and_slot(domain, 0, 0);
> +
>         pci_write_config_dword(pci_root, 0xD4, value);
>         pci_write_config_dword(pci_root, 0xD0, mcr);
>         pci_dev_put(pci_root);
> @@ -180,10 +183,8 @@ static void cdv_init_pm(struct drm_device *dev)
>         int domain = pci_domain_nr(pdev->bus);
>         int i;
>
> -       dev_priv->apm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
> -                                                       PSB_APMBA) & 0xFFFF;
> -       dev_priv->ospm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT,
> -                                                       PSB_OSPMBA) & 0xFFFF;
> +       dev_priv->apm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT, PSB_APMBA) & 0xFFFF;
> +       dev_priv->ospm_base = CDV_MSG_READ32(domain, PSB_PUNIT_PORT, PSB_OSPMBA) & 0xFFFF;
>
>         /* Power status */
>         pwr_cnt = inl(dev_priv->apm_base + PSB_APM_CMD);
> @@ -196,6 +197,7 @@ static void cdv_init_pm(struct drm_device *dev)
>         /* Wait for the GPU power */
>         for (i = 0; i < 5; i++) {
>                 u32 pwr_sts = inl(dev_priv->apm_base + PSB_APM_STS);
> +
>                 if ((pwr_sts & PSB_PWRGT_GFX_MASK) == 0)
>                         return;
>                 udelay(10);
> @@ -215,7 +217,7 @@ static void cdv_errata(struct drm_device *dev)
>          *      Bonus Launch to work around the issue, by degrading
>          *      performance.
>          */
> -        CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
> +       CDV_MSG_WRITE32(pci_domain_nr(pdev->bus), 3, 0x30, 0x08027108);
>  }
>
>  /**
> @@ -401,20 +403,21 @@ static int cdv_power_up(struct drm_device *dev)
>
>  static void cdv_hotplug_work_func(struct work_struct *work)
>  {
> -        struct drm_psb_private *dev_priv = container_of(work, struct drm_psb_private,
> +       struct drm_psb_private *dev_priv = container_of(work, struct drm_psb_private,
>                                                         hotplug_work);
>         struct drm_device *dev = &dev_priv->dev;
>
> -        /* Just fire off a uevent and let userspace tell us what to do */
> -        drm_helper_hpd_irq_event(dev);
> +       /* Just fire off a uevent and let userspace tell us what to do */
> +       drm_helper_hpd_irq_event(dev);
>  }
>
>  /* The core driver has received a hotplug IRQ. We are in IRQ context
> -   so extract the needed information and kick off queued processing */
> -
> + * so extract the needed information and kick off queued processing
> + */
>  static int cdv_hotplug_event(struct drm_device *dev)
>  {
>         struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
> +
>         schedule_work(&dev_priv->hotplug_work);
>         REG_WRITE(PORT_HOTPLUG_STAT, REG_READ(PORT_HOTPLUG_STAT));
>         return 1;
> @@ -424,6 +427,7 @@ static void cdv_hotplug_enable(struct drm_device *dev, bool on)
>  {
>         if (on) {
>                 u32 hotplug = REG_READ(PORT_HOTPLUG_EN);
> +
>                 hotplug |= HDMIB_HOTPLUG_INT_EN | HDMIC_HOTPLUG_INT_EN |
>                            HDMID_HOTPLUG_INT_EN | CRT_HOTPLUG_INT_EN;
>                 REG_WRITE(PORT_HOTPLUG_EN, hotplug);
> @@ -549,6 +553,7 @@ static const struct psb_offset cdv_regmap[2] = {
>  static int cdv_chip_setup(struct drm_device *dev)
>  {
>         struct drm_psb_private *dev_priv = to_drm_psb_private(dev);
> +
>         INIT_WORK(&dev_priv->hotplug_work, cdv_hotplug_work_func);
>
>         dev_priv->use_msi = true;
> --
> 2.20.1.7.g153144c
>
