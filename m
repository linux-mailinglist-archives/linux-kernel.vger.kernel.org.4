Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4846CA80F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjC0OqO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 10:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjC0OqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:46:11 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E592830DA;
        Mon, 27 Mar 2023 07:46:09 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id r11so37253487edd.5;
        Mon, 27 Mar 2023 07:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679928368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ft6/VFhBqMAajm7d7DHE8dyXMfMvTu+AETmhZe8sB7g=;
        b=X3ImNx8qrcq2C+Wp1bJ3OtNn30KQ4YzuGjlUf5SW03prJWqMaEEB7f2ZZChXNTDINn
         6Kq0hx2c+zSERsow5LqVEVTribr5feuah4rcoTCPthS3E0LUGX/MO/HYTjQN9UCs4qPK
         NnL2APiOTe6XIxgbWl8XdC+L49j9Iki+lTxW7DBpSXrfc3E0YnVz/OaRw8HZAUK60iCR
         fcYrpsk+QwHQOV+lAvwdIQXy1NQBWo25LwRzrG0t0DiMJjwKZRElBfVVZ9KYR+h6eaWj
         TrsWogoYPYHm3EPyfSYEGEkjg6ddXOYTorPsGX5FZGeWRsvlaL5bh797HulReIyriNdT
         jPqg==
X-Gm-Message-State: AAQBX9cQTUlpmk9Ck7D4Fk3OdVhRsNACaNZkTEjxWjpd6AOSpRyRgptr
        9EA1yeWQTRlhrxkQf3aZ553F1rpBaytfdHWQZyA=
X-Google-Smtp-Source: AKy350ZogeZg4OxiejM2Ru310GtbPn0+xRwZfnpamPM6UpyHEErFM6of/dWIJS+flsX2Cf15tbz/5K2ON1SAFLSw/TI=
X-Received: by 2002:a50:cc94:0:b0:4fb:c8e3:1ae2 with SMTP id
 q20-20020a50cc94000000b004fbc8e31ae2mr6172808edi.3.1679928368373; Mon, 27 Mar
 2023 07:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230327130150.84114-1-andriy.shevchenko@linux.intel.com> <20230327130150.84114-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230327130150.84114-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Mar 2023 16:45:57 +0200
Message-ID: <CAJZ5v0i_VMS-2=cMaGU9kbS-eCsGqmOXm_nGvhz4B9ZAa7tLfQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] device property: Remove unused struct net_device
 forward declaration
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
> There is no users in the property.h for the struct net_device.
> Remove the latter for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
> v2: no changes (just Cc'ed accordingly)
>  include/linux/property.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 4a536548606b..59f452198c64 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -16,7 +16,6 @@
>  #include <linux/types.h>
>
>  struct device;
> -struct net_device;
>
>  enum dev_prop_type {
>         DEV_PROP_U8,
> --
> 2.40.0.1.gaa8946217a0b
>
