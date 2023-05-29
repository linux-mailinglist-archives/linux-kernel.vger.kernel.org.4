Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21A8714BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjE2ONp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 29 May 2023 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjE2ONo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:13:44 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C6BAD;
        Mon, 29 May 2023 07:13:42 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9740c1c4a24so14477966b.1;
        Mon, 29 May 2023 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685369621; x=1687961621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=26NjF04cMsMDS8klff31uqLdZAIm9ImX4dVMC32z4z4=;
        b=MfrK594lEAcfKeFD9SHcdUPlVR/+3YEOGjeaSEwnp7Y5wl3sR810uuSBPatIVg5urc
         5Z/mk/m2ySe7lABBrbuNu8+6BhqU4UBeYVq8+qfhFK7Xdgfon9QAhwrIQWDuLsevNcAf
         9un8HCAnHzMncfmJyCUixz/dm5ugYtwaW5xsIiJSFNOfCiHIWfK9X0TcTGZ9Fx4YfJ4J
         ZeUAIwyb66abSKsr66kGE7sOt8bD2PLaKSjv3kSWNf3InsGVGI0fUYxsBqhEz5/gQ6vU
         txF7d8s5EHHCquwjcCmYGn2UGwK7e3U45ZhuWMnIYnyzYUBoi4V/DO3CJYNI5zbJsAZD
         dgkg==
X-Gm-Message-State: AC+VfDxPeV69nNT84A/yyKb2ewXiFyfbWrgKWE7c+NDGrjTcbKFfQY1j
        92l6KTGvvNG2Iv4lshk1BlWX7KEgN0NwTdRsgdw=
X-Google-Smtp-Source: ACHHUZ5A5h0rdHchN5D5aqNIGja/yKWlLLcAJsn6CyLak4s9T7I/PUv8BsikHYLDTp0eTbjMk4WWFOb8fF0+s8YZG3A=
X-Received: by 2002:a17:906:729e:b0:94f:66af:b1f7 with SMTP id
 b30-20020a170906729e00b0094f66afb1f7mr10353306ejl.1.1685369620628; Mon, 29
 May 2023 07:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4464371bc72147e10a392a1873466c8df033039c.1685341309.git.christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 29 May 2023 16:13:25 +0200
Message-ID: <CAJZ5v0g2=iYThmRzJXofUXSMrVPM-T2Ck8-HxiS=2_cn3Hv52g@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Slightly simplify an error message in acpi_ds_result_push()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 8:31 AM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> 'object' is known to be NULL at this point. There is little value to log
> it twice in the error message.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

ACPICA changes require (at least) a pull request submitted to the
upstream ACPICA project on GitHub.

If you have submitted one, please resend the Linux patch with a Link
tag pointing to the corresponding upstream ACPICA pull request.

Thanks!

> ---
>  drivers/acpi/acpica/dswstate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/dswstate.c b/drivers/acpi/acpica/dswstate.c
> index d3841ded3a81..75338a13c802 100644
> --- a/drivers/acpi/acpica/dswstate.c
> +++ b/drivers/acpi/acpica/dswstate.c
> @@ -146,8 +146,8 @@ acpi_ds_result_push(union acpi_operand_object *object,
>
>         if (!object) {
>                 ACPI_ERROR((AE_INFO,
> -                           "Null Object! Obj=%p State=%p Num=%u",
> -                           object, walk_state, walk_state->result_count));
> +                           "Null Object! State=%p Num=%u",
> +                           walk_state, walk_state->result_count));
>                 return (AE_BAD_PARAMETER);
>         }
>
> --
> 2.34.1
>
