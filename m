Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7B36D27E1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCaSdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjCaSdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:33:18 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155531CB87;
        Fri, 31 Mar 2023 11:33:17 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id d22-20020a9d5e16000000b0069b5252ced7so12311831oti.13;
        Fri, 31 Mar 2023 11:33:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680287596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRhw4+gSmUKDFVNe4CaJ5if9d/WbaipuiqooHxfT4eA=;
        b=m1WfKWgF3hqz2VG20ZpJbsm1JjgJDcUpH+hkJlEdA0Aiye0ech257iOt/6nnq34Y91
         VQXX21y6HV4D74obKK/AjbnSzgeQaOKc6RN1Q4pVUxKtY20QuI0fA9tVBkiYhyhiy4IS
         8vZrZWTAZMUW5284sQ9ltw1LuxJw73EWqSK0KzWco7TbarhmU/9gKpLTWuVdWXdMPgDC
         WPfa8QPRDURlZlUSWXOH7SwJyr0/U5/aHA7fuycD2IKFmmJFkU2QJ1cDy2dQAhV7MJGh
         jBcsXl37x7ZjeThEImL4Nzhrg0g3roI98rPQFRp0Cdd+JwIL9GWyx5BYbdVYZtMICLAS
         xMIw==
X-Gm-Message-State: AO0yUKUxi3MUhZAHDjctHYF/3PxDriQp4QUN6rFmwHm7Z8mXqL6Cy4DQ
        pSfmFd9i+KRRiJlQXQRlY0i/3OdqyQ==
X-Google-Smtp-Source: AK7set+O9b9HU5G/Sjl5yhFUsZUNBveJx2hmlsB2V4mnpUA1VQwLVNq4z86k7P29r8jMZopkPxUItw==
X-Received: by 2002:a05:6830:3a11:b0:693:d8a3:1f07 with SMTP id di17-20020a0568303a1100b00693d8a31f07mr13892605otb.22.1680287596275;
        Fri, 31 Mar 2023 11:33:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w3-20020a9d6383000000b006a11c15a097sm1428502otk.4.2023.03.31.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:33:15 -0700 (PDT)
Received: (nullmailer pid 1915009 invoked by uid 1000);
        Fri, 31 Mar 2023 18:33:15 -0000
Date:   Fri, 31 Mar 2023 13:33:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     herbert@gondor.apana.org.au, gaurav.jain@nxp.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        pankaj.gupta@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        horia.geanta@nxp.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH] dt-bindings: crypto: sec-v4.0-mon: add snvs power off
 support
Message-ID: <168028759194.1914867.10213503513159167493.robh@kernel.org>
References: <20230323123907.103719-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323123907.103719-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Mar 2023 20:39:07 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add SNVS power off support. The SNVS_LP LPCR register could
> drive signal to PMIC to turn off system power.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Applied, thanks!

