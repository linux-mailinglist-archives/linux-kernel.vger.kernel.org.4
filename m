Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7FF6D0533
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjC3Mri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjC3Mrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:47:36 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D091;
        Thu, 30 Mar 2023 05:47:35 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id n6-20020a4abd06000000b0053b59893660so2948431oop.0;
        Thu, 30 Mar 2023 05:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680180454;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wtBuzl8K04aB3AnZ0txrHE1YrIRmUQ4B9qyhQlZzPH4=;
        b=cM1i2U3hcUE4Ot19SZ7suxzieLs1imCr6E0h4LrEoKU/mlWFte6rXkcbXQJEezh68v
         5J0fiJnIk4Cu3uWPcRLhEXiYaaQkvTXY2RCEXPCIL92WwEIGlKZ2huRUyg2QrpBu2GFG
         0YWUpOtFe48MC0Dv4ta6+k4FBffT6wwV1pOpLGdTL3PA0dK4sHc3kJHlvzlGmS66c4S7
         JrYvy/KBfE8lSY/WC0kHbdqQ2VMSuQyoi9LiGhediafQPe8GZEQpSY1/ouMVrGjTNu9P
         HOOSfq1BNFWvpbY3ZbNRs7VCt7NQ+6xmFdfdXO0d4/bv2CzTGe6KEmhhTqyqhgcCiQXF
         Vj7w==
X-Gm-Message-State: AAQBX9c//mAeh+Y/PypbCuS+R61lfILfEO0SsPbUZ7uZO7AZRLSsBa4M
        XJGgHEVGQBrwaheLIF/4dQ==
X-Google-Smtp-Source: AKy350YAs9GHa0khQvQ57kJ/w+Cv/Wcx7rcV/rtgNaN69Ll2vzsHrcuxjOWOnUOmrppCGRVgAFmvPg==
X-Received: by 2002:a4a:5244:0:b0:537:b1ad:1c7c with SMTP id d65-20020a4a5244000000b00537b1ad1c7cmr6894747oob.0.1680180454079;
        Thu, 30 Mar 2023 05:47:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j41-20020a4a88ac000000b0053e3da7f810sm4707307ooa.25.2023.03.30.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 05:47:33 -0700 (PDT)
Received: (nullmailer pid 1824005 invoked by uid 1000);
        Thu, 30 Mar 2023 12:47:33 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20230330110512.549704-3-keguang.zhang@gmail.com>
References: <20230330110512.549704-1-keguang.zhang@gmail.com>
 <20230330110512.549704-3-keguang.zhang@gmail.com>
Message-Id: <168017971140.1808596.3407628411299700675.robh@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: timer: Add Loongson-1 clocksource
Date:   Thu, 30 Mar 2023 07:47:33 -0500
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 19:05:11 +0800, Keguang Zhang wrote:
> Add devicetree binding document for Loongson-1 clocksource.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: None
> V1 -> V2: None
> ---
>  .../timer/loongson,ls1x-pwmtimer.yaml         | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.example.dts:21:18: fatal error: dt-bindings/clock/loongson,ls1x-clk.h: No such file or directory
   21 |         #include <dt-bindings/clock/loongson,ls1x-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/timer/loongson,ls1x-pwmtimer.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1512: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230330110512.549704-3-keguang.zhang@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

