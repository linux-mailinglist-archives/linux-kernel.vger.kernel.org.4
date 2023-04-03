Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9686D4FC6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjDCR7z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Apr 2023 13:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjDCR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:59:50 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CDE3AAB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:59:23 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id i5so120860320eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680544670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdla5rejrcEhOYw74pFRk6pnEtVJwILDYX/iCCA2b94=;
        b=pD7ENBKbB4y7DRB5Yw5WPEcIRXAfXkOGIgQ6bpx976r+UnJuJCTZ0UuOl2DXn5Z2FB
         sCHsko4gAjJJz/Ex0+z94f09QDdisIrMU+BQO5fdgIXUAI07Vk/koxWP3etsIN6jZ712
         wsFodlVtmxDngJmnON2vSbImSIcqXsK386VsLeVZ1bVcDQDXQzcoU8rZc9qg19KHbrjg
         bZ1TAfiwmZ2MzW65PNTd7deSidgENjReghp0g+i1/8Vn4i3VqdkACwL4UXINdZgFJBeE
         pzHAPru2Yuc7lIawnk1FyC4C2ORXWl3UWPzN+FkGcVjjw1Ha2Yi7abhPq7x8/UFvv5XD
         GJqg==
X-Gm-Message-State: AAQBX9dQ3oPSzgJzheiWndWHNVh/NIRt7Y4YsrYohWqluP8wLS1/6Ewg
        N3DDgBrbPCtgtWTlCJ6l/3GPCxFnwSB+Qj8qUT4=
X-Google-Smtp-Source: AKy350Yxcv2qvLT5IbjrOUJPIftoHFiadRnEXdjJet2kfDFjrR1ezhzcUYi010MzDFHRpd0XgPsv9MCjsacR/cjdnh0=
X-Received: by 2002:a17:907:d02:b0:931:6921:bdbb with SMTP id
 gn2-20020a1709070d0200b009316921bdbbmr17586102ejc.2.1680544669749; Mon, 03
 Apr 2023 10:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <2023040244-duffel-pushpin-f738@gregkh> <2023040249-handball-gruffly-5da7@gregkh>
In-Reply-To: <2023040249-handball-gruffly-5da7@gregkh>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 3 Apr 2023 19:57:38 +0200
Message-ID: <CAJZ5v0hvE8ttVfpCveL8TwL_ApZpaPY-eKXGv09CoCb26p79Gw@mail.gmail.com>
Subject: Re: [PATCH 3/5] driver core: class: mark the struct class in struct
 class_interface constant
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
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

On Sun, Apr 2, 2023 at 7:59 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> The struct class pointer in struct class_interface is never modified, so
> mark it as const so that no one accidentally tries to modify it in the
> future.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/class.c         | 2 +-
>  include/linux/device/class.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/class.c b/drivers/base/class.c
> index 05bce79d3d19..ad8b9f163fd2 100644
> --- a/drivers/base/class.c
> +++ b/drivers/base/class.c
> @@ -498,7 +498,7 @@ EXPORT_SYMBOL_GPL(class_interface_register);
>  void class_interface_unregister(struct class_interface *class_intf)
>  {
>         struct subsys_private *sp;
> -       struct class *parent = class_intf->class;
> +       const struct class *parent = class_intf->class;
>         struct class_dev_iter iter;
>         struct device *dev;
>
> diff --git a/include/linux/device/class.h b/include/linux/device/class.h
> index 4bf46f9bbb56..53287aa105b8 100644
> --- a/include/linux/device/class.h
> +++ b/include/linux/device/class.h
> @@ -217,7 +217,7 @@ ssize_t show_class_attr_string(const struct class *class, const struct class_att
>
>  struct class_interface {
>         struct list_head        node;
> -       struct class            *class;
> +       const struct class      *class;
>
>         int (*add_dev)          (struct device *, struct class_interface *);
>         void (*remove_dev)      (struct device *, struct class_interface *);
> --
> 2.40.0
>
