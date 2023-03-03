Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F007D6AA020
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjCCTcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 14:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjCCTcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 14:32:19 -0500
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10118158;
        Fri,  3 Mar 2023 11:32:17 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id bx14so2435915uab.0;
        Fri, 03 Mar 2023 11:32:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677871937;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWJ4FADfr2/FMxcGcYPZfY1Zl6PqjyD4YVCe6cweaQI=;
        b=qpJ/XtXtW3t1BB2iKByZ61SsuHvp14l9KFXCVpYvc81wEshU7jvF+o0TsNTrls8rQz
         RTRduzTmMcWQUo5mjb85RuRn2GlAt0XNp/KexyaBWlEYFrWHmo2K9QrUzMFB2wlvuu9l
         Nwx1aaUkvzaftHnOgNFbJzMIo0BHaU9MgPlPDrBUNxoPPRe3Xw57d9MwBFoPVkjVvDuU
         /fRKEgA5RzW3iLTtCq8Inq+iq+RvYH7zezVN55d9lXf7OQZtqlQS+YVw/yFP6GxeOjTI
         u4YPrxPMJ+8choFsqcmAN0JnBkYBRRavrwpVzDzjjiSLfi4ktVlYxcHHDLxyAFrtHWxZ
         5Yug==
X-Gm-Message-State: AO0yUKUciGYAab77BNMXaLDZ/Bm5fhXcJ0H1DdMpuRpGU+XcN1c6lc5L
        BPfm4V5LAFQogUZMrerR2g==
X-Google-Smtp-Source: AK7set8cRF5Fe5+ipJkJLKsCcOKIoZDntxrqZxlmthlhgeK6tQ7aDR1UrXsoQlyGnVTerRgycdFerg==
X-Received: by 2002:a05:6122:148b:b0:408:a4b6:a48c with SMTP id z11-20020a056122148b00b00408a4b6a48cmr1605791vkp.2.1677871936605;
        Fri, 03 Mar 2023 11:32:16 -0800 (PST)
Received: from robh_at_kernel.org (adsl-72-50-3-187.prtc.net. [72.50.3.187])
        by smtp.gmail.com with ESMTPSA id u17-20020a1f2e11000000b004134e4380c2sm392541vku.24.2023.03.03.11.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 11:32:16 -0800 (PST)
Received: (nullmailer pid 19152 invoked by uid 1000);
        Fri, 03 Mar 2023 19:32:13 -0000
Date:   Fri, 3 Mar 2023 13:32:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, airlied@redhat.com, dipenp@nvidia.com,
        treding@nvidia.com, mwen@igalia.com, fmdefrancesco@gmail.com,
        arnd@arndb.de, bvanassche@acm.org, ogabbay@kernel.org,
        axboe@kernel.dk, mathieu.poirier@linaro.org, linux@zary.sk,
        masahiroy@kernel.org, yangyicong@hisilicon.com,
        dan.j.williams@intel.com, jacek.lawrynowicz@linux.intel.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        furong.zhou@linux.intel.com, andriy.shevchenko@intel.com,
        linus.walleij@linaro.org
Subject: Re: [PATCHv3 1/4] dt-bindings: wiegand: add Wiegand controller
 common properties
Message-ID: <20230303193213.GA6048-robh@kernel.org>
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
 <20230301142835.19614-2-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230301142835.19614-2-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 03:28:32PM +0100, Martin Zaťovič wrote:
> Wiegand bus is defined by a Wiegand controller node. This node
> can contain one or more device nodes for devices attached to
> the controller(it is advised to only connect one device as Wiegand
> is a point-to-point bus).
> 
> Wiegand controller needs to specify several attributes such as
> the pulse length in order to function properly. These attributes
> are documented here.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-controller.yaml  | 39 +++++++++++++++++++
>  MAINTAINERS                                   |  5 +++
>  2 files changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> new file mode 100644
> index 000000000000..df985cb3045a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/wiegand/wiegand-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Wiegand Generic Controller Common Properties
> +
> +maintainers:
> +  - Martin Zaťovič <martin.zatovic@tbs-biometrics.com>
> +
> +description:
> +  Wiegand busses can be described with a node for the Wiegand controller device
> +  and a set of child nodes for each SPI slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^wiegand(@.*|-[0-9a-f])?$"
> +
> +  pulse-len-us:
> +    description: |

Don't need '|' here and elsewhere.

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>

> +      Length of the low pulse in microseconds.
> +
> +  interval-len-us:
> +    description: |
> +      Length of a whole bit (both the pulse and the high phase) in microseconds.
> +
> +  frame-gap-us:
> +    description: |
> +      Length of the last bit of a frame (both the pulse and the high phase) in
> +      microseconds.
> +
> +required:
> +  - compatible
> +  - pulse-len-us
> +  - interval-len-us
> +  - frame-gap-us
> +
> +additionalProperties: true
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b0db911207ba..1f6f6d236f0c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22512,6 +22512,11 @@ L:	linux-rtc@vger.kernel.org
>  S:	Maintained
>  F:	drivers/rtc/rtc-sd3078.c
>  
> +WIEGAND BUS DRIVER
> +M:	Martin Zaťovič <m.zatovic1@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> +
>  WIIMOTE HID DRIVER
>  M:	David Rheinsberg <david.rheinsberg@gmail.com>
>  L:	linux-input@vger.kernel.org
> -- 
> 2.39.2
> 
