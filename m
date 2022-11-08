Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4C6211F6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 14:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbiKHNG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 08:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234291AbiKHNGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 08:06:51 -0500
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EEFA468;
        Tue,  8 Nov 2022 05:06:50 -0800 (PST)
Received: by mail-qk1-f181.google.com with SMTP id z30so8974313qkz.13;
        Tue, 08 Nov 2022 05:06:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LI5tKvQ3xbrBkw4pUpaVa/1GYtcIna1PWM17WCwqkc4=;
        b=va+HiDmHMsNkjzcg1PqsywD6KByihnSiyvZhMV/t3REDkf7Ce4xmjiv/Eh/o1/oFM7
         DHPFpa+KG7bP3+A7p4iLHPN6BY5adUFJxjhBlwvn7Ji9oEisQcKRIb0sxSSz8PHe1bZN
         7heSGr5CuviYAOCW/GD0Z8parrX3YBeuwb0sdM5NL5qJYaFr2G+EuKyDIPPhy6s0jV4v
         HAvzfV/z2InpgMReBarycPg9ySODQiv9JMhCks1yCgU97IpjATRlEP9pjsUc6/+fwByR
         7dXNZ6osjITFece0P86LA/VuLlsjoFYxZcC3oA8lUA2WL1qqquCdiyAwYni6gdsliz03
         H6Lw==
X-Gm-Message-State: ACrzQf1NgCOO+pUdwzYekenKujMJE12v5wZr15H2qp3SLYBAQahTrKVg
        eASY1CB0JdzKW0TMwO0cmxY9tYLmaG+G1EJUg3oLe6jb
X-Google-Smtp-Source: AMsMyM6mWnv7hmiQNfBMlQvN6ojeFaZNX36NmVT47vgzqWz5SZt+WPWZwPyHGmH0W/MgDOOVPQhecxo4I04uf7M7HcI=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr38188547qkl.443.1667912809286; Tue, 08
 Nov 2022 05:06:49 -0800 (PST)
MIME-Version: 1.0
References: <7ce6bd54.f8.184570dd1b6.Coremail.wangkailong@jari.cn>
In-Reply-To: <7ce6bd54.f8.184570dd1b6.Coremail.wangkailong@jari.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Nov 2022 14:06:36 +0100
Message-ID: <CAJZ5v0iv5FP=RKjyvS6Yaq7JvvxmQnz0LKZj5HmOFDbn2VvS2g@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Fix return
To:     wangkailong@jari.cn
Cc:     Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Wentland <harry.wentland@amd.com>, Li <sunpeng.li@amd.com>,
        Siqueira <Rodrigo.Siqueira@amd.com>,
        Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, Airlie <airlied@gmail.com>,
        Vetter <daniel@ffwll.ch>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
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

On Tue, Nov 8, 2022 at 12:48 PM <wangkailong@jari.cn> wrote:
>
> return is not a function, parentheses are not required
>
> Signed-off-by: KaiLong Wang <wangkailong@jari.cn>

ACPICA material is to be submitted to the upstream project at GitHub
(please see MAINTAINERS for the link).

You may notice, however, that your changes do not align with the
coding style there.

Moreover, the patch contains non-ACPICA changes that are not mentioned
in the changelog.

> ---
>  drivers/acpi/acpica/evsci.c                     | 12 +++++-------
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 17 +++++++----------
>  2 files changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/acpi/acpica/evsci.c b/drivers/acpi/acpica/evsci.c
> index 3915ff61412b..63dd2aa2d16a 100644
> --- a/drivers/acpi/acpica/evsci.c
> +++ b/drivers/acpi/acpica/evsci.c
> @@ -38,9 +38,8 @@ u32 acpi_ev_sci_dispatch(void)
>
>         /* Are there any host-installed SCI handlers? */
>
> -       if (!acpi_gbl_sci_handler_list) {
> -               return (int_status);
> -       }
> +       if (!acpi_gbl_sci_handler_list)
> +               return int_status;
>
>         flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
>
> @@ -57,7 +56,7 @@ u32 acpi_ev_sci_dispatch(void)
>         }
>
>         acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
> -       return (int_status);
> +       return int_status;
>  }
>
>  /*******************************************************************************
> @@ -193,9 +192,8 @@ acpi_status acpi_ev_remove_all_sci_handlers(void)
>             acpi_os_remove_interrupt_handler((u32) acpi_gbl_FADT.sci_interrupt,
>                                              acpi_ev_sci_xrupt_handler);
>
> -       if (!acpi_gbl_sci_handler_list) {
> -               return (status);
> -       }
> +       if (!acpi_gbl_sci_handler_list)
> +               return status;
>
>         flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index 38d71b5c1f2d..66661a20117b 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -29,7 +29,6 @@
>  #include "core_types.h"
>  #include "resource.h"
>  #include "ipp.h"
> -#include "timing_generator.h"
>  #include "dc_dmub_srv.h"
>
>  #define DC_LOGGER dc->ctx->logger
> @@ -152,9 +151,8 @@ static void dc_stream_free(struct kref *kref)
>
>  void dc_stream_release(struct dc_stream_state *stream)
>  {
> -       if (stream != NULL) {
> +       if (stream != NULL)
>                 kref_put(&stream->refcount, dc_stream_free);
> -       }
>  }
>
>  struct dc_stream_state *dc_create_stream_for_sink(
> @@ -316,11 +314,11 @@ bool dc_stream_set_cursor_attributes(
>         struct dc  *dc;
>         bool reset_idle_optimizations = false;
>
> -       if (NULL == stream) {
> +       if (stream == NULL) {
>                 dm_error("DC: dc_stream is NULL!\n");
>                 return false;
>         }
> -       if (NULL == attributes) {
> +       if (attributes == NULL) {
>                 dm_error("DC: attributes is NULL!\n");
>                 return false;
>         }
> @@ -399,12 +397,12 @@ bool dc_stream_set_cursor_position(
>         struct dc  *dc = stream->ctx->dc;
>         bool reset_idle_optimizations = false;
>
> -       if (NULL == stream) {
> +       if (stream == NULL) {
>                 dm_error("DC: dc_stream is NULL!\n");
>                 return false;
>         }
>
> -       if (NULL == position) {
> +       if (position == NULL) {
>                 dm_error("DC: cursor position is NULL!\n");
>                 return false;
>         }
> @@ -468,9 +466,8 @@ bool dc_stream_add_writeback(struct dc *dc,
>                 }
>         }
>
> -       if (!isDrc) {
> +       if (!isDrc)
>                 stream->writeback_info[stream->num_wb_info++] = *wb_info;
> -       }
>
>         if (dc->hwss.enable_writeback) {
>                 struct dc_stream_status *stream_status = dc_stream_get_status(stream);
> @@ -526,7 +523,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
>         /* remove writeback info for disabled writeback pipes from stream */
>         for (i = 0, j = 0; i < stream->num_wb_info; i++) {
>                 if (stream->writeback_info[i].wb_enabled) {
> -                       if (j < i)
> +                       if (i != j)
>                                 /* trim the array */
>                                 stream->writeback_info[j] = stream->writeback_info[i];
>                         j++;
> --
> 2.36.1
