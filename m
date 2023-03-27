Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C9F6CA80C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbjC0Opd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 10:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjC0Op1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:45:27 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7C130F6;
        Mon, 27 Mar 2023 07:45:26 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id x3so37142063edb.10;
        Mon, 27 Mar 2023 07:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xqx7BG6DbrJV5wVYNqu1sizTrODp1YIAvlx1rxv/dHw=;
        b=Xdc8Z3heKdPTdf1g/dMXyUPRJG187y8yVAlRlh35zKhLhlwDuPVjBrld71Z+4wyyPa
         IW/W5joYsn0QFpTyUO7qEDXJC3RjJQ/OW4coYHaRE67MDFpRoJ9KI0pUz0Skkdve0AUp
         ObruFi4P+lewh1AMTpAFpNgSB6Zpb14XE+3/inkRFRC/mypAvzaAJE+J5P/KfkZdm2HY
         4jFEn1KQBAvkjLj0oia1hJA2PoLZnSSgVkfTS28kUZb0RYv11XuBV3OFkXV6LEKQ+L9B
         +q6OO3h3fS0/1KUsi4xSYoMcvio7BVxhxxE6qIoFBvv/Wv6L16/oBvt2McUVFi8XWSC6
         +gCA==
X-Gm-Message-State: AAQBX9eQI5/yM6fdL3Klw25MiVoK3UjljrhZB7vaN+sMBiBNyNy9DXvs
        +gVuPrOre1QoHqC7V8r/5IyITkvubLVvkSeuXIg=
X-Google-Smtp-Source: AKy350ZuKxgSHHk6NQd8hY3qoPJQjzqVVe6ZP3MC4ic80UsNRvDg38SM04k6AzTGcFnW3UxmshoSo0AHdTW7K+E9pG0=
X-Received: by 2002:a50:d6d6:0:b0:4fb:c8e3:1adb with SMTP id
 l22-20020a50d6d6000000b004fbc8e31adbmr5776908edj.3.1679928324869; Mon, 27 Mar
 2023 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 16:45:13 +0200
Message-ID: <CAJZ5v0jodw=LME60q39V4+6NVStNjmmTF80VyQMGo+iwWngDLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] device property: Add headers to the Driver Core
 entry in MAINTAINERS
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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

On Mon, Mar 27, 2023 at 3:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The header files (fwnode.h and property.h) are part of the device
> property API, which in its turn is part of driver core. Add the
> missed headers to the corresponding record in the MAINTAINERS database.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: new patch
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 93fb4e5a2814..aa61d9ede78b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6316,7 +6316,9 @@ F:        drivers/base/
>  F:     fs/debugfs/
>  F:     fs/sysfs/
>  F:     include/linux/debugfs.h
> +F:     include/linux/fwnode.h
>  F:     include/linux/kobj*
> +F:     include/linux/property.h
>  F:     lib/kobj*

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

>  DRIVERS FOR OMAP ADAPTIVE VOLTAGE SCALING (AVS)
> --
> 2.40.0.1.gaa8946217a0b
>
