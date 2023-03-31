Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5879B6D28A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 21:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjCaT0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 15:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCaT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 15:26:18 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB35420C07;
        Fri, 31 Mar 2023 12:26:17 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id y184so17464303oiy.8;
        Fri, 31 Mar 2023 12:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680290777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QG+3vcoiKpypL3RpLDG/DALqcVwEWd1dtFI2TUE2EJc=;
        b=on2+IQIbVr+xm5m2Svj0UNlWE4iAi6JeyjmGHp07cot1+B8vOH/Qzygkv79rQ6fHH1
         i7y6sPiY7rEXKz++dizfTEWk3BulTyTLNIt9DWMKkzqzmNh+AT8eSRUtolYP4QhsocLM
         3QHtAAp0z6wKhTkkJlpgBRbYNJW5qcZrvq73Ylz2kehhku6LFsIhrnUzsmZIFMLjlqNG
         jeQD1nwPrfBlZ4dtE0QIiL2k7U04vHMnR0zc8fhCoprhzIfx0ClMvihYJ3J6PmO2xAhO
         s4riVXMM9Z+04ijam29Mbt2dvU+pNP0+SWUcP+G+nbDLR+xV7fjmauZgiqMV/sFQA8Cf
         9nhA==
X-Gm-Message-State: AO0yUKVPcdXWt8n/akcZPYBuphMOlS0leCIL2fkqu87a1X0ZB+kyDHPH
        Fs6yuC3hGRyVyVK5r5tXnw==
X-Google-Smtp-Source: AK7set8/VWQr5CVqKOtd67yZ6gqCo9i14nUeVDoECRGKJZHR0qvc44LdPfsnJ79D+XkRd1ir0MBlgA==
X-Received: by 2002:a05:6808:9a6:b0:386:a0c5:4a7 with SMTP id e6-20020a05680809a600b00386a0c504a7mr12602448oig.16.1680290775536;
        Fri, 31 Mar 2023 12:26:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s25-20020a056808209900b00383b371f2a7sm1279388oiw.42.2023.03.31.12.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 12:26:15 -0700 (PDT)
Received: (nullmailer pid 2085725 invoked by uid 1000);
        Fri, 31 Mar 2023 19:26:13 -0000
Date:   Fri, 31 Mar 2023 14:26:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: document Novatek
Message-ID: <168029077201.2085648.12464986262175052883.robh@kernel.org>
References: <20230326155719.91780-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326155719.91780-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 26 Mar 2023 17:57:19 +0200, Krzysztof Kozlowski wrote:
> Document Novatek vendor prefix already used for Novatek nt36672a panel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

