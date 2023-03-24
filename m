Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B4A6C79C0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCXI2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjCXI2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:28:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365521166F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:28:09 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C07DB6603103;
        Fri, 24 Mar 2023 08:28:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679646488;
        bh=OSwLd13ABDNH1gGaWUK5KSnyz988zi7C1RttukscA54=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ou2NdNkkb7pLdAkRWSCBxGmVGnfSDgJCLQm4JCEeXffSRjOSweFQHdCYcUlQdBsni
         ufpIFuXAaTQ1EU1ccvxC/7RPqNcwFxS8+6iGpyPot/PH3LmeUSdpOT2zO/9+Nxm6TU
         ipgBjTYph2G+1cA+KDTLieTuwU1bulKNnHrnS3CdP/PIs+/kvBF45e6P4EbMMcKMVR
         bJYP7NQ/fcGRc+2XwW2ppKesuVz14Mp8ztTalJi4jOLH9UlicJaIgYvoigHnJDWIqx
         nXh7KjJ24Ywt4l20BhvWxv0xyVvrqa3tX/rhLrFABqNk2a3a4uetV+Fz6Eqg5lzYdR
         hoY1cRNr1YZfQ==
Message-ID: <4f9d243c-0029-fee6-5caa-a4463dfe2b77@collabora.com>
Date:   Fri, 24 Mar 2023 09:28:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] soc: mediatek: mutex: Use dev_err_probe()
To:     ye.xingchen@zte.com.cn, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <202303241017290414354@zte.com.cn>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202303241017290414354@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/03/23 03:17, ye.xingchen@zte.com.cn ha scritto:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


