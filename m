Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAC6D22FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjCaOvD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 31 Mar 2023 10:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbjCaOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:50:50 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E820C0A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:48 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id eh3so90550138edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 07:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pe6FinZeS1pkwMop/ma6WqhVI+pcNnzqOaPUeYcglF8=;
        b=E583zMajTLH0uJfnCxJAvLXeOT0P0qcaID6kZsnratqUe+F+3NFhcyfQ/r8k8OioCm
         aJlMpcn6vFkdUXKSAZEBnPOSWLSUQcO6BSf2vACW88uWcl4tB1g34DGThwjSWTzXtayu
         cEGeHvHH1a2iXB/VqOuA4XMyvnsYWZ4UfjRuBKWyDzDSpHLHK4YrwJxeynt5qdQ9ncNO
         P0u5c1L5oXLSGFdZaWu8hbLYAWY0Hp7x0WhtziJAY+kQa9pDHa38EF/MzufbcJ5jfDyG
         sMKUGjT+KF7FoBYdkp4etaYGypJJNcQubpzwk9lNH1QWdsQNKtOryRjGvAtdjhmpQ9qM
         nOaQ==
X-Gm-Message-State: AAQBX9fzpyiq5q1uZ/PzC3Pl4PiJ2ftu6oM8SK/gZiWgyHuiDlawcIQq
        qdQl1FgFN/Nldabb3Eb/rjtd6+Iddaq4KM25zLXFFChu7bI=
X-Google-Smtp-Source: AKy350aw2lOqVN1QtlSfDR4pHGNJOQFKjonJRDRD57eOVcDDTqup7dhnu6a78q9ODn3sR4ZCFUfcoFaY0MLTxzgNsZ0=
X-Received: by 2002:a50:9fe3:0:b0:502:62ba:865b with SMTP id
 c90-20020a509fe3000000b0050262ba865bmr4731378edf.3.1680274247210; Fri, 31 Mar
 2023 07:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230331093318.82288-1-gregkh@linuxfoundation.org> <20230331093318.82288-6-gregkh@linuxfoundation.org>
In-Reply-To: <20230331093318.82288-6-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 16:50:35 +0200
Message-ID: <CAJZ5v0jVUg9doPtEqS4+dkFDb-aJVRH7LA50u6PwWobAzF6UKQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] driver core: make sysfs_dev_block_kobj static
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
> Nothing outside of drivers/base/core.c uses sysfs_dev_block_kobj, so
> make it static and document what it is used for so we remember it the
> next time we touch it 15 years from now.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/core.c          | 4 +++-
>  include/linux/device/class.h | 2 --
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index dbc2ba6dfffc..cf6f41c2060c 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2256,7 +2256,9 @@ int (*platform_notify)(struct device *dev) = NULL;
>  int (*platform_notify_remove)(struct device *dev) = NULL;
>  static struct kobject *dev_kobj;
>  struct kobject *sysfs_dev_char_kobj;
> -struct kobject *sysfs_dev_block_kobj;
> +
> +/* /sys/dev/block */
> +static struct kobject *sysfs_dev_block_kobj;
>
>  static DEFINE_MUTEX(device_hotplug_lock);
>
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index e946642c314e..7e4a1a6329f4 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -76,8 +76,6 @@ struct class_dev_iter {
>         const struct device_type        *type;
>  };
>
> -extern struct kobject *sysfs_dev_block_kobj;
> -
>  int __must_check class_register(struct class *class);
>  void class_unregister(const struct class *class);
>  bool class_is_registered(const struct class *class);
> --
> 2.40.0
>
