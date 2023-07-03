Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26E6745B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGCLoH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Jul 2023 07:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGCLoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 07:44:05 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76519EC;
        Mon,  3 Jul 2023 04:44:04 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c2cf4e61bc6so4989971276.3;
        Mon, 03 Jul 2023 04:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688384643; x=1690976643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SaPHjrNNjb65n2ku8Yebhkij9c9u2ekJbgNiYyI6QAg=;
        b=ZKYRUxOYTVKnsL/4T+U1jTRGFNtPUrDY2zxtKYb6rQ5Nni0SooR5d8qdxYxj8BxN+1
         hTQ1C8yxLtogvWapmhkhRHUVFqZ22VsXyWXrAlvOTT1gdbbQ9uOGAqiZiK7ST5G6A9ZR
         mwgudvlFRkL/oRecTfXVbxTNk1su7qQgZtxVXmeVUJmP/ap1eePmBNARn/MYR+QrZbvS
         YwXyWtIfyL/xjea1fsyebyNzLky4xDvEPnGAzu76MGlC9WAxfmMYRvC7DQoztGCUL3gB
         5pqWqswleV+LRtIr5qS9V+jUVYlhCQTVzxysgP1Ah+Npjq4/G1fJFBIGDs/7CbAky806
         voUQ==
X-Gm-Message-State: ABy/qLYfFGr75Vbz9XNgNuh6ELr1DpJyXEKKwmHJNXLghoFn6PRhXysc
        VVw8hoN9P/nd1a37kj350ohMgkyrgHfheQ==
X-Google-Smtp-Source: APBJJlGZcIpqsfOkh094e1NCa8yTu2qj9qTjhVMRX//+8WevoM0R07x+7SAEW5koowQozJEEB25mVg==
X-Received: by 2002:a25:d3c8:0:b0:c10:c7d7:9cf5 with SMTP id e191-20020a25d3c8000000b00c10c7d79cf5mr9815045ybf.27.1688384643526;
        Mon, 03 Jul 2023 04:44:03 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 187-20020a2510c4000000b00bf4d24fd976sm4400428ybq.10.2023.07.03.04.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 04:44:03 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5704ddda6dfso52519117b3.1;
        Mon, 03 Jul 2023 04:44:03 -0700 (PDT)
X-Received: by 2002:a5b:4c3:0:b0:bb3:9ea1:7738 with SMTP id
 u3-20020a5b04c3000000b00bb39ea17738mr9979732ybp.24.1688384643065; Mon, 03 Jul
 2023 04:44:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230702185252.44462-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230702185252.44462-1-krzysztof.kozlowski@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 3 Jul 2023 13:43:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWfQPdPdBT=qEFtZ4awc05syL2FQAn7mXGzQBg2MapQ8A@mail.gmail.com>
Message-ID: <CAMuHMdWfQPdPdBT=qEFtZ4awc05syL2FQAn7mXGzQBg2MapQ8A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: minor whitespace cleanup around '='
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 2, 2023 at 8:52 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> The DTS code coding style expects exactly one space before and after '='
> sign.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.6.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
