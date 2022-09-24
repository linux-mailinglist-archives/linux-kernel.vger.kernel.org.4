Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16405E8E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiIXQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbiIXQwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:52:31 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66C52D1F4;
        Sat, 24 Sep 2022 09:52:27 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id c11so1824863qtw.8;
        Sat, 24 Sep 2022 09:52:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=P6Yp7bWFgW/ocrevyMc619Inz7oF6cbIjoDxngEHtYA=;
        b=Qrul35aIxs7a0HrK1H/sEfQcujOG+dJtnJa/oex0XiG3mZsfct5D/ovvJAKVJpeTxn
         2sCeV+4QU+6xSCRnyb6q8pd9d6ZSMA6kheaIFpmU6MBsl+AwAd8lMDv2fMFFZb0BnLOR
         w/Cb6F37YaGhmMrtA7+gvNatoIAbHKlpcZ1JOw3hchRpDhFyuhOUs87xDZJN4m1Rc7eM
         nQ5nJs7jL32n6w4zcinI2v0NGKb8aBQVRs1ekrxz/+gG8HreJJeQo5i38iggCGMRvsJZ
         L7dGCZKSKz2QDCj6PgInn0WLTgAJtKyerJGgpSxq+VlSo9HqvW1rwf8nSJjF0kGw0U5X
         qEPA==
X-Gm-Message-State: ACrzQf1HxqMXj1rVXK1cPOkLZcD8AFiubk6nkGuTwZoaQuiUkbebKG3m
        deCG5BkK/t3fS/EdhpuOj03j3NRc60JYsWisH2I=
X-Google-Smtp-Source: AMsMyM7xeNJROoTBrySCo1JRHAKCLj3mT51z155UY84Z7zgFHGGlCNmlBFrkYNGY7SJNxZ8Q5qP6oYKa4tqNqSSOMsY=
X-Received: by 2002:a05:622a:11c8:b0:35c:e912:a8ea with SMTP id
 n8-20020a05622a11c800b0035ce912a8eamr11829694qtk.17.1664038346630; Sat, 24
 Sep 2022 09:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220921092834.230356-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220921092834.230356-1-ye.xingchen@zte.com.cn>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 24 Sep 2022 18:52:15 +0200
Message-ID: <CAJZ5v0jVgb3dzqUj5QLgxcJacOxGWqJm4BvyO081cHBpV63XRg@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] ACPI: APEI: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 11:28 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value erst_get_record_id_begin() and apei_exec_write_register()
>  directly instead of storing it in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
> v1 -> v2
> combine the patchs in APEI.
>  drivers/acpi/apei/apei-base.c | 5 +----
>  drivers/acpi/apei/erst.c      | 6 +-----
>  2 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 9f49272cad39..9b52482b4ed5 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -125,12 +125,9 @@ EXPORT_SYMBOL_GPL(apei_exec_write_register);
>  int apei_exec_write_register_value(struct apei_exec_context *ctx,
>                                    struct acpi_whea_header *entry)
>  {
> -       int rc;
> -
>         ctx->value = entry->value;
> -       rc = apei_exec_write_register(ctx, entry);
>
> -       return rc;
> +       return apei_exec_write_register(ctx, entry);
>  }
>  EXPORT_SYMBOL_GPL(apei_exec_write_register_value);
>
> diff --git a/drivers/acpi/apei/erst.c b/drivers/acpi/apei/erst.c
> index 31b077eedb58..247989060e29 100644
> --- a/drivers/acpi/apei/erst.c
> +++ b/drivers/acpi/apei/erst.c
> @@ -1020,14 +1020,10 @@ static int reader_pos;
>
>  static int erst_open_pstore(struct pstore_info *psi)
>  {
> -       int rc;
> -
>         if (erst_disable)
>                 return -ENODEV;
>
> -       rc = erst_get_record_id_begin(&reader_pos);
> -
> -       return rc;
> +       return erst_get_record_id_begin(&reader_pos);
>  }
>
>  static int erst_close_pstore(struct pstore_info *psi)
> --

Applied as 6.1 material with some edits in the subject and changelog, thanks!
