Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128C692071
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjBJOFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJOFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:05:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90433656AE;
        Fri, 10 Feb 2023 06:05:22 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 386D366020EA;
        Fri, 10 Feb 2023 14:05:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676037920;
        bh=cqDAyS7WEw+aJC1vtNbHL4JA5/YlZyKWTf2H2EDwQN8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k/JskO7+JOYOaDHViewiF5wyfP0mi7qPHKxV2/qqOkDHzaOuXUZ39HjNy/euqcyqz
         mi9wnN7XAhafBsxnXAc+8AST7EA4vT8NtSboeWDwCLruVtp3Ezr8k/oSqikhkmfL/F
         XpGejhiWfnUoB+kD5hxgA7yx6QHAEjnWbahqyplZE0RhTBCYdJosBGpfe/Qfi4jW9D
         ndZNz24aCagf/8rPjaFB0nV9yTNeiHUcL05r+KG5w+3rN2Y3Bm1wk36C2m5jvWu/yD
         R+FDqYpAGsgMWSvq4IxfmOSgdLx3f/ENdYS8i3S9jpogQa0jkAtEn98X557tTLWbKp
         4FFMmdQW1K93Q==
Message-ID: <270c795f-e8c0-7458-edb9-ca407a3bc275@collabora.com>
Date:   Fri, 10 Feb 2023 15:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v5 03/12] dt-bindings: remoteproc: mediatek: Support
 MT8195 dual-core SCP
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
 <20230210085931.8941-4-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230210085931.8941-4-tinghan.shen@mediatek.com>
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
> Extend the SCP binding to describe the MT8195 dual-core SCP.
> 
> Under different applications, the MT8195 SCP can be used as single-core
> or dual-core. This change keeps the single-core definition and
> adds new definitions for dual-core use case.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


