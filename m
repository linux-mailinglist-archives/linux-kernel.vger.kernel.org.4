Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84816C6484
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 11:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCWKO2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjCWKOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:14:25 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFE5193F3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:14:22 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id n2so25955140qtp.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566461;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQfQAaEd8e3pdT6SieYAlbXKlZL1zLEjWeZ5UGtmAuM=;
        b=c3xSH/CuT9RTEeM2+ghJ9bdOvDQduZ5JCFZJYLtmgaG4TpRagzKJgsXKMHgWHOL+sy
         XG7R1CTX+469ylvYAhcOByPEH8U8RuENW15HJGoWUa1RhlGHCfgFAwiwasvGaiJg2NdS
         YCPJhbYLnG2F3R6Cu3eb1iHg+S+7sbhhzr+bm1GIUxwJtjhoIgqK7HIzttqoVovx7LaC
         OhvCcivL+aQ4hLO80e0Wytq/Z5+gYgHEzJ2D661Ax0pJTReSJ9sZv6oO9BG8S7EA1aMh
         Iin5RS6u1KfEY2bA8MX6FLAc82+WvqkppAouh0fEhGGlhDNrAsM0mVvu5JH9Pt5HzyrF
         /VLg==
X-Gm-Message-State: AO0yUKV2fWEcZYffJ7KqPjnojfLpzppdhV/i8lXsDc9jCCGSPCbCNMgz
        QX+GzGoFAFZo4SjUGms1GtZlpbyZMs2XrA==
X-Google-Smtp-Source: AK7set82fCaVxPr4oRr4wAJGaANjkge2nWoPOHsPT5QIaTMKrS5F31T44yfNK1kv4GVrGfRBZcJkWA==
X-Received: by 2002:a05:622a:1a98:b0:3e3:7c78:9ec4 with SMTP id s24-20020a05622a1a9800b003e37c789ec4mr11230291qtc.21.1679566461066;
        Thu, 23 Mar 2023 03:14:21 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id d184-20020a3768c1000000b0074688c36facsm7490907qkc.56.2023.03.23.03.14.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 03:14:20 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-536af432ee5so387391717b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 03:14:20 -0700 (PDT)
X-Received: by 2002:a81:b149:0:b0:544:bb1e:f9cf with SMTP id
 p70-20020a81b149000000b00544bb1ef9cfmr1602754ywh.4.1679566459959; Thu, 23 Mar
 2023 03:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230323100624.337354-1-b-kapoor@ti.com>
In-Reply-To: <20230323100624.337354-1-b-kapoor@ti.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 11:14:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWF0yGwM5hk=o+te2fPw-G8XhGZ6TGfF-KvnVnasPjKNQ@mail.gmail.com>
Message-ID: <CAMuHMdWF0yGwM5hk=o+te2fPw-G8XhGZ6TGfF-KvnVnasPjKNQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable CAN PHY transceiver driver
To:     Bhavya Kapoor <b-kapoor@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        quic_bjorande@quicinc.com, dmitry.baryshkov@linaro.org,
        arnd@arndb.de, krzysztof.kozlowski@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org, rafal@milecki.pl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya,

On Thu, Mar 23, 2023 at 11:06 AM Bhavya Kapoor <b-kapoor@ti.com> wrote:
> Enable CAN PHY transceiver driver to be built as a module.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>

Thanks for your patch!
(I wanted to send a similar patch soon ;-)

> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -368,6 +368,7 @@ CONFIG_REALTEK_PHY=y
>  CONFIG_ROCKCHIP_PHY=y
>  CONFIG_DP83867_PHY=y
>  CONFIG_VITESSE_PHY=y
> +CONFIG_PHY_CAN_TRANSCEIVER=m

This doesn't look like the right spot to insert this?

Based on "make savedefconfig", I'd say:

     CONFIG_PHY_XGENE=y
   +CONFIG_PHY_CAN_TRANSCEIVER=m
     CONFIG_PHY_SUN4I_USB=y

>  CONFIG_CAN_FLEXCAN=m
>  CONFIG_CAN_RCAR=m
>  CONFIG_CAN_RCAR_CANFD=m
> --
> 2.34.1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
