Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3E692062
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjBJOBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjBJOBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:01:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E637498B;
        Fri, 10 Feb 2023 06:01:07 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA70466020EA;
        Fri, 10 Feb 2023 14:01:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676037666;
        bh=1nACN3toSy0bL2coCaCf797kOjg0fbtFmGw0pIIjUec=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XwIoN4XWr/LgYYvHELLcVicMRL6rH8ofiB8rPR7eIYxCvOrPnNzn0fc8GHQyEEwyP
         75+9/rJn+tAKcrzp35XgjSrOFrpWZL1WYpT7uVPXrAxdoxdUdd4EDAP0GjqqRZZg08
         wzfj2uRj9xTzG0WE5o7xLGXQaNFASLbbXDGYJTPFycTphEp19K66Lwx4ZBYzQoBVZk
         oiCrpHILMLA1I0Ngn6B4BgHzHCEooJMXfrFAWbTRjWStUHF4PpjhTkEWYftN075E0T
         ZTNLRyQMmeHOxvE/slcsIeQ/ZQhP1YqEZihnWC0IULBNyBHuPbdw67rPkC+bxHMYGd
         iM7ym8W8sp3sw==
Message-ID: <2318282b-c61d-3f86-2053-ee20c7f13e7f@collabora.com>
Date:   Fri, 10 Feb 2023 15:01:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 10/12] remoteproc: mediatek: Handle MT8195 SCP core 1
 watchdog timeout
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230210085931.8941-1-tinghan.shen@mediatek.com>
 <20230210085931.8941-11-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230210085931.8941-11-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/23 09:59, Tinghan Shen ha scritto:
> The MT8195 SCP core 1 watchdog timeout needs to be handled in the
> SCP core 0 IRQ handler because the MT8195 SCP core 1 watchdog timeout
> IRQ is wired on the same IRQ entry for core 0 watchdog timeout.
> MT8195 SCP has a watchdog status register to identify the watchdog
> timeout source when IRQ triggered.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


