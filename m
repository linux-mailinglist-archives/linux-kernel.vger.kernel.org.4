Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0A688AA4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjBBXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjBBXR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:17:58 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B661582436;
        Thu,  2 Feb 2023 15:17:55 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-142b72a728fso4628024fac.9;
        Thu, 02 Feb 2023 15:17:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVyacUnj4NjLiVL2oCPB9AQvkGtTDBNOFK1fA2rLKDU=;
        b=CvTsK1T/ihtutsEdwvfA5+FWYJkfXMCbwtkV5BpR0bBNvdgVr/wGoMQ2Q7Zx5L1WLk
         1ps2HRXoH2o8+ENOzqGS6ilZog3PrBw/tVwep5KkQD49kPKYDZugeTh2Tdn3RbGuKxYP
         0HfamSwuognu3LbNCVo6E6Z9IXTf9QWX9iCf5BMnpD3nEuW8M4AMZbXl2z/HLp9mDMUZ
         ILR2tA3gc/ssyfpv93lJ5XzN3WW4Pddy/iKm9IDOBjGhMk0Yr+BywT5kkIof7pIbSpvA
         EuXG2aV1WSJQk16LN54q6El6yRiju4VnmBYjtnppH5N1ge/Evo9RZ/kqs63TMtRdNDPW
         btdw==
X-Gm-Message-State: AO0yUKUGT8OqtoAzIvFNYMDDB+QYMvwV6lcN60NBpFMRk7N1sg8dl5m1
        oHwRKwO2GxMLu/uUNa4+lA==
X-Google-Smtp-Source: AK7set+5wcoT1qxab/f2AP1SMTbR5SDSvDXU7lDMa//8ZCFDYo+A8FqhZNV20HeQ/1/J44IrMR7o2g==
X-Received: by 2002:a05:6870:ecac:b0:163:9eb8:43a7 with SMTP id eo44-20020a056870ecac00b001639eb843a7mr4431172oab.59.1675379874956;
        Thu, 02 Feb 2023 15:17:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h41-20020a056870172900b0014c8b5d54b2sm318501oae.20.2023.02.02.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:17:54 -0800 (PST)
Received: (nullmailer pid 2886780 invoked by uid 1000);
        Thu, 02 Feb 2023 23:17:53 -0000
Date:   Thu, 2 Feb 2023 17:17:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Carvalho Chehab <mchehab+huawei@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Yu Chen <chenyu56@huawei.com>,
        linux-phy@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH] dt-bindings: phy: hisilicon: Fix
 'hisilicon,eye-diagram-param' differing types
Message-ID: <167537987279.2886728.4247751754421507223.robh@kernel.org>
References: <20230125221444.3058631-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221444.3058631-1-robh@kernel.org>
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


On Wed, 25 Jan 2023 16:14:43 -0600, Rob Herring wrote:
> 'hisilicon,eye-diagram-param' is also defined in
> hisilicon,phy-hi3670-pcie.yaml as a 'uint32-array'. Unify it to use
> 'uint32-array' everywhere.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/phy/hisilicon,hi3660-usb3.yaml         | 3 ++-
>  .../devicetree/bindings/phy/hisilicon,hi3670-usb3.yaml         | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 

Applied, thanks!

