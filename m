Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F56EE762
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbjDYSLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYSLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:11:05 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A51619B;
        Tue, 25 Apr 2023 11:11:04 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-18eb858b503so1552004fac.3;
        Tue, 25 Apr 2023 11:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682446263; x=1685038263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blucUmTFFpYTbfvcDnO8xeGwtboxlR6eWgksqH9ouRk=;
        b=D0GY08vLTRQ8sQoBzuWIPmUlSwr1zlooOasJoWhDm65ceW8V7uLWj/K2OdNSC9iAGX
         Uz45ZbfMmLUf1E/wV4FGvgOTRkfsAWd8ArxoAqY8uRSvl0B01QSQLFX+rAS3vqXJ73o6
         SrlsXRDZU4z/BtkbA75AzhqjVguKUgIU6xENArDWSbruxjERhn5arUlNmbRvl81aGlwY
         qFZdbrRGnpi3gxAS5oJyv55HyRlAgY1pBUS91rDVg123YcBXiUaLLi3rgEJMdxtozw5i
         +8fxomEC6TnjMXtr4RM8a7xS9YKn/4r97G7Pq3NwlivDceuOIY5cGGbL+ucYl3KVlr+e
         C0zQ==
X-Gm-Message-State: AAQBX9eQRkB40SY7Yqt6ixpIpcvNp95bF41WUAqlh29+ZdXIsZPr7W4i
        TPEUK4/HjzFq8Zvf2eV2Yw==
X-Google-Smtp-Source: AKy350ab+YkZ7m8tzyd2lMcmqjzLCSkKC3Fd7xKM9Ad2SJ7uD/BQj013Z3HR+2XikXPzNJctOz8xsw==
X-Received: by 2002:a05:6870:a406:b0:17f:cf1f:9d8f with SMTP id m6-20020a056870a40600b0017fcf1f9d8fmr11610087oal.8.1682446263383;
        Tue, 25 Apr 2023 11:11:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a056870e50500b00187e500e7b3sm5724335oag.49.2023.04.25.11.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:11:03 -0700 (PDT)
Received: (nullmailer pid 2031664 invoked by uid 1000);
        Tue, 25 Apr 2023 18:11:02 -0000
Date:   Tue, 25 Apr 2023 13:11:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org, michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/7] dt-bindings: display: panel: Add Ilitek ili9805
 panel controller
Message-ID: <20230425181102.GA2031194-robh@kernel.org>
References: <20230421154308.527128-1-dario.binacchi@amarulasolutions.com>
 <20230421154308.527128-5-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421154308.527128-5-dario.binacchi@amarulasolutions.com>
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

On Fri, Apr 21, 2023 at 05:43:05PM +0200, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Add documentation for "ilitek,ili9805" panel.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>  .../display/panel/ilitek,ili9805.yaml         | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9805.yaml

Same comments on this one.

