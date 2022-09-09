Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D7F5B3D5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiIIQrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiIIQrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:47:23 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DE6145FF5;
        Fri,  9 Sep 2022 09:47:12 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id l7-20020a056830154700b0065563d564dfso1394726otp.0;
        Fri, 09 Sep 2022 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Z3Bk8gw//Jqs0Nz+1Df9SNsgz3sVODj2lJ7DrNb/rcw=;
        b=5pGbJVBE8gRWuMmEtsNZaNvVR2BWPecLuV6Ly9Hxa4bzddKT6G1qwfPTYTFhWJsAXG
         RwuBg4icbMd3QXHBRFUpTfx6b8YfCFspwkL4jfvtvpGVBpMCtLu+2EUHf4FtcrsrVgXI
         PjabJWy2CUpz1g3Ny/mHfG1MAmzCfHe+B87jR6MPOJUlp9eGP7A9neeMT4HKmWvQ4bZO
         WFxQXiNjIChKR147PhiTZud/bUsDi8l5nNeQJ75ZUhkKcY//oLMsH9gImhD9kEo1uUNE
         MQJ2QubnJnRkfH5Ou0Mx2eAYpa3ZT9IEPpRWAz83NsSnh+gBSaAazWPeCrUpy8iiIsHe
         IN4w==
X-Gm-Message-State: ACgBeo0AMwEWkbgcSq5NFRoCL5V/EQY39GFuaApJqjmk/fHdR3hVjhIw
        mFbaB9CWUi8eZRZpmY3LWA==
X-Google-Smtp-Source: AA6agR4E0MTyy++dKWEmauODIGuopUtC+EC56O+epKPx3hJsvFGl4In3n6Mp/CwHpG0SDrmCUgiIEw==
X-Received: by 2002:a05:6830:33cd:b0:654:fc7e:f4ee with SMTP id q13-20020a05683033cd00b00654fc7ef4eemr1643807ott.171.1662742031605;
        Fri, 09 Sep 2022 09:47:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z36-20020a056870d6a400b0012b2b0b6281sm442358oap.9.2022.09.09.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 09:47:11 -0700 (PDT)
Received: (nullmailer pid 1600337 invoked by uid 1000);
        Fri, 09 Sep 2022 16:47:10 -0000
Date:   Fri, 9 Sep 2022 11:47:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>
Cc:     jdelvare@suse.com, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 3/4] dt-bindings: hwmon: Add bindings for max31760
Message-ID: <20220909164710.GA1537271-robh@kernel.org>
References: <20220909133718.388213-1-Ibrahim.Tilki@analog.com>
 <20220909133718.388213-4-Ibrahim.Tilki@analog.com>
 <1662740789.477872.1507147.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662740789.477872.1507147.nullmailer@robh.at.kernel.org>
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

On Fri, Sep 09, 2022 at 11:26:29AM -0500, Rob Herring wrote:
> On Fri, 09 Sep 2022 16:37:17 +0300, Ibrahim Tilki wrote:
> > Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > ---
> >  .../bindings/hwmon/adi,max31760.yaml          | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31760.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/hwmon/adi,max31760.yaml: error checking schema file

Not sure why the error is useless ATM. I'm checking that.

The problem is that 'reg' is a matrix and you need to either fully 
define it or use the simplified form for a single cell:

reg:
  minimum: 0x50
  maximum: 0x57

The full, expanded form is:

reg:
  items:
    - items:
        - minimum: 0x50
          maximum: 0x57

> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31760.yaml: ignoring, error in schema: properties: reg

> Documentation/devicetree/bindings/hwmon/adi,max31760.example.dtb:0:0: /example-0/i2c/fan-controller@50: failed to match any schema with compatible: ['adi,max31760']

This will go away when the schema passes checks.

Rob
