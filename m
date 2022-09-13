Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BE15B799C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbiIMS3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiIMS3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:29:09 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3FF3ECF6;
        Tue, 13 Sep 2022 10:45:38 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1280590722dso34224373fac.1;
        Tue, 13 Sep 2022 10:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qDU1dVfDL2VHKGYWJ5a0s674Yk9833G02h9G9SPMZJE=;
        b=LkZD2sHqitDdrOPrMSV9dUYgcUgwzFXiqiIIXf3XLXdzJOBnMwHNR5elDIjKjfE34b
         qQGGL84wD9Xqi6VjM0DaUu66UTXXT20aS05IuItNLietoCc50v3LzjcTv2vbOx+Lr42o
         9raen6GjqiyH1HgBUx0glRIvep0JOoq2rpTBAwqAmeKEIharfRzxfquNj+PjNqXTYmTn
         3dJOLH9r+Tte3sYnrFMB1liW1Ki85kV/IObqgCF7sa1FmuNN4qzOqmwCd/+vU7J1geUn
         BbeoFyLf+xp3TysM3hSpW2+6i0BOemlXHAe8XIVMBeoIWx284SwzmcAF5Yr4W1oCc2fT
         1Abg==
X-Gm-Message-State: ACgBeo2gLtq/n7TOjidOaWQk2tChNWSewRQOCqAAXUT9rPaTvjrUjS18
        5TsRpmOwudvCulFWDcYdmQ==
X-Google-Smtp-Source: AA6agR6RvE10OYUPFnLECvJH5VU6fTop/H+TsqK9L3rPA9XBgzAe7bDAvDb7F3y4VOCoTrWY6p8pTQ==
X-Received: by 2002:a05:6870:8a09:b0:126:7a92:1b0b with SMTP id p9-20020a0568708a0900b001267a921b0bmr253474oaq.152.1663091137486;
        Tue, 13 Sep 2022 10:45:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v66-20020acade45000000b00344a22e71a9sm5452753oig.9.2022.09.13.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 10:45:36 -0700 (PDT)
Received: (nullmailer pid 4130546 invoked by uid 1000);
        Tue, 13 Sep 2022 17:45:35 -0000
Date:   Tue, 13 Sep 2022 12:45:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] dt-bindings: nvmem: u-boot,env: add basic NVMEM cells
Message-ID: <20220913174535.GA4119815-robh@kernel.org>
References: <20220703084843.21922-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220703084843.21922-1-zajec5@gmail.com>
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

On Sun, 03 Jul 2022 10:48:43 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> U-Boot doesn't have cells at hardcoded addresses. They are stored in
> internal format. It's still important to define relevant cells in DT so
> NVMEM consumers can reference them.
> 
> Update binding to allow including basic cells as NVMEM device subnodes.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../devicetree/bindings/nvmem/u-boot,env.yaml       | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

Sorry, I guess I was thinking this depended on or interacted with one of 
the other nvmem series.

Applied, thanks!

Rob
