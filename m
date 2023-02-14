Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC687696067
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjBNKLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBNKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:11:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD31710;
        Tue, 14 Feb 2023 02:10:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B5289660216A;
        Tue, 14 Feb 2023 10:10:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676369457;
        bh=Nz84FU88SiQNcVV2Xf8ERsDCZvoj6BMjNkoLM7HSosA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UBhAcz9eTI6cj2F7o6lSc4x0J9OIlfSr17kGw6C414a3os9jwmS/5th+5VNALUB+l
         +EjXQ9vcy88KDwkniChABlIBIdZYt5yjnCaXXGicdbKhXJH969hylK0Bah9oIjvw4G
         VIz14OnxnSzuoyV2he3Ugrt/D1KNTxFVFXL6LcTy0E3s9hAlvLvyqfGswYpDFAzrlQ
         N2o5pm14kwddOJZFil2POcgrfzinQxGyEc92PS26OXNuMN0XlcQm/uJVN8+t2hf1wI
         SQUU1///k0TXL9YNHb2TU3NPT+/UUnzXwVlPpvInyLI4CmvouGwfKqhg9DT2aNQnvB
         xmxOzIHFK4mbw==
Message-ID: <b0331a71-e316-28df-43bb-790ec748fafa@collabora.com>
Date:   Tue, 14 Feb 2023 11:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v4] media: platform: mtk-mdp3: Add missing check and free
 for ida_alloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, mchehab@kernel.org,
        matthias.bgg@gmail.com, moudy.ho@mediatek.com,
        daoyuan.huang@mediatek.com, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230209135245.11203-1-jiasheng@iscas.ac.cn>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209135245.11203-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 14:52, Jiasheng Jiang ha scritto:
> Add the check for the return value of the ida_alloc in order to avoid
> NULL pointer dereference.
> Moreover, free allocated "ctx->id" if mdp_m2m_open fails later in order
> to avoid memory leak.
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


