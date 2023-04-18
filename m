Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92B0A6E6B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 19:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjDRRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjDRRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 13:37:30 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9ED98;
        Tue, 18 Apr 2023 10:37:28 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-38e3a1a07c8so435552b6e.0;
        Tue, 18 Apr 2023 10:37:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681839447; x=1684431447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M52uF3Xny9Xn+CTWt1O2zToBNMFTvehdIRABY+BcMFA=;
        b=Poi35h38+rOIZ+q6STDUvLN45HEWNExtW2eQL+oD3kPI7WfW3Xy9m55I4GQZBDF7Il
         VGhUVB38IOtJjDQFdpXoM0S9gMgrPELEiDwAFg2lADHiS10oPVtB+2j93h8PrMHk5Yjd
         GRdL6ST993cdCKdMQ73TNBEZ1sPIcdYgnpvN7pvLSYNX5EqRV7gzUZyeu6MAxMVrrP6n
         XKj7Z+XZ4wS0/OyBstF6vUs1lMCQ52m3gLCUUx+GPhZH9y0khK8gfgVLEUVnmAbFq0LN
         BwGmgBchwN2qtsRa/Bd0CPLl2nGEWqFlGx795n0i6TNcm4zMq8H83ia6VsqFHRCCG5Rb
         GhWw==
X-Gm-Message-State: AAQBX9eBCujT3jSW+h4WQcAxXOQnmUMRs6od99WgeA0U1vVXQ4NXKZ6S
        kTQI1sWySSUc/mC0KvhxXg==
X-Google-Smtp-Source: AKy350bVrNX3a1hCXCQhFiJKCcWj3iFKBcmfsQoe98Y+4J2EIkcrjEukoGrJeBNrpMAXZjW5vx3oaQ==
X-Received: by 2002:a05:6808:354:b0:38e:295b:2e22 with SMTP id j20-20020a056808035400b0038e295b2e22mr1383654oie.3.1681839447320;
        Tue, 18 Apr 2023 10:37:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 2-20020a544182000000b0038e07fe2c97sm2470038oiy.42.2023.04.18.10.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 10:37:26 -0700 (PDT)
Received: (nullmailer pid 2019466 invoked by uid 1000);
        Tue, 18 Apr 2023 17:37:24 -0000
Date:   Tue, 18 Apr 2023 12:37:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alain Volmat <avolmat@me.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, patrice.chotard@foss.st.com
Subject: Re: [PATCH] dt-bindings: irqchip: sti: remove stih415/stih416 and
 stid127
Message-ID: <168183942381.2018957.2512468893497866547.robh@kernel.org>
References: <20230416190950.18929-1-avolmat@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230416190950.18929-1-avolmat@me.com>
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


On Sun, 16 Apr 2023 21:09:50 +0200, Alain Volmat wrote:
> Remove bindings for the stih415/stih416/stid127 since they are
> not supported within the kernel anymore.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> Patch sent previously via serie: https://lore.kernel.org/all/20230209091659.1409-5-avolmat@me.com/
>  .../bindings/interrupt-controller/st,sti-irq-syscfg.txt  | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 

Applied, thanks!

