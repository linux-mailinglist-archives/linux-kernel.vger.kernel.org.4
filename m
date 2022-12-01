Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16D63EB8E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLAIsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbiLAIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:47:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6560FDFC6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:47:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4525E6602A81;
        Thu,  1 Dec 2022 08:47:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669884434;
        bh=TB5bLrpKXkDRMFvWFAAHuFF1CR0GtLXdKBtS2KeNsgk=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=WdKKvLiDbZ5CL/lgLFU5onzxpqdklw229IC7HfGsRNaIQ6uOgX6IONurkSzOCHoeK
         rxUavI8ph2aaXDzEWpIr4mJab/E/hBwRm8WEBNHpZ+0vYt5SNgZi3LUwWle7DQLtC8
         QXCsnqZ3SE56b4IImBdljrDWT6pkObBJZtXL+OJP85fN4D2ILKsC2BpHBtMkMLviQ4
         xvqa242prCZd7fSPGXwgqRuA5yr07wTVV1aTnyKwu3y1bmzqKz3FvRMVaZFCG89ADq
         E8DS+tzoUVUs33qPwjWYstxgSzBR11dfF0h7mins8qs1Wi/IuZz16wbBrhZ0/waAud
         pTjMmWysnytMw==
Message-ID: <eee83c7f-441d-997c-de6b-56ea351f70cd@collabora.com>
Date:   Thu, 1 Dec 2022 09:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] mailbox: mtk-cmdq: Do not request irq until we are
 ready
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221125-mtk-mailbox-v3-0-c4b635052b65@chromium.org>
Content-Language: en-US
In-Reply-To: <20221125-mtk-mailbox-v3-0-c4b635052b65@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/11/22 13:58, Ricardo Ribalda ha scritto:
> If the system comes from kexec() the peripheral might trigger an IRQ
> befoe we are ready for it. Triggering a crash due to an access to
> invalid memory.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


