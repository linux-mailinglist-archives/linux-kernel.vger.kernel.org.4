Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD72D5B6C89
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiIMLtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiIMLtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:49:15 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DCF1DA5E;
        Tue, 13 Sep 2022 04:49:15 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-127f5411b9cso31350004fac.4;
        Tue, 13 Sep 2022 04:49:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=jfHxk46l/Ubkw1ya447s4gixNu2E4pZBle5cj7lC+04=;
        b=Hb6iaXRi2T98o+bt0NCS2OZK0OkPWfU01fFL4vtq1RaMlBAA3IheU38dRHrBOYTy7+
         0Cl2RSxDU8VGEeB6PdTWA/52sosW57LNaVrlEYv+UDJoVbybrFcxx96oK9ojgiLR6xPn
         t/Iz9kQTI6pYtGKQNZMv98f3kCXCc4hNg73bc13fVDczhXGS7Fknx/oD8THL2MctDRx/
         eg77jA79ooiayQkm1YyqhPAvSbWgMPL6c7GWbAOU0pMY4AnfoTARjvo4QZNAIbeaNYE2
         4p4qJlNmOys5aAzI9B3dVSy2yd90Zp7juieQeNJYZvHM7OPu2oPsa1JfiEPbb6g1M+ZI
         0nLg==
X-Gm-Message-State: ACgBeo1+wBlRf9fN6sAr4UhyOVRuSmc/cbpB/o+fjkOnLjCdAXfHL2Lg
        rogizBIf3KvE2BT/OdcPKw==
X-Google-Smtp-Source: AA6agR4fA8xkyndeFcHZAvqpj4k5n+3xbo2JfoulUiG/P4CVnStgOgoXTpHXRD1gSV285hXLSiz+1w==
X-Received: by 2002:a05:6870:c1d3:b0:126:8942:24e6 with SMTP id i19-20020a056870c1d300b00126894224e6mr1508181oad.111.1663069754339;
        Tue, 13 Sep 2022 04:49:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w10-20020a4aca0a000000b00475652b97d8sm3396803ooq.42.2022.09.13.04.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:49:13 -0700 (PDT)
Received: (nullmailer pid 3375583 invoked by uid 1000);
        Tue, 13 Sep 2022 11:49:13 -0000
Date:   Tue, 13 Sep 2022 06:49:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        linux@roeck-us.net, rtanwar@maxlinear.com,
        andriy.shevchenko@intel.com, hhhawa@amazon.com, jonnyc@amazon.com,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v5 11/21] dt-bindings: hwmon: (mr75203) add
 "moortec,vm-active-channels" property
Message-ID: <20220913114913.GA3375473-robh@kernel.org>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-12-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-12-farbere@amazon.com>
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

On Thu, 08 Sep 2022 15:24:39 +0000, Eliav Farber wrote:
> Add optional "moortec,vm-active-channels" property to define the number
> of active channels per VM.
> 
> This shall be useful to avoid exposing sysfs for reading inputs that are
> not connected to any voltage source.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V5 -> V4:
> - Fix typo in description (nou --> not).
> 
> V4 -> V3:
> - Fix DT checker errors.
> 
> V3 -> V2:
> - Add "moortec" prefix to property name.
> - Add explanation why this change is needed.
> 
>  .../devicetree/bindings/hwmon/moortec,mr75203.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
