Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD85F6E00
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiJFTP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiJFTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:15:22 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6974EB2DB3;
        Thu,  6 Oct 2022 12:15:20 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id s192so3131541oie.3;
        Thu, 06 Oct 2022 12:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSeGwdd1h0eArxw0/Cs1IlyZ0sg0R0d0VuaW7/1/fjA=;
        b=fdkVPK0thHZwTU9ZUQM2Iq8qAmyX1H2E3Ev7//ut8Spu32EULiwnNjZwgAr1XlFMy/
         7YdWJesvQ7cy0cateHic7JmtVSolkNOQk4Qxfy3odvb9kMHG+P9aHLp5nMttpAv8ifML
         pK6md+2BVhd/2M7xhswvi58/opDmHLjpjVij3d2eO31ggEKRbJfNnN9fbWEi8AJ3KHjD
         Muhd6W9I6eFoNoYBAUDzb2qGDhficN33sLtb48nIDUVAVs2EkAlLhYysrcwbrUp9ElZJ
         m5LVeIkScQ5SeFWnCCtLKdR29eP2dB9Z9gA8wNcaotZkFUfiHz1E/iVlSGvNrNAvrIXf
         s8xA==
X-Gm-Message-State: ACrzQf2w6/i4fuQXDTA19Dg+TJAooB98ADGF3vUkIV91y3gP39X1q9Nx
        uTj0tNQ8RpThHn23Hg3Z+Q==
X-Google-Smtp-Source: AMsMyM6n/l5A3cpqNPJc5Pcf2MD5XwLNIlPtA8DpqPA07b3UMAXxD4ppfGl5DeEdEvKLl43AkzrxbQ==
X-Received: by 2002:a05:6808:1b85:b0:34d:8ce1:d5b0 with SMTP id cj5-20020a0568081b8500b0034d8ce1d5b0mr5662048oib.194.1665083719643;
        Thu, 06 Oct 2022 12:15:19 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id b130-20020aca3488000000b00353ef11d6c9sm2467oia.19.2022.10.06.12.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 12:15:19 -0700 (PDT)
Received: (nullmailer pid 46581 invoked by uid 1000);
        Thu, 06 Oct 2022 19:15:17 -0000
Date:   Thu, 6 Oct 2022 14:15:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] arm64: dts: mediatek: mt6779: Remove syscon
 compatible from pin controller
Message-ID: <20221006191517.GA45995-robh@kernel.org>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-2-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005174343.24240-2-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:43:34PM +0300, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Remove syscon compatible string from pin controller to follow
> DT bindings and pass checks. Adding the syscon compatible to
> the DT bindings documentation instead causes a different check
> error due to the syscon document specifying a maximum of 1 item
> in the reg property, while this has 9. Nothing is using the pin
> controller as a syscon at the moment so it should be a safe
> thing to do.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6779.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
