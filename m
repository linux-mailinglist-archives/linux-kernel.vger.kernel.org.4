Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40CF6722DE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 17:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjARQVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 11:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjARQVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 11:21:17 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF6358282;
        Wed, 18 Jan 2023 08:18:04 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j9so7447940qtv.4;
        Wed, 18 Jan 2023 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OMMu3XovHqwLeu0gHfs9xCvQZaDl1KpPgg4sPO5JPY8=;
        b=PTj+AMj1P8vRit+dcK05Jx2X7ySZUq8HNs0uBdGF9PwJlCw7bl8/YtzpVcJQIaLSoN
         hD4uiIyyDFjsMYopDsmWa3wXKhJ/E7NO9MDYS98j3dtou+K0EMgTUk/iJUGHxEREzMwF
         B8/XC84Lx/H2N9LFKlKc65cLuHrx4YrZwSjTuvsVQuyGGvbfvxC8myrZPo/pUkJM3vhW
         XWV8RgCf3NjUkJGew7DYRaWZ3PujeIkxHQr4R8DFgcT5FYiUEw5RJ3yF/SJE1EWzKrLP
         OS2F6JjJ+5wipzh764Y3CZDT2tDcnycNes+V4BwOKxxRFI/bhMktewv2wQuYGjpwLRqz
         XiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMMu3XovHqwLeu0gHfs9xCvQZaDl1KpPgg4sPO5JPY8=;
        b=NwE787jVqsEUx9CWTCWqFUgQ+d8KC/9Ov70i9lfnBSkEPsDpA7uMlSHINCiS8IJX+E
         ACL7vbVF7ZNNBvvNYHo6Lws1GBrGv3jTot4mUei/QUYZ363HYYoc/uoPbdyPbAk8NI0b
         ojy6uy8ah0XeT0F0cw8376nCljDOLUJ0QuvB69CIOtdkBFRibiRvUdR79u8cTpeciutk
         AdMhjbEGI/VJA5cnFO5y0l3y/DQHNr+01IMW8yWEoZqpghW4oIydMMpJOCp/MvHQdtiS
         kcq3X+hyOaFBme2zFww3mFrjlgEsYtM4XMsSerIG3KA6e6BoIIUqM8fZyezWZeXaFqyY
         scSQ==
X-Gm-Message-State: AFqh2kogs7Bm/dV4/k83v5Pfk/OudIKhWR12t7cDHP0MjIoe/ZbnY9fK
        AnBs2+MvtArCKRlZg7QpSOgj7VT6+DBWXrXeZZrGuwlIQsY=
X-Google-Smtp-Source: AMrXdXvvmUfykE6Z5yGDFpO8mZ7rNMTtzVx/lK8I1taRVEeqLVqPLwwL4C+PuW1djDYIUxVLKjAj29X3QA5e/Oa+5sA=
X-Received: by 2002:ac8:6e81:0:b0:3b6:3c45:ada4 with SMTP id
 c1-20020ac86e81000000b003b63c45ada4mr340174qtv.481.1674058683393; Wed, 18 Jan
 2023 08:18:03 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75VcxvPZOZpGMSQXkCFv+WekHckMJkympfdR0ih72AjjkNw@mail.gmail.com>
 <20230118160739.26059-1-bpappas@pappasbrent.com>
In-Reply-To: <20230118160739.26059-1-bpappas@pappasbrent.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Jan 2023 18:17:27 +0200
Message-ID: <CAHp75VeP42nhAnjWMXnsHpd7SQhJ2G1kqX6mbEHxnpFHhKWYHg@mail.gmail.com>
Subject: Re: [PATCH v6] media: atomisp: pci: Replace bytes macros with functions
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     ailus@linux.intel.com, error27@gmail.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, mchehab@kernel.org
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

On Wed, Jan 18, 2023 at 6:08 PM Brent Pappas <bpappas@pappasbrent.com> wrote:
>
> Replace the function-like macros FPNTBL_BYTES(), SCTBL_BYTES(), and
> MORPH_PLANE_BYTES() with functions to comply with Linux coding style
> standards.
> Replace multiplication with calls to array_size() and array3_size()
> to prevent accidental arithmetic overflow.

In my MUA I don't clearly see if indentations are really being fixed,
assuming that
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thank you and keep going!

> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
> Changelog:
> V1 -> V2: Use size_mul() to perform size_t multiplication without risk of
>                   overflow.
>                   Remove the inline keyword from function definitions.
>
> V2 -> V3: Add commit message.
>
> V3 -> V4: Use array_size() and array3_size() for multiplication.
>
> V4 -> V5: Fix indentation.
>
> V5 -> V6: Try again to fix indentation (use tabs of size 8).
>
>  .../staging/media/atomisp/pci/sh_css_params.c | 38 +++++++++++--------
>  1 file changed, 23 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/media/atomisp/pci/sh_css_params.c b/drivers/staging/media/atomisp/pci/sh_css_params.c
> index f08564f58242..7e111df5c09d 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css_params.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css_params.c
> @@ -98,17 +98,27 @@
>  #include "sh_css_frac.h"
>  #include "ia_css_bufq.h"
>
> -#define FPNTBL_BYTES(binary) \
> -       (sizeof(char) * (binary)->in_frame_info.res.height * \
> -        (binary)->in_frame_info.padded_width)
> +static size_t fpntbl_bytes(const struct ia_css_binary *binary)
> +{
> +       return array3_size(sizeof(char),
> +                          binary->in_frame_info.res.height,
> +                          binary->in_frame_info.padded_width);
> +}
>
> -#define SCTBL_BYTES(binary) \
> -       (sizeof(unsigned short) * (binary)->sctbl_height * \
> -        (binary)->sctbl_aligned_width_per_color * IA_CSS_SC_NUM_COLORS)
> +static size_t sctbl_bytes(const struct ia_css_binary *binary)
> +{
> +       return size_mul(sizeof(unsigned short),
> +                         array3_size(binary->sctbl_height,
> +                                     binary->sctbl_aligned_width_per_color,
> +                                     IA_CSS_SC_NUM_COLORS));
> +}
>
> -#define MORPH_PLANE_BYTES(binary) \
> -       (SH_CSS_MORPH_TABLE_ELEM_BYTES * (binary)->morph_tbl_aligned_width * \
> -        (binary)->morph_tbl_height)
> +static size_t morph_plane_bytes(const struct ia_css_binary *binary)
> +{
> +       return array3_size(SH_CSS_MORPH_TABLE_ELEM_BYTES,
> +                          binary->morph_tbl_aligned_width,
> +                          binary->morph_tbl_height);
> +}
>
>  /* We keep a second copy of the ptr struct for the SP to access.
>     Again, this would not be necessary on the chip. */
> @@ -3279,7 +3289,7 @@ sh_css_params_write_to_ddr_internal(
>         if (binary->info->sp.enable.fpnr) {
>                 buff_realloced = reallocate_buffer(&ddr_map->fpn_tbl,
>                                                    &ddr_map_size->fpn_tbl,
> -                                                  (size_t)(FPNTBL_BYTES(binary)),
> +                                                  fpntbl_bytes(binary),
>                                                    params->config_changed[IA_CSS_FPN_ID],
>                                                    &err);
>                 if (err) {
> @@ -3304,7 +3314,7 @@ sh_css_params_write_to_ddr_internal(
>
>                 buff_realloced = reallocate_buffer(&ddr_map->sc_tbl,
>                                                    &ddr_map_size->sc_tbl,
> -                                                  SCTBL_BYTES(binary),
> +                                                  sctbl_bytes(binary),
>                                                    params->sc_table_changed,
>                                                    &err);
>                 if (err) {
> @@ -3538,8 +3548,7 @@ sh_css_params_write_to_ddr_internal(
>                         buff_realloced |=
>                             reallocate_buffer(virt_addr_tetra_x[i],
>                                             virt_size_tetra_x[i],
> -                                           (size_t)
> -                                           (MORPH_PLANE_BYTES(binary)),
> +                                           morph_plane_bytes(binary),
>                                             params->morph_table_changed,
>                                             &err);
>                         if (err) {
> @@ -3549,8 +3558,7 @@ sh_css_params_write_to_ddr_internal(
>                         buff_realloced |=
>                             reallocate_buffer(virt_addr_tetra_y[i],
>                                             virt_size_tetra_y[i],
> -                                           (size_t)
> -                                           (MORPH_PLANE_BYTES(binary)),
> +                                           morph_plane_bytes(binary),
>                                             params->morph_table_changed,
>                                             &err);
>                         if (err) {
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
