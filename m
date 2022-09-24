Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D024E5E8EC1
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiIXRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbiIXRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 13:03:17 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728D795693;
        Sat, 24 Sep 2022 10:03:15 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id g2so1908280qkk.1;
        Sat, 24 Sep 2022 10:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5Oj5RA8rn9Qktt9kVPsACHjRhcWrRSHzXz4A/CK+Liw=;
        b=6yAaGmXSumeLVR8G2xvx9Ya3NiQVmpN7pFZsQTWK3Eckg1ok4SXiH//1Muo+gK0Z5U
         +IhIpSmeghqaptqvwLairOeN7DG5FFNDOfgFCJGf5NEDIue6qFxMATQRds9eUp9IQxpc
         MVYmZgMXcG8zx1xeFEez4RmyNB53dyxMoZ2UkKzOPBzgh9olZEGT+ZvJaV7swI8W973E
         50abTXNHMHj62Nyri2pWfI2K38K5tuHYLJpokp/VwGXUHFlztCIYLsBRpEoLYyrOtAqb
         rz2GIU7JWeOXgruIG4QnGgBmTosB8SD4DxJvHOW77XBcxMaecDEC0LdEEYgLK5ThPSWl
         vxag==
X-Gm-Message-State: ACrzQf1jXWztseM6xYAQpLnqvsnrTYuYz8OVU9j6d46wnGQIg0/jhhUE
        Mt2T5yAUdWlaBGiaeHohDu+pGCC2YFeRu6UySgk=
X-Google-Smtp-Source: AMsMyM4PKak5RBjro7zyF3T/ozZ4Ns7hvTHmw/i4M3UzGNXZnHxLb/Cw+WdoUwRK9GCoJcKj088HrWSqtt7Z+pWPsBU=
X-Received: by 2002:a05:620a:4008:b0:6ce:8725:cb7 with SMTP id
 h8-20020a05620a400800b006ce87250cb7mr9665355qko.480.1664038994620; Sat, 24
 Sep 2022 10:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220921172422.650880-1-kellen.renshaw@canonical.com>
In-Reply-To: <20220921172422.650880-1-kellen.renshaw@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 19:03:03 +0200
Message-ID: <CAJZ5v0g=x2cBoFjOufOD6_4nLHhRqoFmM+4BHtWFifVGgNcKUQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resources: Add ASUS model S5402ZA to quirks
To:     Kellen Renshaw <kellen.renshaw@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Hui Wang <hui.wang@canonical.com>
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

On Wed, Sep 21, 2022 at 7:24 PM Kellen Renshaw
<kellen.renshaw@canonical.com> wrote:
>
> The Asus Vivobook S5402ZA has the same keyboard issue as Asus Vivobook
> K3402ZA/K3502ZA. The kernel overrides IRQ 1 to Edge_High when it
> should be Active_Low.
>
> This patch adds the S5402ZA model to the quirk list.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=216158
> Tested-by: Kellen Renshaw <kellen.renshaw@canonical.com>
> Signed-off-by: Kellen Renshaw <kellen.renshaw@canonical.com>
> ---
> Follows e12dee373673 (ACPI: resource: Skip IRQ override on Asus Vivobook
> K3402ZA/K3502ZA).
>
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8b4faec8cae7..5d688e546239 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -414,6 +414,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "K3502ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus Vivobook S5402ZA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "S5402ZA"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.1 material, thanks!
