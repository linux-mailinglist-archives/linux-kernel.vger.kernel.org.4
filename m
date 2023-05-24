Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2A870F569
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjEXLgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXLgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:36:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30F5194;
        Wed, 24 May 2023 04:36:45 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-970028cfb6cso143723466b.1;
        Wed, 24 May 2023 04:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684928204; x=1687520204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oCm6OKqBd9FZs5dbQajMLTNl/mBBTw3OR4x7693gBrE=;
        b=I4cLiQTIHzZm8sBtmVFsdKbYNOnsZaNirYxqf6IUwmR/TVcrTxYzng5ZcIlrMGi3nJ
         NkK6nRvGj9klSbim8whLvYb4lg+Re/RXvex9vQKI0PHxP3CHoH1IvY4656ENSpmkKITU
         e7MhLmPx7pR3FJ12s2edRbrhtWs3KgNZX0XHKDIYTOaYfI06HSw8kqVCv9+WY7CDShQk
         j/BtXX7LtGKvj+BbfGj4HaOh1vvDZoxhL2KhyW1JVdeZZ6mgB8Adx3wn7rNJjOh2Wqtw
         V4hIa5AUzBdiOnM+BPnzj0UvpdnIs5pGhgDmgFobJO/+VP+p73wJMIGQ9ROnIgid7JXi
         GTUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928204; x=1687520204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oCm6OKqBd9FZs5dbQajMLTNl/mBBTw3OR4x7693gBrE=;
        b=k8NBXteQDXvTGlYqsrTkDUpAH21GRYN4fMzXOqVRCTO+b//13fAOupcWdByNMqDXTv
         ysQTG6jn5Qy65XnyAhLDNTaCyLrgPCmyz4IL4y00pqJxH4BqxKeWxXXCX+B+g57zBPO6
         wSAMjP2EEykWcog9kaOkal8c9ClaDbHGTcLJML2p2kPEOUVbo0Y555ePk4IeY1RTkAkr
         MdfaOmn1wO3C8d1IFYvJ6dq5NxgOi1lKcLzTBkAGtvYIeF/gFb7sflz0ySKHGdOzfwiS
         1LzZvEexQ8BjPSdN7Cjm4xHARngNd1MnIeDd4+l64V/cfM4nfKblMzBj5hSkFfSpvaxW
         D3JQ==
X-Gm-Message-State: AC+VfDy/2/33cWpXMte6+bSu/7jdiWL6uePvesQI2yvNi7/yQtY51DI+
        Kp6yZHfdrseghwP5UkAvi7NDLPF1JaH3UQG1mW4=
X-Google-Smtp-Source: ACHHUZ5GJeAlXBJeAiYbUR3dLRmpJzG6jJfr1vlY311+6DHVApmd/vBenb0CNYBAN8rhGpxSZ6ePzW/DFt2WAMcrqFA=
X-Received: by 2002:a17:907:6ea2:b0:96f:98f1:6512 with SMTP id
 sh34-20020a1709076ea200b0096f98f16512mr15842859ejc.41.1684928203919; Wed, 24
 May 2023 04:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230524082744.3215427-1-bigunclemax@gmail.com> <20230524103431.50c6a2fd@donnerap.cambridge.arm.com>
In-Reply-To: <20230524103431.50c6a2fd@donnerap.cambridge.arm.com>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Wed, 24 May 2023 14:36:28 +0300
Message-ID: <CALHCpMh2sZSCrFMMT13kYbsu+C2bC2xY3coB_fv0mZom_g=oPQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/4] Add support for Allwinner GPADC on
 D1/T113s/R329 SoCs
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

thanks for you comments

> This may sound kind of obvious, but wouldn't it be easier to model this
> with one compatible string, and have the number of channels as a DT
> property?

Yes, I completely agree that using separate config for each SoCs is looks
overcomplicated because the only difference is the number of channels.
I thought about a DT property with channels number but I didn't find
another ADC driver with the same approach (except i2c ADC's with child nodes).

> Or, alternatively, using iio/multiplexer/io-channel-mux.yaml, since it's
> only one ADC anyway?
I'm sorry, I didn't quite understand what you're suggesting.

> And btw: it seems that the T507 (the H616 die with a different pinout) has
> the same IP, with four channels:
> http://dl.linux-sunxi.org/T507/

Oh, thanks for pointing that. I'll add it to the list in the next version.
