Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C0D7320D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 22:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFOUU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFOUU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 16:20:26 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6BA2101;
        Thu, 15 Jun 2023 13:20:25 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3408217cd66so12875915ab.0;
        Thu, 15 Jun 2023 13:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686860425; x=1689452425;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=98h4clkEAbJKyL0mPSeiS1aUtvolLi8t7UFMljZk2ik=;
        b=bSOujuYqcGK4Fcbol43JdR18iNDJ2RpsNZJoJ1AEC4wIK1JfvmKgmzy+t9mTYlEhiM
         JzK6PYiHiAfTrDDxDwI8Ohels0NmcnFNHN7+2yxkOrRB16IvQrB+dMk96XhTGpUZ3x9g
         NpZMnjG6n0TUPQSxE37X7B0NaYkSyZrA1p0h2rsDU/orBqPQYB2Mu1SwQwiItm/JJ/pa
         yr35Zt5UAFtk+bBbZWQ1ByfyckVrxQOaAbx5vFaeyODn2p8lnnZxwLvFkljqhz+GgbpT
         2YYhi/xvlG6BAsIexcQIMsWpALxc8BsdeDQvHfrHkIULV85ROxkJtkjXDNtr+lZP3Rlf
         yZJQ==
X-Gm-Message-State: AC+VfDx7DVQ03iRhJwSY09tAzJ9arH3tmjdz2bN/JH6zJMCHzEL4dJjH
        YvqFT7z7ySZb/8BgAZaDfw==
X-Google-Smtp-Source: ACHHUZ6pGXCQ/jAqDTVq6IYMmb38pjQzkTICdrkSwqYxuDo2nMLr0hecMWf7qd/OGR1/8ZfLXohc0g==
X-Received: by 2002:a05:6602:22da:b0:777:8e86:7702 with SMTP id e26-20020a05660222da00b007778e867702mr362037ioe.16.1686860423911;
        Thu, 15 Jun 2023 13:20:23 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i17-20020a02b691000000b0041f49dbcaf3sm5773017jam.171.2023.06.15.13.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 13:20:23 -0700 (PDT)
Received: (nullmailer pid 1598537 invoked by uid 1000);
        Thu, 15 Jun 2023 20:20:21 -0000
Date:   Thu, 15 Jun 2023 14:20:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@pengutronix.de,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 shineworld lh133k compatible
Message-ID: <20230615202021.GA1594065-robh@kernel.org>
References: <20230614123222.4167460-1-l.goehrs@pengutronix.de>
 <20230614123222.4167460-3-l.goehrs@pengutronix.de>
 <81007308-02dc-b1fb-f336-21bc25033c12@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81007308-02dc-b1fb-f336-21bc25033c12@tronnes.org>
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

On Thu, Jun 15, 2023 at 12:35:25PM +0200, Noralf Trønnes wrote:
> 
> 
> On 6/14/23 14:32, Leonard Göhrs wrote:
> > The Shineworld LH133K is a 1.3" 240x240px RGB LCD with a MIPI DBI
> > compatible SPI interface.
> > The initialization procedure is quite basic with the exception of
> > requiring inverted colors.
> > A basic mipi-dbi-cmd[1] script to get the display running thus looks
> > like this:
> > 
> >     $ cat shineworld,lh133k.txt
> >     command 0x11 # exit sleep mode
> >     delay 120
> > 
> >     # The display seems to require display color inversion, so enable it.
> >     command 0x21 # INVON
> > 
> >     # Enable normal display mode (in contrast to partial display mode).
> >     command 0x13 # NORON
> >     command 0x29 # MIPI_DCS_SET_DISPLAY_ON
> > 
> >     $ mipi-dbi-cmd shineworld,lh133k.bin shineworld,lh133k.txt
> > 
> > [1]: https://github.com/notro/panel-mipi-dbi
> > 
> > Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> 
> Normally I would take this trough drm-misc-next but -rc6 is the cutoff
> so if I do that it won't make it to 6.5. If the other patches make it to
> 6.5 the dtb checks will fail. I'm okay with the patches going through
> another tree if that's preferred. Let me know if I should apply the
> mipi-dbi-spi patches.

I've applied patches 1, 2, and 3. The netdev folks should pick up the 
other bindings.

Rob
