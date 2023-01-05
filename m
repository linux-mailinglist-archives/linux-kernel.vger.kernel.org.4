Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C777065E312
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 03:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAECyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 21:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAECyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:54:08 -0500
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A0747317;
        Wed,  4 Jan 2023 18:54:04 -0800 (PST)
Received: by mail-il1-f178.google.com with SMTP id a9so8146878ilk.6;
        Wed, 04 Jan 2023 18:54:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uo8aaDBNuPpwcjfTN7FaqbLzjNsP65OWj81qbxQ1v/o=;
        b=NgSsUOCMXz+zPnrwP2BeLZuhUhQnioG6Gj46OiU5krIwwiNluH5J2BLUAsc42miNts
         ucm0nUhDl3eTCQeaIHSelOjzQ7rZH1N8poof77tIEe97MTENMPqF6TZnUwdlU9tvq8Xx
         iOqXQSI9ayS445M9WJ43UxW8nUkfxJgOn5f4xxP7+xvfYI3Xnerztwa5C//lxcNsLVxA
         e+tPkd0tU0QGQEIZzqhAG9Vq14T2DUTt7jx3uqfH9ZPzEXD3gkOPh+neFC9gSlbcgbJ8
         BWwe/9x5637x4zbU9nOgw7fBCRl8UhU75yvszH3c7fLUVX5l+LIBpiP+24PFSa1NHgtC
         TYgA==
X-Gm-Message-State: AFqh2koHnucJ4uA06PM+GlyxNUNBfBMw0oIFd/P+HsHfmprf3RLmNjei
        g1onodx8U0W20SRPXh326w==
X-Google-Smtp-Source: AMrXdXt2O6reALRbsQ0faKden0HAldxkl+yKFHyn35Uf84/Jx0Ep+KZ79ieL4uWueXMBZmADOw0sgQ==
X-Received: by 2002:a92:6e10:0:b0:30c:44bb:8d23 with SMTP id j16-20020a926e10000000b0030c44bb8d23mr9547897ilc.2.1672887243487;
        Wed, 04 Jan 2023 18:54:03 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i11-20020a92c94b000000b002fc323a2902sm11210167ilq.62.2023.01.04.18.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 18:54:03 -0800 (PST)
Received: (nullmailer pid 3295153 invoked by uid 1000);
        Thu, 05 Jan 2023 02:53:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?b?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     hemantk@codeaurora.org, bvanassche@acm.org, tzimmermann@suse.de,
        iwona.winiarska@intel.com, dipenp@nvidia.com,
        quic_jhugo@quicinc.com, gregkh@linuxfoundation.org,
        mani@kernel.org, Michael.Srba@seznam.cz,
        linux-kernel@vger.kernel.org, fmdefrancesco@gmail.com,
        andersson@kernel.org, jason.m.bills@linux.intel.com,
        ogabbay@kernel.org, jae.hyun.yoo@linux.intel.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, robh+dt@kernel.org
In-Reply-To: <20230104133414.39305-2-m.zatovic1@gmail.com>
References: <20230104133414.39305-1-m.zatovic1@gmail.com>
 <20230104133414.39305-2-m.zatovic1@gmail.com>
Message-Id: <167288699863.3289839.678028969383210.robh@kernel.org>
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

