Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5826F6920C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjBJOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjBJOWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:22:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2959B5C49A;
        Fri, 10 Feb 2023 06:22:53 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 71CCE66020EC;
        Fri, 10 Feb 2023 14:22:51 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676038971;
        bh=Kiib32ShMeFp0/GlAjIugogG27QI4xwFPCM7Vl2Jn9M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JToGUUNZKAPWOOGtXG5QMpFJ/S0EOEeoEcVfrNCKVG5qcz2dtEoTawLWfSBOmI8VV
         06zHp3ohLG+owU8gyMm6E9jUuAmzS4zy+FCB5ftSPpWHcCEcWOXlVO6SDp7H/VZS3R
         szqcF/3NuAe5L/7QqXtmS37fqU946BoY+ST07puhgYnpaOoDsm9P+RJi8dtp9ltS3j
         bgqwr0VeQc352zhmf/IljlPqMhqHQboZfuGvwjYPekTg1Gar6piFwqRwBG5p/9io5b
         wdc4gJnfdeoOu9OsEwfWWNwn1rJt6SWsx6FWnL3r3XqgmZTlATFYw9sq6u7PCqYA3V
         J51pe6oO6aoFA==
Message-ID: <471dedd0-b580-f16c-0b21-5a030520151e@collabora.com>
Date:   Fri, 10 Feb 2023 15:22:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v1] remoteproc: mediatek: Check the SCP image format
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230210031354.1335-1-tinghan.shen@mediatek.com>
 <6f48f7a2-23d4-687d-5c9b-3a1561928ed7@gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6f48f7a2-23d4-687d-5c9b-3a1561928ed7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/02/23 12:32, Matthias Brugger ha scritto:
> 
> 
> On 10/02/2023 04:13, Tinghan Shen wrote:
>> Do a sanity check on the SCP image before loading it to avoid
>> driver crashes.
>>
>> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


