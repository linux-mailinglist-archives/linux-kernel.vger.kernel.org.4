Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159B560EAF4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 23:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiJZVvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 17:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJZVvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 17:51:17 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BC18D220;
        Wed, 26 Oct 2022 14:51:16 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id s206so7178881oie.3;
        Wed, 26 Oct 2022 14:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1HH6shXGISkDJv+IT3gnOXjKGNY9Hpn7mwxlaFOwLY=;
        b=agiJYRNqAQiEC1HUjg4VJPjWiwqIv8Q/kTyOuRkqdhaU6kd9aRA1+ywREwenqdmIWK
         V3AS5O/j/YNcBmAsn+otJOXhcDHuWC9jycvu8OzOFsKqhM96RCnmAD/vJELbxBSTrrmN
         Mjf7HU/I425Sqo4mCXyY20bwvSlc50ibdLGmHXlitmGSyULlWca3x05BrP6tPg8bbPSb
         HDfD4uTe704t2FfBq1a/CqwL/sgcrtuRFOJSI1kVqv2EQySeMxUZz/4ZRKPT2MQr6FVi
         SpRtH4IorD4j6qoUmRRgQoSGoEpleaL+34cqYuLO6qofY8ANH7a7ThzfIPV1gTNI07pr
         sWZA==
X-Gm-Message-State: ACrzQf22ns8a4fOfBz9MxbVgWmQKyfGjR9vgyJZL92i8r8YFE2+/Pzx/
        j8P+1BHG97x+5D0TuVTzTTbotSdU8A==
X-Google-Smtp-Source: AMsMyM61DQrmnpMuyToA7SYGpwKlkPAyakNsuAGhuQ3T87LMMSyKzI08yZItiSPk/lOh+9L8rOHBlg==
X-Received: by 2002:a05:6808:60a:b0:355:50f8:1743 with SMTP id y10-20020a056808060a00b0035550f81743mr3222515oih.125.1666821075169;
        Wed, 26 Oct 2022 14:51:15 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q10-20020a05683033ca00b00661a33883b8sm2610209ott.71.2022.10.26.14.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:51:14 -0700 (PDT)
Received: (nullmailer pid 1359772 invoked by uid 1000);
        Wed, 26 Oct 2022 21:51:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        "benjamin.gaignard@st.com" <benjamin.gaignard@st.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
In-Reply-To: <ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com>
References: <cover.1666806317.git.oleksii_moisieiev@epam.com> <ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com>
Message-Id: <166682078099.1353934.10574272333105424439.robh@kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: Document common device controller bindings
Date:   Wed, 26 Oct 2022 16:51:15 -0500
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Oct 2022 17:51:27 +0000, Oleksii Moisieiev wrote:
> Introducing of the common device controller bindings for the controller
> provider and consumer devices. Those bindings are intended to allow
> divided system on chip into muliple domains, that can be used to
> configure hardware permissions.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  .../feature-domain-controller.yaml            | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/feature-domains/feature-domain-controller.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/feature-domains/feature-domain-controller.example.dtb: foo@0: feature-domain-names: ['default', 'unbind'] is too long
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/feature-domains/feature-domain-controller.yaml

doc reference errors (make refcheckdocs):


See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/ab68324eea3c788a369260f5a1e5da843a960cde.1666806317.git.oleksii_moisieiev@epam.com/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

