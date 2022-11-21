Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97072631C53
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiKUJF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiKUJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:05:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EC83EB7;
        Mon, 21 Nov 2022 01:05:55 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B61C660159C;
        Mon, 21 Nov 2022 09:05:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669021554;
        bh=oYdPeMNEX2Rrmz5Dlvw9fvA18GDij/SA6IU1bFcqUtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dYYG43t7UPlFu0jI1EavN7PAIlw1d3ek7C9ujtFX7sj15AkrTpI4x2+EoYu914LYz
         W8lG6SfTDkKRceeYARgJQbreqeVZQIKtf0++BF6wQcI1rTKoCCpQiQfiXTNEya1Utl
         pw9tu6/uqHIrAFftb/BJZk204SPPzL7mEbJxHNtRGoumCs+iVWNQ3jH24jqjuSe7HK
         WdfekXjBDsLhXTvmN3fm1NN2cPay3318W8cdOeu9lbj/knezkhqI0WQHN0KaK2aTiE
         sjHY19OCL4aXP6RSsEJsuYmm0uuYm04iQ5SIVQQ5taje83jXXa1k7Ipk4fpM6+FyDr
         AZZjyQOYqjHnA==
Message-ID: <2545400a-e821-ce05-5c59-67b9838f4644@collabora.com>
Date:   Mon, 21 Nov 2022 10:05:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] usb: host: xhci-mtk: omit shared hcd if either root hub
 has no ports
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221118110116.20165-1-chunfeng.yun@mediatek.com>
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

Il 18/11/22 12:01, Chunfeng Yun ha scritto:
> There is error log when add a usb3 root hub without ports:
> "hub 4-0:1.0: config failed, hub doesn't have any ports! (err -19)"
> 
> so omit the shared hcd if either of the root hubs has no ports, but
> usually there is no usb3 port.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


