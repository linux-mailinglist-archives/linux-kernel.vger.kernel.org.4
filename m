Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6440D65463B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 19:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiLVS60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 13:58:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiLVS6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 13:58:24 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E59223397;
        Thu, 22 Dec 2022 10:58:24 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id k7-20020a056830168700b0067832816190so1611371otr.1;
        Thu, 22 Dec 2022 10:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhbyt8tYgm2186gecgii/47TQCYcaECmRYTmYzgGwIU=;
        b=gl2ElP+Q/yfaIT8OvrcoXe9/SHAkXmXDk2swpE8IMaZ845oqAD6ViBUFUTty29UV+U
         dk2glZRI1rb85lQ7Y23mKPy/oIMYY3Kx0N0UbjDEDoK+jvKly16D+BqiOd6QOnEUh2Cz
         //SZPHdDfDtI9pDakOZGOjRllUTaOVZdzIiwT+B4Sr+DWW6cC7dJ9YNcCQ2FSsG1hwzL
         FecxAkuCyXQMaC1Ed3wNMYw025hkeo7dYluEWNBbYhLHbimZafoS6SpBfLwUxKZuSRSQ
         CZoNEhv2zidO/HO1fz8mmozwsTQVbiLnJ2F2xgN3UV3bdWhmCOdqKV0RiRctCIDnLFeU
         xwWA==
X-Gm-Message-State: AFqh2ko7jVvrzrmBx4CWn272eh1qOJfxY6s3OzEaL60yYWQJoQSnlmZf
        EZwu2VaW5/BBLcn5W0MTCpu5Shki+g==
X-Google-Smtp-Source: AMrXdXvVxDqgiagVMWlnoZXL5Ms8BxpgU7uL4iEG2MUuqKwAEKuN6mdiazLgqReWxfcghnO3M2QriQ==
X-Received: by 2002:a9d:7507:0:b0:66d:a04b:eeac with SMTP id r7-20020a9d7507000000b0066da04beeacmr3123066otk.30.1671735503321;
        Thu, 22 Dec 2022 10:58:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e20-20020a0568301f3400b0066e820696edsm667677oth.13.2022.12.22.10.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 10:58:23 -0800 (PST)
Received: (nullmailer pid 1908218 invoked by uid 1000);
        Thu, 22 Dec 2022 18:58:22 -0000
Date:   Thu, 22 Dec 2022 12:58:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Emekcan Aras <emekcan.aras@arm.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Miguel Silva <rui.silva@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] adds corstone500 device tree
Message-ID: <20221222185822.GB1897073-robh@kernel.org>
References: <20221222123244.147238-1-emekcan.aras@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222123244.147238-1-emekcan.aras@arm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 12:32:42PM +0000, Emekcan Aras wrote:
> Adds device tree and correspondent binding for ARM Corstone500 reference 
> solution. 
> 
> Thanks for the comments, and sorry for the late reply. Most of the comments are
> addressed except one.
> 
> @Krzysztof Kozlowski: Thanks a lot for the comments. I've tried to fixed all of 
> them. Just have one question regarding having no dtsi or compatible platform.
> Corstone500 is a reference hardware design, however there is no silicon solution
> from it yet. And from device tree perspective, both FPGA and FVP (virtual 
> platform) implementations are identical(same addresses and same nodes, etc.).

Does the FVP support virtio devices? Other FVP models do.

> So we didn't want to create a seperate dtsi file. What would you recommend here
> ? Can you point me to a device tree from a similar platform?
> 
> Cheers,
> Emek
> 
> Emekcan Aras (2):
>   arm: dts: arm: add arm corstone500 device tree
>   dt-bindings: Add Arm corstone500 platform
> 
>  .../bindings/arm/arm,corstone500.yaml         |  30 +++
>  arch/arm/boot/dts/Makefile                    |   3 +-
>  arch/arm/boot/dts/corstone500.dts             | 182 ++++++++++++++++++
>  3 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,corstone500.yaml
>  create mode 100644 arch/arm/boot/dts/corstone500.dts
> 
> -- 
> 2.25.1
> 
> 
