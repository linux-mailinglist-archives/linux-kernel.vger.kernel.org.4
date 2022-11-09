Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE941622D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 15:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKIOMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 09:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiKIOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 09:11:59 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7317665
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 06:11:59 -0800 (PST)
Received: by mail-qk1-f182.google.com with SMTP id 8so10975079qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 06:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/cT2gZsJ2v9YrZOvT3xenA9VViLuZ5d27nLPJyUinc=;
        b=bLRTnoJE+1EohlRVCQPyd+aA/31OID0nBSEBdx7RyHLHXq5h4vgPlm/bCUoTikASKI
         qvOAIhkXFd5WkLGYK78iywsdNf75bPjtnFUepvpRIDWyUfvbxDLEO8FtBlQwI5w3yuv3
         1a6Kcilycou9DbiFzxNCiyibrDXXW5QOVG//qb7Y71B/qE+zpvsZvIAlGDfhowkVA0XK
         LdeWY3fN8MOuFZnDEhKiuIAC5OiAhoCOdfeKfVtyQAMDwQPUcu1X7nrTMvgBgJttPFUF
         Uxtl4eq9r9vf1SBVV9opjkkQCXfvGUBfNYLQ3nd5Eo4yA9f01esGhHL8rw6hn66PZxJB
         zV1g==
X-Gm-Message-State: ACrzQf3UuxGGie9tf/2KPXi/+qNoqGz7peZTAZpPvWUYt5QAkVvPhAEU
        qnaezGgCHMYQKQhHtOXLpkh9PEELsU+smNZJwzc=
X-Google-Smtp-Source: AMsMyM6kxRFSioMBt88vdU7sYhFFokwPINKbJdJaVQ5SGcrfGyp0E/XBSOQ4/YrNIktcOvkZs2k0z3J9LwmR8RsXe1I=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr42126816qkl.443.1668003118163; Wed, 09
 Nov 2022 06:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20221109140711.105222-1-gregkh@linuxfoundation.org>
In-Reply-To: <20221109140711.105222-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Nov 2022 15:11:47 +0100
Message-ID: <CAJZ5v0gv6L9Q+Nu3U0JAWqJk4MPt7kGVGiOAKuX5FcF=znyfTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] driver core: remove devm_device_remove_groups()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 3:07 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There is no in-kernel user of this function, so it is not needed anymore
> and can be removed.
>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

For both patches in the series:

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c    | 17 -----------------
>  include/linux/device.h |  2 --
>  2 files changed, 19 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index d02501933467..6137de5073b1 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2693,23 +2693,6 @@ int devm_device_add_groups(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_device_add_groups);
>
> -/**
> - * devm_device_remove_groups - remove a list of managed groups
> - *
> - * @dev:       The device for the groups to be removed from
> - * @groups:    NULL terminated list of groups to be removed
> - *
> - * If groups is not NULL, remove the specified groups from the device.
> - */
> -void devm_device_remove_groups(struct device *dev,
> -                              const struct attribute_group **groups)
> -{
> -       WARN_ON(devres_release(dev, devm_attr_groups_remove,
> -                              devm_attr_group_match,
> -                              /* cast away const */ (void *)groups));
> -}
> -EXPORT_SYMBOL_GPL(devm_device_remove_groups);
> -
>  static int device_add_attrs(struct device *dev)
>  {
>         struct class *class = dev->class;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 023ea50b1916..4efc607c008c 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1062,8 +1062,6 @@ static inline void device_remove_group(struct device *dev,
>
>  int __must_check devm_device_add_groups(struct device *dev,
>                                         const struct attribute_group **groups);
> -void devm_device_remove_groups(struct device *dev,
> -                              const struct attribute_group **groups);
>  int __must_check devm_device_add_group(struct device *dev,
>                                        const struct attribute_group *grp);
>  void devm_device_remove_group(struct device *dev,
> --
> 2.38.1
>
