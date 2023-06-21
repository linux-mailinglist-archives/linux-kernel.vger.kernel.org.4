Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6EE738178
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjFUKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjFUKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:00:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B54A3;
        Wed, 21 Jun 2023 03:00:13 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8F92B6606F79;
        Wed, 21 Jun 2023 11:00:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687341612;
        bh=Ph+03Fr42BlVtzH5wEcKX5Csb0mSfoQbYcHJJGg40Co=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LdF3IBH5a+ErxRKXcSUPN/bn2oVRx9YsFx819NnpZ+OttiUJlbAQmlG/QWfLdZ1VP
         SE5ffSB3+1dzjgbEYMPJ/rUBrgNXN/jobAuXHBpgkHfZ4EmYJ0Mixi4hYwUeIzbQgC
         GRXixwt/aYI+/dPbwq/fyYL5iP1lFD7wtHkd5gDmR5QHyT8MmTOT/z+OrCjx/8/L50
         Pm48v7YpdyQtHd8PKJnRJT6UGZaK1vlxzCoz6Amulsu3ZrB/9Y77sPk045E+f+lGU+
         WFERUIxJSmoGIkqCkywo/ibKy+5sZEpSRITgWZRe9sFNmbqyuKbJ8rL7H/1sw5jgHj
         cQa1LXSJeFqNg==
Message-ID: <0db4a705-10d0-93ce-df61-1a20d6d09959@collabora.com>
Date:   Wed, 21 Jun 2023 12:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 13/14] drm/mediatek: Sort OVL adaptor components in
 alphabetical order
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230621031938.5884-1-shawn.sung@mediatek.com>
 <20230621031938.5884-14-shawn.sung@mediatek.com>
 <8442c6a4-14a7-e3b3-0a82-0797ef3ddd77@collabora.com>
 <9a2acfe13a22ddb1caace1fb58089f5c8a5f8b07.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9a2acfe13a22ddb1caace1fb58089f5c8a5f8b07.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/06/23 11:16, Shawn Sung (宋孝謙) ha scritto:
> On Wed, 2023-06-21 at 10:16 +0200, AngeloGioacchino Del Regno wrote:
>>   	
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>   Il 21/06/23 05:19, Hsiao Chien Sung ha scritto:
>>> - Rename OVL_ADAPTOR_TYPE_RDMA to OVL_ADAPTOR_TYPE_MDP_RDMA
>>>     to align the naming rule of mtk_ovl_adaptor_comp_id.
>>> - Sort components' names in alphabetical order
>>> - Sort device table in alphabetical order
>>> - Add sentinel to device table
>>>
>>> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
>>
>> I agree, but this commit should come before [12/14] of this series.
> 
> Got it. Since [12/14] removed many lines that use component ID/type
> (for example, in mtk_ovl_adaptor_clk_enable() or
> mtk_ovl_adaptor_add_comp()), if this commit has to move before that,
> should I still modify them and delete them in [12/14]? Thanks.
> 

Every commit has to work on its own, so you first perform the renaming in
one commit, then you modify and delete.


>>
>> Regards,
>> Angelo
>>
> 
> Best regards,
> Hsiao Chien Sung

