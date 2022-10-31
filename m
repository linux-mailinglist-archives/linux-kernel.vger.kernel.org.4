Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DE76137DA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiJaNYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJaNYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:24:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB087DC1;
        Mon, 31 Oct 2022 06:24:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFBB1660037C;
        Mon, 31 Oct 2022 13:24:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667222643;
        bh=FGCLVcrbsRRA9pknCacs9VnpBtBKl7pLRAKqrBSRr9I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VQeYkjVlii3B1a7OfsypnxmQLryaiTnyX2bIFMlhgfMG7ms4ZCmCZLGCfvkHguPYa
         L+Py0JN9WYyg0EzcqRZ/4weiwwZxnof1vw9nGPhDTixpWcFFlOywWDoHLdfuRjcmZP
         GVyKvrNFmmKzap3zIKqlYSDS4u+kkfjkjyQA4/WlJmzt8CE8PFZW26nJmis4H1TOds
         MFlS0k2yVY5gOZypEqJblnePzSy9rQ9O5HuDYKDn69yCVO+WATdfiBO1PW19htAKjO
         qetFnHp/ff4z1gU5ffmwmdE5gKkMMzM4veefna6cLiKTaSABv5Ac0spBuBue5+WYlT
         7pEjkMxfolH6w==
Message-ID: <81072604-3c56-54e8-2f4f-ee52ba73eeae@collabora.com>
Date:   Mon, 31 Oct 2022 14:24:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 2/3] arm64: dts: mt8195: Add pcie and pcie phy nodes
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221028094317.29270-1-tinghan.shen@mediatek.com>
 <20221028094317.29270-3-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221028094317.29270-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/10/22 11:43, Tinghan Shen ha scritto:
> Add pcie and pcie phy nodes for mt8195.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


