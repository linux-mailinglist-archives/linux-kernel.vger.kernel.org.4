Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636B6C7965
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjCXIKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:10:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C6B74A;
        Fri, 24 Mar 2023 01:10:34 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a] (unknown [IPv6:2a01:e0a:120:3210:1cb3:11e4:5834:9d5a])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D3616603101;
        Fri, 24 Mar 2023 08:10:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679645432;
        bh=lJ+hBP3Cg9URGS4sU7aN1R/NGhoudvSbdxIP0xXz8u8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=O2i/iVyff7pQlSOE94VwAALDTwGeZZpQvZmKW6n3IJM5G+JVmRbqrn5GPMLN05UGw
         f/wm25SSnFPDL/kg3SK3yD5in67rNvMZX21U/Tab8mD5peYzO3v0+OxwgY0PMEb8HC
         B8pfwJVAjfz2sflzkj1D/D9tkUoZE5Gm9mderLQeBVGjSs6Wz5Xt8ykYnQwfXmfV/j
         ZGyWxLAyind9wdHrjSO7TjRDecarnghGlbLsWO/dVwBVNFRAb2NFB+8i1ngXz3FVaG
         Ou+bXR3B/UDL/JQqp4x4q6RBdrKqzZuxiOe950ZRR7lkI3+wFCop5867NJPjtI4mmR
         oiUE5Re8iXXgw==
Message-ID: <bb638f1a-9d13-7331-9190-7470e98d05f7@collabora.com>
Date:   Fri, 24 Mar 2023 09:10:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] media: verisilicon: Simplify error handling in
 tile_buffer_reallocate()
To:     Markus Elfring <Markus.Elfring@web.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        kernel-janitors@vger.kernel.org
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230323131704.414281-1-benjamin.gaignard@collabora.com>
 <69159492-dced-a082-5f7e-3d8d0e880f58@web.de>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <69159492-dced-a082-5f7e-3d8d0e880f58@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 24/03/2023 à 07:37, Markus Elfring a écrit :
>> Rework allocation errors cases handling to simply it
>> by removing useless tests.
> How do you think about to use a wording like “Simplify handling of allocation
> error cases by removing useless tests.” for your change description?
>
>
>> Reported-by: …
>> ---
>>   .../media/platform/verisilicon/hantro_hevc.c  | 23 ++++++++-----------
> Would you like to add any links for corresponding information?

No, it was just to show that you have reported the possible clean up

Regards,
Benjamin

>
> Regards,
> Markus
>
