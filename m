Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E709F68DD53
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbjBGPv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:51:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjBGPvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:51:25 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554983C3E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:51:24 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id 194so610443pfy.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zJqpF+5l/IPdPEY6JIeF4TFZYJP1idCXHeFCUM83wtQ=;
        b=nQq8QIq6PQv7uMLArYJEKgRPLuFvsE3jWauI90SBHUO/Dz/BIWwD0qzZjJ6qR0h7C1
         +FTx0RN7RsMACnrwLaBMM45ej8qv6JPaY0fq8MIc+ZOPImDDErHBM9LLtWKCYqVH9cZI
         dOMMo8XVpMP8e1vyzTy3s2YF4Sc3OGiE2hnFEw0kBcgFV9pQamPbKyFVKMvzob+tvV6U
         vNLT6drgbZbx28wHdxut58Smh52G2sj4rsnaPKPgSzw31p4ieE787exp+1/pCFaYWHcx
         C35hltFu5sE3tchlHLlQd7ndvO8IRCx37ochztJHVx3CnsFS504iY61rBx67W/WMl1lP
         4Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zJqpF+5l/IPdPEY6JIeF4TFZYJP1idCXHeFCUM83wtQ=;
        b=KsIsaGuretFCJ3C3A3Of4NVje0T42J5VHfNPvglG8cvvftx0hDlnQzBVHK3yjHIicm
         QDRJUPM703YV9VGkmKmfbrO/Ji2Q82LT+0A1GPRUm1+sYiwMn8c+pW1N3Q8wTjYqXKlG
         KCoZ+w0R0uGxFw/1njYX0nQQ8l6QEfw1O7FLc98HpuYX8lICjuXP9JIRh+rPkP0y8Xd7
         aXgjSl2bDlGBuW+KYuU8JrniLCx0x1ScpZVtYzvmoLiJAyd1mNjm2dcQ+FFhW4nxURIK
         7LgXeHf7QH48gcnIZKEuYUWc/nyJA60rYLlHxFOECEtaKdP5aL5WHDWdgJWcE01wdgb4
         /cuA==
X-Gm-Message-State: AO0yUKUOCAM3fGx0YIB7AeS/ITkMFiJWRQ2LvvW0gPfho7k7INaidPcC
        utqExFiVFptamMskgT9Lnf6f7oJwmoEd3txajOU=
X-Google-Smtp-Source: AK7set+3rX9SsIe4o7ouaEK13M8jQ8GlNYxtnmlb+gAP0sP9ZVChMnXMvLIt+2lGwjxQDeEC7xuXFkc3m1otM/x5NL8=
X-Received: by 2002:a62:6d85:0:b0:593:a079:639a with SMTP id
 i127-20020a626d85000000b00593a079639amr959208pfc.44.1675785083642; Tue, 07
 Feb 2023 07:51:23 -0800 (PST)
MIME-Version: 1.0
References: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
In-Reply-To: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Tue, 7 Feb 2023 15:51:12 +0000
Message-ID: <CAMxBKG3o_6R7M0gaUHXA5yGgSe6HBWYK25fwF=8mN+JTno9t7Q@mail.gmail.com>
Subject: Re: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet
 3 10IGL5
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
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

Further information:

With the above fix, the very early boot console messages are not
rotated. adding "fbcon=rotate:1" to the kernel command line corrects
this. But these early boot console messages are still garbled - it
looks like the display driver in use at the time cannot write to the
screen fast enough - lines are half-formed before scrolling.

Note that this corrects itself and later boot messages are legible
before the plymouth splash (if in use). I can't see anything that
looks like useful information re the fb in journalctl immediately
preceding the first legible output seen during boot.

I've played around with console, earlycon and fbcon parms to no useful
effect. Any ideas?

Darrell

On Fri, 3 Feb 2023 at 18:32, Darrell Kavanagh
<darrell.kavanagh@gmail.com> wrote:
>
> Hi,
>
> This is another Lenovo with detachable keyboard and 1200x1920 screen
> mounted sideways.
>
> The following has been tested with 6.2.0-rc6.
>
> Thanks,
> Darrell
>
> index 3659f04..590bb7b 100644
> --- a/kernel/drm_panel_orientation
> _quirks.c
> +++ b/kernel/linux-6.2-rc6/drivers/gpu/drm/drm_panel_orientation_quirks.c
> @@ -304,6 +304,12 @@ static const struct dmi_system_id orientation_data[] = {
>                   DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad
> D330-10IGM"),
>                 },
>                 .driver_data = (void *)&lcd1200x1920_rightside_up,
> +       }, {    /* Lenovo IdeaPad Duet 3 10IGL5 */
> +               .matches = {
> +                 DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> +                 DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
> +               },
> +               .driver_data = (void *)&lcd1200x1920_rightside_up,
>         }, {    /* Lenovo Ideapad D330-10IGL (HD) */
>                 .matches = {
>                   DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
