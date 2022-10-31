Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85F9613E26
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiJaTXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJaTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:23:41 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B504E120A4;
        Mon, 31 Oct 2022 12:23:40 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id cy15-20020a056830698f00b0065c530585afso7316934otb.2;
        Mon, 31 Oct 2022 12:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQuV1G1h9Q2KEJeOpqlGNcbiDdFW7/cHLrtfvW/w2c0=;
        b=JmRt9+k4ZUgN6ftkOqfI/zFY+9JJENYl+mWIGGL8QqnFLxs/mN6IdSI4Btwgk2L8z7
         rtGVL2Cpl4xm8EaqbrUzQbkdhJVYh4BYP1+vFMj/tB7HSb8ZeG/XNmKa/PlrCzIeql3q
         puV0/5TUOOFzxwh2vrjI/4ejRG/49Qp7N8mhRP1zFFyM5z+0iyAzrOiak5hunvpHNAod
         r3o8HR3KWRzJxto0Rnx5xzHuPLrc9rWenqwSMvl7ZZYoIahghdHfUk6cs5uPin02x7gE
         DZoo2iCS5qW0akSvVREQWa7uHurvnPp38dRq2NYeeRbr3wriLss016EnUfMOvl7eK/ky
         28Kw==
X-Gm-Message-State: ACrzQf1GsXp0mcvS+NzA5jRxdKMzL31T532l53Yu+2xkFyPMRDQQQRNS
        tWCytnsCPZqtYZeKr4cgtw==
X-Google-Smtp-Source: AMsMyM5z4xeQYenKTAqnF5JTbwSTSwTnovUxg75w3nRZZYqNQSLHm9rPIMBXZ8XLc484+u8e7zdX+w==
X-Received: by 2002:a05:6830:600b:b0:661:152:5de9 with SMTP id bx11-20020a056830600b00b0066101525de9mr7315548otb.143.1667244219911;
        Mon, 31 Oct 2022 12:23:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f10-20020a056870d14a00b00130d060ce80sm3465436oac.31.2022.10.31.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:23:39 -0700 (PDT)
Received: (nullmailer pid 3283626 invoked by uid 1000);
        Mon, 31 Oct 2022 19:23:41 -0000
Date:   Mon, 31 Oct 2022 14:23:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        od@opendingux.net
Subject: Re: [PATCH v2 1/4] dt-bindings: rtc: ingenic: Rework compatible
 strings and add #clock-cells
Message-ID: <20221031192341.GA3270129-robh@kernel.org>
References: <20221028225519.89210-1-paul@crapouillou.net>
 <20221028225519.89210-2-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028225519.89210-2-paul@crapouillou.net>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:55:16PM +0100, Paul Cercueil wrote:
> The RTC in the JZ4770 is compatible with the JZ4760, but has an extra
> register that permits to configure the behaviour of the CLK32K pin. The
> same goes for the RTC in the JZ4780.
> 
> Therefore, the ingenic,jz4770-rtc and ingenic,jz4780-rtc strings do not
> fall back anymore to ingenic,jz4760-rtc. The ingenic,jz4780-rtc string
> now falls back to the ingenic,jz4770-rtc string.

This is a compatibility mess. There is no driver support in v6.1-rc for 
ingenic,jz4770-rtc, so a new DT would not work with existing kernels. It 
sounds like you need 3 compatibles for 4780.

> 
> Additionally, since the RTCs in the JZ4770 and JZ4780 support outputting
> the input oscillator's clock to the CLK32K pin, the RTC node is now also
> a clock provider on these SoCs, so a #clock-cells property is added.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
>  v2: - add constraint on which SoCs can have the #clock-cells property
>      - add JZ4780 example which has a #clock-cells
> 
>  .../devicetree/bindings/rtc/ingenic,rtc.yaml  | 32 +++++++++++++++++--
>  1 file changed, 30 insertions(+), 2 deletions(-)
