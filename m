Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD8F6615F9
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbjAHO5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjAHO47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:56:59 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F246B1EF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:56:58 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-4c131bede4bso83069577b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k1MT1NvPYIMo2ZLTevFHd6y8JlHD8c2n6t4NL4C3qiU=;
        b=IimKZGzjyBN/IwOImMFxy1qcpmN2ljyL4mJlQCpNZ6v5qsZm2GJrr32BWkqwcXnDnK
         1WOMFIETP9sf3wyDw1+gg3MUaMTOYH4DaPU7wV+lrHTeAMSzgmf+1j/aXGmdTKiBYNt5
         pVMIzTlDf4uuvhlWUDRcnIwJCO01Z28NKldlJSMflgqziCSE891imj6WvK+k6AMgPNZu
         gXc9wvPKzyGkf/AP/oPnN/Y8sZwOrrw987phYcm8qNtWQ824J0odQW3AX2BTOuDZLvpO
         p2TbKvxGvLRFw2QaTyk7VVaRfFduZSaOqCX9eL1V6TnqVIvPyNmu4M/AKRHmFvwmf8DB
         oA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1MT1NvPYIMo2ZLTevFHd6y8JlHD8c2n6t4NL4C3qiU=;
        b=HTm07hctvBE4hcvB3YEZNQnm3b1+q02V7BwH2sILZeeEcANZkcG3SDrDM6IJ3RVDEi
         gIN32bpYBdDlii8bnZz2c6ky6Xmq7x1xttpgAsceBelVa2p7cB07scZ9tpNlPemYByWm
         9KO3T+vSxVkmo6fpTbmFXduVh7bk1LCruZzE+GF8bfLm2S3pym+7RbvPlFmlbE2SeRCX
         wXF2ZysV8XdSXJwfpz8MMMkIyPNV4Q8/XU+H2oegxVQYJrADtuQ+Ji03+G25gYcr4GHf
         sx1hE2gsYSfdXeuggeBh5DEz569Lc4FWFLCsbgyv0GWYFxZrq7UlJ6kMIzxo1QaKaHox
         L/8Q==
X-Gm-Message-State: AFqh2kqtWipjBRJXqAPc/Ra7OEdbFZl/OgFjK/+7oIdI5S+WiqgX9M16
        zXuYhV29jGvx6kgtAQvnVrHjBgCt06aV8sEeusV/fNZ/ptgGL8rMvVacAg==
X-Google-Smtp-Source: AMrXdXuxB5WtL24kqAClguCBU3C9rzgkYpBE0NlO0uD34yj/r6j2lEOVvTXbXMepjjdJ0pc1jRTo7vyx7UuBve6typ4=
X-Received: by 2002:a81:91d2:0:b0:3b6:bbd4:2769 with SMTP id
 i201-20020a8191d2000000b003b6bbd42769mr1127812ywg.5.1673189817873; Sun, 08
 Jan 2023 06:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20230106143002.1434266-1-steve@sk2.org> <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
In-Reply-To: <CAMuHMdWvOx+K+eQfpC-t2jfkVTQOa+SBorwi=LKmUdW7VPwjig@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 15:56:46 +0100
Message-ID: <CANiq72nnyxq_JhCETL+v1zQuU=HHjsS66Lt=0bzQ6Xy6CPKN2Q@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: ht16k33: Use backlight helper
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Kitt <steve@sk2.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
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

On Sun, Jan 8, 2023 at 11:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

This will likely go through drm-misc as part of a bigger series:

    https://lore.kernel.org/lkml/20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org/

So you may want to copy-paste your tag there.

Cheers,
Miguel
