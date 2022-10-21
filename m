Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE4D606DB4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 04:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiJUCYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 22:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiJUCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 22:24:07 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C30F6822;
        Thu, 20 Oct 2022 19:23:39 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso1896407fac.6;
        Thu, 20 Oct 2022 19:23:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNQ3vjGcEPcvHyjvRPTWPsOp3CT58XeJ0LewLJ1miuY=;
        b=bu2tEhGG1ihTGBv3BnAapeTKZ87BSJQAVwGklDtmcgwqx6bk5HZwIH1CZrN1IZGfR7
         GJ7U/ts6VllKMu9Ksn+/5WadgY5RvZyxiICgE143cMrq1Pai6ODkP8it/euXehcSp/IX
         1XKoZYUwxE8NU+L+HWZecrpeaquLdRBn66HbVKkd0gxxdTsrQR1C2w36W+ZqQ+qYWAkG
         pkpOGPqFoqUWPnLtNbPhmZx98wul9RlD6KVWXpT6VO3H5NbUTvjpcvnWG9vGn41OspOE
         uKLIIgzEz8nY7ktGPusCfukHqYauOKMD0j7YU53twTqI8SccyNIinOhhGbOg7R7F9iDv
         eFQw==
X-Gm-Message-State: ACrzQf0ADpsZBMNIb+3T9SbwOfTzCWvoSTjpjj5rA3iJYlVweioCZGzi
        bAiULM9Y01gkD4CqhHYlWA==
X-Google-Smtp-Source: AMsMyM4PgS70DhbiAIylCYUqrYmb1aRUHMtCGwr1nTpf2yCVehqo0R6PUxPgxcxX19uBZjcmtWurzA==
X-Received: by 2002:a05:6870:d28a:b0:12b:7ed3:cf38 with SMTP id d10-20020a056870d28a00b0012b7ed3cf38mr11205835oae.138.1666319005906;
        Thu, 20 Oct 2022 19:23:25 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b004805cfab0ffsm8009161ooq.31.2022.10.20.19.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 19:23:25 -0700 (PDT)
Received: (nullmailer pid 2195079 invoked by uid 1000);
        Fri, 21 Oct 2022 02:23:26 -0000
Date:   Thu, 20 Oct 2022 21:23:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: fsl-imx-cspi: update i.MX8MP
 binding
Message-ID: <166631900602.2195025.11954037790952809560.robh@kernel.org>
References: <20221020103158.2273874-1-peng.fan@oss.nxp.com>
 <20221020103158.2273874-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020103158.2273874-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Oct 2022 18:31:57 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8MP ECSPI is derived from i.MX6UL, so update the binding.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
