Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C943C6D2303
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjCaOwB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjCaOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:51:46 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DEE1F7AA
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:51:27 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id ew6so90578236edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KxCr3nedc7gseqp/MKtKxJ5ucMhxAWFs7Ct9g/ZwuMc=;
        b=gEeCqjUPc0YIN0a/XPRLeR//MB72hMHdJj5Z2RqWoONEFShc+EDe0hjfN3WYWWqCYj
         uYZyOsownuIHZ28G2tWqtz1108TNeczgdz6YIulm0WicQJ2gacahvDvn3zifWHzu8SkS
         hvCwDkv1csCe5yWWNXyVJu7Xa5Pi327tHua/ZRu8EIZkmpeNSq2kAWiuaOfwZM9sEQsU
         n2pkAbyOiHtZyazXCQSa22CeyfM8aBrk/g66cjAmejYIyC8BO4HTy/RhTzyACOyFFQPR
         RoybkrJq6Imt9OzVlO7CX3kWNNZh2CRXxaBr5P7gD37IrfiIGvEZUlT7rhj//VftTlMa
         LYww==
X-Gm-Message-State: AAQBX9cxvzFnp/j+YAAwIkEPfnm9NIxxZUQUcPbkgTRvULvb7zpAeYdm
        LQO84uI463VLDgYHkkSwuOAflptqPfNMDqWMfbNSLnF+9DU=
X-Google-Smtp-Source: AKy350aIkTYggXQ6CQIwQa3MlzWB+cEP42QJ6JV/jBsxesEcYMgCrEuBI2UxQle97Cl+WSh9CIfIf3viJyQ21sZyWqQ=
X-Received: by 2002:a50:d543:0:b0:4fb:f19:87f with SMTP id f3-20020a50d543000000b004fb0f19087fmr13969310edj.3.1680274271068;
 Fri, 31 Mar 2023 07:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-7-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-7-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 16:50:59 +0200
Message-ID: <CAJZ5v0g7bbZc36pZD2TzQVfjsGt99UdpYSfL=TmYmjD3f6gg7g@mail.gmail.com>
Subject: Re: [PATCH 7/7] driver core: make sysfs_dev_char_kobj static
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 11:33 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Nothing outside of drivers/base/core.c uses sysfs_dev_char_kobj, so
> make it static and document what it is used for so we remember it the
> next time we touch it 15 years from now.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/base.h | 3 ---
>  drivers/base/core.c | 4 +++-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 4660e1159ee0..e96f3343fd7c 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -191,9 +191,6 @@ const char *device_get_devnode(const struct device *dev, umode_t *mode,
>  extern struct kset *devices_kset;
>  void devices_kset_move_last(struct device *dev);
>
> -/* /sys/dev/char directory */
> -extern struct kobject *sysfs_dev_char_kobj;
> -
>  #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
>  void module_add_driver(struct module *mod, struct device_driver *drv);
>  void module_remove_driver(struct device_driver *drv);
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index cf6f41c2060c..47e16c088e77 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2255,7 +2255,9 @@ static void fw_devlink_link_device(struct device *dev)
>  int (*platform_notify)(struct device *dev) = NULL;
>  int (*platform_notify_remove)(struct device *dev) = NULL;
>  static struct kobject *dev_kobj;
> -struct kobject *sysfs_dev_char_kobj;
> +
> +/* /sys/dev/char */
> +static struct kobject *sysfs_dev_char_kobj;
>
>  /* /sys/dev/block */
>  static struct kobject *sysfs_dev_block_kobj;
> --
> 2.40.0
>
