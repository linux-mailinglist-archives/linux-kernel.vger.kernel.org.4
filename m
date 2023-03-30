Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71376CFF6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjC3JCh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Mar 2023 05:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjC3JCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:02:35 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51372717;
        Thu, 30 Mar 2023 02:02:33 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-536af432ee5so343191357b3.0;
        Thu, 30 Mar 2023 02:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680166953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqG2Z6d0Pb8iORwk+e3Ro79KtXr2omWNescegmF+Vgw=;
        b=bpwrZNIOp165hWwL3+FCbghUFU358553YFUquIAKZ9AaV6sQDGDDhXPyg/TPOpeUUJ
         04P89k2MXfVCm3+lowyRNpNoNLggxEcP2OhAHGcoFi2DcUsuD8Q5kfcqhaORZUHxibU4
         NIdKnZdSoolhNuIdDfraLLOTtSxR+mN4TAjeSmzTYTjlNo1aAaoBcR54zv2cxJOS9nzG
         dyYMrWZVUaLLSb9G9kaYOOiZHgWN47wqnuYoOrXxXKOQSbUkak0Ck+lAai4yi467WPKg
         IJV9txCfUZ7RHSuSpmk/w3BprvK1IV10OjsNaFbG0xdsZ965s/29J06cgeMWVhi2Hrwi
         Bq+Q==
X-Gm-Message-State: AAQBX9ezbwZZQqSdG7JzwVtIwn0hJ9lNS+cKwz8aDak9BnpRRIDsrzYl
        9pAWELRQ9TduZefguPtG7Ql6DqdMTgrLcw==
X-Google-Smtp-Source: AKy350aff33rXZwWHf0szL4sARp1j7U9xYXErkrMEc3O4TZfMxBUW2La7aVfSGNjyEmDESdz5Lk7dA==
X-Received: by 2002:a0d:d7c4:0:b0:545:b05f:6722 with SMTP id z187-20020a0dd7c4000000b00545b05f6722mr20490288ywd.10.1680166952840;
        Thu, 30 Mar 2023 02:02:32 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id cp33-20020a05690c0e2100b00545a08184c6sm3440426ywb.86.2023.03.30.02.02.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:02:32 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5419d4c340aso342023437b3.11;
        Thu, 30 Mar 2023 02:02:32 -0700 (PDT)
X-Received: by 2002:a81:7e10:0:b0:52f:184a:da09 with SMTP id
 o16-20020a817e10000000b0052f184ada09mr2923082ywn.2.1680166952237; Thu, 30 Mar
 2023 02:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230122121129.28699-1-krzysztof.kozlowski@linaro.org>
 <CAMuHMdXdZbJDTOzQG4=pRpR1OCU0=RTDZDH0MnPW8Ea2LJKs6A@mail.gmail.com> <082ab65b-09d3-e899-ef46-7fe04446109f@kernel.org>
In-Reply-To: <082ab65b-09d3-e899-ef46-7fe04446109f@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 30 Mar 2023 11:02:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf=X2eGpa9P0OF34b8yA8vrx_nFqW+P+Odu5S7P1xeng@mail.gmail.com>
Message-ID: <CAMuHMdUf=X2eGpa9P0OF34b8yA8vrx_nFqW+P+Odu5S7P1xeng@mail.gmail.com>
Subject: Re: [GIT PULL] memory: drivers for v6.3
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Jan 23, 2023 at 11:47 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> BTW, you might want to add separate Renesas RPC IF maintainer entry or
> include it also in Renesas SoC. Otherwise you don't get CC on it.

FYI, that should be taken care of for all DT-based drivers for Renesas
on-SoC peripherals by
https://lore.kernel.org/linux-renesas-soc/c1be1e97c5457eade25b0eb5118196677cecfc08.1679039809.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
