Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E036D528C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjDCUgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjDCUgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:36:00 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB350E76;
        Mon,  3 Apr 2023 13:35:59 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id n6-20020a4abd06000000b0053b59893660so4852477oop.0;
        Mon, 03 Apr 2023 13:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s+ztjMRV3XuJNS6XNA0zIS69fOM4rrYdilJ7sszmKnc=;
        b=8I/ypPSNoW3RXgar7rgXQ8yHcs+lhBQcZEWUENO/OjzhSCBNweZw6+ycSzmoDqB6zo
         Vk0W0d1ldjFJAovIdhOkmcZzX0gVzq1Hr7JXCUy8Ib4g/YYhUybNpSM2LCmFSRjA0iPO
         mz2AUsNxejg6wXWTLhGajPnPTbsi7g2VckKeD+UbKg/C9D1cRux3rjhI1jnSMAiVxCCo
         uVDNFpR7rHC5P7Tgl27jXti9vE3g9gpnqGxNfvmcozN/E7+4m03tj6WcjhcRBO1mS08M
         2Sr1vGIAyyIZVAhQdybcVrOorC70Crs+aB0ifMP8UByEBwAcvOoxmKaqyb8TkMlMxekb
         csHA==
X-Gm-Message-State: AAQBX9eYrw/2SKyG1p+RhxFK9sbl5UuGSVVDpBDFDZAKzVTlbraXjUS2
        wm08tQROvoJ2CovRdkMySw==
X-Google-Smtp-Source: AKy350aRTze7nxISoQoidgmjvyO79M8vfm5+3WRLN1fTJnbUk9iawOOVRB0+vpQESeL8A4KZQXpHgA==
X-Received: by 2002:a4a:4942:0:b0:517:a7d1:9762 with SMTP id z63-20020a4a4942000000b00517a7d19762mr275070ooa.7.1680554158990;
        Mon, 03 Apr 2023 13:35:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j19-20020a9d7f13000000b006a13dd5c8a2sm4686393otq.5.2023.04.03.13.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 13:35:58 -0700 (PDT)
Received: (nullmailer pid 1702926 invoked by uid 1000);
        Mon, 03 Apr 2023 20:35:57 -0000
Date:   Mon, 3 Apr 2023 15:35:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, Peng Fan <peng.fan@nxp.com>,
        robh+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: serial: fsl-lpuart: add optional
 power-domains property
Message-ID: <168055415736.1702887.7631783771882924355.robh@kernel.org>
References: <20230328054355.1973397-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328054355.1973397-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 13:43:55 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional power-domains property for i.MX8 usage.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

