Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1226694C0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjBMQJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjBMQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:09:27 -0500
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A262358F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:09:26 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id p26so33044190ejx.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:09:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEMTmhutwyOZSyLGCOvOE6wJmj4JCra/dtNp3LlVOqc=;
        b=zrIc/KjNMCTPqC+r9RR4dziGkTJuxvfbUN7zzzgfXYBe7Tn835vxHb1vs6jb4a4UIa
         z9xUvVlVdFw1ohDkL8h6UgzLu4ThKAKd+zlwTW9/ik5og0DIg6y0ZqtpZFzPiQnUWgae
         NA/D07pzPBWuwVVwf2GSaysuj0qKoRWENbaZaOoKG0IRAH37RByznveaZb9rRmHs7fAT
         y6oRE2NOYiS9mq+WXvaLli8DwngC6CjvfkpiqbF/g4MuMjjZtcgysj2H3BsaGH2cZZ3M
         SugndkvtHHi56XOKRz3E636i1S4R4lGe76b2DpDrkZbS61FD0xeVQEqAp9YFu37xZCqs
         FA/A==
X-Gm-Message-State: AO0yUKVqOQkTZgiJVaK1wM/+rN7nb+OYgUgJCIAVvQ7SZ3TY7YP1YUqa
        o2ov9oDXwuCZLjBtthYtj60gvEKWXPfkpbNbFG473rmMKnc=
X-Google-Smtp-Source: AK7set+GPr3+X8peQ2FGBrLnuDPruO89AgYTi421eRc1t/pFJMKB1L8Lo+NU6+MRCRoHPGsZXjB+V2PGVv4D+BnvCMU=
X-Received: by 2002:a17:906:c1ca:b0:877:747d:1108 with SMTP id
 bw10-20020a170906c1ca00b00877747d1108mr4852266ejb.5.1676304564994; Mon, 13
 Feb 2023 08:09:24 -0800 (PST)
MIME-Version: 1.0
References: <20230210091318.733561-1-gregkh@linuxfoundation.org>
In-Reply-To: <20230210091318.733561-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 17:09:13 +0100
Message-ID: <CAJZ5v0g1u6_1zg_akBTLz10sTPM+QTj07Vaz+UbTOMStU4X+hA@mail.gmail.com>
Subject: Re: [PATCH] driver core: bus: update my copyright notice
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Fri, Feb 10, 2023 at 10:13 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> There's been some work done recently to the drivers/base/bus.c file so
> update the copyright notice in it to make those who track those types of
> things have an easier job.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

LGTM:

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/bus.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index 301b9c6ece86..4ec6cfb5893c 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -6,6 +6,7 @@
>   * Copyright (c) 2002-3 Open Source Development Labs
>   * Copyright (c) 2007 Greg Kroah-Hartman <gregkh@suse.de>
>   * Copyright (c) 2007 Novell Inc.
> + * Copyright (c) 2023 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>   */
>
>  #include <linux/async.h>
> --
> 2.39.1
>
