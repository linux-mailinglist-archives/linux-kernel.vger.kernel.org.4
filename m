Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76D5FD83A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiJMLWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 07:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJMLWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 07:22:46 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1670E52D0;
        Thu, 13 Oct 2022 04:22:45 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so1110041oom.1;
        Thu, 13 Oct 2022 04:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2pVn4Fvc8UPvpqqHE5JTFIcuecvDh3adTSLyFNQC4I=;
        b=YOK/DagqNVFQtVWjcdaBxaPepnB+gP1FaXy7+X47fvUtf4LDvcA8X5r6gBJ8EmuSQT
         2y7oWQs8XO7OkCa0/RmE0JM/JWdRcM9Vc6csuJHqh1XZG0p97CPkpJjYam8B1KmNWCQY
         O5Outd3Zk91Xj/2PJJOU87sj6AvvVa8ISSKgil4nypz2DmvqSaDqNkYmuoBVHGAepwiV
         KszUDOxwPT0G5+eSJ3HcVM3EoZ6kwIvFHD7lY6bqKHt28mc/Y6T6LPfeePwYXmLZ3Gxz
         wLDAMW/sHMasy4lkL1ZS7F/e/kKQpb2BN5ceYpzfvwOePR1bOQj9J1kwzwI7tHcuTkfm
         79Xw==
X-Gm-Message-State: ACrzQf3cs0v/85d30SeLkcRR7HehhuRMY97NCremon5Gp1Ki3gWHcA9q
        ET3BPGO0x8WBf4xy5W0Ngw==
X-Google-Smtp-Source: AMsMyM4nNIc+oRZiG6wqfGw107MyYKxWYrQ+/jkkSqpfpMwFaFfpGJOPQSYGQzkONdcJKd36NRceMA==
X-Received: by 2002:a05:6830:2044:b0:661:8f8f:ffa2 with SMTP id f4-20020a056830204400b006618f8fffa2mr11109551otp.142.1665660165127;
        Thu, 13 Oct 2022 04:22:45 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y1-20020a4ade01000000b0047f8ceca22bsm1951171oot.15.2022.10.13.04.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 04:22:44 -0700 (PDT)
Received: (nullmailer pid 5417 invoked by uid 1000);
        Thu, 13 Oct 2022 11:22:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jeff <jeff_chang@richtek.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, jeff_chang@ricthek.com,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz
In-Reply-To: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
References: <20221013080643.6509-1-richtek.jeff.chang@gmail.com>
Message-Id: <166565993196.4194034.3763255376639766451.robh@kernel.org>
Subject: Re: [PATCH] ASoC: Add Richtek RT5512 Speaker Amp Driver
Date:   Thu, 13 Oct 2022 06:22:44 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 16:06:43 +0800, Jeff Chang wrote:
> From: Jeff <jeff_chang@richtek.com>
> 
> The RT5512 is a boosted class-D amplifier with V/I sensing.
> A built-in DC-DC step-up converter is used to provide efficient power for
> class-D amplifier with multi-level class-H operation. The digital audio
> interface supports I2S, left-justified, right-justified and TDM format for
> audio in with a data out used for chip information like voltage sense and
> current sense, which are able to be monitored via DATAO pin through proper
> register setting.
> 
> Signed-off-by: SHIH CHIA CHANG <jeff_chang@richtek.com>
> ---
>  .../bindings/sound/richtek,rt5512.yaml        |  50 +
>  sound/soc/codecs/Kconfig                      |  10 +
>  sound/soc/codecs/Makefile                     |   2 +
>  sound/soc/codecs/rt5512.c                     | 860 ++++++++++++++++++
>  4 files changed, 922 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/richtek,rt5512.yaml
>  create mode 100644 sound/soc/codecs/rt5512.c
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/sound/richtek,rt5512.example.dtb:0:0: /example-0/i2c/rt5512@5c: failed to match any schema with compatible: ['richtek,rt5512']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

