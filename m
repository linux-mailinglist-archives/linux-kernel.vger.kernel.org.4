Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7269E388
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjBUPem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUPej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:34:39 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C612330F;
        Tue, 21 Feb 2023 07:34:38 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id y8so4836322oiy.6;
        Tue, 21 Feb 2023 07:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPZ9w/mJMwHQADuar36Ew6+bDf4d5LulJH0xzYxETUI=;
        b=zj/7J2/BPbNKZ8o+w+NFl1zjB6w2ijimPglYWZuF73tTvwmo8CKyY96wvIpK+uWMKo
         rIWpTYWB/jRIzMh7c026rQ/ZZV5S8aKQJeJqO+7qjRUgfwQWlzlJeT77P1FQjuf7IlY+
         BhGrP8dtzly5Zp9K7JNpnPxXSYsLG1K8j+85jxjpM/utN8dRREZapxwNwyjO/8OXOdDa
         GjzncnYyrVJiCnblsZ1llQxIjYkuYztqd2yZysHZNT949ad+aLIcTMHAArgmww0Jl93g
         F0IU7d/9nQcHsHQl70iCUucD7XWOTz/0kevwUVtIgvn0h2gQh+9d1kSpNuF9kGsjkfI5
         KgYQ==
X-Gm-Message-State: AO0yUKVBfll9vUWQBI6VkBYAW7oHnBluRWibVEoRU8X1r9gp5sUqINQJ
        vebrE7pF/fFeiPkgsW5hBg==
X-Google-Smtp-Source: AK7set/sStOZzxCPbndd6bmxqW6CaEtYI6tI8MD8HAnORp0pSLDH0sYTVFLYbT2dKnGO9vdpFnCEzg==
X-Received: by 2002:a54:4412:0:b0:37f:a534:3de9 with SMTP id k18-20020a544412000000b0037fa5343de9mr183834oiw.4.1676993678016;
        Tue, 21 Feb 2023 07:34:38 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q127-20020acac085000000b0037d813cd612sm316937oif.43.2023.02.21.07.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:34:37 -0800 (PST)
Received: (nullmailer pid 2576524 invoked by uid 1000);
        Tue, 21 Feb 2023 15:34:37 -0000
Date:   Tue, 21 Feb 2023 09:34:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
Message-ID: <167699367567.2576443.8351931302556927937.robh@kernel.org>
References: <20230221102545.2103632-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221102545.2103632-1-keguang.zhang@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 18:25:45 +0800, Keguang Zhang wrote:
> Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> V2 -> V3: Fix the description
> V1 -> V2: Drop the description part
> ---
>  .../loongson,ls1x-intc.txt                    | 24 ---------
>  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
>  2 files changed, 51 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> 

Applied, thanks!

