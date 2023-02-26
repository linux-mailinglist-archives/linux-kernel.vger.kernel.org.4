Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377856A337A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 19:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjBZSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 13:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBZSil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 13:38:41 -0500
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A5B768;
        Sun, 26 Feb 2023 10:38:40 -0800 (PST)
Received: by mail-il1-f176.google.com with SMTP id s8so2827930ilv.10;
        Sun, 26 Feb 2023 10:38:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KapxYTomvu59mWLVr5fqDVRnfE034d9Qe/O0kjHGyo4=;
        b=gjx+koWa538iP7igAfQ6sR6z9BX8yPFm4LV2jzvCxWSUW57Q4/hnNki3hA+A/HH1yq
         Xi/YN+l5MfC+mCxO2ySX5TKcWwfVSSKyUV6ZY9xhx6/jmNLDO3lu1VWMwhewB1tLtHpL
         WIIMR5wBmbd2T0RgZ3vWf8FnzxKCeH1jqPVw7/voraa0l60O8XkMVP0sT03atIwS2v3F
         fyinqS1LJDFEeQeQmIdFmEsZfyWZlouLOZttDHEE/qFhRnK2Q0HAtiMU/3UPqjIhYv7T
         iVbMw0aBeCaQlMRPCX0X3flq/6qJbpl92T2aPwmLB43O767r8omg0Ixxkxams7Y0cPwZ
         QMeQ==
X-Gm-Message-State: AO0yUKV1AQVs9ChEfHIpCeNMxLICOUf9LVSYrEGF/EE0Dc/sF1tB9cdx
        kpStSABN3ZZGHShEt4oh/A==
X-Google-Smtp-Source: AK7set9n8DDNpC4hB74xJ2JU8XjS3anvJsTrFcA7XhlUG3DTjyhpdQ6KB4JcJ7bzRMeGVlwepczC/A==
X-Received: by 2002:a92:cd89:0:b0:314:f7f:a35a with SMTP id r9-20020a92cd89000000b003140f7fa35amr19991705ilb.7.1677436719547;
        Sun, 26 Feb 2023 10:38:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:8ddf:ff6b:c94c:94fd:4442])
        by smtp.gmail.com with ESMTPSA id y21-20020a02bb15000000b003acfdc75a53sm1547986jan.48.2023.02.26.10.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 10:38:39 -0800 (PST)
Received: (nullmailer pid 150130 invoked by uid 1000);
        Sun, 26 Feb 2023 18:38:28 -0000
Date:   Sun, 26 Feb 2023 12:38:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 1/2] dt-bindings: nvmem: mmio: new binding for MMIO
 accessible NVMEM devices
Message-ID: <167743670799.150030.2985662299530290415.robh@kernel.org>
References: <20230220174930.7440-1-zajec5@gmail.com>
 <20230220174930.7440-2-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230220174930.7440-2-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 20 Feb 2023 18:49:29 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Content of some NVMEM devices can be read using MMIO. Some of them
> (probably very few though) may be also programmable that way. Add
> generic binding to allow describing such hardware.
> 
> This *doesn't* apply to any more complicated devices that need more
> complex interface e.g. for writing. While such devices could be
> supported for reading purposes by the same driver - they should get
> their own binding.
> 
> This binding will gain even more usability once we fully support NVMEM
> layouts (describing content of NVMEM devices in an independent way).
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V3: Make it clear this binding should NOT be used for more complex devices
> ---
>  .../devicetree/bindings/nvmem/mmio.yaml       | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mmio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

