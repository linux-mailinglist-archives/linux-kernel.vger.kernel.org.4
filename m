Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA38F5EF1E1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbiI2JZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234886AbiI2JZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:25:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C676971;
        Thu, 29 Sep 2022 02:25:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8446366022B4;
        Thu, 29 Sep 2022 10:25:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664443523;
        bh=qCJlWCzZUOjlbWhUBr+CjY4sGdMeJ1qenSLOO28pr3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LO/GFqKuGCASvKu0rA1gy3hLof1Q7Ud3Oy1HSNPRtfDtnfSyP/cg6zkjBtI9uJJmH
         b0+rhEmqlTR36W5AeatLZSTYpKtwXueOCXLuX2OCLIV6oF2I7GwcUi+G5tPxzSS96P
         X7mnXMU766MFUsCwZSXr/IUjvD++RJy3h4EtWX+2K7AMjNX4az3cd5GuhTF7dHv4aj
         Me9R0v8J2MdFArLgh928AQzFcfbf8owpK8jUFt1AWSWmubcK6NIolsse3jgVf2cUiX
         ETRIdFG9wb7rkFWn3sEj+7ar2mJAf+iVYgSPt9o5dF/tQnrhB/GzzNabNSLeAMRXgZ
         5Q0ICPrtRx1Zw==
Message-ID: <aed50d17-3010-a5ee-a19d-14bfe5e6ac3d@collabora.com>
Date:   Thu, 29 Sep 2022 11:25:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: mediatek: mt8186: Fix spelling mistake "slect" ->
 "select"
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220928220417.66799-1-colin.i.king@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928220417.66799-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/09/22 00:04, Colin Ian King ha scritto:
> There are some spelling mistakes in dev_err messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


