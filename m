Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5573C5B3C5F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiIIPuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiIIPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:50:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553995F7ED;
        Fri,  9 Sep 2022 08:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5E0D62016;
        Fri,  9 Sep 2022 15:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB87FC433D6;
        Fri,  9 Sep 2022 15:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662738618;
        bh=K4+LglmFp8FKylejwGTXUXRPRgG940EZ6uOZ5dbE5Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FZ+zvbQ55IL88ER3l79/TjnFA1C/cc7HTrVT4Re4Zfz3HM7NiPjJgoOSTEalTtkHh
         GjCV7NVRrHbDblb693XBXkmc/gdU+B6Up4jf73tnVng+mOaAQa0LGRbzn5RmTbHfg5
         GPayF2tImeLw/q3/ecMTB91uHs6TmmIWzivxu2lWjxjkBH2iZD3Er3m2CNoanwF9Gd
         yTPCATdlQlBllB7HfJsO50oLdbiFlr+Naqs1IIpbRf97itaOu0EiTaW1OKygYqy4yy
         V+VrgqvZaQ0TnQ7YDS6QdzQQzYzlEPimQrOk+OtKuBmb8q9yEU4IEiIwwtxpkKCjYl
         hD3nSg5M+0Xvg==
Date:   Fri, 9 Sep 2022 16:50:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [RESEND][PATCH V8 1/2] dt-bindings: mfd: sprd: Add bindings for
 ums512 global registers
Message-ID: <YxtgtNY9qXwV5gfR@google.com>
References: <20220909152421.278662-1-gengcixi@gmail.com>
 <20220909152421.278662-2-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909152421.278662-2-gengcixi@gmail.com>
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
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
