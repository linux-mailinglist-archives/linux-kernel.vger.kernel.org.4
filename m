Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E966C1D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjCTRJP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbjCTRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:08:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0705B32CE0;
        Mon, 20 Mar 2023 10:04:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w9so49493313edc.3;
        Mon, 20 Mar 2023 10:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679331734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4jK8gh5sPVn7plj4DMWjVY4LumCmSzgEWBGR/d5MNzk=;
        b=OmdFQlI6/xh2YzgDmVmQGwVePyfzazL3+mKcKR1Jndmx1APzLgK2kSSu9uc07ndMGm
         qUzyJ5tsv/E4uKWzT85DDLlTvYO4Lo7V5eA2WkNy4IuqRLN6tSodTBJL/5ygb37gjzNq
         Z22iTfWVp/ZPkb5x1egIBG5ZzwvhXcbF11Q841iXvxOOLXanlcq0Ij3tB8LM+XkRO2wd
         lDDuLBZzLx5VYuh+PS3dQcX624Lm4RBvRRldWbNZR+xKw6y8mnytI+gZ+XNA5wWB8mQY
         D69kVX6C+ENvZbaIIy34KPhXfmoZ/FI8R6CyvYTeyngXqNQfSs5DfQGo8BII1s8UluSL
         HZAA==
X-Gm-Message-State: AO0yUKWUBj4zNakmB20IeLbi11Vo+0lZRqyQglCQC8WRvTn6dkAUfRdg
        ZbKvh9EhJj6qaHYrz1kzdB2s7fmt9ZAv7vlqVs0=
X-Google-Smtp-Source: AK7set/yaQH79SPShN0Ft8Rn+W7KFso8X28Jo7X9BK0NLwxuQPr45ns2P9CMLo5z5VgZ3MH5TCCLgqt6sxcycLbRjXI=
X-Received: by 2002:a50:c389:0:b0:4fb:f19:881 with SMTP id h9-20020a50c389000000b004fb0f190881mr154316edf.3.1679331734246;
 Mon, 20 Mar 2023 10:02:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230226061912.2590679-1-void0red@gmail.com>
In-Reply-To: <20230226061912.2590679-1-void0red@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:02:02 +0100
Message-ID: <CAJZ5v0gPUBFzuFiRWW8KHAwB1Agy+Le=CWuRD0RTr4MkNeEmQw@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: check null return of ACPI_ALLOCATE_ZEROED in acpi_db_display_objects
To:     Kang Chen <void0red@gmail.com>
Cc:     lenb@kernel.org, robert.moore@intel.com,
        rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 7:19 AM Kang Chen <void0red@gmail.com> wrote:
>
> ACPI_ALLOCATE_ZEROED may fails, object_info might be null and will
> cause null pointer dereference later.
>
> Signed-off-by: Kang Chen <void0red@gmail.com>

As a rule, ACPICA changes need to be submitted as pull requests to the
upstream ACPICA project on GitHub in the first place.

When this happens, please resend the patch with a Link tag pointing to
the corresponding upstream pull request.

> ---
>  drivers/acpi/acpica/dbnames.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/acpica/dbnames.c b/drivers/acpi/acpica/dbnames.c
> index 3615e1a6e..b91155ea9 100644
> --- a/drivers/acpi/acpica/dbnames.c
> +++ b/drivers/acpi/acpica/dbnames.c
> @@ -652,6 +652,9 @@ acpi_status acpi_db_display_objects(char *obj_type_arg, char *display_count_arg)
>                 object_info =
>                     ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_object_info));
>
> +               if (!object_info)
> +                       return (AE_NO_MEMORY);
> +
>                 /* Walk the namespace from the root */
>
>                 (void)acpi_walk_namespace(ACPI_TYPE_ANY, ACPI_ROOT_OBJECT,
> --
> 2.34.1
>
