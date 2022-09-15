Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF235B98D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiIOKbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIOKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:31:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2398593
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:31:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 709E76601DA4;
        Thu, 15 Sep 2022 11:31:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663237899;
        bh=cw5utiGORthyeJlMeh2OqxvWGrsBK/NlZJEzrppZ6R0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OLpV6alBN8hdQ9TNr7vdOPIVGnlYEZD+qYoPEHgvObkIQOJ/nyRFde7jI1kHFtSlC
         LMewm2YgVgwoROWlg7d1dOU6dWy0ow83BZHAyYHJJljZY3mcd9PQqK0A94amaSzpcG
         zsn3Smb+3/FitO1oFa0iALsReszrPsNhIPoSBPpXc9fm5KqwgQQwJP7Ih/ZUNyaIYT
         H/xi64row2bgdYsF4kJ+iw4Wa9RnPiTeZVf8BjzeFJS8PGdvDhk6W4q1OE3Pk37cWn
         s3Mml/XdCbj/QYEwRBrPlPd3sXjC9jJWX0to8yq2MfTPalGlYfROlfidDPqOeo1Oec
         E2cqDzzrh/TVg==
Message-ID: <abe4254b-cb81-8a79-9039-36e4c47bc059@collabora.com>
Date:   Thu, 15 Sep 2022 12:31:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/3] drm/mediatek: dp: Remove unused register definitions
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie
Cc:     matthias.bgg@gmail.com, granquet@baylibre.com, daniel@ffwll.ch,
        jitao.shi@mediatek.com, ck.hu@mediatek.com,
        liangxu.xu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075028.644-1-rex-bc.chen@mediatek.com>
 <20220915075028.644-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915075028.644-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 09:50, Bo-Chen Chen ha scritto:
> Some definitions in mtk_dp_reg.h are not used, so remove these
> redundant codes.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


