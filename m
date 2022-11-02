Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479B2616911
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiKBQc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKBQak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:30:40 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F1A1A068;
        Wed,  2 Nov 2022 09:27:38 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id b124so7224223oia.4;
        Wed, 02 Nov 2022 09:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i9DKiEWbNAaN/Ts40u1N+OS2G5jTBUDfQom4SPfBpvM=;
        b=T99EGzJIXKshfKrr/FyLEIMSC30TADkMsPiKVQTlQddWlATGESXBjso9/ZqgJMQMdb
         hWbbHcQAvI93VE++aWzw6lLSU0+odprzO8N5cyG9c1qZHd34i+6MmlZpPu1yHbwfgDaz
         Z2LMBaVCU5ZHu71HDJuSSsWwaqo3AA7g4x48pSviI0YQbZYLzUM+yBq8ezi0czm14VMw
         WuGPI49WpXW5bM5kq1ERYfBaIZztblIdPA5e1zjpCBqYDiv/pjpgsdvrzsPFDwPJ4/3l
         e5+zBGQTa9l2n4GAFqK4JrG85M3L2GKDBqI8o3G5vzFiXrOayg3OYe0FCo4RM98ZkowZ
         MREg==
X-Gm-Message-State: ACrzQf0OmCOhUSl2LRe/MZ0lkvWs76uU795OOBics7qzRqVRZzsmPcWY
        EsKJoXJqY6BOQOGAX5riEw==
X-Google-Smtp-Source: AMsMyM67RWisMgvzXM6lu3hppm/ObJ62lp65Rp3SAt/u6oun+fxtpu/niXGprbl7JxabeqPDQABX7A==
X-Received: by 2002:a05:6808:2391:b0:35a:2d2d:59d9 with SMTP id bp17-20020a056808239100b0035a2d2d59d9mr5107214oib.121.1667406457247;
        Wed, 02 Nov 2022 09:27:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o6-20020a9d4046000000b0066194e0e1casm5088489oti.75.2022.11.02.09.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:27:36 -0700 (PDT)
Received: (nullmailer pid 4001651 invoked by uid 1000);
        Wed, 02 Nov 2022 16:27:38 -0000
Date:   Wed, 2 Nov 2022 11:27:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Stephen Boyd <sboyd@kernel.org>, phone-devel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        afd@ti.com, Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,spmi-pmic: rename extcon node
 name
Message-ID: <166740645799.4001595.14016941956420935954.robh@kernel.org>
References: <20221031175717.942237-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031175717.942237-1-luca@z3ntu.xyz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 18:57:14 +0100, Luca Weiss wrote:
> extcon is a Linux-specific name and shouldn't be a part of the dts. Make
> it be called usb-detect@ instead.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> This patch builds on top of
> https://lore.kernel.org/linux-arm-msm/20221031173933.936147-1-luca@z3ntu.xyz/
> But could also be applied without, if conflicts are resolved.
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
