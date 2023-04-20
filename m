Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0046E9D3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjDTU3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbjDTU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:29:24 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701256A69;
        Thu, 20 Apr 2023 13:28:29 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-38dec65ab50so817520b6e.2;
        Thu, 20 Apr 2023 13:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022508; x=1684614508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BN77bzqJ/yB3QRLGMq1KZD+vDxVUQ63pMFzLm/nky90=;
        b=DQHlk+00Bi6Z/g6kRVYz2R2IUQlqP2N59benrPEetEx4D+Cdlbo8lT0SyY2/Fsf78M
         r9eVLjEY4F83LFjP/z5ERc5DdNorQabbnmjXWZomhvOkxdBB15k15H0GowpxDRZJhWZ2
         2MZmQHXoq5i3Bsk5MxeXNO6EUNc1QkGNS/ROkSLiZtWsnXo+V44cNyZHTGVkhjqXIcbv
         z+EY923IYIoZ0na1+fkqGSTBDhHMzDHq/nFNjxBk1DBm4e4ndjlCeNdrhDDgit1ejyks
         xPkI2KYROGQpr4mmL8CzZrH1jRRN++vNOfOS2dF84KqzLEDdW+B9uMm8t/Mnv8KdoMTx
         o6ug==
X-Gm-Message-State: AAQBX9c5OxUmo4sdpE5WFClExdVwuBBZEdC6Vf9nwKuaznIEvC3gh++E
        QdPqUFiBBkHgX12j86j15BPRg+HXog==
X-Google-Smtp-Source: AKy350YP/wcJUWbAJZqPtERkTWpbOBn8zaoVA7FARmNZR360RMUPkqUkW8Gbr0sDfp/ANPlj4XEhCg==
X-Received: by 2002:a05:6808:1507:b0:38e:eaf:cf2d with SMTP id u7-20020a056808150700b0038e0eafcf2dmr1811511oiw.56.1682022508227;
        Thu, 20 Apr 2023 13:28:28 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g5-20020a4a8945000000b0053dfd96fa61sm1008295ooi.39.2023.04.20.13.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:28:27 -0700 (PDT)
Received: (nullmailer pid 3448242 invoked by uid 1000);
        Thu, 20 Apr 2023 20:28:26 -0000
Date:   Thu, 20 Apr 2023 15:28:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Heiko Stuebner <heiko.stuebner@bq.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: Fix lvds.yaml references
Message-ID: <168202248831.3447844.12379188835461282102.robh@kernel.org>
References: <20230418150658.1535120-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418150658.1535120-1-robh@kernel.org>
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


On Tue, 18 Apr 2023 10:06:57 -0500, Rob Herring wrote:
> The trailing "/" in "lvds.yaml/#" is not a valid JSON pointer. The existing
> jsonschema package allows it, but coming changes make allowed "$ref" URIs
> stricter.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/panel/advantech,idk-1110wr.yaml | 2 +-
>  .../devicetree/bindings/display/panel/innolux,ee101ia-01d.yaml  | 2 +-
>  .../devicetree/bindings/display/panel/mitsubishi,aa104xd12.yaml | 2 +-
>  .../devicetree/bindings/display/panel/mitsubishi,aa121td01.yaml | 2 +-
>  Documentation/devicetree/bindings/display/panel/panel-lvds.yaml | 2 +-
>  .../devicetree/bindings/display/panel/sgd,gktw70sdae4se.yaml    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 

Applied, thanks!

