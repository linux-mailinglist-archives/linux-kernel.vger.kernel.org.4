Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB645B524A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 02:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiILAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 20:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiILAoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 20:44:19 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5188927CF9;
        Sun, 11 Sep 2022 17:44:18 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-12803ac8113so19440371fac.8;
        Sun, 11 Sep 2022 17:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=V+fdkvdPWRhvXn+afJKKR9vxZ+OhqSngIUjZosWiaGM=;
        b=CwzMWhbmooMFXwzX8zqVWMtuNLpJ2KLVVKDkWjZRgq1tZhPztZ8TFzvNrf1KllNTkb
         qiBTFL3egj+1Kw47Cdd44kuFJPaHDjUbgjp2FW/6Ldk0b2xOydMNLZK4GIyFvjoJUo5Z
         xOf+97STy4agG3M4HYPu7YqqPD9qR2s9gwPQci4T3vxJOOxT03mfNPyF/ZUeVm6G7621
         VGI8LgTOA4Sbzh+VPnIEZAMmwYHgIW5fwICMknXY65SfHf90M8BFZNrsUtARHBiUgDKG
         QF1vJsiHJUPBly1ny9Mgsy1QKs29o5zLGGmRDJNaL/FBoT7+0WBpmqZyUSKtOHfVguK7
         QSow==
X-Gm-Message-State: ACgBeo20VfV5ksuHJCp30GiqIhCrv6xo1wdeRdgpVkeuvl8lrjsl8bF+
        2EvjRhJ1ceMw7r/BR6/szFVRouvbdw==
X-Google-Smtp-Source: AA6agR6EjSggqXBE7a+I9hL6SZCJ+S5mIWBC+TVZZAoQKWYb+xJHzJHktuQdS8OxzNaK4ZaxTze78Q==
X-Received: by 2002:a05:6808:d4c:b0:345:32dc:7a69 with SMTP id w12-20020a0568080d4c00b0034532dc7a69mr8061256oik.118.1662943457205;
        Sun, 11 Sep 2022 17:44:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y5-20020a4ade05000000b00475790c9a08sm470912oot.16.2022.09.11.17.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 17:44:16 -0700 (PDT)
Received: (nullmailer pid 3629323 invoked by uid 1000);
        Mon, 12 Sep 2022 00:44:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hugues Fruchet <hugues.fruchet@foss.st.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-media@vger.kernel.org,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, devicetree@vger.kernel.org
In-Reply-To: <20220910144010.34272-2-hugues.fruchet@foss.st.com>
References: <20220910144010.34272-1-hugues.fruchet@foss.st.com> <20220910144010.34272-2-hugues.fruchet@foss.st.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: media: add bindings for dcmipp driver
Date:   Sun, 11 Sep 2022 19:44:15 -0500
Message-Id: <1662943455.958018.3629322.nullmailer@robh.at.kernel.org>
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

On Sat, 10 Sep 2022 16:40:06 +0200, Hugues Fruchet wrote:
> From: Alain Volmat <alain.volmat@foss.st.com>
> 
> Add the yaml binding for the DCMIPP driver.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  .../bindings/media/st,stm32-dcmipp.yaml       | 96 +++++++++++++++++++
>  1 file changed, 96 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32-dcmipp.example.dtb: dcmipp@5a000000: port:endpoint: Unevaluated properties are not allowed ('pclk-max-frequency' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/media/st,stm32-dcmipp.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

