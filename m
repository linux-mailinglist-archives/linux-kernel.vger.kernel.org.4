Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE056702077
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjENWax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 18:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjENWat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 18:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ADC10EF;
        Sun, 14 May 2023 15:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0036A616F6;
        Sun, 14 May 2023 22:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFA8C433EF;
        Sun, 14 May 2023 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684103447;
        bh=0Zu+Moxt89SvEkQoekYiB8XJzcCpCjsAEr25gRJ6iX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d7cVgU+Zm+MPP/qJJqUxj2ah0X9nEA/O7JzKezKZwUHapJ7djlAtVPXfdI4Z2Gq2g
         MPUfcda646V20B+6kGBjxTu6DXqratvXg10/MK9gz0E83VBIKgRvCe6R+rfXDUm5yL
         1sfQrndSoHzRvZVhbLqF5i/kr7Ya/N8PFzZR5TX/gHZ7+39UwiWtzSeE92Zc+iVLQP
         w38VQyGP36IxApZyzFfdYXCxrxpgv2iBqMG594hYjH9Wy7shfd2wl5dP75xZoQ+Fxt
         sRkauTqAo+hu61M7j7c2oyBi4TZggqNpK/q4LHEzWmnA6Q2s0rfaQ7a8h7w6TvOcFX
         M6wrnXR3Ns3DQ==
Message-ID: <920892df-9429-d185-d037-d8f22574d91f@kernel.org>
Date:   Mon, 15 May 2023 07:30:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] dt-bindings: ata: ahci-ceva: Cover all 4 iommus
 entries
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-ide@vger.kernel.org
References: <de594534321417d25d2434db334db075524f61e0.1683892320.git.michal.simek@amd.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <de594534321417d25d2434db334db075524f61e0.1683892320.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/12/23 20:52, Michal Simek wrote:
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
> Fixes: 8ac47837f0e0 ("arm64: dts: zynqmp: Add missing iommu IDs")
> Cc: stable@vger.kernel.org # v5.12+
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to for-6.4-fixes. Thanks !


