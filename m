Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD946796A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 12:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjAXLb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 06:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234032AbjAXLbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 06:31:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1648CF772;
        Tue, 24 Jan 2023 03:31:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF726B8117D;
        Tue, 24 Jan 2023 11:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8419BC433EF;
        Tue, 24 Jan 2023 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674559881;
        bh=vSvpFgPqXmxl07qKO0PotIG3YQSs9V4kcX2WYtv6Y00=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MMe07pLbu1gmDqdbs7WNdKnwqs+02+j539LNGY1cbZMWSb+LgaN+KtJUxKap9GrfZ
         Hfhq+ygaBNKzJtysre7CBNnQlIR0Am8ltX6plLvaXdquNMgugVHz57WxEz2rNQ/fLz
         BZIsFBfSWiYZADWRI7ik7KAtacsW3AzCP9theWeLzf4veQK/glOgUD9GJIjUxoCCW6
         tC31q7RHPnyE8UPD7z5eIvTBISBkftsQgI2XvEJihbHkDyLk6OPcKaGgyBxqmM6ocJ
         IqwjQz7zIvo0gms9KkDdTo0rv/FXFiTdDCIBDkBg1GE+6h+u6Rx4dNMyyuKWA+Ws3h
         hZaRP1nfl9ayQ==
Message-ID: <c850df25-57b8-3172-8e5c-c466dc8556cd@kernel.org>
Date:   Tue, 24 Jan 2023 12:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v1 2/4] Revert "dt-bindings: mmc: Add bindings for Intel
 Thunder Bay SoC"
Content-Language: en-US
To:     rashmi.a@intel.com, ulf.hansson@linaro.org,
        michal.simek@xilinx.com, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, vkoul@kernel.org, andriy.shevchenko@linux.intel.com,
        linux-phy@lists.infradead.org, mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com
References: <20230124054427.28808-1-rashmi.a@intel.com>
 <20230124054427.28808-2-rashmi.a@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230124054427.28808-2-rashmi.a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 06:44, rashmi.a@intel.com wrote:
> From: "A, Rashmi" <rashmi.a@intel.com>
> 
> This reverts commit ab991c05c42853f0b6110022db9bf30fcc6323dd.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Revert Thunder Bay specific code as the product got cancelled
> and there are no end customers.
> 
> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>wq

Stray characters.

> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
>  1 file changed, 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 4053de758db6..0d5d21dd30bb 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -88,12 +88,6 @@ properties:
>          description:
>            For this device it is strongly suggested to include
>            arasan,soc-ctl-syscon.
> -      - items:
> -          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
> -          - const: arasan,sdhci-5.1

Instead should be made rather deprecated, unless you are sure there is
no single person in the world using the bindings (e.g. with BSD or
bootloader)?



Best regards,
Krzysztof

