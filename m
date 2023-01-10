Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132DA6640AC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238575AbjAJMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbjAJMhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:37:37 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3707559D35
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:37:27 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id az20so9145567ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To1EwtqsW0k0IdqS8xqhATtmlLVCrUlAZBlyyiO3WRU=;
        b=SPvzaI8qdo0F6vqHy3OqCTkMqwOHIOmRn8Rb94TRxszjOx/MLOR0DQ9xyU9vIE/SPi
         euKB++XthNbPZo0BDlCUepLa3QcLTtxvKlMp6M0A+gL2dNIYE/vbZlxLNHG1SLknzrVf
         rIExmjNh/wdAG002fUA9Lq0DiTAhuK7XW0zmpk6F8k6LyiEs9YtJmEAbP3qifl2AnD0w
         xywEvypBMgiDlJL1DyW+DJh6x1XI3XPG02DCfYP5djgOxlk46a414tuHiSLn7debcZXh
         lf/JO7v2xTebPT02P5wcMazp56DCU3AUFwTBHJUQoA2Xj6hCif7TE8s8VLQJW+aOABAg
         yzUA==
X-Gm-Message-State: AFqh2krjZQYsslnNKJlcNEY9+j9PdYUHUZH09JsBhik8+KEieJIEE5p8
        TcrFwgMqMPWh7JLbJH1MFBdJRx8wH4dvSwOL84k8qiim+bs=
X-Google-Smtp-Source: AMrXdXsjxB74UHauY58TNQXEskUeWQAPLpPTSmufKOzS3Znb0KypiSQ5P8SbD7zo+yPC144T31ACTIl0A8jfmaES00s=
X-Received: by 2002:a17:907:29c3:b0:84d:4b8e:efc with SMTP id
 ev3-20020a17090729c300b0084d4b8e0efcmr443432ejc.390.1673354245811; Tue, 10
 Jan 2023 04:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20230109175810.2965448-1-gregkh@linuxfoundation.org> <20230109175810.2965448-6-gregkh@linuxfoundation.org>
In-Reply-To: <20230109175810.2965448-6-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 10 Jan 2023 13:37:14 +0100
Message-ID: <CAJZ5v0jJwXhc2XOCxSYK6jw_OfDLYuHR5X34UOVWpP_jRWZ7LQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] driver core: move struct subsys_dev_iter to a local file
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 6:58 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> struct subsys_dev_iter is not used by any code outside of
> drivers/base/bus.c so move it into that file and out of the global bus.h
> file.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/base/bus.c         | 5 +++++
>  include/linux/device/bus.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index e0fe07872a74..e0953656d5ac 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -941,6 +941,11 @@ void bus_sort_breadthfirst(struct bus_type *bus,
>  }
>  EXPORT_SYMBOL_GPL(bus_sort_breadthfirst);
>
> +struct subsys_dev_iter {
> +       struct klist_iter               ki;
> +       const struct device_type        *type;
> +};
> +
>  /**
>   * subsys_dev_iter_init - initialize subsys device iterator
>   * @iter: subsys iterator to initialize
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index ffa562f2d975..53e3cdf18bae 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -150,11 +150,6 @@ int device_match_acpi_handle(struct device *dev, const void *handle);
>  int device_match_any(struct device *dev, const void *unused);
>
>  /* iterator helpers for buses */
> -struct subsys_dev_iter {
> -       struct klist_iter               ki;
> -       const struct device_type        *type;
> -};
> -
>  int bus_for_each_dev(struct bus_type *bus, struct device *start, void *data,
>                      int (*fn)(struct device *dev, void *data));
>  struct device *bus_find_device(struct bus_type *bus, struct device *start,
> --
> 2.39.0
>
