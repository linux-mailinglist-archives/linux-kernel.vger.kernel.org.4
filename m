Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8552C65459D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 18:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLVRZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 12:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiLVRZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 12:25:09 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6795BC;
        Thu, 22 Dec 2022 09:25:06 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so1445278otk.8;
        Thu, 22 Dec 2022 09:25:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ywdkxpZzszObyiaiHAhYDxjz+PlTqZSkApdfOvvTQ0=;
        b=BHE2yHXE1DDbI3ikHZ+/LeykKIJu1E5Mgeb2j7aN22epXnKvo7FFp0cjAunNURrpvp
         n10f1xZazcMWm6weLaMSzDAzgCAAjvQ1KEgpy+6qkMa6uqTsUb6+GfG5dD8C3W1judx7
         ROUqdAzlJScpqJ4YtyOxtlUyZv1umc7IVPwymurrUPfPIQmxzaltWATX7pew2pzqgTWv
         k6xi34NMXAftrazFtHoGxQIWacfD/784LIRERZvX9eHzbdCGtuGoS4krhEIgAt5K+Kek
         ag1lx95+uBmxXBLW1xH+oAx7LKcCANhlWzUdhxtGFW33bTkFRoifTKtuUkbzvCzTvXRU
         /Kcg==
X-Gm-Message-State: AFqh2kphPaqLSB+rnyUEe32JY8WuWuvK74rRatu2hwYeCVL9TvvIadmG
        zP8G3NEBefKP7zE/XaV0Vw==
X-Google-Smtp-Source: AMrXdXt5z9z5o3HrtDtlpTLaUxF8WJ7smRmdVlV7GJ1nnomSW+EwnHVVb0D3SaYlD4+RiYOwlnOIbQ==
X-Received: by 2002:a9d:6550:0:b0:670:6f6c:5fc7 with SMTP id q16-20020a9d6550000000b006706f6c5fc7mr2988539otl.9.1671729905440;
        Thu, 22 Dec 2022 09:25:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u20-20020a9d4d94000000b0066871c3adb3sm557759otk.28.2022.12.22.09.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 09:25:04 -0800 (PST)
Received: (nullmailer pid 1746062 invoked by uid 1000);
        Thu, 22 Dec 2022 17:25:04 -0000
Date:   Thu, 22 Dec 2022 11:25:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuteng Zhong <zonyitoo@gmail.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
Subject: Re: [PATCH v3 1/2] arm64: dts: rockchip: Add RK3566 LubanCat 1
Message-ID: <20221222172504.GA1741501-robh@kernel.org>
References: <Y6Kc650FuvHFWxP0@VM-66-53-centos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Kc650FuvHFWxP0@VM-66-53-centos>
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

On Wed, Dec 21, 2022 at 01:43:07PM +0800, Yuteng Zhong wrote:
> LubanCat 1 is a Rockchip RK3566 SBC based
> is developed by EmbedFire Electronics Co., Ltd.
> Mini Linux Card Type Cheap Computer Development Board
> It has the following characteristics:
> - MicroSD card slot, onboard eMMC flash memory
> - 1GbE Realtek RTL8211F Ethernet Transceiver
> - 1 USB Type-C port (power and USB2.0 OTG)
> - 1 USB 3.0 Host port
> - 3 USB 2.0 Host ports
> - 1 HDMI
> - 1 infrared receiver
> - 1 MIPI DSI
> - 1 MIPI CSI
> - 1 x 4-section headphone jack
> - Mini PCIe socket (USB or PCIe)
> - 1 SIM Card slot
> - 1 SYS LED and 1 PWR LED
> - 40-pin GPIO expansion header
> 
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>

DHDAXCW is a legal name?

The person sending the patch email should be last.

> ---
> 
> Changed in V2:
>   - Remove RNG node
> Changed in V3:
>   - Modify all node names
> 
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +

Bindings should be separate patch.

>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 600 ++++++++++++++++++

Fix all the whitespace errors checkpatch.pl complains about.
