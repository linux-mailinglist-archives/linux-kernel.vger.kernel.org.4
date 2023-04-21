Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801A86EB30B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjDUUuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUUuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:50:52 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78041FCE;
        Fri, 21 Apr 2023 13:50:50 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6a606135408so2272411a34.0;
        Fri, 21 Apr 2023 13:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682110250; x=1684702250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXtCjLr6e0ACopDROp6u8nUQuHmLJz4px5GPfgN7eBs=;
        b=TUaO0wl8KaFHrcF1Lj21f1zJ5mly5IVwmjyLPjGpv8SBL180QIdPBhhFUYyiky4JUr
         ZvvTM4935larbI6j+beSwZ0K4dxr1ALUgaPhevsUL8B0NyJmBjwPmsnGb+PYmpJZbCvx
         7J3RASs80R0nC27nq/M/BavElF7r7XgfbSAQUZt4TFUfIxR5Yc1fUROrkyO1Qd/Fy9ag
         JyGkoJMuz6TixS5d/PXiORdrh98uiug9/XE8bEcNu5V/kjQgrw7/76giacfPyyjh3RTA
         PcdXYW3h1amF1IIsWeTWRYw5JZaC77TzV/JQhG4CTyBrTydfOcuKBz2ava5+yliJiu30
         bM8Q==
X-Gm-Message-State: AAQBX9eG05GlcExWdPTt/DB1OzoUnAclYaTd9QUN6N6aO7u61pXmKoOF
        0t2uCnDXSXswMOJnd02QMA==
X-Google-Smtp-Source: AKy350bPLU6VfMLXu2FkytWiKxId89Rd2v0v24jbsfIKHmbVrFRwKEmRaexmkc8JvSdGQcxb3jpkAg==
X-Received: by 2002:a9d:6348:0:b0:69f:7d3:6eae with SMTP id y8-20020a9d6348000000b0069f07d36eaemr3194982otk.7.1682110250073;
        Fri, 21 Apr 2023 13:50:50 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i15-20020a9d624f000000b0069fb8bfb4f3sm2071766otk.77.2023.04.21.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:50:49 -0700 (PDT)
Received: (nullmailer pid 1745210 invoked by uid 1000);
        Fri, 21 Apr 2023 20:50:48 -0000
Date:   Fri, 21 Apr 2023 15:50:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: ov2685: Correct data-lanes attribute
Message-ID: <168211024600.1745117.14232716289484936971.robh@kernel.org>
References: <20230419-ov2685-dtschema-fixup-v1-1-c850a34b3a26@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419-ov2685-dtschema-fixup-v1-1-c850a34b3a26@z3ntu.xyz>
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


On Wed, 19 Apr 2023 17:58:27 +0200, Luca Weiss wrote:
> When adapting the original doc conversion to support 2 lanes, minItems
> should've been added as well since the sensor supports either 1 or 2
> lanes. Add minItems to make the validation happy again.
> 
> Fixes: 8d561d78aeab ("media: dt-bindings: ov2685: convert to dtschema")
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

