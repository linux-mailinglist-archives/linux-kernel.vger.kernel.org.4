Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD85F2F46
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJCLGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJCLGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:06:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF6D402DB;
        Mon,  3 Oct 2022 04:06:38 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.55.162])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D625A6602297;
        Mon,  3 Oct 2022 12:06:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664795196;
        bh=Uknm/eeST+46BULBKRwl+r3IUY1mmXz/O75r7yudO1U=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=Ibf1wkp4l50qt4baeVbevrRUQA+SgpW1cAWfkZ3LYSmX/0ty4YUJnTAmeKyj15/sM
         1IRcw3fnLRUvQP0Sj0JBgsCBcp7iSw6nOhPeW3YX+ga9m+Cq9Vncm9uxNHc4BMijeA
         v53vUpmOTfYvR2pL5Ea01djCexkb/9vXMIrzIbwvrJtnMgSbsAfYbZJb8LqDIGw90k
         JKt/eQ+hUgsWOz7C1FOYPBmCVnTqSLU5IU1vN4y87bSEuHyxj9cQfauwh9nD7Ube3Q
         ABmQOUZY/qa/hrrbUACC9oQ9lQectosZDOj7eWon9o+ZdBMhrszxKev77az4Owm9d9
         jW/77hBj9pv2Q==
Message-ID: <c5169131-486e-9808-ba48-b7abe1be6a99@collabora.com>
Date:   Mon, 3 Oct 2022 14:06:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v3 0/3] Enable initial support for StarFive VisionFive V1
 SBC
Content-Language: en-US
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Drew Fustini <drew@beagleboard.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220908142914.359777-1-cristian.ciocaltea@collabora.com>
In-Reply-To: <20220908142914.359777-1-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please let me know if there is anything else missing in order to get 
this queued for merging.

Thanks,
Cristian

On 9/8/22 17:29, Cristian Ciocaltea wrote:
> The StarFive VisionFive V1 SBC [1] is similar with the already supported
> BeagleV Starlight Beta board, both being based on the StarFive JH7100 SoC.
> 
> In addition to documenting the necessary compatibles, this patch series
> moves most of the content from jh7100-beaglev-starlight.dts to a new file
> jh7100-common.dtsi, to be shared between the two boards.
> 
> No other changes are required in order to successfully boot the board.
> 
> [1] https://github.com/starfive-tech/VisionFive
> 
> Changes in v3:
>   - Added Reviewed-by tag from Krzysztof in patch 1/3
>   - Optimized patch 2/3 by enabling copy detection on "git format-patch",
>     as indicated by Krzysztof
> 
> Changes in v2:
>   - Simplified documentation by using 'enum' instead of 'const' in
>     patch 1/3, according to Conor's review
>   - Added Reviewed-by tags from Conor
> 
> Cristian Ciocaltea (3):
>    dt-bindings: riscv: starfive: Add StarFive VisionFive V1 board
>    riscv: dts: starfive: Add common DT for JH7100 based boards
>    riscv: dts: starfive: Add StarFive VisionFive V1 device tree
> 
>   .../devicetree/bindings/riscv/starfive.yaml   |   4 +-
>   arch/riscv/boot/dts/starfive/Makefile         |   2 +-
>   .../dts/starfive/jh7100-beaglev-starlight.dts | 153 +-----------------
>   ...aglev-starlight.dts => jh7100-common.dtsi} |   3 -
>   .../jh7100-starfive-visionfive-v1.dts         |  20 +++
>   5 files changed, 25 insertions(+), 157 deletions(-)
>   copy arch/riscv/boot/dts/starfive/{jh7100-beaglev-starlight.dts => jh7100-common.dtsi} (96%)
>   create mode 100644 arch/riscv/boot/dts/starfive/jh7100-starfive-visionfive-v1.dts
> 
