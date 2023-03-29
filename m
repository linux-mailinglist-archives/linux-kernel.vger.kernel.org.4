Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501EC6CF372
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC2TpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 15:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjC2To7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 15:44:59 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9235B90;
        Wed, 29 Mar 2023 12:44:42 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-17997ccf711so17441632fac.0;
        Wed, 29 Mar 2023 12:44:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gw4BTbq/GKEHZpknHsWKDHl2LDWv94M+hU6ER2t+0i0=;
        b=qAfe8epRU9bO9aRwl9zLOvj5KJhwhk0onBok+LhJt99dJnSi4wd2vUUW35ym0jv/NH
         uvgGaaewqlXl6q1jKhdRJUkGhtD0lyiAt0pIStsQuVFrFy2f8OiFheaM/mNc+LbeO4iq
         pD8FCR3NDUucK+J0Snq6XpxGe3bW35IGcG5qZ+0HuBN4UA5vYSTUMlkqEsarLX4ytifm
         gCl1WVJ2t1HDAnNhKKkGgeaaSgOT6YjJkBG4IszYHKD8J03PH1rbmKoqbKymyuzQrnJ6
         xpNoRw2ofybvE8D2pKOor9Ja5/NO5KYfG6mMuyZWb62AgWXOGVYihOEWAfQiCfM7UUAR
         90wg==
X-Gm-Message-State: AAQBX9fNUNOuxg+/MGGtJjeb7HsH/Y5yxXPmikqKgX0t2M5N/bXWHEoc
        TXZPIpLuPaCjg5VsdcEBug==
X-Google-Smtp-Source: AK7set+O9Odhp1fWLs2DYIMjVAxvfspb1xzgtELXVpLM0P2qPRhdawCZdo1a7m777DWX9U02hiRWpw==
X-Received: by 2002:a05:6870:65a5:b0:17a:c102:b449 with SMTP id fp37-20020a05687065a500b0017ac102b449mr12497538oab.59.1680119075716;
        Wed, 29 Mar 2023 12:44:35 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id tk6-20020a05687189c600b0017703cd8ff6sm12085149oab.7.2023.03.29.12.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 12:44:35 -0700 (PDT)
Received: (nullmailer pid 4097012 invoked by uid 1000);
        Wed, 29 Mar 2023 19:44:34 -0000
Date:   Wed, 29 Mar 2023 14:44:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Michael Srba <Michael.Srba@seznam.cz>,
        Harigovindan P <harigovi@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: display: panel-simple: merge Innolux
 p120zdg-bf1
Message-ID: <20230329194434.GA4096624-robh@kernel.org>
References: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230326155425.91181-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 05:54:20PM +0200, Krzysztof Kozlowski wrote:
> There is nothing special in Innolux p120zdg-bf1 panel, so just like
> other Innolux panels it can be made part of panel-simple.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../display/panel/innolux,p120zdg-bf1.yaml    | 43 -------------------
>  .../bindings/display/panel/panel-simple.yaml  |  2 +
>  2 files changed, 2 insertions(+), 43 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/panel/innolux,p120zdg-bf1.yaml

Series applied to drm-misc-next.

Rob
