Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89A6E7407
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 09:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjDSHan convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Apr 2023 03:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDSHal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 03:30:41 -0400
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E79F6A56;
        Wed, 19 Apr 2023 00:30:40 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id v9so10583520ybm.0;
        Wed, 19 Apr 2023 00:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681889439; x=1684481439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl+9MxhodSkpFbWP32wSe4vQg054/6Au+Xs3Cd4nAXc=;
        b=doRCMM02wgWPxKRXtvtzgVhxiBvc6/InfsCOxZTzgfJgKWCMF5UB+viAOP3rtp7IfN
         TtdfZdH22buLGJ1DXYCNUC4ILOK4hJtTornal/6oUHY6C2/G4PgmkHLfC67XR4HWRZb1
         5yF5APxN7kkpBoYAE6K1CRoBnAk/oRoPBoQPLy7Q/0FirpHcKYMX18AMEABiOsaJZAAr
         3a0cGnTYkn+oklabeQo6NvjUGUnvNBtpQzYyFbQOq8jaPBKo5Zd+7Oe7x4GJrJ3nZqQJ
         nt/Cj8vi7OEZEb6807gTLnAQzX8wtd+GnJ7X6RQoANfK33g2SmH2hxjgd3sn7gJXZOZi
         qKlg==
X-Gm-Message-State: AAQBX9fgG2PEVDn4NXUfb3YVJYZQulqmvm3ROeujnT/956ahrxMxV59W
        DL3/8ehQMNyPwj6PFhGFaqT5fn7TVzNPCzY2
X-Google-Smtp-Source: AKy350Y9cl64N6OSHlLKOVLm8i2Mu1FSTKB4fqQzHaHLIYpchNXCVK867ttAQvA9DEgsJ8bv11eLGQ==
X-Received: by 2002:a05:6902:114d:b0:b8f:36fb:d60e with SMTP id p13-20020a056902114d00b00b8f36fbd60emr25653463ybu.28.1681889439630;
        Wed, 19 Apr 2023 00:30:39 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id a6-20020a259386000000b00b923b9e0a82sm2520936ybm.45.2023.04.19.00.30.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 00:30:38 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-54ee0b73e08so491553547b3.0;
        Wed, 19 Apr 2023 00:30:38 -0700 (PDT)
X-Received: by 2002:a81:7d08:0:b0:551:213:9c24 with SMTP id
 y8-20020a817d08000000b0055102139c24mr2500611ywc.41.1681889438311; Wed, 19 Apr
 2023 00:30:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230419070934.422997-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230419070934.422997-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Apr 2023 09:30:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXx9a9dV4GApYQNMYsTO7E1fGXFr4DFJXKmpYhdNN_fAA@mail.gmail.com>
Message-ID: <CAMuHMdXx9a9dV4GApYQNMYsTO7E1fGXFr4DFJXKmpYhdNN_fAA@mail.gmail.com>
Subject: Re: [PATCH v2] sh: pci: Remove unused variable in SH-7786 PCI Express code
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 9:14 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Addresses the following warning when building sdk7786_defconfig:
>
> arch/sh/drivers/pci/pcie-sh7786.c:34:22: warning: 'dma_pfn_offset' defined but not used [-Wunused-variable]
>    34 | static unsigned long dma_pfn_offset;
>       |                      ^~~~~~~~~~~~~~
>
> Fixes: e0d072782c73 ("dma-mapping: introduce DMA range map, supplanting dma_pfn_offset")
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> ---
> v2:
> - Fix formatting in commit message

My
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
on v1 is still valid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
