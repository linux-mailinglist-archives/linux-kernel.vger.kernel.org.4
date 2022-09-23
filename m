Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8549B5E76B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiIWJTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbiIWJTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:19:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B9AB42
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:19:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 555AC6601BDF;
        Fri, 23 Sep 2022 10:19:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663924784;
        bh=L8D1yTEhULRIAS6lI51HY0j9CE5jcl5Cm2AEs0nABTw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PdlxoKsr0n4pUp6rXaoDv1z95wkQwSDLj9HW9GDDCwAMWLOUl9PsJd4qls4Cpb/zv
         a0nz1P8zzsvcGgGVH0CDWqBUGSgyngy5l9j4nunNfT7s1nqZKct0uyoUSoVik5cPUr
         +O4B0I7GsgWdV6H12y1pS5TMwWIX5c9j/ZUmjhbh1DAENlhoKJUtUF2/gLTFAGUspz
         uS1af1SK84lFDivPwjqXIwHqBgtMS80rJIBXgCXnYEYuy9VD5Csxt3iHrjWayudeX/
         ZsCHnKRrIWeHIc2b9er2iWh4Nx8SFdrUu4VakhREUKGspz5ZheGVbROEpK5V1dyLyL
         lAfVid34fkaUg==
Message-ID: <b11fec5e-0725-be3c-4b4b-0e68bf00c10d@collabora.com>
Date:   Fri, 23 Sep 2022 11:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9,0/3] Add dpi output format control for MT8186
Content-Language: en-US
To:     xinlei.lee@mediatek.com, matthias.bgg@gmail.com,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <1663922440-20242-1-git-send-email-xinlei.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <1663922440-20242-1-git-send-email-xinlei.lee@mediatek.com>
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

Il 23/09/22 10:40, xinlei.lee@mediatek.com ha scritto:
> From: Xinlei Lee <xinlei.lee@mediatek.com>
> 
> Base on the branch of ck-linux-next/mediatek-drm-fixes.
> 

Hello Xinlei,

I've reviewed v8 just some minutes before you pushed this v9.

Can you please make the requested changes from v8 on patch [2/3] and
push a v10 retaining the Reviewed-by tags that I released on v8?

Thanks,
Angelo


