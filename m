Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C1F6072CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJUIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiJUIrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:47:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA4D1B5749;
        Fri, 21 Oct 2022 01:47:28 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 261DF6602253;
        Fri, 21 Oct 2022 09:47:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666342047;
        bh=3eiZ7szUM3OGxgQJ5CQfnDH0rk8YT6swITKmzLR52I0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mYvD6b4iGePjjlYqWTUkjv03Z2uF4Z06HMzaQSws37T6h4GfMD7/RC4cZHOQpCCQ/
         gDOmvcEdZlcDTL5Kkzn5wJf0h6g9Yyien7kiONzKR+T/Vj2/HXWQsT5sIgZNs9Y6N5
         sjzzJTZ5V5Bgqpqn8TuMDVyhU+exACNyS+H98skwKVTV65XhLKYFhxgJA4WRFlegP0
         PqT9UwHu8IuKkZKPHtAI6qsGoLJdHT8bxWt7caV5MUR3QQfkUC6gwWk1idweWTbKVj
         leq32C5jEGq8sxU6Q8Xn+rwoVpHlpK53QtoHdAOh4YeJZtFdXUJHIdj9LucWVU9md8
         LllCcCo8U8ZLg==
Message-ID: <bc4dacea-b4a8-89f5-a9cb-c698b439cc53@collabora.com>
Date:   Fri, 21 Oct 2022 10:47:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 3/3] media: platform: mtk-mdp3: fix error handling in
 mdp_probe()
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221020071800.20487-1-moudy.ho@mediatek.com>
 <20221020071800.20487-4-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221020071800.20487-4-moudy.ho@mediatek.com>
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

Il 20/10/22 09:18, Moudy Ho ha scritto:
> Adjust label "err_return" order to avoid double freeing, and
> add two labels for easy traceability.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


