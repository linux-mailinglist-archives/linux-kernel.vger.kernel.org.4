Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA577394DE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjFVBsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjFVBr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:47:57 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985AD10D2;
        Wed, 21 Jun 2023 18:47:55 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-780bd47ef93so41764839f.2;
        Wed, 21 Jun 2023 18:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398475; x=1689990475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6lwlIACoL/oGFO27bjHDY0Ho8Hok0K/LdTyvT1Aqys=;
        b=Uycgc4Z3yBwPqbv9DcphqHn+wd6dFesAERxQuiks9MGpN8foK5MMIWNsV2bONLOfmk
         HemObqYmifeXFM0e8fL62DRcmzkglbPTlDAeGiSpKo6vs804DYPkbIC8N3EClzSGTvjE
         QHcDPnXxkgbdrKna1xv2+Z2vnfkKs9dyda5yd5xU1i6INqsEzzehT7MRzjqPPlClXxos
         4b/qAgZwENwJWlMyrsAzZOFDDAaZU2/sQKUH7sDbNmxRsJqdgsatJQSxg0aW2XcRVrhi
         ef5lR1rPVPYyeQUMVMms4i2hgJmdP0GT3zDk2aEczhhc2wxo+aygJ9a5lGWIoHY/qsYM
         GV5A==
X-Gm-Message-State: AC+VfDxECG1GmwvYC6i/B8p/wHRLYP9lIfpAcoqFRCiGIGCg0JyFAEEp
        VzsUAPcNjmN3Xq9HbHyZQg==
X-Google-Smtp-Source: ACHHUZ5xbAsh5HM5f4tHiRpRYvVagaBlyC5jsuZyygZJanfzT8FnpDf6NQwAklw+4yEA1IZrei1NVg==
X-Received: by 2002:a6b:fd16:0:b0:777:b107:dd4d with SMTP id c22-20020a6bfd16000000b00777b107dd4dmr13981457ioi.16.1687398474803;
        Wed, 21 Jun 2023 18:47:54 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g14-20020a02cd0e000000b004268fbb21f4sm1429030jaq.44.2023.06.21.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:47:54 -0700 (PDT)
Received: (nullmailer pid 36911 invoked by uid 1000);
        Thu, 22 Jun 2023 01:47:52 -0000
Date:   Wed, 21 Jun 2023 19:47:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        alexandre.torgue@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: connector: usb: allow a single HS port
Message-ID: <168739847068.36808.12687973210277426277.robh@kernel.org>
References: <20230620085633.533187-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620085633.533187-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 10:56:33 +0200, Fabrice Gasnier wrote:
> Allow a single HS port to be used e.g. without reg property and a unit
> address. OF graph allows a single port node, without 'reg' property.
> 
> This removes a couple of Warnings or errors on STM32MP boards.
> When using single HS port currently, when doing building with W=1:
> arch/arm/boot/dts/stm32mp157c-dk2.dtb: stusb1600@28: connector:
> Unevaluated properties are not allowed ('port' was unexpected)
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Notes: Other attempts seem to lead to a dead end. Ex: by updating the
> relevant dts files, to use ports, and port@0, make W=1 shows
> ...connector/ports: graph node has single child node
> 'port@0', #address-cells/#size-cells are not necessary.
> But not adding them lead to another "Warning (avoid_default_addr_size)"
> ---
>  .../bindings/connector/usb-connector.yaml     | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 

Applied, thanks!

