Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99475F75A8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiJGI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJGI4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:56:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78619D0CD2;
        Fri,  7 Oct 2022 01:56:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 33E2A6602329;
        Fri,  7 Oct 2022 09:56:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665132962;
        bh=z2yoDJUQzSqyLq/HCRimKaAJVGrSi/DMVz+hMd0IFT8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=klepZAq2fMI72AUgwsk46OGgVGu9kbEfpaqp5Ey6NRvxVkvR3YtwWj0ne70XK6FBG
         95UmzYhSP5aOtbgLLJCqEXVxrGh4jWd17tB1HCsedMtwh17iO68MFIG4IeCrPE5SIB
         bXKBNxzVNsPXBQIcLSG9f+a3IyWb76wmRwbB1khJbjQF7X0zctwcVPdVNJxQZcuAn4
         6srNwS5E0yaVEQ/KTTxUAMPkesFm7AI0Tis4Da/qaFDbnGLZwjxwbQQh5vXd8g82kU
         EwMu0rIDWqgXuIciHxIGIs1/Pevc0Z8grqlwyv9QaLltsecCOyM2YJmURXoAbMb4Yy
         DxiGZY4k1FVeg==
Message-ID: <c88ccdd5-ff6a-1d16-03a2-fe8cb776f99d@collabora.com>
Date:   Fri, 7 Oct 2022 10:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/5] arm64: dts: mediatek: asurada: Add aliases for i2c
 and mmc
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-6-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006212528.103790-6-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 23:25, Nícolas F. R. A. Prado ha scritto:
> Add aliases for the i2c and mmc nodes on the Asurada platform DT to
> ensure that we get stable ids for those devices on userspace.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


