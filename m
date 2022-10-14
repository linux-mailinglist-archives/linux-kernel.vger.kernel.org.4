Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9195FF50A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiJNVJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbiJNVJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:09:48 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6BF5584;
        Fri, 14 Oct 2022 14:09:40 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-132af5e5543so7281790fac.8;
        Fri, 14 Oct 2022 14:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hb6+hRsJ2+j+iFOkFuOlPFAOELc94JpoZuRVImRdf8g=;
        b=2E2flWabyczENMEFHS0kHdDvpHUjWgRbpYQtRN77ZY3S54gnNv7yM/Wi3tppK2cdPe
         7VtxeH++biM/OSZBTVTvr4tCxPwHEKd0GSL8SiAVCPVvrDC7fQ7N2krDopj9nVRsg1AC
         rYVun/RGpOivdkgTmhE0lZOf3g0dtQ30gk5M9jMvq9flkpewFYITMRB6VJ+uTGVfKJ9/
         /NkFFo2l6EHPW2hWvGTYgwwLeBnidBTVnXw8nZyjRGWkWpyBQ8M7e3j6RqrdSpJWJdqv
         londH3nmO5s/wDEDsghJxsFyZSrBYiAzSTruLTCJP1Z37ClOOyMRUpnS+qg2RXIbx6lV
         /t4Q==
X-Gm-Message-State: ACrzQf1RGAgZwAOH4Fl+a06whsmJwMVuPdWn/X9zmE825+cTc7n8wBW+
        qCgKhtrdH1Opn20VOocj7UNnf8Xq5i5B
X-Google-Smtp-Source: AMsMyM4+BPQEN5gTldI4WjhqseUpc40eMXjxoGcOKszJd0o09wnb6qdWDwfEFTmDEqNGJfLGVrMorg==
X-Received: by 2002:a05:6870:538a:b0:132:756f:2c98 with SMTP id h10-20020a056870538a00b00132756f2c98mr9414474oan.134.1665781780102;
        Fri, 14 Oct 2022 14:09:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d21-20020a9d4f15000000b0066193fe498bsm1776819otl.28.2022.10.14.14.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:09:39 -0700 (PDT)
Received: (nullmailer pid 2910371 invoked by uid 1000);
        Fri, 14 Oct 2022 21:09:40 -0000
Date:   Fri, 14 Oct 2022 16:09:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        William Zhang <william.zhang@broadcom.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dt-bindings: nvmem: u-boot,env: add Broadcom's
 variant binding
Message-ID: <166578177913.2909910.7600034251484225468.robh@kernel.org>
References: <20220930163631.27040-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930163631.27040-1-zajec5@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sep 2022 18:36:31 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Broadcom uses U-Boot for a lot of their bcmbca familiy chipsets. U-Boot
> stores its configuration in an environment data block.
> 
> Such blocks are usually stored on flash as a separated partition at
> hardcoded address. Broadcom however decided to:
> 1. Store env data block inside U-Boot partition
> 2. Avoid sticking to hardcoded offsets
> 3. Use custom header with "uEnv" magic and env data length
> 
> Example (length 0x4000):
> $ hexdump -n 32 -C -s 0x40000 /dev/mtdblock0
> 00040000  76 6e 45 75 00 40 00 00  34 89 7a 82 49 4d 41 47  |vnEu.@..4.z.IMAG|
> 00040010  45 3d 4e 41 4e 44 3a 31  4d 2c 31 30 32 34 4d 00  |E=NAND:1M,1024M.|
> (0x40000 offset is unit specific and can change)
> 
> Starting with the commit 118f3fbe517f4 ("dt-bindings: mtd: partitions:
> support label/name only partition") DT can describe partitions matching
> them by a name (without specifying actual address). With that feature
> and this binding change it's possible to:
> 1. Specify DT node for Broadcom's U-Boot env data subpartition
> 2. Add nodes for specific environment data variables
> 3. Reference them as NVMEM cells
> 
> This binding is unlikely to help Broadcom's U-Boot. U-Boot SPL needs to
> find environment data early (before it accesses DTB) and it does that by
> looking for an "uEnv" magic. Dirty way.
> 
> This binding can however be used by operating systems. It allows
> describing cleanly U-Boot, its env data and variables. It tells
> operating system about Broadcom-specific env data so it can parse it.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Work on better commit body & add example
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

Applied, thanks!
