Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587F5EAC93
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiIZQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiIZQcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:32:12 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06441181C0;
        Mon, 26 Sep 2022 08:21:14 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id n83so8607849oif.11;
        Mon, 26 Sep 2022 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=34Dly/59vA9BGCyZSvsKIj3l9vOYmCctczWHkPWb3MA=;
        b=f6lbFYze4rqOtYmbcKN2VXG772ZJULviBTUDolnKHOBNqnW+xzTssMxXzAkyOzfFcC
         i56AX2pcYC8ogpaQZPOnFZrHPACXf26U8CSwt26JscvrKRM4J0jJpex2hj5+IxQp3Gjo
         St9MCw/Xz3j2daAP7MNDKb09rvZOFmaJ2ZWNy6CGmTU/bS23p12VdPVzswfWC+u/ily1
         CaFwL2WuWyWVHg4Y1wgUM575WG+PKYsK0bLfdYTER8y5LvnP/4Zf5iliqMjxTNs8oS6f
         7ux+YT3PpqaVMg5RV+IVmKIn56gQBs9rMYzb9hT7g8s9xnd3dXlH/GkcConscIKTFzG/
         /ywQ==
X-Gm-Message-State: ACrzQf2zcnTcMlL7KPMA7xKAZ1qPUCfcbUKCz1GKfxiBcmZ32VqxVPKC
        7IbxM22cs//6MlzIM6nAwg==
X-Google-Smtp-Source: AMsMyM6YF0CeTQRnist/vo7AghkCgUaVZvOXdmVq8mR0R6Qzrp/kssnnRIobhGR0NnBE8FYaGWIC+g==
X-Received: by 2002:aca:b409:0:b0:350:e9a8:15b5 with SMTP id d9-20020acab409000000b00350e9a815b5mr12417878oif.299.1664205630762;
        Mon, 26 Sep 2022 08:20:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z10-20020a9d65ca000000b00636d0984f5asm7992690oth.11.2022.09.26.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 08:20:30 -0700 (PDT)
Received: (nullmailer pid 1982209 invoked by uid 1000);
        Mon, 26 Sep 2022 15:20:29 -0000
Date:   Mon, 26 Sep 2022 10:20:29 -0500
From:   robh@kernel.org
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH v4 2/8] dt-bindings: arm: cpus: Add kryo240 compatible
Message-ID: <20220926152029.GA1981960-robh@kernel.org>
References: <20220919180618.1840194-1-iskren.chernev@gmail.com>
 <20220919180618.1840194-3-iskren.chernev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919180618.1840194-3-iskren.chernev@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 21:06:12 +0300, Iskren Chernev wrote:
> Kryo240 is found in SM4250, the slower sibling of the SM6115.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
