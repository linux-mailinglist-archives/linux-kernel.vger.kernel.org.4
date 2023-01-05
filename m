Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C3665E314
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjAECyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjAECyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:54:09 -0500
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01667479D8;
        Wed,  4 Jan 2023 18:54:07 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id y2so20496348ily.5;
        Wed, 04 Jan 2023 18:54:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uo8aaDBNuPpwcjfTN7FaqbLzjNsP65OWj81qbxQ1v/o=;
        b=so3RR4NyOqzn5iApjRcPe9Dls+reNHhZd9t0pyg0PMoX3kmnwHoGazqdo4SkhABs1+
         0GvpjAkIUd/gRxPumaWYwFokQ1qqBE+RA1ZCzuvneZWJDSzqiCKY8AG0WnPM//5x8XRb
         CEEThIHTjY4rRkzNjGrfvPdRZHKXeuRqi/gmfnQ3e1MFokjP3hq/CFHRWuJM9aFS4z8h
         aNO98UoOP/muTUNePI8V3EbfJOuKFZy4MfDo01p+WyRq+Z9SNlPn0Q/Ku1Y3FHRWK9dN
         VL+o8Q3G2m+l2nvxthPWEIlBMfkwh3e4658ySkaEzxAG7ulWPXJ5VXR10YQXCKqqehVN
         MRsg==
X-Gm-Message-State: AFqh2kqqCDE6RV+rVmH/4yp10VARC83pn040eam67tgRSQCwGJl8KejM
        86XIQcDbr8dLY4X9Hg7+vMt8S71oxg==
X-Google-Smtp-Source: AMrXdXuWTfGcvdFiJHOgFCjJ2+gnXLNbpoZtfUTMmR6Ilf/cPfiiGtZHbB2MaVOBB+YYivANAFJGdA==
X-Received: by 2002:a05:6e02:1d19:b0:30c:2ff1:ae62 with SMTP id i25-20020a056e021d1900b0030c2ff1ae62mr16451529ila.4.1672887247183;
        Wed, 04 Jan 2023 18:54:07 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k25-20020a023359000000b0038a183cb719sm11512462jak.141.2023.01.04.18.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:54:06 -0800 (PST)
Received: (nullmailer pid 3295151 invoked by uid 1000);
        Thu, 05 Jan 2023 02:53:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?b?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     bvanassche@acm.org, mani@kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, iwona.winiarska@intel.com,
        tzimmermann@suse.de, robh+dt@kernel.org, Michael.Srba@seznam.cz,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        hemantk@codeaurora.org, quic_jhugo@quicinc.com, dipenp@nvidia.com,
        fmdefrancesco@gmail.com, jason.m.bills@linux.intel.com,
        jae.hyun.yoo@linux.intel.com, ogabbay@kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org
In-Reply-To: <20230104133414.39305-2-m.zatovic1@gmail.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-2-m.zatovic1@gmail.com>
Message-Id: <167288699743.3289802.11416300260059460595.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: add Wiegand controller dt-binding documentation
Date:   Wed, 04 Jan 2023 20:53:58 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 04 Jan 2023 14:34:12 +0100, Martin Zaťovič wrote:
> A Weigand bus is defined by a Wiegand controller node. This node
> can contain one or more device nodes for devices attached to
> the controller(it is advised to only connect one device as Wiegand
> is a point-to-point bus).
> 
> Wiegand controller needs to specify several attributes such as
> the pulse length in order to function properly. These attributes
> are documented here.
> 
> Signed-off-by: Martin Zaťovič <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-controller.yaml  | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/wiegand/wiegand-controller.example.dts:20.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:434: Documentation/devicetree/bindings/wiegand/wiegand-controller.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1508: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230104133414.39305-2-m.zatovic1@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

