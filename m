Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1825B7681
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiIMQaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIMQ3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:29:47 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9265FE;
        Tue, 13 Sep 2022 08:24:40 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1279948d93dso32956281fac.10;
        Tue, 13 Sep 2022 08:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=HBF93/3uK9ytKfofiwTx1nTs+Gg2IlX8qJpJ9qDMavQ=;
        b=2W+ksGrzg7OUySG/4x3B6OcCYhY1v2DvrGEntEwbX9KNP6znF/l/wnqKBcwFddMOYR
         uqO60Yc0ECadqyyGzzUPUIOCey7ZFT/rvmRu7AwzVm7sjo2xT9rOGwqIzroJONuK/S3G
         x6zdq4oYBA3/sXeDzn385OQIX+1exvul/OHYeXKa/8xnmK605P0brs3wzCPfnaZ5dPKa
         4+cxEeO9qIJbI2S4zueU6efdzfvRVB7PQwi8ixnrJamJNqmNmM3fGg1g483mORbydNLa
         bQOEKr1GYLC+lFZNzTLe/rZpM7G9CR3UkvCM/mUhLxysDoIL+GksYGeWpuUJ7Dbfm6J6
         39tQ==
X-Gm-Message-State: ACgBeo22Ji+uMLhIH+9Z7W8DYimMyebTFTtR3oke1+hOsO1zZMd84ZdC
        KlKCEv0LhUdD54AFhK/CZg==
X-Google-Smtp-Source: AA6agR73mOYbb8xQ4qxcGvgPxj2G+or5wV6qhF+ujSQEWH0K2S2Dxeq4LDJSwvhbSYSE8rlvI6P68g==
X-Received: by 2002:aca:3b89:0:b0:345:64e9:73c2 with SMTP id i131-20020aca3b89000000b0034564e973c2mr1723594oia.87.1663082583448;
        Tue, 13 Sep 2022 08:23:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m7-20020a9d6447000000b00616d25dc933sm6013736otl.69.2022.09.13.08.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 08:23:02 -0700 (PDT)
Received: (nullmailer pid 3762736 invoked by uid 1000);
        Tue, 13 Sep 2022 15:23:02 -0000
Date:   Tue, 13 Sep 2022 10:23:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Colin Foster <colin.foster@in-advantage.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-phy@lists.infradead.org, linux-mips@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        UNGLinuxDriver@microchip.com, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: phy: ocelot-serdes: convert to YAML
Message-ID: <20220913152302.GA3762698-robh@kernel.org>
References: <20220911163715.4036144-1-colin.foster@in-advantage.com>
 <20220911163715.4036144-2-colin.foster@in-advantage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911163715.4036144-2-colin.foster@in-advantage.com>
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

On Sun, 11 Sep 2022 09:37:15 -0700, Colin Foster wrote:
> Convert the phy-ocelot-serdes device tree binding to the new YAML format.
> 
> Additionally, add the file to MAINTAINERS since the original file didn't
> exist.
> 
> Signed-off-by: Colin Foster <colin.foster@in-advantage.com>
> ---
> 
> v1 -> v2:
>     * new yaml file is now named mscc,vsc7514-serdes.yaml
>     * examlpes != examples
>     * remove "driver" name from the binding
>     * remove ethernet port consumer from the example
>     * add additionalProperties: false
>     * remove unnecessary, obvious sentence in the description
> 
> ---
>  .../bindings/phy/mscc,vsc7514-serdes.yaml     | 56 +++++++++++++++++++
>  .../bindings/phy/phy-ocelot-serdes.txt        | 43 --------------
>  MAINTAINERS                                   |  1 +
>  3 files changed, 57 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/mscc,vsc7514-serdes.yaml
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-ocelot-serdes.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
