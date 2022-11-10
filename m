Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC74D6247BC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiKJQ7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiKJQ7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:59:06 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8A7649;
        Thu, 10 Nov 2022 08:59:05 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id a7-20020a056830008700b0066c82848060so1452464oto.4;
        Thu, 10 Nov 2022 08:59:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu9VOZ0bBSO5GSl6uftNhEUB8IXfetD8C5a9NRdg/mo=;
        b=V1MFecBoHPUtB6m+B4+uVeG4mSuuUhJs7kGbxomx5uLA5Lm25TjTfV9RUw1UD0LmgQ
         bqAWHuvgAjD40s/0FpajNBbUmWyoO2MebesBgyKVB+wbQtP24bBlfB5wNP0H611mbV64
         EW3phRmWDLqtln8HKGIoK+qvwgQQu8h/Zwpx/MznlzWR+baK/CxCfApCP66E1/4aSCZC
         IcJ2t+vI4x9/+cMuTtBoTjfFlMM4wXpr1DyvBAzo3o3tPrKcKGPkzYP0Q54R5nLRJ3D8
         WutRZxBpm6PHFf71DnZe/A4LGXMX8vaBimLdlM2fDxBRVHMgP5mWuNRmTbbsp4lfCtPu
         kQHQ==
X-Gm-Message-State: ACrzQf21boBRRv5UGEv0lePTYtGXezQ81/CD/Su1v3y9YV51bM1YPFwX
        gueW8LsP2Iz5mqNKRecH7Q==
X-Google-Smtp-Source: AMsMyM78mWWnsWMVZD6WZragXacIiaUrC3claHPaA6YiV9+7ZSj7JKhpC9nH+jPz0uH4KpyFF+QyPA==
X-Received: by 2002:a9d:7047:0:b0:66c:6bc1:158e with SMTP id x7-20020a9d7047000000b0066c6bc1158emr22811550otj.350.1668099544935;
        Thu, 10 Nov 2022 08:59:04 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u19-20020a056808001300b0035418324b78sm5895937oic.11.2022.11.10.08.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:59:04 -0800 (PST)
Received: (nullmailer pid 526147 invoked by uid 1000);
        Thu, 10 Nov 2022 16:59:06 -0000
Date:   Thu, 10 Nov 2022 10:59:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/17] dt-bindings: mtd: nvmem-cells: Fix example
Message-ID: <20221110165906.GA241353-robh@kernel.org>
References: <20221104164718.1290859-1-miquel.raynal@bootlin.com>
 <20221104164718.1290859-14-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104164718.1290859-14-miquel.raynal@bootlin.com>
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

On Fri, Nov 04, 2022 at 05:47:14PM +0100, Miquel Raynal wrote:
> There is no such thing as a "ranges" property within an nvmem-cells
> node. There is no use of it, it is anyway not pictured anywhere that
> this is valid, so drop it from the example.

For a memory mapped device such as parallel NOR flash. It would be 
perfectly fine to translate a nvmem cell 'reg' address to a CPU address. 
If the partitions are not memory mapped, then it's a gray area. Whether 
it makes sense to translate just to just the absolute offset of the 
flash device, maybe or maybe not. At a minimum, 'ranges' just means 
can translate to the parent address space. The Linux DT translate code 
only supports the full translation to CPU addresses, but then it mainly 
just supports creating resources.

Rob
