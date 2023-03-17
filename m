Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE94D6BE88E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 12:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjCQLuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 07:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjCQLt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 07:49:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D1C54C96
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 04:49:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D8B8B82433
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 11:49:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530A3C433EF;
        Fri, 17 Mar 2023 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679053788;
        bh=AF71asxE7X13lcCyaqDpizk2SwpjJ/tXOc4hfN2y0/M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fytkpfzfopmuZJZEf+6m4NozJGkkCFVNe+9PaF2NIg0n+JgMhoPN4ndCF/LmSqu5J
         M4OD3k6RNxbE4Hbjl9shSkUhCGmpjMELb1XPgHIgXLdipsTKihF0sKHoblvh/QyRZi
         l2Q+YIZqjUAfx2M2GJoeEQQ/S9yDeeYNb7457fkxlZkvLYR/+oIYDWQjn7nF1fEqdv
         /J0QKiXdVQNBRdG1F86oesCX6ELU12EyuVpiQhiW/a3YwajkPCM2sDw+oqbJTNssJL
         gPZUgMRmOcG2uANehy56VfaDHgU3ti6zHzBsjN6JQUBdzGvuML5eypmsEEAfmVg9xH
         chqQLQR67gRwA==
Message-ID: <ae7c1d45-8e19-dc96-6769-c0b37791132d@kernel.org>
Date:   Fri, 17 Mar 2023 12:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] bindings: regulator: pca9450: Add LOADSW regulator
To:     Nicolas Heemeryck <nicolas.heemeryck@devialet.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20230317093911.1254530-1-nicolas.heemeryck@devialet.com>
 <20230317093911.1254530-3-nicolas.heemeryck@devialet.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230317093911.1254530-3-nicolas.heemeryck@devialet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 10:39, Nicolas Heemeryck wrote:
> Add the binding documentation for the load switch regulator.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed important mailing lists as well, thus patch won't be tested.
That's a NAK. :(

> 
> Signed-off-by: Nicolas Heemeryck <nicolas.heemeryck@devialet.com>
> ---
>  .../bindings/regulator/nxp,pca9450-regulator.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> index 835b53302db8..064d57256aff 100644
> --- a/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/nxp,pca9450-regulator.yaml
> @@ -20,6 +20,7 @@ description: |
>  #The valid names for PCA9450 regulator nodes are:
>  #BUCK1, BUCK2, BUCK3, BUCK4, BUCK5, BUCK6,
>  #LDO1, LDO2, LDO3, LDO4, LDO5
> +#LOADSW
>  #Note: Buck3 removed on PCA9450B and connect with Buck1 on PCA9450C.
>  
>  properties:
> @@ -74,6 +75,14 @@ properties:
>  
>          unevaluatedProperties: false
>  
> +        "LOADSW":

Does not look like pattern... unless you want something-LOADSW, but then
why?



Best regards,
Krzysztof

