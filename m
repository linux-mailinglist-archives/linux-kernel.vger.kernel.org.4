Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F01742A66
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjF2QNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbjF2QNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:13:51 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D161FD7;
        Thu, 29 Jun 2023 09:13:50 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-783549ef058so35570639f.2;
        Thu, 29 Jun 2023 09:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688055230; x=1690647230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFdEMQN79kKvi2kqq2FWX13+T3/lc6iF08TGlcclIMM=;
        b=OK+qIdB41FgCJ5pG0D3wR8kaHODBj3KThJHXW7cipoe965k4ffNQgDeZQluY3Ea/xb
         QrQfrRRrZKU7ezqscg+t/l1r4BGvEkMvp1+IVbP6CK2VS1U8FwDVegS2qdPuMlo4SRSl
         /QCbhEtrxsU4xY6JFA8aKQWjm29PciwUb43uKHLAQ9XJ7F/zuDsdOzD5n/bdaG4LHkGx
         adougrsnsmMsuLjdXliEMP0kDNmNmEzBqf9J/JzRuyC4/xAeR3I/Q2/yx1bDcnKu93g2
         ZDq0GR3UL8Somazck3T3PwMn965lwafvEYcRCiyHaJVMiVeW6lWaeYdxFJaZDXtv4FIV
         r0pw==
X-Gm-Message-State: AC+VfDwNkJGnhPCSIakK672k6s3v+BhmWwisLuUvb+UA/XOekHYXyN+E
        Z4iU1R8CQWqN4O4XZMRcBA==
X-Google-Smtp-Source: ACHHUZ7L2K0rZJQWVeqYf2S62Sl0/yPlkbfb3EeaeI4ZoJX8fp5J5T7DRDWdMHB2JIzwO9Yj9chBGQ==
X-Received: by 2002:a5e:c606:0:b0:785:cb8d:f1c5 with SMTP id f6-20020a5ec606000000b00785cb8df1c5mr15334iok.12.1688055230020;
        Thu, 29 Jun 2023 09:13:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k5-20020a02cb45000000b0040bbcee6b57sm1708532jap.133.2023.06.29.09.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 09:13:49 -0700 (PDT)
Received: (nullmailer pid 3129978 invoked by uid 1000);
        Thu, 29 Jun 2023 16:13:47 -0000
Date:   Thu, 29 Jun 2023 10:13:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH V4] dt-bindings: nvmem: fixed-cell: add compatible for
 MAC cells
Message-ID: <168805522630.3129899.14135828731809373225.robh@kernel.org>
References: <20230627204630.9476-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230627204630.9476-1-zajec5@gmail.com>
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


On Tue, 27 Jun 2023 22:46:30 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> A lot of home routers have NVMEM fixed cells containing MAC address that
> need some further processing. In ~99% cases MAC needs to be:
> 1. Optionally parsed from ASCII format
> 2. Increased by a vendor-picked value
> 
> There was already an attempt to design a binding for that at NVMEM
> device level in the past. It wasn't accepted though as it didn't really
> fit NVMEM device layer.
> 
> The introduction of NVMEM fixed-cells layout seems to be an opportunity
> to provide a relevant binding in a clean way.
> 
> This commit adds a *generic* compatible string: "mac-base". As always it
> needs to be carefully reviewed.
> 
> OpenWrt project currently supports ~300 home routers that have NVMEM
> cell with binary-stored base MAC.T hose devices are manufactured by
> multiple vendors. There are TP-Link devices (76 of them), Netgear (19),
> D-Link (11), OpenMesh (9), EnGenius (8), GL.iNet (8), ZTE (7),
> Xiaomi (5), Ubiquiti (6) and more. Those devices don't share an
> architecture or SoC.
> 
> Another 200 devices have base MAC stored in an ASCII format (not all
> those devices have been converted to DT though).
> 
> It would be impractical to provide unique "compatible" strings for NVMEM
> layouts of all those devices. It seems like a valid case for allowing a
> generic binding instead. Even if this binding will not be sufficient for
> some further devices it seems to be useful enough as it is.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Drop "mac-ascii" as length can be checked instead
>     Fix "allOf" by adding required: [ compatible ]
> V3: Fix cell length in "description" (thank you Rob!)
> V4: Fix cell length (12 → 6) in fixed-layout.yaml example as well
> ---
>  .../bindings/nvmem/layouts/fixed-cell.yaml    | 26 +++++++++++++++++++
>  .../bindings/nvmem/layouts/fixed-layout.yaml  | 12 +++++++++
>  .../devicetree/bindings/nvmem/nvmem.yaml      |  5 +++-
>  3 files changed, 42 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

