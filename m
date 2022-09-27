Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFA05EC6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiI0OyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiI0Oxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:53:35 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19356B2879;
        Tue, 27 Sep 2022 07:51:43 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id d17so6129572qko.13;
        Tue, 27 Sep 2022 07:51:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=mcmbFJNhtLAll3ZUzfvL0JQzBR7USTKl9MyorTFZA2I=;
        b=hhFfg7bOv3JPslW1Lywu+O8oTyDgVOQCY5qVPXRsS9VpvlPjp/iTwXpKvD6Ikcmaow
         qcLxhuBfgeWQkkl2foGPoc+KCENuRkl6x2F4Q5f+FxQbN4Fu83jlcMSQL2jl8p/1yZEy
         YZpNSo18W3geSPaKa5dcrWLuAN3xF03yb0f5HiD/Yli4hvC4X/mykSr5eR9IR3KveeQR
         CIUmCcBFP4hAaURdtX5c4dTDQAvxWKYrZ+jEIODDBrM7LJDbJpKMZBv9qxNS3WxWnss6
         XCSUGpq5kLF1geN05dHwgyGOS9E3jtZ9An7Xjb/oAz7/oJSmqRXIf5Sb4p1Dawwye9oC
         coyQ==
X-Gm-Message-State: ACrzQf22z9TCeUcKaZmRbHgX16/fDQX/B4YW+2gJoU0EqPT5IsN9gQ0s
        wkdVqEHBMMj2cQnyhzIxrvwiWZOKGIdPKg==
X-Google-Smtp-Source: AMsMyM6/pxbBc1bUGqW3NPrX+YQPSp8U9WLoUPyw1jXSb0XeV2JDLwmCz7a4ZiHoljcQ1NIphTp+Pg==
X-Received: by 2002:a05:620a:158d:b0:6cd:efb1:8eb6 with SMTP id d13-20020a05620a158d00b006cdefb18eb6mr17736313qkk.185.1664290302541;
        Tue, 27 Sep 2022 07:51:42 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id d22-20020ac81196000000b0035d453b8c57sm963061qtj.11.2022.09.27.07.51.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:51:42 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id c9so12527266ybf.5;
        Tue, 27 Sep 2022 07:51:41 -0700 (PDT)
X-Received: by 2002:a5b:506:0:b0:6af:ffac:4459 with SMTP id
 o6-20020a5b0506000000b006afffac4459mr23972953ybp.365.1664290301712; Tue, 27
 Sep 2022 07:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com> <20220926230438.GA3128861-robh@kernel.org>
 <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
In-Reply-To: <cbe89899-7f56-c43a-f8c9-887825fbe4a6@amd.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Sep 2022 16:51:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
Message-ID: <CAMuHMdUuzrdf4rmD3n_-S9ujrfmY5Y6VOsNapiLRR5MG9bKAjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
To:     Michal Simek <michal.simek@amd.com>
Cc:     Rob Herring <robh@kernel.org>,
        Alex Helms <alexander.helms.jy@renesas.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
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

Hi Michal,

On Tue, Sep 27, 2022 at 4:10 PM Michal Simek <michal.simek@amd.com> wrote:
> On 9/27/22 01:04, Rob Herring wrote:
> > On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
> >> Add dt bindings for the Renesas ProXO oscillator.
> >>
> >> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>

> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml

> Driver is also using clock-output-names which is not listed here.

... which is deprecated, and thus should not be used by the driver
at all.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
