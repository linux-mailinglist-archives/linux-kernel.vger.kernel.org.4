Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8EE615E77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 09:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiKBIzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKBIzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 04:55:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966FB27DE7;
        Wed,  2 Nov 2022 01:55:38 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E74D36602929;
        Wed,  2 Nov 2022 08:55:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667379336;
        bh=96/vIlCR0pm8B4E0/1/a7fElFLkubeJEBzd4uuxKC64=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ojzgURK3lzEbgIcNB+4xc2oHgrl8FATrqeLB3BqnJR0WjLJmk/i9C2wanD5wNgTfS
         P03Zcuqmog9HdYZhQupYHuIsKKcwbJo4BHH1tzXhuA/p8Bj1iknx82U15P/1jbqxC+
         G4QypHYxK6hmmp2Gdy145aa398eT35o9a9sdyXgVBPlKEefkoIdMsdqWRDVMx6nlNn
         AV6trM/NNvAxOCEYHwl6HNw6yexR01ZA+aqY2gR0KFhZoqnmLXvtfiTWNFXKXdk0FY
         4dnmoavItEYUkw6InryI7EmkA04bSdzkS0WZd4m1Y6PQ3qtF2ykmIsHTYrTUmLT8PW
         VFc34eP0xLuwA==
Message-ID: <32627314-4971-7eea-8007-1797707e7969@collabora.com>
Date:   Wed, 2 Nov 2022 09:55:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] kbuild: Add DTB_FILES variable for dtbs_check
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Rob Herring <robh@kernel.org>
Cc:     kernel@collabora.com, Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221101220304.65715-1-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221101220304.65715-1-nfraprado@collabora.com>
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

Il 01/11/22 23:03, Nícolas F. R. A. Prado ha scritto:
> Currently running dtbs_check compiles and runs the DT checker on all
> enabled devicetrees against all dt-bindings. This can take a long time,
> and is an unnecessary burden when just validating a new devicetree or
> changes in an existing one, with the dt-bindings unchanged.
> 
> Similarly to DT_SCHEMA_FILES for dt_binding_check, add a DTB_FILES
> variable that can be passed to the dtbs_check make command to restrict
> which devicetrees are validated.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


