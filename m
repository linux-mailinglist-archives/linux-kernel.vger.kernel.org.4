Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E1F64F536
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiLPXhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiLPXhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:37:22 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CBDFFD;
        Fri, 16 Dec 2022 15:37:21 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-144b21f5e5fso5085814fac.12;
        Fri, 16 Dec 2022 15:37:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii0p33EQ9H4zp/XmzfpUA0yClbxfMoE6kATAvTWMwec=;
        b=GurJknlqsXoI8qsybBvXNgbrRY91Iu+7EnmVLZi3wDq3/GgNdpau8lmuBATxEotfxx
         oBUl+SUgIwR5+UZB8mTsNmIZI+TmpoJblxH3iHVAsEtmJDiMsxsar1YAzH8HJLl3DeAs
         45aEuC/fAnG/oRtgb789TKSOD2gupuDAyXvrMAyspakj2kwJryE/VNiSTLjrtm6/Fa/d
         biTdi1wjz9kXqljqsbCnYmUb0TskbUiENPZYg0Ju87KziaRWyAs0WFY3A8GecQ51tLOO
         +5EzFdHvQmazTyMcmX9n561oRjG/D50uksWbTE1jHLMIh6j5ZBt9hyAftsV8m3THpS2Y
         mCYA==
X-Gm-Message-State: AFqh2kq8p716U+eTwPIojfeW2BH2aMTEr2xHq+NLfx+W0Xct6GY6Xw7S
        mOwKC1/Dzz9b8LatjGwoAw==
X-Google-Smtp-Source: AMrXdXvAb/LsQP3Ex0aDd+UgqHNCU2nLgLX/l3ruHhfCO9PK3TsEg8yDhvAa4dol4NasHyfSjPcTsQ==
X-Received: by 2002:a05:6870:46ab:b0:144:c0f3:ca57 with SMTP id a43-20020a05687046ab00b00144c0f3ca57mr252303oap.39.1671233840763;
        Fri, 16 Dec 2022 15:37:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i8-20020a056820012800b004a0aac2d28fsm1397017ood.35.2022.12.16.15.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:37:20 -0800 (PST)
Received: (nullmailer pid 81854 invoked by uid 1000);
        Fri, 16 Dec 2022 23:37:19 -0000
Date:   Fri, 16 Dec 2022 17:37:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        luis.oliveira@synopsys.com
Subject: Re: [PATCH v5 2/4] dt-bindings: phy: Document the Synopsys MIPI DPHY
 Rx bindings
Message-ID: <20221216233719.GA80712-robh@kernel.org>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216143717.1002015-3-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:37:15PM +0200, Eugen Hristev wrote:
> From: Luis Oliveira <Luis.Oliveira@synopsys.com>
> 
> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> RX mode.
> 
> Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> ---
>  .../bindings/phy/snps,dw-dphy-rx.txt          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt

New bindings must be in schema format.

Rob

