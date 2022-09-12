Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679AF5B5673
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiILIja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 04:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiILIj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 04:39:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 148906554;
        Mon, 12 Sep 2022 01:39:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39B131756;
        Mon, 12 Sep 2022 01:39:31 -0700 (PDT)
Received: from [10.57.49.22] (unknown [10.57.49.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 338C63F73D;
        Mon, 12 Sep 2022 01:39:23 -0700 (PDT)
Message-ID: <8dc7b4ca-8900-8e7e-01a1-118d0d050271@arm.com>
Date:   Mon, 12 Sep 2022 09:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 05/13] dt-bindings: arm: update
 arm,coresight-cpu-debug.yaml reference
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        corbet@lwn.net
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1660829433.git.mchehab@kernel.org>
 <20815dbff3d27f5d3e6876363f052d2a08ad2e72.1660829433.git.mchehab@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20815dbff3d27f5d3e6876363f052d2a08ad2e72.1660829433.git.mchehab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2022 14:38, Mauro Carvalho Chehab wrote:
> Changeset 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
> renamed: Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
> to: Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 66d052047ca8 ("dt-bindings: arm: Convert CoreSight CPU debug to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
> 
> See [PATCH 00/13] at: https://lore.kernel.org/all/cover.1660829433.git.mchehab@kernel.org/
> 
>   Documentation/trace/coresight/coresight-cpu-debug.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/coresight/coresight-cpu-debug.rst b/Documentation/trace/coresight/coresight-cpu-debug.rst
> index 993dd294b81b..79bbe587e5e8 100644
> --- a/Documentation/trace/coresight/coresight-cpu-debug.rst
> +++ b/Documentation/trace/coresight/coresight-cpu-debug.rst
> @@ -117,7 +117,7 @@ divide into below cases:
>   Device Tree Bindings
>   --------------------
>   
> -See Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt for details.
> +See Documentation/devicetree/bindings/arm/arm,coresight-cpu-debug.yaml for details.
>   
>   
>   How to use the module

