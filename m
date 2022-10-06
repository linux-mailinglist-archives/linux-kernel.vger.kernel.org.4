Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7215E5F6FD2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiJFU4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiJFU4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:56:02 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19CEABD61;
        Thu,  6 Oct 2022 13:56:01 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id t79so3467918oie.0;
        Thu, 06 Oct 2022 13:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DqeI+R+Wl9n6YmzBn1dp1u6WiX9q5YBC2Gudgl+n04c=;
        b=RJR4KQO1GWUVYGah4zBrvcASMg9hgRQTAilTKDAkNiZfnmFjnp/H68tGvOs4K3QFBZ
         QGUcWbvANTo8WPMvVi2PIJ74sNpzdnmKyjhCFQaTu83VeSFxqT0n/si36twMJTCPYkKq
         5U/V/vAhyWdr/q/fn5FeR8YJFVyXiOwoksJQFvTQdn95h+aW8Pw+WK5ocPW9Wvl4Y94W
         4wpfXWaClfSnXyCxXqZZlHZktv6SmgD6roEhUvhtxEvlu8Lsn71OTHarjZnAn4hMUgbe
         is8MZMCNQtfbjIpyxt8TnT/gyxtCmBsRjjh2htq7OvZc6slHM3Trbi6uYmoSMHeBkaJn
         1vbA==
X-Gm-Message-State: ACrzQf10rR7dFXnCi08Y5UQILfUYrWy5uvJLUsYtkORNG6WhUGPxy/4B
        rBaCkmMC3Q49HSastZB+nQ==
X-Google-Smtp-Source: AMsMyM6X6LpwRO/LcfoVsg5SIuVkOuBwInx2Eda/zfB6hqIDLzgK7FK2p36n4ry++iDeYNau7IEijA==
X-Received: by 2002:a05:6808:106:b0:354:2aa2:6d14 with SMTP id b6-20020a056808010600b003542aa26d14mr294097oie.86.1665089761039;
        Thu, 06 Oct 2022 13:56:01 -0700 (PDT)
Received: from robh_at_kernel.org ([2607:fb90:8a65:c536:245:842:a3a4:9017])
        by smtp.gmail.com with ESMTPSA id u12-20020a056808114c00b00353f2786f44sm83144oiu.52.2022.10.06.13.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 13:56:00 -0700 (PDT)
Received: (nullmailer pid 132399 invoked by uid 1000);
        Thu, 06 Oct 2022 20:55:59 -0000
Date:   Thu, 6 Oct 2022 15:55:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maya Matuszczyk <maccraft123mc@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, macroalpha@hotmail.com,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: arm: rockchip: Add Odroid Go Advance
 Black Edition
Message-ID: <166508975874.132347.8187333745126261016.robh@kernel.org>
References: <20221006174519.46161-1-maccraft123mc@gmail.com>
 <20221006174519.46161-2-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006174519.46161-2-maccraft123mc@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Oct 2022 19:45:18 +0200, Maya Matuszczyk wrote:
> Add entry for an updated revision of the Odroid Go Advance.
> 
> Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
