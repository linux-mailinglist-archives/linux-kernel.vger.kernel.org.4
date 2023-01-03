Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6E465C039
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbjACMtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237663AbjACMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CB62CD;
        Tue,  3 Jan 2023 04:49:45 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 818F46602CF2;
        Tue,  3 Jan 2023 12:49:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672750184;
        bh=cKufuK/SQXHZY7UgYbfqx1IwLxjbfTYMLGfuy2CKsPk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g1wjpLxsUYLZKEK5ecAlCc3elaIDzpmV+nLcVd07pHpAYAfnZlhe8SUo2D2UaR83d
         NtmsO5j7vNMmKkIjCSkZh+TezHoCcnLWhHfOvznadmV/z48Rij2qZJMBF9vPDiIxVD
         qEcjDFIY2cADv+nB87VCZPmr6uxjnJOasVOH+eb8sW8u8zZUI6+JSGm8fjl4RPIEc5
         BMvG4P8FbSZ6SygIYensx1boE4t8hN1oMHZGiTCeg5UBYhSorkH5DhqQlIxCsxIcsD
         VHzXkmJ0udW1GvVW0k1wHMa7b6BHs9HfpbM1lpuTew+1BR7waj2XF+AQSc6YGAvqVR
         JtbNj6S9EgJgw==
Message-ID: <3ebb927b-d662-506f-2531-62abd851c0b3@collabora.com>
Date:   Tue, 3 Jan 2023 13:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 12/13] soc: mediatek: mtk-svs: Use
 pm_runtime_resume_and_get() in svs_init01()
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Shang XiaoJing <shangxiaojing@huawei.com>
References: <20221226094248.4506-1-roger.lu@mediatek.com>
 <20221226094248.4506-13-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221226094248.4506-13-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/12/22 10:42, Roger Lu ha scritto:
> From: Shang XiaoJing <shangxiaojing@huawei.com>
> 
> svs_init01() calls pm_runtime_get_sync() and added fail path as
> svs_init01_finish to put usage_counter. However, pm_runtime_get_sync()
> will increment usage_counter even it failed. Fix it by replacing it with
> pm_runtime_resume_and_get() to keep usage counter balanced.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


