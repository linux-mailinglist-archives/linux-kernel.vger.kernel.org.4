Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB5668FB7D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBHXrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjBHXrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:47:03 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CED0C640;
        Wed,  8 Feb 2023 15:46:53 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id dt8so314067oib.0;
        Wed, 08 Feb 2023 15:46:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+icIdKslGvMFTYoNpZsRusMzcE34hYdnJpALIQzixk=;
        b=ROjFRIJL6KDIXXNHUt2UatbEWXpYnBE380bxPLtEDC68ymYYO5GnvV9QskdkDxptzb
         uQeOZqBokSx16wCzRJoOy6pvlyJPFRnC155CQpq51GCxcE7cbM5ktlpqg6EnEQFzgaMG
         rzzqzxhyxcM/Da/BCQHeb+p0epzYhN0hpD2er3FizbbiUCXhg8oKjNxfcpTkClzAN/Nf
         0qZPN24uUgWmIxcVN2SlyvMPqz1uja6tW4OniMTXh1itfxHETf03Y0KZYiHRIJJn4JJ2
         G8hI6873vlxAsqiUrz2B2fkVGyJU6XJnA7t5/I1viuD7dluQQnEDsMtUq7gZauJr2XfS
         p8YQ==
X-Gm-Message-State: AO0yUKUq3/mdZ8xSgGiwz/+HMjBz+7VZz8VIw4ZYowPFgPyT57w8qWLf
        NrnJG2toqrs72VyDg0mDsw==
X-Google-Smtp-Source: AK7set+t4lw5gVcug+Sb9ZM+igBFEHDv4+leQDcKVRz+QrmI0qjbrl7Y7T8tHpaaJA9Cfjk7F+5V3w==
X-Received: by 2002:aca:1015:0:b0:36d:ea30:7bdf with SMTP id 21-20020aca1015000000b0036dea307bdfmr3728234oiq.49.1675900012280;
        Wed, 08 Feb 2023 15:46:52 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s83-20020acac256000000b003785a948b27sm47788oif.16.2023.02.08.15.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:46:51 -0800 (PST)
Received: (nullmailer pid 2935262 invoked by uid 1000);
        Wed, 08 Feb 2023 23:46:51 -0000
Date:   Wed, 8 Feb 2023 17:46:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: phy: amlogic,g12a-usb3-pcie-phy: add
 missing optional phy-supply property
Message-ID: <167590001058.2935209.9991726555575605805.robh@kernel.org>
References: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207-b4-amlogic-amlogic-g12a-usb3-pcie-phy-fix-v1-1-3e437b759549@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 16:03:53 +0100, Neil Armstrong wrote:
> Add missing optional phy-supply property used to power up PHY regulators.
> 
> Fixes: 87a55485f2fc ("dt-bindings: phy: meson-g12a-usb3-pcie-phy: convert to yaml")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/phy/amlogic,g12a-usb3-pcie-phy.yaml          | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

