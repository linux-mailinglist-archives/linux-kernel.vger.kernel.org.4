Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6071F5FF58D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJNVnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJNVnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:43:51 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE1A1958C8;
        Fri, 14 Oct 2022 14:43:50 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so1882582ooo.8;
        Fri, 14 Oct 2022 14:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsufLNFM7jG51GY0dQr+V7Jz/aTFB4t5E1h05t4lU/Q=;
        b=xpYRQhzpu0GtOGtWDS6yxDeRhfDoHU2CvF9Ji4b+5f8SLb2ao0VhwLfaQuR+7Q/hw5
         Dychab4i3xf+g47oMph31Mykq2hxFGSYxNycp6CStjT+6Bt0WRvoJEUCETWc0CP8c1qe
         hM6Yr9sJXE0kgPER12EnKDW1B/JkVu+LFgI7qQPlAguAEJKoIUdRxbHnw4OmVwkMn9YE
         3ohxF2EwQoMi5T0qB2CB0/tGmyNjyJj376wdXbbFrXwvlOeOMK42qIme6mvP6lQA7BFx
         rdZAIlU8TwdEKjriEprabvI3GeHg1v9tYFx7hbfSX7sYQtA+/wEISLhe16v6HiO7YsWf
         nfog==
X-Gm-Message-State: ACrzQf26vO/370sKnofckWIqIXdrAUcQeMtc/xhwgCrQFV9vVYCjilsJ
        VKQ9UrYWtUc1pWmPqNB/SA==
X-Google-Smtp-Source: AMsMyM6fLTHPSbOXoYwxDCAkaGDn+10AxfgooMekB9fxUJGM4iLfCvcG7NzoSyU6LCucpf/wUNLOZg==
X-Received: by 2002:a4a:346:0:b0:476:8699:bdca with SMTP id 67-20020a4a0346000000b004768699bdcamr2768723ooi.29.1665783829754;
        Fri, 14 Oct 2022 14:43:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cv36-20020a056870c6a400b0011bde9f5745sm1902094oab.23.2022.10.14.14.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:43:49 -0700 (PDT)
Received: (nullmailer pid 2949845 invoked by uid 1000);
        Fri, 14 Oct 2022 21:43:50 -0000
Date:   Fri, 14 Oct 2022 16:43:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH] dt-bindings: clock: Convert pwm-clock to DT schema
Message-ID: <166578382952.2949791.14457951848803615803.robh@kernel.org>
References: <20221011162919.3025038-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011162919.3025038-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Oct 2022 11:29:18 -0500, Rob Herring wrote:
> Convert the pwm-clock binding to DT schema format. A straight-forward
> conversion.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/clock/pwm-clock.txt   | 26 -----------
>  .../devicetree/bindings/clock/pwm-clock.yaml  | 45 +++++++++++++++++++
>  2 files changed, 45 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.yaml
> 

Applied, thanks!
