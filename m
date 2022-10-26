Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D6260E922
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 21:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiJZTlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 15:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiJZTl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 15:41:27 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCBFB7EDA;
        Wed, 26 Oct 2022 12:41:19 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-12c8312131fso21612780fac.4;
        Wed, 26 Oct 2022 12:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPHONoWIoiJZTFgcTi0/G6lMn83E2o6AmOqzxyIw2bs=;
        b=wIH3a7zC8AuUkw0n38RRFk9KmPRnM7N5MBZWrpX5rMD1F/4tSN4w90JNS+Wf4Ae7LQ
         4BrsPQJ6QEYde6sHMVnJ3+Jg+R9L5GpA4KRLtlod6FyEk5acHlc5RrfSGfKIa87dh78r
         d1SRzbsw3hZeSK7GbXwXwgy4R7BykmpHuNF986GS5z9APiDqYPqCYozxlecToo2Pjicm
         N5kjmJNCoU//25FFeYfmcpzK5fQSTimtZ6ztd4HxgaGpo0O+wlWxI1ommczng9pP7OC9
         ostkJYBCVrXsVm0Xhr7Ew4BVUxbzoZs8tQDAFi8fXM3KZjWwQ4zzivOpMFw6vE168x4I
         Fazg==
X-Gm-Message-State: ACrzQf1MORvuvbhBBJbm1yLb5FfAKQkEanJxj6C+fMasO8KfdmAPoyR0
        S2L00k3Kc84qntP6tjPqIQ==
X-Google-Smtp-Source: AMsMyM4QwTUCtNMwN5OtnKfodKO29IN4opAIzj4qcr/bDuqdr1/vA0ZASc7FopWtKVyVaVnnMpIatA==
X-Received: by 2002:a05:6870:f59e:b0:132:bcd:565f with SMTP id eh30-20020a056870f59e00b001320bcd565fmr3169738oab.254.1666813279179;
        Wed, 26 Oct 2022 12:41:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y18-20020a056870429200b0010c727a3c79sm3630583oah.26.2022.10.26.12.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 12:41:18 -0700 (PDT)
Received: (nullmailer pid 1046234 invoked by uid 1000);
        Wed, 26 Oct 2022 19:41:20 -0000
Date:   Wed, 26 Oct 2022 14:41:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Jens Axboe <axboe@kernel.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mikhail Zhilkin <csharper2005@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Christian Marangi <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: support marking
 rootfs partition
Message-ID: <166681327937.1046171.12755634067676619192.robh@kernel.org>
References: <20221022211318.32009-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221022211318.32009-1-zajec5@gmail.com>
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

On Sat, 22 Oct 2022 23:13:17 +0200, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Linux needs to know what to use as root device. On embedded devices with
> flash the only common way to specify that is cmdline & root= parameter.
> 
> That solution works with U-Boot which is Linux & cmdline aware but isn't
> available with all market bootloaders. Also that method is fragile:
> 1. Requires specific probing order on multi-flash devices
> 2. Uses hardcoded partitions indexes
> 
> A lot of devices use different partitioning methods. It may be
> "fixed-partitions" or some dynamic partitioning (e.g. based on parts
> table). For such cases allow "linux,rootfs" property to mark correct
> flash partition.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Use "linux,rootfs" as more accurate. Thanks Rob.
> ---
>  .../devicetree/bindings/mtd/partitions/fixed-partitions.yaml  | 1 +
>  .../devicetree/bindings/mtd/partitions/partition.yaml         | 4 ++++
>  2 files changed, 5 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
