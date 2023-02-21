Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037F369E3BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbjBUPkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjBUPkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:40:15 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BEF2BF35;
        Tue, 21 Feb 2023 07:39:56 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso1108105otj.13;
        Tue, 21 Feb 2023 07:39:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5/tMfieURLcBSj5dsmqN62a4IUK2Eg+XakNMC0OKXU=;
        b=tBE8PtcUvet0yKWNVPnMeE3WHwgesYUinGDfCZn3pzhMIFm23LUtXUWlUfOqY2S8Dn
         Wv33p11ivH3fcQFI+01DjgzNRwJLL15h6Np3RfYEKlGQHOJqs7t5DSrVmnuYiNiTHhV9
         f/ewEygFGE8f7DCez3Rd8gFjXRN1qhsyDQFOoZ/CLrFp0NAZyCfwqirDg7RnmbWWjkR3
         lc2G2j09ELX5987Tzi/RXN9hJDFsWen/C9yeL2VIXqeBlBAbloyjimyEOq0J8lASmFpC
         O+dI63cHOTHbnjhlMrI6PXoVr6oQOC/DOEKasdT+gCr3LDKnMCDPg7Z05vsj7pweEyKr
         ijsA==
X-Gm-Message-State: AO0yUKW069gLwmvlcV38a3a9dXd3OfmDdWCRPkGzLaYk+QPcj18oownp
        ezDGuE8C3wdTnD8eUfUiiw==
X-Google-Smtp-Source: AK7set+5D9u532a/FkmP73W9cjxPme9PnhFyfhuayG1zE0gSufgX9Q0AFXayW6atHjKU2bJCTj4bXA==
X-Received: by 2002:a9d:1d0:0:b0:68d:41b2:5b75 with SMTP id e74-20020a9d01d0000000b0068d41b25b75mr7462876ote.11.1676993969090;
        Tue, 21 Feb 2023 07:39:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q7-20020a9d57c7000000b00690f7c779ebsm1218195oti.7.2023.02.21.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:39:28 -0800 (PST)
Received: (nullmailer pid 2584244 invoked by uid 1000);
        Tue, 21 Feb 2023 15:39:27 -0000
Date:   Tue, 21 Feb 2023 09:39:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Stephen Boyd <sboyd@kernel.org>,
        Sagar Kadam <sagar.kadam@openfive.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Sagar Kadam <sagar.kadam@sifive.com>
Subject: Re: [PATCH] dt-bindings: drop Sagar Kadam from SiFive binding
 maintainership
Message-ID: <167699396496.2584137.12786082916323503594.robh@kernel.org>
References: <20230217180035.39658-1-conor@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217180035.39658-1-conor@kernel.org>
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


On Fri, 17 Feb 2023 18:00:36 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Sagar's email listed in maintainers is bouncing as his division was sold
> off by the company. I attempted to contact him some days ago on what the
> bounce email told me was his new contact information, but am yet to
> receive a response.
> 
> Paul and Palmer are listed on each of the bindings, both of whom were
> alive & well as of Wednesday so the bindings remain maintained.
> 
> CC: Sagar Kadam <sagar.kadam@openfive.com>
> CC: Sagar Kadam <sagar.kadam@sifive.com>
> Link: https://lore.kernel.org/all/785425ca-4000-a7e4-16d6-4d68c91b158d@kernel.org/
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Palmer/Paul, as mentioned Wednesday, here you go!
> ---
>  Documentation/devicetree/bindings/clock/sifive/fu540-prci.yaml | 1 -
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml       | 1 -
>  Documentation/devicetree/bindings/pwm/pwm-sifive.yaml          | 1 -
>  Documentation/devicetree/bindings/riscv/sifive,ccache0.yaml    | 3 +--
>  4 files changed, 1 insertion(+), 5 deletions(-)
> 

Applied, thanks!

