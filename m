Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A43D362CA6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbiKPUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiKPUPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:15:50 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A565845;
        Wed, 16 Nov 2022 12:15:49 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id p27-20020a056830319b00b0066d7a348e20so7156729ots.8;
        Wed, 16 Nov 2022 12:15:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5LJWysSdFU+Zc/k0bAhJW5rRLdDYPdN6FVykD4Nl8k=;
        b=WP0bHWVp7vbGY+ug185aRLzWcKGPLl/PEz+naQiQOjlIJhNbMHdOt4jais8NQzqdjr
         fgJzRYn2httWc8RIXzzfWOP1GuoQ4JNtuhieF6F2j4LIhclgWGI54JzwV/ehpgojo7H/
         OM84DXu6ZsiN9HoUZAnTJrtjw3mhDUGjmKuDavD4JH76/Q0Gf1WblRB4k+HnTFP40+p+
         1EgJoHA0tjj73xn2Z1EEYizuw7EX+tMOjrRtR7qljXHTngCmB/HyTRX3kT5oT/JBlxfl
         2YRuKxeZPsAgSoPqm5QtbO3PoT625yoN0pxBIrR3EEyO2PC5B9kQw5EgIANUfdEA9WKC
         6jYw==
X-Gm-Message-State: ANoB5pmbh/ndGJ/yi433peODCBn9DvfvGQMIKKqzvPpUJZ5rCWH/vih7
        nThgBPbs1En9GVd4HKLGYCY2h3/ddw==
X-Google-Smtp-Source: AA0mqf6HSWLYnrerfr1UKbSIi1DOecaYVPts8H+J4hwinPVJdDZNGCH2QqHFJf7Fol01NbgZRRSMQQ==
X-Received: by 2002:a9d:6e8d:0:b0:655:f7b0:bc19 with SMTP id a13-20020a9d6e8d000000b00655f7b0bc19mr11564035otr.381.1668629749159;
        Wed, 16 Nov 2022 12:15:49 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j15-20020a056808034f00b0035a66bb4982sm6380993oie.57.2022.11.16.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 12:15:48 -0800 (PST)
Received: (nullmailer pid 817327 invoked by uid 1000);
        Wed, 16 Nov 2022 20:15:50 -0000
Date:   Wed, 16 Nov 2022 14:15:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Georgi Vlaev <g-vlaev@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vibhore Vardhan <vibhore@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dt-bindings: ti, sci: Add lpm region and
 firmware-name
Message-ID: <166862975025.817271.11540467321940082459.robh@kernel.org>
References: <20221111171739.160693-1-g-vlaev@ti.com>
 <20221111171739.160693-2-g-vlaev@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111171739.160693-2-g-vlaev@ti.com>
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


On Fri, 11 Nov 2022 19:17:35 +0200, Georgi Vlaev wrote:
> From: Dave Gerlach <d-gerlach@ti.com>
> 
> Add documentation for the lpm region which tells the ti-sci driver where
> to load the FS Stub low power mode firmware and also the firmware-name
> which tells the driver which binary to load. Both of these are optional
> for normal system operation but required to enabled suspend-to-mem usage
> of Deep Sleep state.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Georgi Vlaev <g-vlaev@ti.com>
> ---
>  .../bindings/arm/keystone/ti,sci.yaml         | 21 +++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
