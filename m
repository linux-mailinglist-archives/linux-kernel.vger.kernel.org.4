Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823716B3A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjCJJdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:33:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjCJJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:33:16 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D376A63
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:30:44 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 756686602E9A;
        Fri, 10 Mar 2023 09:30:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678440641;
        bh=cEnOOEHWgbBtPV7HBLUeOsc7+RNQYM9W3hbWj/wzbXw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G08HtZhX1oshhNDulG45oNkghnpLjrdxnhbfPDO1tMWdVucq2brB9fczC49zSVj25
         ApmjDvMLR0t//jXdazwVHYEpv5/O5mzv0c8aGoeY/TGUVOfGTnrqbjsDOrN/89tZCD
         1rA4kIPOdmDK/hD1tp0awKIevKhyBGTTlIiZ+pasbNQEcOcbymg0nUyKi6n2LSxn4S
         fGWbJqrcWdok29qtmkF4AfPqW2/lrOzsQkqyFiqhx8yjqlcUSojlt2wthVeLBkpNNw
         5bnopUA2AYxjUK55zgLfS+rOWnnZc+zZ3vYla774GEgmSgXVGgPZgKSOgC36hHaQ82
         0LSIQfsiSVb3g==
Message-ID: <1c21a19f-4412-7a55-fa61-81010e74f2d6@collabora.com>
Date:   Fri, 10 Mar 2023 10:30:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/3] cpufreq: mediatek: fix passing zero to 'PTR_ERR'
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nick <vincent@systemli.org>,
        Dan Carpenter <error27@gmail.com>
References: <20230310051750.4745-1-jia-wei.chang@mediatek.com>
 <20230310051750.4745-2-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230310051750.4745-2-jia-wei.chang@mediatek.com>
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

Il 10/03/23 06:17, jia-wei.chang ha scritto:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> In order to prevent passing zero to 'PTR_ERR' in
> mtk_cpu_dvfs_info_init(), we fix the return value of of_get_cci() using
> error pointer by explicitly casting error number.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Fixes: 0daa47325bae ("cpufreq: mediatek: Link CCI device to CPU")
> Reported-by: Dan Carpenter <error27@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


