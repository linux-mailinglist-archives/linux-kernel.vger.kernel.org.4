Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F855B6DF5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiIMNIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiIMNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:08:18 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A819D46DAA;
        Tue, 13 Sep 2022 06:08:16 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-11eab59db71so31876134fac.11;
        Tue, 13 Sep 2022 06:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gYRvuQ2qdE1v5ZxvpALuLEYAx8HMvTd8N+InKp0h9SA=;
        b=Um0i3BlM77/oo1BnUs6m2GnCiir6buKFBIzp+7GTWv9YUFd9DAEqQZ6OmIDrrfEzB/
         1g8mt286LLSsUqKrBhyhRHrxLQLzhv74IQZJILCUZUGsESbkVJQjYeLLt+bIp9ULBXYt
         1AbDYoScayTx9EhKxmKIT6DtD8nOslTA3QprGebJonyxgFkiGeSxPmM5XpOaw2WCpTO/
         RcUB1WX/vlKQGqP4zxYswHul4AyZve8zUnc1DOKAIrMg6Bm4icZYO17Y4sRLBi83wI1O
         2nvyYMEaKk40m3+FY7djBtavz+oe/LaPAK/PAdF8Few7KgdKAlJ8EbmRzXfhiTPwNdqu
         jreQ==
X-Gm-Message-State: ACgBeo1bSyr23DlaY1K0ZHAUl6MBtwj4MVQhiaDNoctBu1AASUqwuQvq
        6aghf64mgDwgfmiaBoTonQ==
X-Google-Smtp-Source: AA6agR543D8vV1CKE1eBM4ij6qnbQIN4icm49CwBYIRIDsP8JddOUmDai/27liOGBenmYu1KFZrc7w==
X-Received: by 2002:a05:6870:ac0d:b0:127:bf92:581f with SMTP id kw13-20020a056870ac0d00b00127bf92581fmr1818362oab.270.1663074495871;
        Tue, 13 Sep 2022 06:08:15 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h24-20020a056830165800b0063974238a5dsm6077956otr.63.2022.09.13.06.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 06:08:15 -0700 (PDT)
Received: (nullmailer pid 3499949 invoked by uid 1000);
        Tue, 13 Sep 2022 13:08:14 -0000
Date:   Tue, 13 Sep 2022 08:08:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        asahi@lists.linux.dev, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 01/10] dt-bindings: apple,aic: Fix required item
 "apple,fiq-index" in affinity description
Message-ID: <20220913130814.GA3495877-robh@kernel.org>
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-2-j@jannau.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909135103.98179-2-j@jannau.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022 15:50:54 +0200, Janne Grunau wrote:
> Fixes: dba07ad11384 ("dt-bindings: apple,aic: Add affinity description for per-cpu pseudo-interrupts")
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> 
>  .../devicetree/bindings/interrupt-controller/apple,aic.yaml     | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied with added commit msg, thanks!
