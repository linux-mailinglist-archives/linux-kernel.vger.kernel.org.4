Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF30E70E026
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjEWPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbjEWPPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:15:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D868E74;
        Tue, 23 May 2023 08:14:45 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BDF586601EB5;
        Tue, 23 May 2023 16:14:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684854876;
        bh=2aHgngDY90rcz6eiJl7lXujREWkfwzn4RDYYWdp0Nuw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Gad/oaxnevggDfqtWB0MCzKsmih2/DtZujGpBn+dmfSUnVo9N+2RMgcy0Qz0970bC
         XPmA0kh5xe+HXRYs3y96KITC352gagXoDp/MSRyxd4zssaDQ4U+gkJmkGeyOwjwmWt
         /pPbGJrsS/YwjEw+6Ifm3YYOOusDhhrs0UKPQxPVVbMRV5KPg5xET2T6OMeXnl/V+j
         X58xQiQxHRUEiysN0YF5OwKnwlhWrcEJ46sBw7QKzyNeuNcm5y70+NB6QHBEMQCJoE
         ZjUEEQMJjRIIimIdRwuwi/pv3A+JNH386Bab/E0RIYJ4+SFJoFNyREyGUJ9+gL32l/
         sKN/fKaIVAIZw==
Message-ID: <bb755ac0-a32a-57f9-f348-d9dd4f0dc697@collabora.com>
Date:   Tue, 23 May 2023 17:14:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] media: mediatek: vcodec: mtk_vcodec_dec_hw: Use
 devm_pm_runtime_enable()
Content-Language: en-US
To:     Fei Shao <fshao@chromium.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230515141610.v2.1.I0d1657be3fea5870f797e975a7aa490291e17993@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/05/23 08:16, Fei Shao ha scritto:
> Convert pm_runtime_enable() to the managed version, and clean up error
> handling and unnecessary .remove() callback accordingly.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but I was probably too late :-)


