Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0CE624AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbiKJTva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiKJTv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:51:26 -0500
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262E04875F;
        Thu, 10 Nov 2022 11:51:25 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id r76-20020a4a374f000000b004988a70de2eso397338oor.2;
        Thu, 10 Nov 2022 11:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHDl1k+IjjiluFcAgubPN6Bxc9jMrBAyPXl0OSR6rYM=;
        b=VtpCCu+QWuUOU7sr/u3PZnILHzEYcWNZ3eQCHupFAMk7M9YioHsj04/MkluO6uaHca
         cpt01/7DGcxlCqRNAOJCJA4u/W3Ukxawsy2g5/vcbj4VfSI94DAlRM6zQ5eGvUHbcozp
         PXvNwiinoi6Kf33v28XTdYmhneN9dy5UUrFJp5mhIot4Dz82EZWWDNjYqafWWOfg26bR
         w+v14NYhsEgYcIEbXbNnxxPpM56EBfGZZWyuDBlJ0jeZuGbCcDU7o5Fj9GrBqcrJ5I5X
         QqVDe6rZDMqUWc+D0X94EQdrcvUj0Ojj4an6+oOyotepaCSTY1c30CTvYCdOC98yvzvA
         xdKQ==
X-Gm-Message-State: ACrzQf0ZFimj2e62nNPfljJU/bQWGjznfTAJa9A8JgzlulIZVkHPWk2q
        LADotISDXxgQr8xv+LylZQ==
X-Google-Smtp-Source: AMsMyM42TMLEWT5X00LepXMJ6bck7ezJKFStYZUnzpZw+gjBVLGQJz6I7y6kxftZhYYaUO3TCmuiiQ==
X-Received: by 2002:a4a:d129:0:b0:49e:1b6a:3c57 with SMTP id n9-20020a4ad129000000b0049e1b6a3c57mr1706373oor.32.1668109884380;
        Thu, 10 Nov 2022 11:51:24 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t25-20020a4adbd9000000b0049427725e62sm132430oou.19.2022.11.10.11.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 11:51:23 -0800 (PST)
Received: (nullmailer pid 884033 invoked by uid 1000);
        Thu, 10 Nov 2022 19:51:25 -0000
Date:   Thu, 10 Nov 2022 13:51:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andy Yan <andyshrk@163.com>
Cc:     linux-arm-kernel@lists.infradead.org, heiko@sntech.de,
        krzysztof.kozlowski+dt@linaro.org, pgwipeout@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: rockchip: Add Rockchip rk3566 box
 demo board
Message-ID: <166810988279.883926.4699648145983985104.robh@kernel.org>
References: <20221105095935.958144-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221105095935.958144-1-andyshrk@163.com>
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


On Sat, 05 Nov 2022 17:59:35 +0800, Andy Yan wrote:
> Add device tree binding for Rockchip rk3566 box demo board.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>
> 
> ---
> 
> Changes in v2:
> - Move it before rk3568 evb
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
