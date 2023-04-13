Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DB06E0A90
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjDMJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjDMJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:50:24 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2146155AB;
        Thu, 13 Apr 2023 02:50:21 -0700 (PDT)
Received: from 8bytes.org (p200300c27714bc0086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7714:bc00:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 08FAA242A7C;
        Thu, 13 Apr 2023 11:50:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1681379419;
        bh=khKX1Kt8U0Nb+s4cjAnuHj6Kz00rGwbDEtCwE44xwB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAoH/0AhRaB1YmsjIYUgU1WtUxL7vKegIm2zyUKEp3pJe93JO4iM2A9ZE2xMxfz1V
         NDGSb2hthiXRMuJhLEPiH7FtsPYCLkSKol/dEx9B0evxW+VmVr/rsqEh6ssGmdvh9W
         S6ZrTgAg8yC/FzSOMzgA/lbc1DsfbttFOYQgf5p6lT0LsAiUNsvP53y+tfOs5SR29S
         /1YUcmPcOtFT0xrbgdPYOVDkg5UYcIhL48IDpzBc3UAMiovcMlQwj2gkrgshYD25uI
         XGt4y1j7nHdkuuqewckE5rukVRcRw3w29UNEq22xlJRUtuoWIjvqLu7vSQn6DmU8HF
         kH7RXlCDGu2vg==
Date:   Thu, 13 Apr 2023 11:50:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] iommu/exynos: Use the devm_clk_get_optional() helper
Message-ID: <ZDfQV2Vbbaa4fRI4@8bytes.org>
References: <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c0d5ce643737ee0952df41fd60433a0bbeb447.1679834256.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 02:37:50PM +0200, Christophe JAILLET wrote:
> Use devm_clk_get_optional() instead of hand writing it.
> This saves some loC and improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/iommu/exynos-iommu.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)

Applied, thanks.
