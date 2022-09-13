Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9475B7752
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiIMRHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbiIMRG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:06:56 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2E8F95D;
        Tue, 13 Sep 2022 08:56:19 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-127d10b4f19so33228200fac.9;
        Tue, 13 Sep 2022 08:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q2pzBTs8AUPnlW7L4Dy5QX/7RTSl832U+8XEa+jPF14=;
        b=3TliU4ej1/Mv6yRhY0IRdutabqZiFzRCWABtJhLBqXaquTDSgK/PEDn49vfsVu1lsN
         3uBxjAppMIxBzoIVAnyox1O6b6dUdt/zQftl3re/PkOXnAcouDn3ulHPs5NqwG5cu+w4
         oUIonfFNO6F4ShJ2fxDk5tn84zyULl6nCmyP4B7CFyckc4qvUigNTxN6iHGNrtvP1T5X
         UQafCUcWel2HC0MrAebcfENrMtSU7qDfqkQEgUyR9CMFLtiQpc3TJA75mE3lnJJhyNhg
         yroVxB8V1Z3bgQkfHmhhGDxiXwx/U4wls9qa/ZVfvYUmOGQcdO+yuU/k/PpLa2Cd2YcA
         LiGg==
X-Gm-Message-State: ACgBeo23lOLupB6imJ6Lr5HS/fVyPSWzqUOydHOkAJ8tPKYsn3bK45PC
        i2JcnOAj3apSPBAegBiXeTtQwuMBIA==
X-Google-Smtp-Source: AA6agR73VBx3kyn5Mb+AYg6v7nseXC+ZG770Imn8LWQNahhPuIqiBSVJh2wKMMSrn+66t6bBMt2fRA==
X-Received: by 2002:a05:6808:2084:b0:34f:93ea:fac5 with SMTP id s4-20020a056808208400b0034f93eafac5mr1757751oiw.256.1663084528271;
        Tue, 13 Sep 2022 08:55:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i4-20020a9d53c4000000b00654625c0c4dsm6103755oth.17.2022.09.13.08.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:55:27 -0700 (PDT)
Received: (nullmailer pid 3808048 invoked by uid 1000);
        Tue, 13 Sep 2022 15:55:27 -0000
Date:   Tue, 13 Sep 2022 10:55:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Fabien Dessenne <fabien.dessenne@foss.st.com>
Subject: Re: [PATCH] dt-bindings: pinctrl: stm32: add missing entries for
 gpio subnodes
Message-ID: <20220913155527.GA3807992-robh@kernel.org>
References: <20220913074639.31932-1-alexandre.torgue@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913074639.31932-1-alexandre.torgue@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 09:46:39 +0200, Alexandre Torgue wrote:
> Add "interrupt-controller" and gpio-line-names to gpio subnodes in order to
> fix dtb validation.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
