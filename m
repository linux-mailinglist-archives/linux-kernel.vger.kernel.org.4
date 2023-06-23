Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F473BF7D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFWUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjFWUZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:25:21 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A85135;
        Fri, 23 Jun 2023 13:25:20 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3422b2554e1so4101145ab.1;
        Fri, 23 Jun 2023 13:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551920; x=1690143920;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Lq1owJ/IaDvQLEQ5ZIXuPqVSkcT5KXvETUiM77W/uA=;
        b=I1ECPeBMciAANckMzeUnuR9m3T2B+ovRKu8eFw9jak78Tefdt6K5wDpUXg/plwzfBW
         XOgL619lXRCK38xOkm38avSDU/OkR3hqKywN0xPfzBQFntNFSk3QcgDrlv7shsNbaoV3
         JIgCSi833rw4vAAS5rvk7Usj2D7yPMM4HKu9qVRDcYq1q7u4aTaWQQBsxcrRgvpAMdtg
         BbDUKhZI1exoWxLEgT+xP27T9v854uHE4huf+EFG+CMJP4gng6ukvRUHXa4KDZRzGZgy
         sHiTUKH1SATz4XcFvAogK/Qkk4byeL3DrxG1e292vtwr6DppRKazY0UMuN+tscpsQrua
         5X9g==
X-Gm-Message-State: AC+VfDwMUs8vuMMwgHIS5gOw/pfNcxXxax4r4Kc6P7D6dhECY2Geb/IL
        8tpVon2n+oj/l3vcxs2CpQ==
X-Google-Smtp-Source: ACHHUZ5pUfmW+oXejyC7m63oSEnw24wNjmXx/26GuKi/vqFEgT30ODrJJKIfcuglsWmLVxB0vNyFRg==
X-Received: by 2002:a92:dc85:0:b0:33e:7c8d:3cc with SMTP id c5-20020a92dc85000000b0033e7c8d03ccmr18089970iln.22.1687551919905;
        Fri, 23 Jun 2023 13:25:19 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id 13-20020a92c64d000000b0034254a9e5f8sm54175ill.25.2023.06.23.13.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:25:19 -0700 (PDT)
Received: (nullmailer pid 1059974 invoked by uid 1000);
        Fri, 23 Jun 2023 20:25:16 -0000
Date:   Fri, 23 Jun 2023 14:25:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-pwm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: drop unneeded quotes
Message-ID: <168755191537.1059860.5101208294995710132.robh@kernel.org>
References: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 09 Jun 2023 16:07:09 +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml | 2 +-
>  Documentation/devicetree/bindings/pwm/mxs-pwm.yaml           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!

