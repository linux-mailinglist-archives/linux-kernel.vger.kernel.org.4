Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F2861F9D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiKGQb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiKGQbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:31:08 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A69186F4;
        Mon,  7 Nov 2022 08:29:24 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id h10so8433031qvq.7;
        Mon, 07 Nov 2022 08:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YEc3usL0SOCpbLQAMpl5fpIatVF66Yy+jDo/lKFgyXg=;
        b=AiFkhByMh2i6qClBYqwJJ0tN4df9VuZqYk07anv1XZYr5RPaSa9+7+j1qsY9DrBdLa
         8kku6dDUQ+E/lZFNX3kog+h8zJXNsmBH9PMirIhOgRnMTOZnPQlWOMR+JGxJNeeGs0UL
         R2cDDQCwcwXfbtNMdWQv39zcyhLOTIQOqjWUwkTO0QmUUBUPEHXlAQlCRvLbYQDnp4kl
         FviPhTH8QYRmEK/I3Nt8iWrhNw5fJCs0/uBf1vN4dFW2WHdj5ahUH/UBMbj0GLghP5Y3
         QLNpWFT0PVEIouHt1d0FJlqfncJ3dQChLw49dxfNfJks5NsXNiN97MxhyxjIUU+vWD69
         zJBw==
X-Gm-Message-State: ACrzQf3NGC8eC47DlZx/It6mldGF39rCHU/YHYsYGw0OE8qfpvSPmPLB
        wp95tXFZIeIXb9RX5UDqOmk9dTL/DCtmsA==
X-Google-Smtp-Source: AMsMyM4norfRd0EXjGE+I92QBBacm0cRwN5+FBuKAh/Yacf5GY5K7VWvsWNgpLnpOPK0tPCjXgajqA==
X-Received: by 2002:a05:6214:212e:b0:4b8:56d2:d0f5 with SMTP id r14-20020a056214212e00b004b856d2d0f5mr45326888qvc.4.1667838563602;
        Mon, 07 Nov 2022 08:29:23 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id fw9-20020a05622a4a8900b003a56d82fd8csm6273907qtb.91.2022.11.07.08.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:29:23 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-333a4a5d495so109278607b3.10;
        Mon, 07 Nov 2022 08:29:23 -0800 (PST)
X-Received: by 2002:a81:12c8:0:b0:36a:bd6b:92fb with SMTP id
 191-20020a8112c8000000b0036abd6b92fbmr46909366yws.316.1667838563156; Mon, 07
 Nov 2022 08:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com> <20221103205546.24836-3-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221103205546.24836-3-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 7 Nov 2022 17:29:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWcQToxLX1g3OsHpFpahk1ES+9eO92X8oQvGrWP=b-nLQ@mail.gmail.com>
Message-ID: <CAMuHMdWcQToxLX1g3OsHpFpahk1ES+9eO92X8oQvGrWP=b-nLQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm64: dts: renesas: r8a779g0: Add TMU nodes
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Nov 3, 2022 at 9:55 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
