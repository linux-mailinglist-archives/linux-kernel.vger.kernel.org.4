Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971027440FA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjF3RQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjF3RQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:16:28 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212635B6;
        Fri, 30 Jun 2023 10:16:27 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7835c92c373so49606439f.0;
        Fri, 30 Jun 2023 10:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688145387; x=1690737387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0brUkaNoGNkkAE49+0o1RyyopO2CLSMIqAvAmOmKs84=;
        b=dPk7C3AURD5WdUbZpH9UpvJzbXg3dw2/fcQohekwsQ/YMeU6hgUigNsAumYfM2aQvY
         3Fst568PYtgo6/cJzA09A3hwo/KYvhOxch15m5zmNLdadW5sudX2kiBFOt2PNAckS+FN
         x29cX3CI6tH3XUAO9LbVFq+oQDrxWPyK7bNJgf55K2mbppfYJsT3d1HSL0VFjyyDAVvh
         IIEdjgKHOC1qKqGZRv46ymmqzijj6WfGG4Y+6sgRL+rLxlNOn6p8cpa25K4B3vVy1ge8
         XWhomu6dVPW3W+84gCc1waaQJ/lChhFVH1LZU3gxvGi4cT65AiLzwkehK3NqZQ3rhBW7
         LHBQ==
X-Gm-Message-State: AC+VfDxDzab9I1allbrV//g6yV96rfDIGPvqJzzwh2DvaBEauYmV1r11
        kzsH2LL9TmM7yca5gz3yxg==
X-Google-Smtp-Source: ACHHUZ4EUSxBlUA2Q7Jj1N1M1Vujx1knZjm24O5/8M4WYtrHG2nVEik0sef5hv3sXquLnx3OFCm5uA==
X-Received: by 2002:a5e:c103:0:b0:783:498c:9cf0 with SMTP id v3-20020a5ec103000000b00783498c9cf0mr2712618iol.4.1688145387134;
        Fri, 30 Jun 2023 10:16:27 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id h23-20020a5e8417000000b00783634b9eafsm3348125ioj.50.2023.06.30.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 10:16:26 -0700 (PDT)
Received: (nullmailer pid 1984513 invoked by uid 1000);
        Fri, 30 Jun 2023 17:16:24 -0000
Date:   Fri, 30 Jun 2023 11:16:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        srinivas.goud@amd.com, robh+dt@kernel.org, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        radhey.shyam.pandey@amd.com, git@amd.com,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V2] dt-bindings: watchdog: cdns,wdt-r1p2: Convert cadence
 watchdog to yaml
Message-ID: <168814424241.1895713.3802904090235932045.robh@kernel.org>
References: <20230601052237.2604997-1-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601052237.2604997-1-srinivas.neeli@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 10:52:37 +0530, Srinivas Neeli wrote:
> Convert cadence watchdog bindings to DT schema format using json-schema.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Changes in V2:
> - Added missing mailing list emails.
>   Conor Dooley <conor+dt@kernel.org>
>   devicetree@vger.kernel.org
> ---
>  .../bindings/watchdog/cadence-wdt.txt         | 23 -------
>  .../bindings/watchdog/cdns,wdt-r1p2.yaml      | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/cadence-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/cdns,wdt-r1p2.yaml
> 

Applied, thanks!

