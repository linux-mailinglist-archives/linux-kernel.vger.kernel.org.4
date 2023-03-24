Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628276C7F04
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjCXNmt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 24 Mar 2023 09:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCXNmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:42:45 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D296518B0F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:42:36 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id o12so8069814edb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:42:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679665355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bv7FdV3Rt82PfEejYXpMJZy9CU6LFvMwm6M6sXTkJa0=;
        b=CmFqZf0+PmCYSZFIvRDhQNdHc2lkfyKJCVcpOz/rFFgBjyhS2KHQ9z+0zx6kFohtYt
         4GBIxWPxXj72gsKA+aYrl7AJ8QlJAk2jfkUxkB4Odzl3DC5SmUGuYMIlS/TeO88ryUbn
         qOOa3qIz994S4Xn044aOoSFrqm7rk0u9wtaqbiFr90EIYbB3p387NGn9v7Kz7HTMDWWX
         2ntVhxCekrjCgi2NKgWPG+7NXiQR1q7BEAGjqyJnaE1HkkehqcJSLAANsPMd00RdN8g9
         FxcE5fRAwRNhCIzNz/ECXwEqh9529Cp+9w/lbNNk+IfC5QSzRYE7jgw7QeFVIXipGZwk
         NmhA==
X-Gm-Message-State: AAQBX9dyGdC4GmAK8MWkQmucPD7rJLF8Cm93eN8sunzuaRTx4Kf7KQ+Z
        eS2pKBqcvQ5lZ9hZoh7VrYFCGpPRiNksfCKHFdlZOCOsBB8=
X-Google-Smtp-Source: AKy350bWvKFirj17A/xgflf7uHPxUo5gmS03ox8ZESt7+tSqTs4qtOE5iSEX8PuGJxCENch/zVLJUPiC/JkxSGtb6gg=
X-Received: by 2002:a17:907:d687:b0:93d:a14f:c9b4 with SMTP id
 wf7-20020a170907d68700b0093da14fc9b4mr1473775ejc.2.1679665355040; Fri, 24 Mar
 2023 06:42:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230324100132.1633647-1-gregkh@linuxfoundation.org> <20230324100132.1633647-2-gregkh@linuxfoundation.org>
In-Reply-To: <20230324100132.1633647-2-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 24 Mar 2023 14:42:23 +0100
Message-ID: <CAJZ5v0jt8=VGpRjiry-hmyJjpE4YEeWi71-4UUxviaZk7xNpSQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] driver core: class.h: remove extern from function prototypes
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

On Fri, Mar 24, 2023 at 11:01 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The kernel coding style does not require 'extern' in function prototypes
> in .h files, so remove them from include/linux/device/class.h as they
> are not needed.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  include/linux/device/class.h | 46 ++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 03d2f99f84c5..1dc7706cb42d 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -82,8 +82,9 @@ struct class_dev_iter {
>
>  extern struct kobject *sysfs_dev_block_kobj;
>  extern struct kobject *sysfs_dev_char_kobj;
> -extern int __must_check class_register(struct class *class);
> -extern void class_unregister(struct class *class);
> +
> +int __must_check class_register(struct class *class);
> +void class_unregister(struct class *class);
>
>  struct class_compat;
>  struct class_compat *class_compat_register(const char *name);
> @@ -93,19 +94,15 @@ int class_compat_create_link(struct class_compat *cls, struct device *dev,
>  void class_compat_remove_link(struct class_compat *cls, struct device *dev,
>                               struct device *device_link);
>
> -extern void class_dev_iter_init(struct class_dev_iter *iter,
> -                               const struct class *class,
> -                               const struct device *start,
> -                               const struct device_type *type);
> -extern struct device *class_dev_iter_next(struct class_dev_iter *iter);
> -extern void class_dev_iter_exit(struct class_dev_iter *iter);
> +void class_dev_iter_init(struct class_dev_iter *iter, const struct class *class,
> +                        const struct device *start, const struct device_type *type);
> +struct device *class_dev_iter_next(struct class_dev_iter *iter);
> +void class_dev_iter_exit(struct class_dev_iter *iter);
>
> -extern int class_for_each_device(const struct class *class, const struct device *start,
> -                                void *data,
> -                                int (*fn)(struct device *dev, void *data));
> -extern struct device *class_find_device(const struct class *class,
> -                                       const struct device *start, const void *data,
> -                                       int (*match)(struct device *, const void *));
> +int class_for_each_device(const struct class *class, const struct device *start, void *data,
> +                         int (*fn)(struct device *dev, void *data));
> +struct device *class_find_device(const struct class *class, const struct device *start,
> +                                const void *data, int (*match)(struct device *, const void *));
>
>  /**
>   * class_find_device_by_name - device iterator for locating a particular device
> @@ -191,12 +188,10 @@ struct class_attribute {
>  #define CLASS_ATTR_WO(_name) \
>         struct class_attribute class_attr_##_name = __ATTR_WO(_name)
>
> -extern int __must_check class_create_file_ns(const struct class *class,
> -                                            const struct class_attribute *attr,
> -                                            const void *ns);
> -extern void class_remove_file_ns(const struct class *class,
> -                                const struct class_attribute *attr,
> -                                const void *ns);
> +int __must_check class_create_file_ns(const struct class *class, const struct class_attribute *attr,
> +                                     const void *ns);
> +void class_remove_file_ns(const struct class *class, const struct class_attribute *attr,
> +                         const void *ns);
>
>  static inline int __must_check class_create_file(const struct class *class,
>                                                  const struct class_attribute *attr)
> @@ -223,8 +218,7 @@ struct class_attribute_string {
>         struct class_attribute_string class_attr_##_name = \
>                 _CLASS_ATTR_STRING(_name, _mode, _str)
>
> -extern ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr,
> -                        char *buf);
> +ssize_t show_class_attr_string(struct class *class, struct class_attribute *attr, char *buf);
>
>  struct class_interface {
>         struct list_head        node;
> @@ -234,10 +228,10 @@ struct class_interface {
>         void (*remove_dev)      (struct device *, struct class_interface *);
>  };
>
> -extern int __must_check class_interface_register(struct class_interface *);
> -extern void class_interface_unregister(struct class_interface *);
> +int __must_check class_interface_register(struct class_interface *);
> +void class_interface_unregister(struct class_interface *);
>
> -extern struct class * __must_check class_create(const char *name);
> -extern void class_destroy(struct class *cls);
> +struct class * __must_check class_create(const char *name);
> +void class_destroy(struct class *cls);
>
>  #endif /* _DEVICE_CLASS_H_ */
> --
> 2.40.0
>
