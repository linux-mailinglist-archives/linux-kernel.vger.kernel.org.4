Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C8C731EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238697AbjFOR0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjFOR0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:26:21 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE8A2726;
        Thu, 15 Jun 2023 10:26:19 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33b3cfb9495so42967135ab.2;
        Thu, 15 Jun 2023 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686849978; x=1689441978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eiE+FMwFXrvEzfrfx66BeZbJm09rLDYZlCG0hGL4XwI=;
        b=Vc1fqBnUQ62UF1hZiubjuiBQsoSNThGP3zpoGa9Ovlel/Kd8HwxXh8MXBZJIHsvTtc
         4aCkb2s8pmyUYqp1FAeziGAdknhGmWj85PxageaTVSPYIv9L7HCzjfmOWCiI2EoJ9kEd
         ExBHfLyiVQsRAX+ys4dcjquUnRI+dbhMpCO4c9rJh3ILYQaAaFMkWyvBbXdBLvOvtO7E
         Fp4sSO999XdZEtB9oRRfNeaHquIQ24oM9nrOfkmBxpqlCmlmGiqXflgz0V1t/MJbuXPj
         oYoH0Itg+byaFZsi64MFoBPjgThDng8GU8mz0egMIhSw3d8NXMlS9VEGm9mK84fAnq+j
         kwsQ==
X-Gm-Message-State: AC+VfDyduqFqvpulfSRbB5V57UB+kpknTOn+3dNjoLLaa1KxI2ued16p
        /MPbg+fVSXSQzXAf4uYLSQ==
X-Google-Smtp-Source: ACHHUZ5ffp/CPCX/w2WnRbG3x6FbKIfQYYkpTq2fX2zmFBurHApqSFxCEWGU/yNpzidUDjI/F1Sn5g==
X-Received: by 2002:a92:d08e:0:b0:33a:b6ca:c4d3 with SMTP id h14-20020a92d08e000000b0033ab6cac4d3mr108866ilh.12.1686849978327;
        Thu, 15 Jun 2023 10:26:18 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h15-20020a02c72f000000b003c4f35c21absm5576928jao.137.2023.06.15.10.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 10:26:17 -0700 (PDT)
Received: (nullmailer pid 1229750 invoked by uid 1000);
        Thu, 15 Jun 2023 17:26:15 -0000
Date:   Thu, 15 Jun 2023 11:26:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>
Subject: Re: [PATCH] dt-bindings: display: Add missing property types
Message-ID: <168684997427.1229651.3186486766088079078.robh@kernel.org>
References: <20230613201114.2824626-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613201114.2824626-1-robh@kernel.org>
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


On Tue, 13 Jun 2023 14:11:14 -0600, Rob Herring wrote:
> A couple of display bridge properties are missing a type definition. Add
> the types to them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/bridge/analogix,dp.yaml          | 1 +
>  .../devicetree/bindings/display/bridge/nxp,tda998x.yaml          | 1 +
>  2 files changed, 2 insertions(+)
> 

Applied, thanks!

