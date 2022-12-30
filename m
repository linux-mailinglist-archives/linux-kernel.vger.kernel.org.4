Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB7C659B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 18:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235333AbiL3R5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 12:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiL3R5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 12:57:43 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A0D13EA5;
        Fri, 30 Dec 2022 09:57:42 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id z126so454984iof.13;
        Fri, 30 Dec 2022 09:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xYLCtR4Ac/mmtjLztahxRbwbCAFgfHsW5daj12ij5RA=;
        b=V8T+/EEYEwuCkz7h53sTqBc8E1DO+Rme68TS12LpCIFu/enWbryQE8hfwekOBqyWva
         UQA+N+mkyUGhoQqyZ+RWeOrlrlZs3VLhn/OU56rz5VQ/bv6g8NBZFK7zuKaZxEN0r/hW
         KMtE7dh7jCh7GLQwrsgUNHYqdL/ZcpEeovaJUKVjScmaDS5YZJCfyEi6Rf9WlMa3DmRY
         PxCmb72HhPEqklidnnKYhCRu6BtlcGe+2t7LnQoNn0DFgavFaqFU0+H9/K2Xe6zLTbe1
         fON/eugttYysmgIXZS+S8hO4R2nPS6GZkuSZ/VKOVcLWW1xSgPiCvl9Zh0RkyNIeOmM6
         BlUA==
X-Gm-Message-State: AFqh2kqROBIHyNjuq3V4dUGIHw2FutGtvUS1iCPJ3/qmDHzUWcDkqqAK
        ipJd7l2x+N449xYbBZ2DqaXKkE77gtowLGdxR7ybM9kc
X-Google-Smtp-Source: AMrXdXvY94uZ+vNRb5PI3DZIxepz9jpGvSzPKMsyDggCHLEBeaJapPt2ChH/9zMDs12vNv/fWuy1EGkHdtANsmcBC5M=
X-Received: by 2002:a02:9707:0:b0:396:2348:340e with SMTP id
 x7-20020a029707000000b003962348340emr3056256jai.195.1672423062302; Fri, 30
 Dec 2022 09:57:42 -0800 (PST)
MIME-Version: 1.0
References: <20221223090215.8704-1-zhoujie@nfschina.com>
In-Reply-To: <20221223090215.8704-1-zhoujie@nfschina.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 30 Dec 2022 18:57:30 +0100
Message-ID: <CAJZ5v0i6F5XMSfSoP6_meZhvh1JeNTx8CO+mukf7qPRxx2DeqA@mail.gmail.com>
Subject: Re: [PATCH] drivers/acpi:remove unnecessary (void*) conversions
To:     Zhou jie <zhoujie@nfschina.com>
Cc:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel.nfschina.com@lists.nfsmail.com
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

On Fri, Dec 23, 2022 at 10:02 AM Zhou jie <zhoujie@nfschina.com> wrote:
>
> The void * type pointer does not need to be cast.
>
> Signed-off-by: Zhou jie <zhoujie@nfschina.com>
> ---
>  drivers/acpi/processor_idle.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 4556c86c3465..3be86d2f9098 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -150,7 +150,7 @@ static void lapic_timer_check_state(int state, struct acpi_processor *pr,
>
>  static void __lapic_timer_propagate_broadcast(void *arg)
>  {
> -       struct acpi_processor *pr = (struct acpi_processor *) arg;
> +       struct acpi_processor *pr = arg;
>
>         if (pr->power.timer_broadcast_on_state < INT_MAX)
>                 tick_broadcast_enable();
> --

Applied as 6.3 material with some edits in the subject and changelog, thanks!
