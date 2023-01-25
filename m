Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E820C67BB86
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 20:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjAYT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 14:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236044AbjAYT6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 14:58:55 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D3D50B;
        Wed, 25 Jan 2023 11:58:38 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso11757589oti.10;
        Wed, 25 Jan 2023 11:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2okyASH/JCrvQKLi2NuQ+QA06bfjxbFJqRj6dFE5tQM=;
        b=qUWfa+l+y/VQ8wQh5WWhg+yUQep1JFUn6LwESJzivO5tRJPxIzRkrGa6jBnzACBCpi
         hhnhp25dR7xhNibVST5zkHAvxSff1xmoXbEEyMEAdv/kl8I0GvLHhBm6MbQXIoMeJfob
         Cgms2Fs7LJP5/nDAmU+l/hZAtDScTDsAg1V6HnitIIoLEP5a/ofygGlgaGTw+jBN5njG
         /6NZGRdP/MyEZXxXWAoN18KR3WVu1pTrOUSUu6vhEEampYzATZuMAVLFmdCSF6wk6K7B
         1rFYIHG+R6Z14DD8V8XQuArk1ls/fdwBcUUsNG9kvZoRZkx6zrqdczAXoLOO3pNos8Wp
         /tLA==
X-Gm-Message-State: AO0yUKWgkEd8t8MZ5QoJ//eHykEZeV17YPP6cuaKz6SnIoi0csTe7kdu
        uN/FqTPYr69VT7u0HTZS2A==
X-Google-Smtp-Source: AK7set9d1LiSdqBsy5DLQ2ic1F6Uy2cyrnOE/ZpKtoJx+XfCn0Ca8jvBCpbuk+lmAZEFdBwjVA88DA==
X-Received: by 2002:a05:6830:3487:b0:688:4c3c:71a3 with SMTP id c7-20020a056830348700b006884c3c71a3mr2890062otu.30.1674676717739;
        Wed, 25 Jan 2023 11:58:37 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g1-20020a9d5f81000000b0068687c98725sm2540366oti.62.2023.01.25.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 11:58:37 -0800 (PST)
Received: (nullmailer pid 2755057 invoked by uid 1000);
        Wed, 25 Jan 2023 19:58:36 -0000
Date:   Wed, 25 Jan 2023 13:58:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     rashmi.a@intel.com
Cc:     mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        nandhini.srikandan@intel.com, vkoul@kernel.org,
        adrian.hunter@intel.com, linux-phy@lists.infradead.org,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com, vasavi.v.itha@intel.com,
        robh+dt@kernel.org, kishon@ti.com,
        andriy.shevchenko@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        mahesh.r.vaidya@intel.com, michal.simek@xilinx.com,
        kris.pan@linux.intel.com
Subject: Re: [PATCH v1 4/4] Revert "dt-bindings: phy: intel: Add Thunder Bay
 eMMC PHY bindings"
Message-ID: <167467671590.2755018.3180084098513210344.robh@kernel.org>
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-4-rashmi.a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124054427.28808-4-rashmi.a@intel.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 24 Jan 2023 11:14:27 +0530, rashmi.a@intel.com wrote:
> From: "A, Rashmi" <rashmi.a@intel.com>
> 
> This reverts commit efb6935dd786a9d213ee542ed77d47ece700357c.
> 
> Revert Thunder Bay specific code as the product got cancelled
> and there are no end customers.
> 
> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>
> ---
>  .../phy/intel,phy-thunderbay-emmc.yaml        | 45 -------------------
>  MAINTAINERS                                   |  7 ---
>  2 files changed, 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunderbay-emmc.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
