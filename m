Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87507672152
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjARPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjARPck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:32:40 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05C94E510;
        Wed, 18 Jan 2023 07:32:38 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so19839527otk.13;
        Wed, 18 Jan 2023 07:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V0kLGC9r5lgXWTZfqO2aD1AR94agoSKCVwl2XarWV5Y=;
        b=cvf2NV/Hq+lPPxvDplwedLJe5Z+FLtK2XZRueGMksa1Tn3PBEU2yfwwbjOQN27QDYD
         59Ka8NBB6nEaLtOh9hjktKwUM07HCTAP0G4X5NmobikXk6I71Esl0FIXEfTnyxk6IP8A
         xHcrbOQjsMFDIp8SkMrLuglksgAPhLqmWysijJQPvUrpEigDFTdmp5sRizVEA0exBYP6
         IKvIwBb3j5NpaNgssLFs9MYtVp3HFAkY/8w8v4treMV6XjPg4TdU1JpS5c23cHOIBWSn
         pCDQFlA2nkj+L+BT5C4w9IE6ynE11MWYE5FtuWiFNow9uRuQl21rCxAFj/ZKgrob6Wef
         zlKQ==
X-Gm-Message-State: AFqh2krShDPii4L08Z9pdKKxpSWdt4DcJEnUsHuQ5kYssCpj6RhdCQyx
        7Al6+xaEDFy+yndBGhWI1g==
X-Google-Smtp-Source: AMrXdXsBh/ovlvd71FQVIia7N0KbCDgpDylT7dGK+3iWXmyziKmrr6DxPup4FeuQxM1HvJM5X9s8pg==
X-Received: by 2002:a9d:4d8c:0:b0:686:413f:a934 with SMTP id u12-20020a9d4d8c000000b00686413fa934mr3756396otk.38.1674055958013;
        Wed, 18 Jan 2023 07:32:38 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id ce6-20020a056830628600b00670679748f9sm18944681otb.49.2023.01.18.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 07:32:37 -0800 (PST)
Received: (nullmailer pid 39617 invoked by uid 1000);
        Wed, 18 Jan 2023 15:32:36 -0000
Date:   Wed, 18 Jan 2023 09:32:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu
Subject: Re: [PATCH v1 1/4] dt-bindings: gpio: rockchip,gpio-bank: add
 compatible string per SoC
Message-ID: <20230118153236.GA33699-robh@kernel.org>
References: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08de3f4b-e33f-95c8-3297-814ea107272a@gmail.com>
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

On Wed, Jan 18, 2023 at 01:13:23PM +0100, Johan Jonker wrote:
> Currently all Rockchip gpio nodes have the same compatible.
> Replace all the compatibles in gpio nodes to be able to
> give them a consistent ID independent from probe order or alias.

I fail to see how the compatible change affects probe order or aliases. 
It is also an ABI break if there is not the existing compatible as a 
fallback. State the problem you are trying to solve with this change, 
not just what your solution is.

GPIO shouldn't really have an alias either IMO.

Rob
