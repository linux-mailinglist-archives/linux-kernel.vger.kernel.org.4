Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1754735FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 00:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjFSWLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 18:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFSWLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 18:11:17 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E44187;
        Mon, 19 Jun 2023 15:11:17 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3422161e53bso8158865ab.1;
        Mon, 19 Jun 2023 15:11:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687212676; x=1689804676;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GzJl3YIufx24rrPPBjiGHwcJLGJVUI+UoKbrhxXg1M=;
        b=eomirQcs7pb2q2stKCz+ZVrYK5fGAj7cMs0tgYixkxoYbjACJD4AZaT1VmVCmnrBUC
         SijCGD2xukzPHXUalO9NiZE61ondsCEE8b8qVefCDywgiOBaL7OKyUZLQp3XYC6AbNQL
         LHe4Av5L4gfeF3282FgK4CfMAEK0mBpLAaswI0LqjLt1/HDTKMKei6z7TOLv6PVeVR0M
         x+TuoqnPDv5IZ+18PayIU8/IIkkdWio0p53z5a/F64tnEF0FGJTWzN042/nR0GRPwkIa
         m0n9l9uNsRDG7np6gulvZCBNejC5oWfPnQhFvkIHYLYlF7x1irjUeRaEcKCzcuWEd60B
         Ir9Q==
X-Gm-Message-State: AC+VfDzVAFv4qE3lcRKM+I4gnUmyu7RQUg2tHHRXDSjytivznYPBh1uF
        7HcplAoyBTWUQpRBv0KFfhJtGLCo1w==
X-Google-Smtp-Source: ACHHUZ6YHBtLREVH2RBkLmpN6iF2iPKgeZP7XF9P82sV7Y/BeGqT4CuDM3LoXhiiKoMP9nbsocyEXQ==
X-Received: by 2002:a92:c60a:0:b0:33e:6d37:ce76 with SMTP id p10-20020a92c60a000000b0033e6d37ce76mr6318463ilm.12.1687212676512;
        Mon, 19 Jun 2023 15:11:16 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b0033bc3a3ea39sm170537ilm.70.2023.06.19.15.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 15:11:15 -0700 (PDT)
Received: (nullmailer pid 1611621 invoked by uid 1000);
        Mon, 19 Jun 2023 22:11:13 -0000
Date:   Mon, 19 Jun 2023 16:11:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v4 4/6] dt-bindings: display: stm32-ltdc: add optional
 st,fb-bpp property
Message-ID: <20230619221113.GA1608794-robh@kernel.org>
References: <20230619165525.1035243-1-dario.binacchi@amarulasolutions.com>
 <20230619165525.1035243-5-dario.binacchi@amarulasolutions.com>
 <20230619-ion-decree-c63d2eb11e83@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619-ion-decree-c63d2eb11e83@spud>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 09:18:25PM +0100, Conor Dooley wrote:
> Hey,
> 
> On Mon, Jun 19, 2023 at 06:55:23PM +0200, Dario Binacchi wrote:
> > Boards that use the STM32F{4,7} series have limited amounts of RAM. The
> > added property allows to size, within certain limits, the memory footprint
> > required by the framebuffer.
> 
> Hmm, this sounds quite a lot like "software policy", since the actual
> display doesn't have these limitations. Rob, Krzysztof?

Indeed. This doesn't belong in DT.

Rob

