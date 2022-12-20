Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01A16524E9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiLTQse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiLTQsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:48:32 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79900DF7B;
        Tue, 20 Dec 2022 08:48:31 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id l8-20020a056830054800b006705fd35eceso7469708otb.12;
        Tue, 20 Dec 2022 08:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmWMDsM7gBznInWF119ExXVPhyOUt68trxWCdWxjVKs=;
        b=ffAowPzaXEW0mkp3KDPjaBpcJ/97DBoaMDfawi7rXzsPOX9n5wRTIfH5RRk/RVzLfq
         LB3XygoiNhRdMMxjdMDHSQ1HPYDWa6YIBP5yGHR9b5j7TvbpshzwKMHwuNBap18yTDWb
         ixJzM4fo9XPuZcs8rxAiohXbVtg3NDHnwFRT4mM4INBuoh8SeXfNo03AJleBR06lcMtu
         xX8IqKEhX8CecA5EpTzLpDcRztIW28deJl1OE6JEwzQg5fXT4u7bER0USWsGhGq1Qxg3
         lRKkOyVLoveW/oTQFVyN3C695m/8hZncBbc1Mrl+TrNQmIWyTnEl2Ba77Prn7NA/uQmf
         nhpQ==
X-Gm-Message-State: ANoB5pl/Pj3zGufnO/+Ce5+84XnO88px26FuntfmkPzz+Me2RIWl3h/N
        CbA9T0I2anhXulCFKGsczbeSNb9cTQ==
X-Google-Smtp-Source: AA0mqf5tVUyJtFiNpYpVQp7R2aB336NTL+3o9bQ1N6XYmFOiUby946PPltH3ZKYoBVVoMdlkJn8Icw==
X-Received: by 2002:a05:6830:144d:b0:670:7c74:2616 with SMTP id w13-20020a056830144d00b006707c742616mr20951968otp.11.1671554910735;
        Tue, 20 Dec 2022 08:48:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t26-20020a05683022fa00b00661ad8741b4sm5889102otc.24.2022.12.20.08.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 08:48:30 -0800 (PST)
Received: (nullmailer pid 724855 invoked by uid 1000);
        Tue, 20 Dec 2022 16:48:29 -0000
Date:   Tue, 20 Dec 2022 10:48:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     linux-rtc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        bruno.thomsen@gmail.com, linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: remove pca/pcf2129 from
 trivial RTC devices list
Message-ID: <167155487539.723236.827037175847349918.robh@kernel.org>
References: <20221220152237.1125178-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220152237.1125178-1-hugo@hugovil.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 10:22:37 -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> pca/pcf2129 devices can also have the 'reset-source' property, so
> remove them from the trivial RTC devices list.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
>  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml | 2 --
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
