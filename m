Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07AC74636F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGCTkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjGCTkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:40:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AA19194;
        Mon,  3 Jul 2023 12:40:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DB612F4;
        Mon,  3 Jul 2023 12:41:32 -0700 (PDT)
Received: from [10.57.38.117] (unknown [10.57.38.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB8143F73F;
        Mon,  3 Jul 2023 12:40:47 -0700 (PDT)
Message-ID: <0aa7227d-264f-a87d-bef1-9f5d1c43a184@arm.com>
Date:   Mon, 3 Jul 2023 20:40:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: pmu: Add Cortex-A520, Cortex-A715,
 and Cortex-A720
Content-Language: en-GB
To:     Rob Herring <robh@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230630185602.2175559-1-robh@kernel.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230630185602.2175559-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-30 19:56, Rob Herring wrote:
> Add compatible strings for the Arm Cortex-A520, Cortex-A715, and
> Cortex-A720 CPU PMUs.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/arm/pmu.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/pmu.yaml b/Documentation/devicetree/bindings/arm/pmu.yaml
> index e14358bf0b9c..0cc468d6c372 100644
> --- a/Documentation/devicetree/bindings/arm/pmu.yaml
> +++ b/Documentation/devicetree/bindings/arm/pmu.yaml
> @@ -49,7 +49,10 @@ properties:
>             - arm,cortex-a77-pmu
>             - arm,cortex-a78-pmu
>             - arm,cortex-a510-pmu
> +          - arm,cortex-a520-pmu
>             - arm,cortex-a710-pmu
> +          - arm,cortex-a715-pmu
> +          - arm,cortex-a720-pmu
>             - arm,cortex-x1-pmu
>             - arm,cortex-x2-pmu

Should we catch up on Cortex-X (3 and 4 now) while we're at it?

Cheers,
Robin.

>             - arm,neoverse-e1-pmu
