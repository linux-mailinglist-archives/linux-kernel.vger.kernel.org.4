Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDFD6E40E9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbjDQH3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 03:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjDQH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:22 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4071A49EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:00 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-54c12009c30so515223617b3.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716539; x=1684308539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnMtUDlq18qCzE4nMfxBUChC3EigpjNhzosV0xBwPc0=;
        b=PYTZKHXByDZBabU1DPqYqlu69YMCUJy/mbZTHBPScBkZlyqVoI88rNEK3wxEWis5ms
         Wpifn/hR/tZYwg1KCM6nGop+JI/0nSd4/lypY//ECsyA8STgf7W/psgwGX5rKHOl2MP4
         Ea0lK8eTOqhHg+Zvv5tGVKytMZ7J/5GPA1cYBnFgCm1JEdNbWks6nv6QWMiCQsrTssI2
         1X73hY/Hkhb/AvoSa1dZJne2fXzwdEbVxkXAs8oi3jzjaSYiDtFfkj/39PBqm91i4xUl
         rQ22P8HY+yhnnWRs5Hc8+UIz1EKqqNwnPeIRGctMgaedx9XMfCF0KSKCXRzwGaNi86Kf
         5pCg==
X-Gm-Message-State: AAQBX9d/4MtD/bRiBZa8CPdaMqsvMTRxsVXLzNB+01XOhCJ3Z8i4iXCu
        Yc9TtnlIw4IoVGAWyYGksb3J+sq41+ovYA==
X-Google-Smtp-Source: AKy350ZZFBoS/arZ5Z0DINPMGUfdcLAaV8NRsY7GfI0kKkp0bt/xw95M7EzbwlZz2gyvVVrA5Ni7RQ==
X-Received: by 2002:a0d:ea56:0:b0:54f:b87e:7e4c with SMTP id t83-20020a0dea56000000b0054fb87e7e4cmr14272935ywe.36.1681716539005;
        Mon, 17 Apr 2023 00:28:59 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id 62-20020a811741000000b0054605c23114sm2929229ywx.66.2023.04.17.00.28.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 00:28:58 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5491fa028adso731562817b3.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:28:58 -0700 (PDT)
X-Received: by 2002:a81:b71c:0:b0:54f:b931:adf7 with SMTP id
 v28-20020a81b71c000000b0054fb931adf7mr9321539ywh.4.1681716538192; Mon, 17 Apr
 2023 00:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230412183834.3769519-1-j.neuschaefer@gmx.net> <CAMuHMdVdJooFiLfttxeRVZO_0doWiurwg3ZkxEbyO7D8eaDeKw@mail.gmail.com>
In-Reply-To: <CAMuHMdVdJooFiLfttxeRVZO_0doWiurwg3ZkxEbyO7D8eaDeKw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 17 Apr 2023 09:28:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV_y3ctAWAWSU-PjdE_hwBJjkgwFhpBQ84WFrhcXU8_2Q@mail.gmail.com>
Message-ID: <CAMuHMdV_y3ctAWAWSU-PjdE_hwBJjkgwFhpBQ84WFrhcXU8_2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] soc: nuvoton: Add a menu for Nuvoton SoC drivers
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 9:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Apr 12, 2023 at 8:38 PM Jonathan Neuschäfer
> <j.neuschaefer@gmx.net> wrote:
> > Add a menu "Nuvoton SoC drivers" to make it easier to add other Nuvoton
> > SoC drivers later on and to prevent asking about the Nuvoton WPCM450 SoC
> > driver when configuring a kernel without support for Nuvoton SoCs.
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Link: https://lore.kernel.org/lkml/CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com/
> > Fixes: 77b8c67b5637 ("soc: nuvoton: Add SoC info driver for WPCM450")

This reference is wrong, it should be 7dbb4a38bff3.

> > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
