Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2056427E9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 12:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiLEL6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 06:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiLEL63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 06:58:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D3EDFB3;
        Mon,  5 Dec 2022 03:58:29 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C3CC660037C;
        Mon,  5 Dec 2022 11:58:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670241507;
        bh=iFlO31DNzJvNqG9JtnHjVtb1y6O92a+FI3D/2tE9y3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M47wkQX/t+5tOCDoiejCPLRXBIPFZ5c9kjtTBRJW6pDPDaimp/c9C8l54j4FmfgHl
         Je5rh5jGD1i/q5/pNpe+M1nn9k17eX4ZkUWOUGTujcNthhqsbBdoylsTDzRr2C5q8A
         ej9jmwe4UhM6nE3cW7GzyJre6wr7anF8WUCv1+xLHjOqce2RPh7sjbGANWQQT7OiJq
         2yJe7aQN0eMNuaK3TAywORy+LoShkXbw3N2I74a//E14Bs6gyqlyI15jKyetttYNWI
         c/sNJY4/1Z7qbo2FMv/ZoZvicLOTspxPuxFGkH4c/K29d65QYDh2labymMcqmI584U
         5N/pCAUGLksjQ==
Message-ID: <5c5d7bce-b0bf-d1ae-1044-3c3ff20c82d6@collabora.com>
Date:   Mon, 5 Dec 2022 12:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] media: platform: mtk-mdp3: Fix return value check in
 mdp_probe()
Content-Language: en-US
To:     Qiheng Lin <linqiheng@huawei.com>, mchehab@kernel.org,
        matthias.bgg@gmail.com
Cc:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221202101836.19858-1-linqiheng@huawei.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221202101836.19858-1-linqiheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/22 11:18, Qiheng Lin ha scritto:
> In case of error, the function mtk_mutex_get()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
> And also fix the err_free_mutex case.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Qiheng Lin <linqiheng@huawei.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

