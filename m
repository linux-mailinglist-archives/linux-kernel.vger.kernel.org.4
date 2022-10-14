Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4088A5FF564
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJNV3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJNV3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:29:04 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12542AD9A2;
        Fri, 14 Oct 2022 14:29:04 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id j188so6393460oih.4;
        Fri, 14 Oct 2022 14:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfjVNrG2seYn/AsbaWZoF91QmzThGX22mYpIImKJdlI=;
        b=CoS+6/rhYTp/n9JT3ITQHYzpWOD7kphIjlZXLogUq5rifMsGVdO6xhmLmEUWQsax48
         RIlMFbSN/nMNChVdVtFm1ZqRnoDkgmVGsi3CPucO+MeIgFpatMRfBVSkpum7ZCVlbdl7
         d0JroVNoF+6dsmtQ43QHQcKPbC5enS1ebo5p2wyIRySAoZULhG+kVUSXfXRHeEI/NOUn
         ZmSv19bbai5Woq2bctx8ripqrKf+4Aw8e9DGTYg2wrYdfldL2Fs3+oR22j3aUUbbimtK
         qMaWoOOkpNLNUinRcK01DAOpV6LYr6tFQQe9DiH1fcHpo4MLaga0e34TnY1Um1+InhLw
         z7CA==
X-Gm-Message-State: ACrzQf0Uxr1Q1vbj7pad7Cixy9h0OgUedLUMDMZtaj7Ywh9lC0QSL1z5
        bVjFT7HXXlV/Poh10bjvNQ==
X-Google-Smtp-Source: AMsMyM4EAsN87FZBBQZloRkXiyRQqsRqKJQ0oyosALn73hPCVDn04fcg+o7psQ2Jjiw8P+aazG/5QA==
X-Received: by 2002:a05:6808:1589:b0:354:6866:bc24 with SMTP id t9-20020a056808158900b003546866bc24mr3493412oiw.24.1665782943250;
        Fri, 14 Oct 2022 14:29:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r23-20020a9d7517000000b0066193df8edasm1703231otk.34.2022.10.14.14.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 14:29:02 -0700 (PDT)
Received: (nullmailer pid 2933276 invoked by uid 1000);
        Fri, 14 Oct 2022 21:29:03 -0000
Date:   Fri, 14 Oct 2022 16:29:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, Peng Fan <peng.fan@nxp.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        xu.yang_2@nxp.com, linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kernel@pengutronix.de, jun.li@nxp.com,
        gregkh@linuxfoundation.org, shawnguo@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/6] dt-bindings: usb: usbmisc-imx: add clocks property
Message-ID: <166578294308.2933219.14760564168339116752.robh@kernel.org>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014095148.2063669-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 17:51:44 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional clocks property
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/fsl,usbmisc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
