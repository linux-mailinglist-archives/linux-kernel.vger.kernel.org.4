Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C623707D44
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjERJvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbjERJvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:51:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AB9212D
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:51:33 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3F6746605943;
        Thu, 18 May 2023 10:51:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684403492;
        bh=HWIbngsvv5AKR8DXcAvoNyK+M3yOcUqvLNMDrOowmGs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L3qPfq0QiO0uG8C7STBGUjyvPtV02pCzuTtv3AXAk3twzdMql6fes/Db2nOzfPqP9
         50BajfffNtqzSmTb59spVnHjEeRIYOx1fFBjc5xHfWk2UPwr8ms1TnUPyL9tav+sEe
         Mfes9qxtVnM1UeddU5EoSXqHa8PmvP0XcaAV8jJZSTnIEJiTEcro/Rf9j1Ck/5AGjz
         0Pa1vDtrO0wW5ZdJWHH3JRxM0wtBmdjw8lC8BNL9BGymQX2Hs4W/Ld7fzROiz0Yq5D
         nQ6ebIbu+Gxz8+3P+k782v1WXY/BkUegelf5LWL/tjZYSqgpz2bQIxvYwci8bP7hFZ
         eDtEWtzHZlUjw==
Message-ID: <f494ab3b-cf7b-85b6-1b4f-732d887164ca@collabora.com>
Date:   Thu, 18 May 2023 11:51:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] regulator: mt6359: add read check for PMIC MT6359
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Sen Chu <sen.chu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230518040646.8730-1-sen.chu@mediatek.com>
 <b9531c67-ab85-5ba4-6d86-9fc83974df4b@collabora.com>
 <CAGXv+5H+peO6fhuE9jj2t6DS5EPRyg8m=zc3ACDGdvm8Bes+RA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGXv+5H+peO6fhuE9jj2t6DS5EPRyg8m=zc3ACDGdvm8Bes+RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/05/23 11:47, Chen-Yu Tsai ha scritto:
> On Thu, May 18, 2023 at 5:32 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 18/05/23 06:06, Sen Chu ha scritto:
>>> Add hardware version read check for PMIC MT6359
>>>
>>> Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> No fixes tag?

You're right. This one needs a fixes tag.

The right tag is

Fixes: 4cfc96547512 ("regulator: mt6359: Add support for MT6359P regulator")

Cheers,
Angelo
