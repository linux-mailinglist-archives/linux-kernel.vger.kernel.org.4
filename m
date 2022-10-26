Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163060EA18
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiJZUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiJZUOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:14:03 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9404F148F57;
        Wed, 26 Oct 2022 13:14:03 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id cb2-20020a056830618200b00661b6e5dcd8so10709094otb.8;
        Wed, 26 Oct 2022 13:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HXzbeLcKBqkTorVo8+Zfos/3G48Sy4NmsXxFj9BHm4s=;
        b=FEnYUn0DCoSCWHvoXyXAqzskXwwWWRZ1DXu7j2xsiizmQKRUn6wH4WOCXzy0s8+wS3
         winpS7JQttSFA5oolmMnvA5KMMmde/RaXpsz/S8Uv6lvOrnQIxl2ZbHBYGQvSUPFtRmb
         D5rkuEZV+pOFyTZqxj04Chv9NIwdbifNI89juCr2IXChHVZWlYppw7TUQnM/NCKdJOas
         sbwbs3Pkz1Sexz5FT9KYCCsyNyF6+C3/vTi/3a+zpX2VLWinGvfOC4DyRupDTJ/U7WiJ
         vhcisrSUuJqNLQd5WVqxsLYKrj0ZLoROeZCj2x+UOItIZ1mosm/akthGuXAS9Nio/G/R
         Z2Vw==
X-Gm-Message-State: ACrzQf0kwxopcVKn9SWxbpgI5lplIcecBQ13DmRT77JRnojeswSmFH6Q
        GUrY6lHV21TnN6uSm4WbH7xVU2t10A==
X-Google-Smtp-Source: AMsMyM7Zwol/YU/IWL2xizOWU3LR7EWtDOR4FhrFEny1tsGGtP5+wWG0o4VTMRg+N4Vj1hYfAmxtcQ==
X-Received: by 2002:a9d:74c8:0:b0:661:d66e:c2c0 with SMTP id a8-20020a9d74c8000000b00661d66ec2c0mr22390323otl.117.1666815242828;
        Wed, 26 Oct 2022 13:14:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z8-20020a056871014800b0013125e6a60fsm3514895oab.58.2022.10.26.13.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:14:01 -0700 (PDT)
Received: (nullmailer pid 1161110 invoked by uid 1000);
        Wed, 26 Oct 2022 20:14:03 -0000
Date:   Wed, 26 Oct 2022 15:14:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, dan.carpenter@oracle.com,
        linux-phy@lists.infradead.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, lee@kernel.org,
        kishon@kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: ti: phy-gmii-sel: Add bindings
 for J721e
Message-ID: <166681524182.1160710.10531302688571765618.robh@kernel.org>
References: <20221026074532.109220-1-s-vadapalli@ti.com>
 <20221026074532.109220-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026074532.109220-2-s-vadapalli@ti.com>
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

On Wed, 26 Oct 2022 13:15:30 +0530, Siddharth Vadapalli wrote:
> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Extend ti,qsgmii-main-ports property to support selection of upto
> two main ports at once across the two QSGMII interfaces.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 48 ++++++++++++++++---
>  1 file changed, 42 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
