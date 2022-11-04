Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DB561961F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 13:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbiKDMVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 08:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiKDMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 08:21:17 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12321FFBC;
        Fri,  4 Nov 2022 05:21:15 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id f8so2907480qkg.3;
        Fri, 04 Nov 2022 05:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MpOBZFHbb5n86fo/L37mcIC77vG4ouciWdT84I9gcW4=;
        b=usoqyl0Fswti9IMLxd6W6eq5sbA7Bl80cvqOLGkijkWFS2+jpNjQrMr/H3FtwNh8qE
         z9sx1671tFAHFngC+NEl0jenHi7ZFzafYfGxfE1R8kA0ffdsoW+2f/EwZDyXZPIZMcC3
         Da55NfF/epeEeyIxhzo9Ejy7y3lHVnUWY2/K0uxTZAyC1WW7UZHRs4mfESD9eTeVe5sQ
         FM9nPKjAoMkzG4OZHIcF4lDGlezj1kOKbdblYZEq6vGPu753tAm9jl+Go9aF0MdatUGj
         zK+GW+c3d/DPsCxe7ZQbAmoanc91QyNMmCMgGf27r6stBLDB4JgSILyjrywC3Pqty3GY
         fueA==
X-Gm-Message-State: ACrzQf1jC8doy0MAmKelhYhlfgTLW4v+JH5OunXjltD8/Ey96NEa28qb
        3gqeyVu3K0m9ihdwqwUf53nD8/bcOmsJ9g==
X-Google-Smtp-Source: AMsMyM6Tc3dneT99Wm55yxEyoppMN0GVPVmVf3jHJqAqDPQ1YkdwUStg7MvaVUWXmRGfVnIWp93EFw==
X-Received: by 2002:ae9:e902:0:b0:6fa:8e2c:6c33 with SMTP id x2-20020ae9e902000000b006fa8e2c6c33mr1954998qkf.664.1667564474809;
        Fri, 04 Nov 2022 05:21:14 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id e15-20020ac845cf000000b003995f6513b9sm2305584qto.95.2022.11.04.05.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 05:21:14 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id j130so5568471ybj.9;
        Fri, 04 Nov 2022 05:21:14 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr22021198ybc.89.1667564474153; Fri, 04
 Nov 2022 05:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com>
 <20221103205546.24836-4-wsa+renesas@sang-engineering.com> <7cfe285d-eb82-1840-0149-b5b77f2beaae@linaro.org>
 <Y2T0MT2mZ5kghUQ1@shikoro>
In-Reply-To: <Y2T0MT2mZ5kghUQ1@shikoro>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Nov 2022 13:21:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXd1B=BbePp9X21ptUbr9tp9Qz4JPYBbvzCVtRjN+A97w@mail.gmail.com>
Message-ID: <CAMuHMdXd1B=BbePp9X21ptUbr9tp9Qz4JPYBbvzCVtRjN+A97w@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: white-hawk-cpu: sort RWDT entry correctly
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Wolfram,

On Fri, Nov 4, 2022 at 12:15 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > But I doubt that there is a bug here. Style (like order of things) is
> > not a bug.
>
> Okay, I'll be more strict next time. Geert, could you kindly drop the
> Fixes tag or shall I resend?

Consider it done, no need to resend.
BTW, I guess the stable machinery will pick it up anyway...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
