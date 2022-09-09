Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6695B3160
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiIIIKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiIIIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:10:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33898606C;
        Fri,  9 Sep 2022 01:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51D1F61F0C;
        Fri,  9 Sep 2022 08:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01964C433D6;
        Fri,  9 Sep 2022 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662711038;
        bh=2jqQZ/d4xJNpEjCgaTT0UvEyC49fzd3+hIiAVpWSMSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmUm/Au0XU1v7SDCW2MI3Iln9pU3QVYNMZ64cfssKGLQyIVJZajNRsnkqm3E1dBgV
         buAWrHqeZFZnJcrnYRu/6BW6RD5Gx3UFJRJb/TJFyu67uUGwQYmDuFx5Jq0ntoFfc/
         O9u8xq8khpl4L+7ArQyLEr665bBZGKTndV1slOOhwgRyEB/MNovnI1pSfEc4VyYRfk
         u19Q8ENfQDwepVV0ZhRIq+M+uXObs7zloNm1Lr9eDvyNz4TNPITlxSmTDBNCSNLhc5
         omjzkDwGogIoMvRZlXu+vom3ewf6I9HxhGbqy/kAgJDzvQXoRkryoubD/JUinU9q0U
         vPbUbqxY0U5Ng==
Date:   Fri, 9 Sep 2022 09:10:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH V7 1/2] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <Yxr0+LJWWsF53dr2@google.com>
References: <20220909073456.239668-1-gengcixi@gmail.com>
 <20220909073456.239668-2-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909073456.239668-2-gengcixi@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Cixi Geng wrote:

> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

I'll take this when the clk driver changes are merged.

-- 
Lee Jones [李琼斯]
