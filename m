Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD6864B2B7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiLMJuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbiLMJuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:50:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548F15FF6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:50:22 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 135BA6602C32;
        Tue, 13 Dec 2022 09:50:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670925021;
        bh=HS72oKm63w2LMEbxOfImNuaKAF4fpLQ7wU9oXHA4roE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RtHJ6ooTaXZdj05uQbT7acXUw89mJS6ITx6Q1+RL8+PauvSKj0GnkXuMiS7D2GW/n
         Ff0q+hMsMGz0Ud71EVrgO2QJmM/VOMABPSe2ZB/1W5kYhIkVSmGrkh9wBBHgILk38/
         qtng7/RaKsmJkDUHFG6kJTTGJPQHA5NEtSSwtrlM2Uw4vdpC76y7t0NQYBzz+D+YgJ
         wSq1CPLm+CIP6yUNM5UZOcxrimnq23attlWv+wrqCZJfAcLTi8DI9W+jiOCh33cN4g
         S2nPNphL6f5JxOXVLkqpK9FM0Rxqu+IMQR7yzOuCJnVq9qRfjAtHTBE+7f8t9c1xar
         RyPqsRiqi7+bw==
Message-ID: <0670a966-2449-977d-a791-4b1c4478524b@collabora.com>
Date:   Tue, 13 Dec 2022 10:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/3] soc: mediatek: mutex: Drop empty platform remove
 function
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20221212222549.3779846-1-u.kleine-koenig@pengutronix.de>
 <20221212222549.3779846-3-u.kleine-koenig@pengutronix.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221212222549.3779846-3-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/12/22 23:25, Uwe Kleine-König ha scritto:
> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Totally agree.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

