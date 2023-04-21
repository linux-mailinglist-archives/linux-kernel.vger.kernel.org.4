Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFC76EB329
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233018AbjDUUzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjDUUzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:55:42 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5BA1FD8;
        Fri, 21 Apr 2023 13:55:40 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a437526b7cso2265961a34.1;
        Fri, 21 Apr 2023 13:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110539; x=1684702539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3qSiryvYVKTt/1kFC1/HjBS+lPj08Bg2k7k8FYWUmPY=;
        b=BciiQFPbekVkCAnmPStembT0oBOT/ap2fDNATVnLOHBJNtQb/ijTulJ3sMnXKql2Gg
         phCrC06j7QFBNWUBSbG8Rl/Ob2c92kSr4BepVCc6wIZLDlWFxESeHrCBnMVctVN+/Y7X
         HJtsQHJcs305j1YquS10R4fV8iq/Q+Wtn+i/wSwscWRZ2pTPlmgqH3kE6w+hq3QW/06T
         A+J+isw4lhctTY/IXQM0tT6vHRus9bXdDjVwpZXHKXdkILhex7354zLtgAMwNtnI5I+/
         wlcS+p4wsM17lPhcEVmi6zIORaxicQxjda7L/tRWW83LT/BTAdU3yzDOaAda+0HHGXWm
         MZSg==
X-Gm-Message-State: AAQBX9cl0ECESnUXtQ9915mZ5k9YB0ihIYfFng+vHq/tRLgHUYSnxGQE
        PH/I7nxtJJL1gopOMRtbQ1Nlm+nNEQ==
X-Google-Smtp-Source: AKy350YI7yqSFFMC7Eccl5RxhLFXnu5rQs5BiCv2qRSux2adqKdkSVoQrmTbX3B2Q53Tny4uu7rkEQ==
X-Received: by 2002:a9d:694d:0:b0:6a1:369f:c489 with SMTP id p13-20020a9d694d000000b006a1369fc489mr3837273oto.33.1682110539435;
        Fri, 21 Apr 2023 13:55:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t4-20020a9d66c4000000b006a4244d2a7asm369406otm.9.2023.04.21.13.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:55:39 -0700 (PDT)
Received: (nullmailer pid 1750988 invoked by uid 1000);
        Fri, 21 Apr 2023 20:55:38 -0000
Date:   Fri, 21 Apr 2023 15:55:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Jarrah Gosbell <kernel@undef.tools>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] dt-bindings: input: touchscreen: goodix: clarify
 irq-gpios misleading text
Message-ID: <168211053800.1750927.15213873309578673308.robh@kernel.org>
References: <20230419171849.946986-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419171849.946986-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 19 Apr 2023 19:18:49 +0200, Luca Ceresoli wrote:
> The irq-gpios description misleading, apparently saying that driving the
> IRQ GPIO resets the device, which is even more puzzling as there is a reset
> GPIO as well.
> 
> In reality the IRQ pin can be driven during the reset sequence to configure
> the client address, as it becomes clear after checking both the datasheet
> and the driver code. Improve the text to clarify that.
> 
> Also rephrase to remove reference to the driver, which is not appropriate
> in the bindings.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  .../devicetree/bindings/input/touchscreen/goodix.yaml         | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

