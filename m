Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D55F63AC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbiJFJbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiJFJb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:31:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C19AF9D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:31:23 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 788ED6601595;
        Thu,  6 Oct 2022 10:31:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665048682;
        bh=Xngz+DX9nQSm2osEDMhxbzEfyfWhmzAaDK4n91qLoMo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nQHG99mmo5EepGe9L8B0xIz3gEN6yWZ2o5lxhbMGbYANtzFA2SLU1l9H8pzYP3q8a
         404havFKDKHFKWi8n+TrYQOsrzXCou6/4xabAdCw4mNr/5k88VuFWEYLOR6SrJgeg1
         WQOjk/Em2YXdn8jBk3s7toj2DW/8ibwAC3o7FB9gvz4jLFRk5BqU1t9z9vdPGZ4i+T
         QDPkvKuHqxmDr9JCqYTpa6jjnjDiETXPVfd1BRQtOwMms8xOuGuuDm4ccfFLpSXMl1
         pxT2zUZNekfKffcUBevCOgM9dfEegZFOjWlEMPN8/KIx/iI7nz+AbFtGRuGhFqoWt7
         ZRGrPK4l1TX4Q==
Message-ID: <97f78c42-d699-8b01-4db8-8887d519c8f8@collabora.com>
Date:   Thu, 6 Oct 2022 11:31:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9, 4/4] mailbox: mtk-cmdq: add MT8186 support
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
 <20221006043456.8754-5-yongqiang.niu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006043456.8754-5-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 06:34, Yongqiang Niu ha scritto:
> add MT8186 cmdq support
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


