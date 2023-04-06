Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B23F6D9DD3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239056AbjDFQrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238800AbjDFQrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:47:37 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F9D83F6;
        Thu,  6 Apr 2023 09:47:15 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id w13so18113321oik.2;
        Thu, 06 Apr 2023 09:47:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680799634; x=1683391634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4YfchWdjXjTn0JuMSZJ2W3hFarimqnpUe1TA/nvAeH0=;
        b=Nr+Hk4/yBcnjr5gelZAsXPVGITPa6HQnH2hrIx8yXHxQl0mX2WofaTIqaqqk2Mna87
         M51Ees3k4Ryd+Eed1SWzIkCOe8ewQ+LnzrIZ1L4KCjKPEmULp6BfF711DVRVaUhMmMax
         SfVrQrbm9mtC4V1oRxplLtCwFOKv98IC/MlV1brJ+JT+gJ4LR5jZeVMr6DwJEDtKhqsK
         HLOwHALGsF4zJqK0Ng6Bl9jrMBn12/h6LaCBAV7R99omtO3JGZ69aw6ENqiKPKxFgClj
         a+o2Z614rgGCKFOs8x+2sklz0lRBpYhZvfyk24wwv0WX4VPaM9ighsusB0ujGIBYHUW1
         tHUA==
X-Gm-Message-State: AAQBX9cQNwB+2971hV55EfiB95dGb/Anbl9pae/Mu/2+3plAo+3DnoO9
        FzkIKUjGRAt7YtKEOMwyVw==
X-Google-Smtp-Source: AKy350bbuaIAoZEiwjlysJa0+efhJhrgeaPw7tJOM4quQaWsEDJyjqAZugMjUjS4tmDtQcileK3kag==
X-Received: by 2002:a05:6808:257:b0:387:1b0f:c03d with SMTP id m23-20020a056808025700b003871b0fc03dmr4863580oie.28.1680799634503;
        Thu, 06 Apr 2023 09:47:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj22-20020a056808199600b0038733b00a5fsm856210oib.10.2023.04.06.09.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:47:14 -0700 (PDT)
Received: (nullmailer pid 3282311 invoked by uid 1000);
        Thu, 06 Apr 2023 16:47:13 -0000
Date:   Thu, 6 Apr 2023 11:47:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abraham I <kishon@ti.com>, Yuti Amonkar <yamonkar@cadence.com>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Swapnil Jakhade <sjakhade@cadence.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: phy: cadence-torrent: drop
 assigned-clocks
Message-ID: <168079962419.3282109.11445334016801468789.robh@kernel.org>
References: <20230404190115.546973-1-krzysztof.kozlowski@linaro.org>
 <20230404190115.546973-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404190115.546973-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 04 Apr 2023 21:01:12 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here and a board could actually need more of clock
> assignments than the schema allows.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml        | 6 ------
>  1 file changed, 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

