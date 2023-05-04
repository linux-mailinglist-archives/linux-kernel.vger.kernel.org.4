Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D129B6F76FD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 22:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjEDU2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 16:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEDU2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 16:28:25 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119C16354;
        Thu,  4 May 2023 13:15:06 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-192d5ab4962so413104fac.3;
        Thu, 04 May 2023 13:15:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683231196; x=1685823196;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmGFO1ls8mvzZ2qitW1HiZvAeEBGZVDV30N8xTg86N8=;
        b=b9DKNxDEfUZ2iXOhFMh0L46Fon2lJKaJoi/XDvsb9eylIgecJax0u/8I59zW501x+S
         yp4d/NNnFg352H8e/Xzgil0PSjHlciCXo9iCp+9M8I+t1coHwWNzCMTUqB4ORmB7bqFd
         R7AJh0cylaE2qGsCKpeW38ram6z/yW6vBmDNwGa77ImY+urr5L/SzT9mQcH1VTeTPP/W
         tOQKV5murVpwpitkkfg3ucqxjrCDQEY39kVc2eKVG3zS2+PmmM4aZCIGGB7XV40aYkx5
         RX8qYgcHPTaS19EBeg3LRR7LqNKW5rJdirSIfsQ/ib+R8G5Q88elPep/1/cgSNNfUIVs
         Xo5A==
X-Gm-Message-State: AC+VfDwheGWMuIHzURh2PFnNbPLupjbRBFiulabMeTSnNFqftON9AHVi
        13PU7v9hytldR2hKKJzpSA==
X-Google-Smtp-Source: ACHHUZ5aCv1z/4rVPGyRr+R5ZqjX+p/gM8IRCJt/kBRMkNPFLsx2aGTwceNqGw0i8ceO0k5bw7HZZA==
X-Received: by 2002:a05:6870:93d3:b0:17e:da48:b65f with SMTP id c19-20020a05687093d300b0017eda48b65fmr1464119oal.22.1683231196361;
        Thu, 04 May 2023 13:13:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870450200b0017f84f81f3csm1003986oao.52.2023.05.04.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 13:13:15 -0700 (PDT)
Received: (nullmailer pid 252340 invoked by uid 1000);
        Thu, 04 May 2023 20:13:14 -0000
Date:   Thu, 4 May 2023 15:13:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@amd.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        git@xilinx.com, Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        devicetree@vger.kernel.org, monstr@monstr.eu,
        linux-arm-kernel@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH] dt-bindings: xilinx: Remove Naga from memory and mtd
 bindings
Message-ID: <168323119248.252262.3704807391594267570.robh@kernel.org>
References: <6b4cdc7158599b4a38409a03eda56e38975b6233.1683103250.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b4cdc7158599b4a38409a03eda56e38975b6233.1683103250.git.michal.simek@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 03 May 2023 10:40:55 +0200, Michal Simek wrote:
> Naga is no longer works for AMD/Xilinx and there is no activity from him to
> continue to maintain Xilinx related drivers. Two drivers have Miquel as
> maintainer and for the last one add myself instead to be kept in a loop if
> there is any change required.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml   | 1 -
>  .../devicetree/bindings/mtd/arasan,nand-controller.yaml         | 2 +-
>  Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml  | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 

Applied, thanks!

