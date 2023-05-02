Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F422D6F4411
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEBMrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjEBMrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:47:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0545FCE;
        Tue,  2 May 2023 05:46:57 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 57A6F6602121;
        Tue,  2 May 2023 13:46:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683031616;
        bh=NaKJyyPWlHN9Ghox5nlaOW5ko2zxa/A4ZsnzrN3xZyM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lDD+DhBxRnivcBILM1CnoJkcAAyxRI5um7/wJsE+DYEizYRyWXO1XGQWXqxCnQbhr
         347qrJFWA+WvKPc3o4f9aDjf7iFKJlWYneIR24poZX8CVSAe6FirpsKTFLACtb7p8s
         wii4MMzGOnFF0yzJCHk6kw9WPnkmE0X2xlIib50UbF7u41wm72+hkD1kOazU2ONwVs
         4lwRZIZZIM1IJJ+t9aXAVmPqQ2h12kdoVU9026YSNNatth/+VEYb/AVeQQolpa6zbp
         div6AN51e14EovwgIFpZFM/gvExNcvN5eM6Rir/mmVclwSt7OCOlWbJZDN1wsiRu5j
         a0sI1iV0yQUMw==
Message-ID: <9c8ca0e7-819a-ac6a-04be-c2dba1f61952@collabora.com>
Date:   Tue, 2 May 2023 15:46:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/8] dt-bindings: nvmem: rockchip-otp: Add compatible for
 RK3588
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <20230501084401.765169-3-cristian.ciocaltea@collabora.com>
 <5471965.k3LOHGUjKi@diego>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <5471965.k3LOHGUjKi@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Heiko,

On 5/2/23 11:42, Heiko Stübner wrote:
> Hi,
> 
> Am Montag, 1. Mai 2023, 10:43:54 CEST schrieb Cristian Ciocaltea:
>> Document the OTP memory found on Rockchip RK3588 SoC.
> 
> nit: I guess the changed clock and resets configuration for rk3588 variants
> could be mentioned in the commit message.

Sure, I will update the commit message if a new revision of the patch
series is required.

> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for reviewing!

Regards,
Cristian
