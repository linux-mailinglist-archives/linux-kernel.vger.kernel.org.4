Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9261B5B5846
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiILK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiILK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:27:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9003739B85;
        Mon, 12 Sep 2022 03:26:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BA5DC6601FDB;
        Mon, 12 Sep 2022 11:26:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978418;
        bh=lsakC5tXlXnwjZ+SXxeOjNZ2MoFmMoIsT0zJ4vJo5oc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IoVq3MfDQ8Lq/69DJYionI4z0bCBxPZDwZDZXcK6CaMLDtptMrQZ9S5NcGnaCpV/E
         WO5+MytT5DVhIi0Us7pHAB8we6kAYnpaWwY8hwFgcdCJXVEyLK6c0ducJz8cFqkxeg
         XE2RyAGtqXhOSFTYIpcGorjtbtlc9AlwWH3OS9nfuSilhbqWdj7um0BRsHpGNuAaGH
         7Nq0KTNWdziVMeQBdRRiLd1yjPga0SpRCN5OtcSgBcZcIfXkMq2qw0tUeRKkBAp2Ve
         Q5s9ciPg0dH1qDawwpsraC04BLszfQGAERB7tF3uOpLxCQJVs+WAzITzDPOu+hUvVF
         tBHfe49Mvg7og==
Message-ID: <ed7ca57f-81c8-514d-2c64-26a4aa8e75d2@collabora.com>
Date:   Mon, 12 Sep 2022 12:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 8/9] drm/mediatek: Add clear RELAY_MODE bit to set
 gamma
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220911153734.24243-1-jason-jh.lin@mediatek.com>
 <20220911153734.24243-9-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220911153734.24243-9-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/22 17:37, Jason-JH.Lin ha scritto:
> Since the bootlaoder may set the RELAY_MODE to gamma be for the kerenl,
> we have to clear the RELAY_MODE bit to make sure that the gamma is
> enabled correctly.
> 
> Fixes: b10023b03082 ("FROMGIT: drm/mediatek: Separate gamma module")

This Fixes tag is invalid. Please fix.

Regards,
Angelo

