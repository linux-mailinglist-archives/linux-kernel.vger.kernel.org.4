Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A323E7502BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbjGLJTJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Jul 2023 05:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjGLJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:19:00 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856EB1992;
        Wed, 12 Jul 2023 02:18:50 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-bff27026cb0so7556505276.1;
        Wed, 12 Jul 2023 02:18:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689153529; x=1691745529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kG5q3OE8NA2B1Rd9ySf5DoQyHhC234Q++094p9pDpiY=;
        b=RbH09Fh2Rwv6i44q4mz6r0oVcyoQAmM6oNtMIiFFXM8FMEcgMyskmz3Tm5oe9glduN
         IqWw9q6resuXdGdh7FPxWvhQtE2Hs4MEydHvfXDgG8zLVIs1CgOb7B2IIV26ZctgKQkv
         Z/4OjJM9oki+AhQl/1RlqwpTeqcT0un2SuAH/WoZtgjFJcjDLMAxr7Ybtl6078Lw4/nd
         3Np3WUiMX/xJ2/zmiRoKAICGUu8Kk/VWWlEeR9GIhkDESuOFtdEcLkUPRtB5KHClxI+I
         wrmdMjGQQa9/MD/jfjOMmztwvesyEbo4//amxwm9GOqJmSVH33YofGzA3rmvlCLFhE8A
         yP+Q==
X-Gm-Message-State: ABy/qLYyo+pKia4zmRJtKbiKpbRDGeTjaZQM1Sme2lFJVvnNv9q+Q4s2
        FvTaG3BUvfcp7b245UM0zgwDilsuURGXCQ==
X-Google-Smtp-Source: APBJJlGSFjNRvHJZkkk5bVWMKipJUpBqL7O06x8V3NpRJN+bkNydqcdBtcR9WubwFNCK3NzcOaMKcw==
X-Received: by 2002:a25:cd85:0:b0:c60:fb80:99f7 with SMTP id d127-20020a25cd85000000b00c60fb8099f7mr15710840ybf.16.1689153529555;
        Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id w8-20020a253008000000b00be4f34d419asm860867ybw.37.2023.07.12.02.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c84fd44593aso3341486276.0;
        Wed, 12 Jul 2023 02:18:49 -0700 (PDT)
X-Received: by 2002:a25:748e:0:b0:c69:b15:3e79 with SMTP id
 p136-20020a25748e000000b00c690b153e79mr17478596ybc.28.1689153528941; Wed, 12
 Jul 2023 02:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
In-Reply-To: <20230707074337.3120530-1-quic_rohkumar@quicinc.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 12 Jul 2023 11:18:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
Message-ID: <CAMuHMdXRt_9BzfnaqVJUAS4QdvGBDZk3B+R_cERUykZhyNWtzQ@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: Update maintainer email id
To:     Rohit kumar <quic_rohkumar@quicinc.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        cychiang@chromium.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

Hi Rohit,

Thanks for your patch!

On Fri, Jul 7, 2023 at 9:49 AM Rohit kumar <quic_rohkumar@quicinc.com> wrote:
> [PATCH v2] ASoC: dt-bindings: Update maintainer email id

Thank you for stepping forward to become a maintainer for all ASoC
DT bindings ;-)

> Updated my mail id to latest quicinc id.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Rohit kumar <quic_rohkumar@quicinc.com>
> ---
> v2: Updated commit header
>
>  .../devicetree/bindings/sound/google,sc7180-trogdor.yaml        | 2 +-
>  Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml     | 2 +-

Oh wait, this is not for all of ASoC...

Please use one-line summaries that reflect the actual changes.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
