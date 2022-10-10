Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6E35F9E40
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiJJMBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiJJMA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:00:59 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB1B422E1;
        Mon, 10 Oct 2022 05:00:53 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1321a1e94b3so12228828fac.1;
        Mon, 10 Oct 2022 05:00:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cvr1/y9Of9lpkIqcjV6G6ntkRJTdHb+csNczqS1QY0Y=;
        b=a0lHkpgWoOGnGl0rGq+SGanzJp45Y+NbjugJ01P+TbmlUhls0YLMny8DJclbTuXRQ/
         MV+NDx2CYa7hnLQxgyvpCSt2xsIZm03tgJAEAFGPYYC9aNGYHIvWRLNM7Lv5W02jlaX5
         ODtGCqhvasunRbPb1A6regiJO4BzK4CKVeBSglbn38Sv9qgpcbAlPhWqKTA8dXCc0xFL
         nvll7Ug+8QE/v3FT4sz4o0+3wh6kNVr0XzPveW0nN/rK9b2eYOLIvfCPWifKzqMTQB20
         uN79xJYxtnY8eGHjpsaYeX7ebCuXUJuRZZh+fIxpmYjWyRREDHDMv5ATB5fvPwqnuNxh
         h9Pg==
X-Gm-Message-State: ACrzQf1lL4o+7Ia8f1nRd9SrxztGyVEhPgK3rHkKSMXI6ll5sFX4lXAs
        UXSMDXzfedJZphZVLNyROQ==
X-Google-Smtp-Source: AMsMyM6oqRBqHzumn9e+K1gFlq5Z/OR4uNPi3VN2ZTest9ElNqOUJS2cK92n+F5XlbQMAf0fzRMWgw==
X-Received: by 2002:a05:6870:e88e:b0:132:411:99 with SMTP id q14-20020a056870e88e00b0013204110099mr14412955oan.226.1665403252857;
        Mon, 10 Oct 2022 05:00:52 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y21-20020a4ae715000000b00425678b9c4bsm4100932oou.0.2022.10.10.05.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:00:52 -0700 (PDT)
Received: (nullmailer pid 412149 invoked by uid 1000);
        Mon, 10 Oct 2022 12:00:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        shawnguo@kernel.org, linux-usb@vger.kernel.org, jun.li@nxp.com,
        linux-imx@nxp.com, s.hauer@pengutronix.de, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org
In-Reply-To: <20221010101816.298334-2-peng.fan@oss.nxp.com>
References: <20221010101816.298334-1-peng.fan@oss.nxp.com> <20221010101816.298334-2-peng.fan@oss.nxp.com>
Message-Id: <166540304239.403876.13950596185888758085.robh@kernel.org>
Subject: Re: [PATCH 1/6] dt-bindings: usb: ci-hdrc-usb2: convert to yaml
Date:   Mon, 10 Oct 2022 07:00:53 -0500
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

On Mon, 10 Oct 2022 18:18:11 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to yaml format
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 158 ---------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 306 ++++++++++++++++++
>  2 files changed, 306 insertions(+), 158 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.example.dtb: usb@f7ed0000: clocks: [[4294967295, 29]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.example.dtb: usb@2184400: clocks: [[4294967295, 162]] is too short
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

