Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2D45EB1FE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiIZUTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIZUTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:19:01 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D7AA3467;
        Mon, 26 Sep 2022 13:18:58 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 102-20020a9d0bef000000b0065a08449ab3so5200873oth.2;
        Mon, 26 Sep 2022 13:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KJlsgimTd3mObvKcs7p4DgFRQTNtaor80jMAncbSWLo=;
        b=3b6z+Apm/6+31RRkavJGVMqVOCodqOk2KSrYs7U2Tv3klzeZqiUz71cKRsFLdqxbbt
         UFeLbeXTqjuugS8ke9i8PT/QwfBC2aizMFnrEk9iwn1T3MslEllYx5n1hnHChhsdYUaH
         gab7jje+9klY0yNb+Zhb0mnbpcGst+qSn0mcgw/Ff2S1/VjPKkC7adjUNEaaUbqUPPi3
         WnbFFwTaM92l99+dG4EygajJCVgl8uSqz5qD0XSSkZ57ATACPZ3+NdcAwxwi0Np1ApLk
         q9MXjeOGgodDFc9QMKHOMdjsQyVm0Shtk+1Vfq50LdAuDakxpwC6ezPNEPX/szwmz+8g
         L7YA==
X-Gm-Message-State: ACrzQf0+bXkNXlvsB0OETMk0wkmBtHBxYd2EsQLqrerNuKDy8RgKUaCc
        qUmSy1+AqVWahgAQ9gEb3A==
X-Google-Smtp-Source: AMsMyM6E/0hljdxLtyM/sOO0YA16vj1XmMdEQbXNAmJVVre7Y09XmtG1e/3e8RSRGm3MHxuS/orTSA==
X-Received: by 2002:a05:6830:34a3:b0:659:7542:6cd4 with SMTP id c35-20020a05683034a300b0065975426cd4mr11088913otu.87.1664223538122;
        Mon, 26 Sep 2022 13:18:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f11-20020a056870548b00b001278611f0f6sm9312863oan.32.2022.09.26.13.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:18:57 -0700 (PDT)
Received: (nullmailer pid 2734688 invoked by uid 1000);
        Mon, 26 Sep 2022 20:18:57 -0000
Date:   Mon, 26 Sep 2022 15:18:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robert Nelson <robertcnelson@gmail.com>
Cc:     Drew Fustini <drew@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        linux-kernel@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: ti: Add bindings for BeagleBone
 AI-64
Message-ID: <20220926201857.GA2734653-robh@kernel.org>
References: <20220921021300.4111283-1-robertcnelson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921021300.4111283-1-robertcnelson@gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 21:12:59 -0500, Robert Nelson wrote:
> This board is based on the ti,j721e
> 
> https://beagleboard.org/ai-64
> https://git.beagleboard.org/beagleboard/beaglebone-ai-64
> 
> Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
> CC: Rob Herring <robh@kernel.org>
> CC: Nishanth Menon <nm@ti.com>
> CC: Jason Kridner <jkridner@beagleboard.org>
> CC: Drew Fustini <drew@beagleboard.org>
> ---
> Changes since v2:
>  - rebased on next after k3.yaml alphabetical sort
> Changes since v1:
>  - added documenation links
>  - add board in alphabetical order
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
