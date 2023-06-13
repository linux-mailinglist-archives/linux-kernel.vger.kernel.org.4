Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC5272DCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbjFMItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbjFMItY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:49:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38475C0;
        Tue, 13 Jun 2023 01:49:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C985B62B6F;
        Tue, 13 Jun 2023 08:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1677C433D2;
        Tue, 13 Jun 2023 08:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686646160;
        bh=13QxIeZfhU5GLFvayprb0+agNd+CZDWoGxFWOWD3MhM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ZNOh2FB1/xMCR9XW9z3iU/U+scSh5i+/NQHd/VfoS2b4vP9bEuKOPbNpGjW3QE3UQ
         QtOo67gei1ki9H6yJ94Z7MdlZ4pyOwSL/+xkAJ1VM2kQqmWIwP8HE3LBAglu9+a+3l
         JE5+q5ZA7J/Yesfi1oBZCT/h9BlH/pwjSI9c42gtIDrbyxq/Sr36kkRqOT4e2lAanC
         e5OtFco8ih63s64epRhj6/Cf57d2BvXQD4ELyJ+zn7PJpk0xf8PJ9Qkm/PvhtjBDYP
         08X5c5thabZbROWDQATmBsCoCuU9Cyh+u7Wo7aUWVXVK+s2N1DVDTcRG2WkjtaWukF
         vN7a5K7fw5hTQ==
Message-ID: <7bf1395a-eba8-fe27-a359-9c50af7add2a@kernel.org>
Date:   Tue, 13 Jun 2023 10:49:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 6/7] ASoC: dt-bindings: mediatek,mt79xx-wm8960: add
 mt79xx-wm8960 document
Content-Language: en-US
To:     Maso Hunag <maso.huang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-7-maso.huang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230612105250.15441-7-maso.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 12:52, Maso Hunag wrote:
> From: Maso Huang <maso.huang@mediatek.com>
> 
> Add document for mt79xx board with wm8960.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
> ---
>  .../sound/mediatek,mt79xx-wm8960.yaml         | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
> new file mode 100644
> index 000000000000..26b38bb629da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt79xx-wm8960.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mediatek,mt79xx-wm8960.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT79xx ASOC sound card with WM8960 codec

What is a MT79xx ASOC? Is it some specific SoC name? What does "A"
stands for in SoC? XX also looks odd, I thought Mediatek uses only numbers.

> +
> +maintainers:
> +  - Maso Huang <maso.huang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt79xx-wm8960-machine
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT79xx ASoC platform.

What is MT79xx ASoC platform?



Best regards,
Krzysztof

