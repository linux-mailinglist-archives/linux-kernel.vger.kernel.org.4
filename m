Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812766F62F7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 04:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjEDCeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 22:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 22:34:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C7E42;
        Wed,  3 May 2023 19:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57F2062C85;
        Thu,  4 May 2023 02:34:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376E8C433D2;
        Thu,  4 May 2023 02:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683167644;
        bh=Bq0qnaWKFfa058rltCY8ZwbyskEb1BVnd2ovTPtppKY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hrjrxztsHVK+9R5BHIPCd11fGLWMeTwkVKGXp3x4o6EATGVytZUcNQiK00Ri+BiNr
         ucyEcJKKiqo8iVUKceVaoUv8dm+qyOVGjsRvoMOsOewCyK5Q3fGVtuzeERhAaxtPR7
         yK0GSxePrv6TfmB5l7m6mkZB/GcgeCz71RuumhmU4itTpmZsfL7Lc36RUtQ8grnk02
         SJELQtQAMrGyqCQddtR9GVO2LGak78JGeT+nHBZVIHVjxUiAYW7t4Dh19p4GvABmJ6
         bnWFjPH+JLvL88a4lSICUcpjuHl+OOCxio3OEZyLgwNY8WpPU49gZsdxOgpo2ixNOL
         jL5rb1lgaWp0w==
Message-ID: <37c651c7-1f7d-fb2c-12d8-646ba3e63247@kernel.org>
Date:   Thu, 4 May 2023 11:34:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] dt-bindings: ata: ahci-ceva: Cover all 4 iommus entries
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <76a2bbd9fb944dbefdb8d429d0a85937d56a3d6f.1683035327.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 22:48, Michal Simek wrote:
> Current only one entry is enabled but IP itself is using 4 different IDs
> which are already listed in zynqmp.dtsi.
> 
> sata: ahci@fd0c0000 {
> 	compatible = "ceva,ahci-1v84";
> 	...
> 	iommus = <&smmu 0x4c0>, <&smmu 0x4c1>,
> 		 <&smmu 0x4c2>, <&smmu 0x4c3>;
> };
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> index 9b31f864e071..71364c6081ff 100644
> --- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> +++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
> @@ -32,7 +32,7 @@ properties:
>      maxItems: 1
>  
>    iommus:
> -    maxItems: 1
> +    maxItems: 4
>  
>    power-domains:
>      maxItems: 1

Is this a bug fix ? If yes, what about adding Fixes & Cc: stable tags ?
