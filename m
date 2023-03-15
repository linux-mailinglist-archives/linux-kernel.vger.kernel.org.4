Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD16BB352
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 13:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjCOMna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 08:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjCOMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 08:43:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF1E99D55
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 05:41:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BA0B660305E;
        Wed, 15 Mar 2023 12:41:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678884097;
        bh=YpgkzR55vUNXg772WCzP3dnHtOqNzPmc0fvNtu9cEog=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bM45v69+qla9S5peI+S+50UIU9fEX4IW3DizilRJhF45gFyhGWZ+y9hvXy3lgGiX6
         zfpod8KJuSbN335rzGc0iYni+0SDT4EsMIVLPk0cv6WFAcyIBVkYy0DaJZzbqCr6S1
         FUUt6L0dXmtLjq9ePxy3P3vzUgE9KYLncgoXPeN2FvgEQIJNP/YP0SlhVcqkrzMQea
         bEBl4neR3Qymteu9SHD9UT9ZYI5PnHztY0gYIxy4wUpcYKG/6zb3PCr28VvAocV/NP
         7hH30YrItGdYEhhDl9rqOMjYrRiJbajS9jUu5haPRHcFgwjScVCg1cRUz8aOjbDQQC
         qD2A+IXk3mZJw==
Message-ID: <8476933f-9723-7a06-0605-8c4fe45f3183@collabora.com>
Date:   Wed, 15 Mar 2023 13:41:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: mediatek: pm-domains: Add buck isolation setting for
 MT8188
Content-Language: en-US
To:     Johnson Wang <johnson.wang@mediatek.com>, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230315114505.25144-1-johnson.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230315114505.25144-1-johnson.wang@mediatek.com>
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

Il 15/03/23 12:45, Johnson Wang ha scritto:
> For ADSP_AO, CAM_VCORE and IMG_VCORE power domains in MT8188,
> we have to add the buck isolation setting to make them work properly.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

