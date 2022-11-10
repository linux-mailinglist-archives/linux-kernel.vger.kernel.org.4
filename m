Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF93623E35
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiKJJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKJJCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:02:19 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669C2B4B3;
        Thu, 10 Nov 2022 01:02:18 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B994F6602A12;
        Thu, 10 Nov 2022 09:02:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668070937;
        bh=ePBS862hPs4yf5c+mZnYpufOgVKu6Ts7nvvHguuCxDM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ndhZA3GFoHwv/PZPwd8KVeA7WW4XwA3owaNqgfUSS5k8gi8uYtm3HqCD4OxboqsXX
         M7ydc5tijTAdmT2wPBlctu4DVMkAi+FSa7hqAB38v8Nb4j+n8WJd2/UVZPMWAZDart
         Ib04DdwnYrW25DYgOmtfEDAuCXTTEI5luzfH4N+1Sk7PfBZk4h+FQmWDhDsZdEVtNe
         VaooFsD30z90PnLjQrSwmS8d819tbNhiXOD9qAgnna7SY4mBN2FL3sN7hby8fBxJ/N
         9Ntcq6hJWRwpSRhA4bQejaM15hHwU6hGcJXcLDyLxaBYpUUsXjT9hjxtaWmxq7Io74
         2/cOMXxqfMHZw==
Message-ID: <a430f1c9-0d25-5771-6a9f-23f47daa3759@collabora.com>
Date:   Thu, 10 Nov 2022 10:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] mmc: mtk-sd: fix two spelling mistakes in comment
Content-Language: en-US
To:     Yu Zhe <yuzhe@nfschina.com>, chaotian.jing@mediatek.com,
        ulf.hansson@linaro.org, matthias.bgg@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com
References: <20221110072819.11530-1-yuzhe@nfschina.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221110072819.11530-1-yuzhe@nfschina.com>
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

Il 10/11/22 08:28, Yu Zhe ha scritto:
> spelling mistake fix : "alreay" -> "already"
> 		       "checksume" -> "checksum"
> 
> Signed-off-by: Yu Zhe <yuzhe@nfschina.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


