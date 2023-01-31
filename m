Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BEA682692
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjAaIfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjAaIez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:34:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D346D67
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:34:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CCBC66602EB0;
        Tue, 31 Jan 2023 08:34:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675154060;
        bh=YTDwGwfBFzyh04yq9kd12N21xcMUH+2G62M5xvhtgB0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=glgiKDV6E0zqSLzJqfUv4HNPK/4i0B3hHYBXcog8fqUYMD82r07E0DTjXVwGaEdDW
         CS1CfpfcK5a6OtbTivjP3gVimQLDHfVVnEEy78r3LL/wyWWZOq10JnvmfE7wVuzhdO
         ryCXFiZvpWNR9xqCTZjOebZI80LOrh0EJ3qvcMrE5yukEmy96e2khU1V7uyPGIilsn
         Z4vdsINZ3rZRZzNbA8xBuR0pkL0vdd5LklnIfs5i5A2dL9MrcM1cnh2oNqcIGzsDAc
         OoxNcKRD8XdkukwEoYw/mTXjHVyeVO6kWfVKXEA9bFYJqRlcLmmYYV0e905HPTvbav
         jOxONT4uTYDlA==
Message-ID: <34593781-1bef-10cb-0816-b2833e9d35ad@collabora.com>
Date:   Tue, 31 Jan 2023 09:34:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 1/2] drm/panel: boe-tv101wum-nl6: Remove extra delay
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        thierry.reding@gmail.com, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1675130359-24459-1-git-send-email-xinlei.lee@mediatek.com>
 <1675130359-24459-2-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1675130359-24459-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/01/23 02:59, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Reduce the delay after LCM reset by removing an extra delay in the
> initialization commands array. The required delay of at least 6ms after
> reset is guaranteed by boe_panel_prepare().
> 
> Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


