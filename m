Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC0165C03B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbjACMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjACMtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:46 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE3D2F3;
        Tue,  3 Jan 2023 04:49:46 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CDBC6602CF7;
        Tue,  3 Jan 2023 12:49:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672750185;
        bh=bxjVD+aRr/ENgJHeJHIRI7ouVBUwPz4lAel5oaRnCrI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LgP8la83dhZOYfQpRQy6Ry47iDMwcZlyXzH4/6thsiar3/ZPrOdmsfphd/QW5BCHo
         bJWIVLtYvhToCBAuSJaTWBwNujrD6iJ6Lb8UOWLEByljJKO/GHYTPH8Nvj4LYcCm7x
         Ymdc+sF0Zq2PVn5s9BHsoIr2wRkwgL7VmoOThtveVmp4NAd3/3/Cdo953Ce66T/tj6
         tsJkAJD/vqSNzh1Om3+kMYY1sLDxC2s+6l3jx6ke2PtXuYFAfmceHTdJAod85IYjko
         61ABeboAakdWrspo8n4qX+HBx0b2/bvrDq6SjmHXu/2eUtS/O26F9wuLyKuvgKA0yt
         7gzWlZtl7+p2g==
Message-ID: <e50c6c98-eb92-d41b-93a2-9fe5af97fe8f@collabora.com>
Date:   Tue, 3 Jan 2023 13:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 11/13] soc: mediatek: mtk-svs: add thermal voltage
 compensation if needed
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221226094248.4506-1-roger.lu@mediatek.com>
 <20221226094248.4506-12-roger.lu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221226094248.4506-12-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/12/22 10:42, Roger Lu ha scritto:
> Some extreme test environment may keep IC temperature very low or very high
> during system boot stage. For stability concern, we add thermal voltage
> compenstation if needed no matter svs bank phase is in init02 or mon mode.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

