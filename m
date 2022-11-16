Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4A962CB89
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiKPUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiKPUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:52:42 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BFB65869;
        Wed, 16 Nov 2022 12:52:41 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so11046272otb.1;
        Wed, 16 Nov 2022 12:52:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDywA0KDoxA4q9xlgxQNU19XoltQxhbezIPsKTrlTvQ=;
        b=PW8sFuG9jNSQCBVs2vGsriDJx8He9YrmHAKtOiPt4tKNb7YTdkqVH8Mcn78s5i3Zuv
         ipr7rXlIuWQTUXCzgdYlDIsdO5eAHapVGm0opKfScHlRPoVQWFv6MwKOWYZ2AQcoaj7e
         8pXLpzJ/+2iE6r64Lns9VIj8BXq9Nf7uWy7LgQc3YN5y/LoGEHMsiGFQM7y0VTQd8+V5
         ePe+7EMv98bCjLGZQ9LxaKf80vCby21oagYV2IoNMfBZldMTsFRFZBnBl2Sozw/0w3U4
         OJ+TWTz+kYLkxAViVmOW06n/u1Ihdv5rrNSCV9+4WPLN7i8C6+PIDd4iEO0iRhIgjxA8
         iITw==
X-Gm-Message-State: ANoB5pnQE3BNeUKBROLpH5s9d4T3GyJ865VMKAnTQqV6Md2iDOHJM4lR
        uosLQlaiJNoBawe8fdEN/Q==
X-Google-Smtp-Source: AA0mqf6UwXoHR+Cq780mOlw4cFFEJrWbD2/F4pKg9asCduIoCMZ997M8D2kS6lpzSZ5vvqwaXXi4Ew==
X-Received: by 2002:a05:6830:1212:b0:663:c55e:c5ac with SMTP id r18-20020a056830121200b00663c55ec5acmr11659729otp.196.1668631961011;
        Wed, 16 Nov 2022 12:52:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a97-20020a9d266a000000b0066c2e241a4csm7097395otb.20.2022.11.16.12.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:52:40 -0800 (PST)
Received: (nullmailer pid 862564 invoked by uid 1000);
        Wed, 16 Nov 2022 20:52:42 -0000
Date:   Wed, 16 Nov 2022 14:52:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: Re: [PATCH v4 2/5] dt-bindings: eeprom: Inherit from nvmem.yaml
Message-ID: <166863196213.862502.10335665514418760279.robh@kernel.org>
References: <20221114085659.847611-1-miquel.raynal@bootlin.com>
 <20221114085659.847611-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114085659.847611-3-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Nov 2022 09:56:56 +0100, Miquel Raynal wrote:
> EEPROMs can be nvmem providers. Let's make all EEPROM bindings
> reference nvmem.yaml as they should, so that nvmem cells and layout
> parsers can be safely described within the EEPROM nodes.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  Documentation/devicetree/bindings/eeprom/at24.yaml           | 5 ++++-
>  Documentation/devicetree/bindings/eeprom/at25.yaml           | 1 +
>  .../devicetree/bindings/eeprom/microchip,93lc46b.yaml        | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
