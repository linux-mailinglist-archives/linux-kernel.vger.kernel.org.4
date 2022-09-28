Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580855EDAAE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbiI1K4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiI1K4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:56:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E92B6DFA3;
        Wed, 28 Sep 2022 03:54:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A31361E18;
        Wed, 28 Sep 2022 10:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0139AC433D6;
        Wed, 28 Sep 2022 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664362418;
        bh=YdKCPzIwgdWUb0jK2QuCvZA7ornVgM+pZYMw4TjPT/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S2lYCiUMkKfTHba/f9auk+zRJZZfkvFdFIuMB/cibhtLYEBaMAAoyVopkBkCxsCzj
         dsAFzxGMLa/xxS93flw4YODOP0ldk2apPDC3uNbNRiBFjN0+dasYlr9Zw13oeflRnO
         GWR2RQcD8GfwwR6WgpZJF5M54ELyZ05iF/7rMr5iRmptSiZudNcTY4LeVIFtL788KZ
         OX4+1ZvJcfYXIOXh17A+z4Xx4kcoVc3VF5K5HotAo5rUVAwG36HPYur8GGcWCqtV/X
         KMTzXP6gPN0Qp0wgTV+Oa0AQ31TONQsJ1js5b+lp4f5cuzu0dbAxkvaGPscdL90GSY
         lE5x+HgY3JJGA==
Date:   Wed, 28 Sep 2022 11:53:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, cy_huang@richtek.com,
        chiaen_wu@richtek.com, alice_chen@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: mfd: mt6370: fix the indentation in the
 example
Message-ID: <YzQnrFIYXQVdPXOh@google.com>
References: <1663295929-9024-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1663295929-9024-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022, cy_huang wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix the indentation in the binding example. There're two redudant space
> charactors need to be removed.
> 
> Acked-by: Rob Herring <robh@kernel.org>

Next time, please keep tags in chronological order.

I'll fix this for you this time.

> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> 'Acked-by' must be added in v2. But I seen the reply after I sent patch v2.
> 
> Sorry to add 'Acked-by' only in v3 change.
> 
> Since v3:
> - Add 'Acked-by' tag.
> 
> Since v2:
> - Add Fixes tag in commit message
> 
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
