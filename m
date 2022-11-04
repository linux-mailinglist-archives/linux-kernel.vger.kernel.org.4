Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FFD61931C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKDJFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 05:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKDJFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 05:05:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA741C90A;
        Fri,  4 Nov 2022 02:05:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B2B556602972;
        Fri,  4 Nov 2022 09:05:39 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667552740;
        bh=MVJ5DFMDCN9ckZXMdLYSo976N8eT7wz6DnPsdP6ZGoU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K+LhH67EBFRCoYuUg3jT84nJ+Fg3kyBukbM7Aqv3kGF/f1IGAM8abbusQKPsSoLGq
         91W1pP18W3f49mde5HCyStWrltCJv8pA1xz1RLExUKyIKnaexlfuVL/uz9kOl28P8Q
         +LE1DwaoC6fBD+pcdgqZohK+iGgvWOW1lhKn+3hjYi1P/wOsQCdT7XtdQFxOB+jlDQ
         9AauUD6X7qn/RnBWRSOTnqXYilP+YRoviJ0Qkg3/NhLIQ8H3q51/5TypDN7xuxO0y4
         fKlDrUtcNm46op2d9V2ol53iuTJyLOOEZNDThXC+YaWofMRSpMStoCIwxDbpON5cUn
         /BUay4/jFlLuQ==
Message-ID: <dfea91e1-31c1-c2e3-a457-98af33e7151c@collabora.com>
Date:   Fri, 4 Nov 2022 10:05:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] vcodec: mediatek: add check for NULL for
Content-Language: en-US
To:     Anastasia Belova <abelova@astralinux.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, lvc-project@linuxtesting.org
References: <20221102121027.4285-1-abelova@astralinux.ru>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221102121027.4285-1-abelova@astralinux.ru>
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

Il 02/11/22 13:10, Anastasia Belova ha scritto:
> Any time calling vp9_is_sf_ref_fb we need fb != NULL after checks.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: f77e89854b3e ("[media] vcodec: mediatek: Add Mediatek VP9 Video Decoder Driver")
> 
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>

Hello Anastasia,

for some reason, you've got an incomplete commit title on this v2. Please fix.

Thanks,
Angelo

