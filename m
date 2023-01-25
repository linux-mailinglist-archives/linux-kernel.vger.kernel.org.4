Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA167B306
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbjAYNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjAYNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:11:12 -0500
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE548A39;
        Wed, 25 Jan 2023 05:10:53 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id 123so22889032ybv.6;
        Wed, 25 Jan 2023 05:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIDMaIN8cgxQOc8iSe6fxRwjh9fZ0t6b2cc0/2RHXF4=;
        b=vpD5Qsn5apYi5uUM3jKMtO9215TRUhXiUFoNInZ2NElmQZm5gY/ae8xUyH+R/xLqyV
         N4cO5CNQUTFtc6darP1chKmDMyL0xWmYL+otMF3Zmy3ZtSnj5A02gMBrQJag0C8L8hyB
         OtHsMm2USZegpQuehTDPvdlLJmwBIfGnp4ttlihRUHGk9B4PhSN8+/ieiF0fl/XnEMiK
         UrlkWiJ6SCGC4CCrUQEQCWbzIASwrcTSykKHWv4belnCeEVS/0u0GB2/3OvGRadDp3xi
         Aud9HKc83DO0NWiMdPU1guHsiV6YYKT89m2HpsnmOathzZAKUUrGebG1tZ5WmKcoM8Cv
         7nDQ==
X-Gm-Message-State: AFqh2kpO25JIVGUG6eynsPAf7JgwZbtT3ma+VQ3VlGQzJKt3VC3WsRU8
        x3fIpK/4qzWc8vjNCImNbHVuZzLUTNbyWA==
X-Google-Smtp-Source: AMrXdXuvCZlmN9DagQp2z+22LovSX0zO6Ix6hrWGRaeaLeA1b5H6zyfrvOpEKjafpCeFNrOVNm5rxw==
X-Received: by 2002:a25:cdc6:0:b0:7c0:3ecf:2672 with SMTP id d189-20020a25cdc6000000b007c03ecf2672mr21620663ybf.40.1674652252333;
        Wed, 25 Jan 2023 05:10:52 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 196-20020a3708cd000000b006fcab4da037sm3505201qki.39.2023.01.25.05.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 05:10:51 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id 123so22888962ybv.6;
        Wed, 25 Jan 2023 05:10:51 -0800 (PST)
X-Received: by 2002:a25:37d4:0:b0:80b:8602:f3fe with SMTP id
 e203-20020a2537d4000000b0080b8602f3femr591237yba.36.1674652251381; Wed, 25
 Jan 2023 05:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20230117232609.477247-1-aford173@gmail.com>
In-Reply-To: <20230117232609.477247-1-aford173@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 25 Jan 2023 14:10:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtc7N45CV=U2BVWb60Xe2hCwA0ZeT3RQPsmayNfOJZNw@mail.gmail.com>
Message-ID: <CAMuHMdUtc7N45CV=U2BVWb60Xe2hCwA0ZeT3RQPsmayNfOJZNw@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: r8a774b1-beacon-rzg2n-kit: Sync aliases
 with rz/g2m
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-renesas-soc@vger.kernel.org, aford@beaconembedded.com,
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

On Wed, Jan 18, 2023 at 1:15 AM Adam Ford <aford173@gmail.com> wrote:
> The Beacon Embedded RZ/G2[MNH] boards all have the same baseboard
> and all share the same PCB.  To make sure all instances appear
> the same, make the aliases for RZ/G2N match the RZ/G2M to
> keep them consistent.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
