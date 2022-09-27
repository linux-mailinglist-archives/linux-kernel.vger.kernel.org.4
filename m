Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F0C5EC083
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiI0LGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiI0LF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:05:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C8EDF91;
        Tue, 27 Sep 2022 04:04:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5D496601F41;
        Tue, 27 Sep 2022 12:04:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664276669;
        bh=MGGRSFV4QKZ64S297uy7PnxQS7sY2jyybyoCgu9gy38=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J95bXywUFI/OUUcoPV975N4k06sRbpqvUJRyFV0TEx/GPmwwlvTcKmu+xtjWC+2bE
         wAA04Ysw7x4/Ac5gewLwtJHBjxv3lxPHXSZ+85bP+qLuTp64JNyTQQaQyE7KIgSUIt
         rIQ0qAMuKDsGaopQvE5OtM6h8D4GdDhuuH0G2Jq/wlcnXKEKeNUlfyaSA+THYy3uK4
         YIbExeus54XILWgapy1lmkrMXj+APPKTtJz+YH9fQ8x2k2yDHYjbEdT/W+e0LLVa90
         nLNeYJb6TMOMZbE19M2D3x8OxQfhE3PsMZJCWIc04LE1oilZFEv/q5ekQGR3NhuzhC
         n/NGrgBp2+o/g==
Message-ID: <cb7ca8a8-14b4-0929-fd05-d37c47285176@collabora.com>
Date:   Tue, 27 Sep 2022 13:04:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 05/11] remoteproc: mediatek: Add SCP core 1 register
 definitions
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <20220927025606.26673-1-tinghan.shen@mediatek.com>
 <20220927025606.26673-6-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220927025606.26673-6-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/09/22 04:56, Tinghan Shen ha scritto:
> Add MT8195 SCP core 1 related register definitions.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


