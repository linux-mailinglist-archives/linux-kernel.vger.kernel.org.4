Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C547062F2B2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbiKRKgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiKRKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:36:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B855A93CC8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:36:31 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0BD026601639;
        Fri, 18 Nov 2022 10:36:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668767790;
        bh=+FQixfeJw7S8UNiAgxgWfk4PwAnxtieDJTIkSPIUbLw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HPVfzg+1wkbMj+lOFSZEUmE7i5MMBAAt8zXMGnq7T4nTRkejRN3FOmSoM3Lj8358Q
         z/GVUw50rXH3TfONlaxgbkxhx5VbkpJAsB5XC0O/RyIH/pzosCqkTNQpZQkLi+tjfF
         bb/CmCJNVcaDnRS7+U4JTN+HM8oR4yrrtY13cM0bRbrD1oZ+3O1a+cCKdi4CX7TYIK
         3n/kdhfNe5O3Z6F3prETg2kflLeLRC4nwv1kKsv8zyXKV+htYctM+16KhYFr8XYokG
         Qi5t7hWAw+k+wkQ2jAZhuIt5Gjz5dqFoP3sKCClDKn43tPjjg6ymMIfQQxQIW41yoO
         V4F6Lm0LigdMw==
Message-ID: <90c7e6f3-ecf6-bb90-5a9a-3fa1eb4b9d5d@collabora.com>
Date:   Fri, 18 Nov 2022 11:36:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v1] mtk-mmsys: Change mtk-mmsys & mtk-mutex to modules
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221118063018.13520-1-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221118063018.13520-1-yongqiang.niu@mediatek.com>
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

Il 18/11/22 07:30, Yongqiang Niu ha scritto:
> Change mtk-mmsys & mtk-mutex to modules for gki
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


