Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB20631522
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 17:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKTQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 11:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKTQSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 11:18:41 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A1D28E37;
        Sun, 20 Nov 2022 08:18:40 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id q186so10358651oia.9;
        Sun, 20 Nov 2022 08:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2tDBskZMqsrQK7Vlan4LyB4H9Bl0NcuolmbUdogh9Q=;
        b=mgo7GlCOQMAJrWkwj2cUKbUqklwefUbKPy1IckK76we0jIJRPc4X5Ur7A0BG+Xszuq
         InVJ5TgTA7KpEtAiKWDTrPjCxxbbCrOtD7gCq3MYGkhJc6pDD2vIbg2Q0jOGS+MVj8qE
         ZifeYcAFkNtEbdQC8cNtbRXybYvuwHZC32gwHFTaLR5RSfmPbk7Ma7+3e5Hez+HRaRIB
         MSyIdTxaGYDpS503X4sAY20fGIrvYpQd2Rs8HsdDaxsMYq92JqbBhXGHAC9abZQMlCP/
         ssw6jLg5mD4g+in4C/ApbCMAguPeceu6r+K98haSI+V6ZJBIr+tnslRy8FJ57JM6JrIe
         8Iow==
X-Gm-Message-State: ANoB5pnDOS3aIQmjzmJhV0WlGzK0ZisAr5roKaPw16Y6W0CHFLLl2b3y
        WFX9VQHx29zz6J4tjVx1djDUAZnYIQ==
X-Google-Smtp-Source: AA0mqf5xElZLdU74sEi5IcptcuBXXu+iE8cVB1Hbe0ztphnxnFIde7XIQp/sMBqSU9wP78D/eineyg==
X-Received: by 2002:a05:6808:109:b0:359:ac90:eb35 with SMTP id b9-20020a056808010900b00359ac90eb35mr7251641oie.80.1668961119583;
        Sun, 20 Nov 2022 08:18:39 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f6:1a48:29f6:113d:266f:a78e])
        by smtp.gmail.com with ESMTPSA id k16-20020a544690000000b0035a534b9237sm3426918oic.29.2022.11.20.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 08:18:39 -0800 (PST)
Received: (nullmailer pid 3153895 invoked by uid 1000);
        Sun, 20 Nov 2022 16:18:40 -0000
Date:   Sun, 20 Nov 2022 10:18:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tanmay Shah <tanmay.shah@amd.com>
Cc:     krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, andersson@kernel.org,
        linux-remoteproc@vger.kernel.org, michal.simek@amd.com,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, bill.mills@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/6] dt-bindings: remoteproc: Add Xilinx RPU
 subsystem bindings
Message-ID: <166896111895.3153827.4429879978680534697.robh@kernel.org>
References: <20221114233940.2096237-1-tanmay.shah@amd.com>
 <20221114233940.2096237-2-tanmay.shah@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114233940.2096237-2-tanmay.shah@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Nov 2022 15:39:35 -0800, Tanmay Shah wrote:
> Xilinx ZynqMP platform has dual-core ARM Cortex R5 Realtime Processing
> Unit(RPU) subsystem. This patch adds dt-bindings for RPU subsystem
> (cluster).
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
> 
> Changes in v11:
>   - rename binding filename to match with compatible string
>   - change $id: value accordingly as well
> 
> Changes in v10:
>   - rename example node to remoteproc
> 
> Changes in v9:
>   - remove power-domains property description
>   - fix nitpicks in description of other properties
> 
> Changes in v8:
>   - Add 'items:' for sram property
> 
> Changes in v7:
>   - Add minItems in sram property
> 
> Changes in v6:
>   - Add maxItems to sram and memory-region property
> 
> Changes in v5:
>   - Add constraints of the possible values of xlnx,cluster-mode property
>   - fix description of power-domains property for r5 core
>   - Remove reg, address-cells and size-cells properties as it is not required
>   - Fix description of mboxes property
>   - Add description of each memory-region and remove old .txt binding link
>     reference in the description
> 
> Changes in v4:
>   - Add memory-region, mboxes and mbox-names properties in example
> 
> Changes in v3:
>   - None
> 
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 135 ++++++++++++++++++
>  include/dt-bindings/power/xlnx-zynqmp-power.h |   6 +
>  2 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
