Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C736D449C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjDCMnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbjDCMnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:43:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF0B9767;
        Mon,  3 Apr 2023 05:43:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 107476603105;
        Mon,  3 Apr 2023 13:43:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680525820;
        bh=pfKKC24shtvA/rXAR9B/Z1hLIkyt7OJi4x4sgnOzJ4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E+aRNVEux5sMeLcJ+vqHmQ5aDu98LjC4Bo2QRef0rixMvao06HXBb+qFWc+tSis7K
         Liy8m21xm8aQetY1koAG4OJFoStg9e/TQCy4NSEN7UqfGpjxNcebUI2Di5pdEQSIWE
         82falL+mlPGFsCKcrEPSEqiDARZ33Ks0IFi8YixFnxRaN9P7jLwBgPpcGAyM04KAcy
         Of85MiIOq4BkW/IqSim9YFPMf0vJTJB8/r+4nIvR7WzYs6GoTZMxYQ3XnhfKAvu/RB
         RBIZQt3gXzvDoQ3XAOZESH5at6jdwGmx0B6jflGyeTfaYKdJqZ+U9w2HsxzqPv3ncm
         DsrKSa9YYwyOg==
Message-ID: <601a8435-8e2a-2c25-5fe3-40be62269469@collabora.com>
Date:   Mon, 3 Apr 2023 14:43:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC] arm64: dts: use size of reserved partition for bl2
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230403105818.29624-1-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403105818.29624-1-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 12:58, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> To store uncompressed bl2 more space is required than partition is
> actually defined.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

If this doesn't get changed anymore, I'm fine with it... but a question arises:
did you send patches to add your BPI-r3 board(s) to upstream u-boot?


> ---
> I used the definition i got from mtk used in their SDK uboot.
> 
> Openwrt uses also the first reserved partition to give bl2 more
> space:
> 
> https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/dts/mt7986a-bananapi-bpi-r3-nor.dts;h=f597b869abc80d1a73f44ebb85ad4da17376bb52;hb=HEAD#l22
> 
> so imho it should be same in mainline to not require complex bl2
> compression.

Regards,
Angelo

