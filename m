Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD4CC6F0905
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243751AbjD0QDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243734AbjD0QDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:03:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD0E3585;
        Thu, 27 Apr 2023 09:03:13 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-38be107e467so2935078b6e.2;
        Thu, 27 Apr 2023 09:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682611393; x=1685203393;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpUDR78eVgfoaENlXo4BrweBkLjcgbvwpsdEBZODQfU=;
        b=UDGYcrX9b2Sd5UzmPHBcOE5ZpG97/HV160me2bz4YDNRn4uwlePW7TTP5GJlhtFRG/
         jZPcFAJ5NOfwVbJbSH9nt6YdCPsyv7AaAQ74HYJfgVDj3/f39gYG1U8MpRz8yk87zf3f
         2rkQ0lajPsFyydbsthGbHobdMBspHGSp6UjCMUtasv1ij/7o5Rs+IPPpBhX/WZEBUQY1
         XFmF6/tlGEZ57Pc9Gt3ET/5InJb2D5KfFzY/shqkkyq589QdG6POcqUMP0tEZYWxm+23
         hhQZVIgKj0cHezC4od8O5v6exobSSM2j2P6FHSsgaFNM+pgg7CJrjDunB9bqbfEiTJ/l
         SGng==
X-Gm-Message-State: AC+VfDzWzIkntI5+eRG2vdcv6YD++mSc7QVc/xb0wQD/eEbMc6fB0eQ6
        DOY1rhw22Q1LQpO6Vek2ig==
X-Google-Smtp-Source: ACHHUZ7uXMKR7Wlwe7Q/gwyCErihpXXjybpweDLlaHz6Jnvmdt9R+Qb1/zEjBssZhiYR2/3YlNZkfw==
X-Received: by 2002:a05:6808:2a87:b0:38e:4c7:571d with SMTP id fc7-20020a0568082a8700b0038e04c7571dmr881164oib.50.1682611392688;
        Thu, 27 Apr 2023 09:03:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s185-20020acadbc2000000b00389898f4c4fsm7861059oig.45.2023.04.27.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:03:12 -0700 (PDT)
Received: (nullmailer pid 3103243 invoked by uid 1000);
        Thu, 27 Apr 2023 16:03:11 -0000
Date:   Thu, 27 Apr 2023 11:03:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chris Paterson <chris.paterson2@renesas.com>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] dt-bindings: pinctrl: renesas,rzv2m: Change maintainer
 to Fabrizio Castro
Message-ID: <168261138977.3103147.17710100927203706954.robh@kernel.org>
References: <20230426100832.11945-1-chris.paterson2@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426100832.11945-1-chris.paterson2@renesas.com>
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


On Wed, 26 Apr 2023 11:08:32 +0100, Chris Paterson wrote:
> Phil no longer works for Renesas.
> 
> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> ---
>  .../devicetree/bindings/pinctrl/renesas,rzv2m-pinctrl.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!

