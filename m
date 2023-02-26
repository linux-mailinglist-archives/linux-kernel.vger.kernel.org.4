Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07F26A339F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBZT2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZT2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:28:44 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FCE7AA5;
        Sun, 26 Feb 2023 11:28:43 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id a1so2889117iln.9;
        Sun, 26 Feb 2023 11:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKuQGwgeivweI5xlO+yyhOKyA8QolVQHlkAsgWNyaXU=;
        b=Zv5X860df2UXEXj3Z9RcC+s4iuWP4PRjzYRvc53wGcXiZ+XkDZq8jIO1MyCx7ic8L2
         4ZfBkaJGuqvpPOW4fjTeAZClog1letVi/IzYKTsONru1GahrsX1Hb2Fwi8Fj7QIPFRK1
         NppzWl9clnk7WgesNplo9Xsg2aIzZC2sLZSh+nTAx9fvZvJBrZiHr+kZuFyFe6z6S98M
         P9S9+vg8qxgDmuM9DcmGGn7ODRmkWdKLWupLvoafxx8HA0phdHJfThoK5uMTEYsLi+Hj
         9JcYwMeVF3VAeSmm7VoouwnvD66UUbkuIus+wIjtbqUjpmG5mhqDOTmlKBCTb1sV6lyb
         MLuw==
X-Gm-Message-State: AO0yUKVNlqGRCoqonF5AVwHOA0JsOK1/Y47AjitKFrQ3NeskLvxfRoux
        YlMTJIQjfvOOKnHvjAUCkw==
X-Google-Smtp-Source: AK7set/yRKMUsr6NvXUpjmQoil22oIQyZmo7yH+GQmh15bAM5qpqQYM0WWeAVEwjoiMqaT0CkRUWFA==
X-Received: by 2002:a05:6e02:198e:b0:315:9452:2822 with SMTP id g14-20020a056e02198e00b0031594522822mr19889535ilf.0.1677439723216;
        Sun, 26 Feb 2023 11:28:43 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id t11-20020a92c90b000000b003158a3455bbsm1443619ilp.78.2023.02.26.11.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 11:28:42 -0800 (PST)
Received: (nullmailer pid 178199 invoked by uid 1000);
        Sun, 26 Feb 2023 19:28:34 -0000
Date:   Sun, 26 Feb 2023 13:28:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] dt-bindings: input: cypress,cyapa: convert to dtschema
Message-ID: <167743971306.178099.7728165026052288759.robh@kernel.org>
References: <20230221161706.56639-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221161706.56639-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 17:17:06 +0100, Krzysztof Kozlowski wrote:
> Convert the Cypress All Points Addressable (APA) I2C Touchpad / Trackpad
> bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/input/cypress,cyapa.txt          | 42 ----------------
>  .../bindings/input/cypress,cyapa.yaml         | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
>  create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

