Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03606BE564
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCQJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjCQJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:20:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDFA61B6;
        Fri, 17 Mar 2023 02:20:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A2E1B660309F;
        Fri, 17 Mar 2023 09:20:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679044813;
        bh=qN3K0KSRIMQUiSrpkYSzcME03jxUWUJUqnODTeKfW1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nu/UW1M193uEvtJO0hJ/riNAZ1gjo3Gua7wTxaxHzTvro0CvquJLLVgWZMmzg85hI
         IF4zE6GcRDZnMTc4yv1NAYYCw60tIdA7YGWtbbwSxGKF/o5Te5BPTGb4Bt1jA7ra9G
         7F41iEGgvvvWrXvoeOpT5sktcG2Q5SANuC9FsditVA8kcINHdQJ2SZobSfIDux60Qv
         D2lTIjFlPjwE9LLLqb0OdbWRvk91c06Lz/kM47mh3a1sXyDQXiK1JdZP8DkLhp4TO/
         6oKK6q68hvKORvgi8wc1nb0BBlY4+IS0AGTz+8OYiQib0JNfAU6Q0JyzL/oq+uA1h8
         zCCMzZIywJm1A==
Message-ID: <5f109541-ecde-bcb4-ae55-93444d800899@collabora.com>
Date:   Fri, 17 Mar 2023 10:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230317061944.15434-1-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230317061944.15434-1-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/03/23 07:19, Allen-KH Cheng ha scritto:
> Add the cpufreq nodes for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

On Asurada-Spherion Chromebook:
Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

