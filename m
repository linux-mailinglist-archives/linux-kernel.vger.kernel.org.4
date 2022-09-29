Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369155EF085
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiI2Ica (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbiI2IcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:32:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0F03CD64D;
        Thu, 29 Sep 2022 01:32:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B126F6601EE2;
        Thu, 29 Sep 2022 09:32:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664440343;
        bh=BzCgkh7agrO1RG0lHCTr2sYO+CUf+iLH1yxL/52k1as=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XWIep3oXSRWI4RxMPsjJSd8aCJm4n+9S0XnuRWgQ4VL9Q/gPc9AjE9UJk78EdSgiH
         7qw0xQdEARP2NFFD1JjVhM/slx4NciRWQD5ESsf8ujUHaVa2GhhFihYkUk+Gm7qYiS
         gt/baMDrdvdFZqN7YAZPYpBE9TJgk+DtuTcNDJwk3/pSCzEaLUA4wyHqnnZHFU9/vd
         i2ab0AIHSf6gExrGaD+loxMwF3DGXLoYOJi9iympXKTrASGRwBQpayhBeoiL9w9xC/
         0bTYN6sChD49W8fR0yExNCngW8HcVlq0lfSlh9UdlxpT5aowXBc9t3wNmz1swxn7D1
         dr+/2mL/0d9XQ==
Message-ID: <c448e20e-a3d3-d895-6902-49cf1e174eba@collabora.com>
Date:   Thu, 29 Sep 2022 10:32:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] media: mediatek: vcodec: Skip unsupported h264 encoder
 profile
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        nicolas.dufresne@collabora.com
Cc:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220926093501.26466-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926093501.26466-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 11:35, Irui Wang ha scritto:
> The encoder driver support h264 baseline, main, high encoder
> profile, set mask for V4L2_CID_MPEG_VIDEO_H264_PROFILE to skip
> the unsupported profile.
> 
> get supported h264_profile by command: v4l2-ctl -d /dev/videoX -L
> h264_profile 0x00990a6b (menu) : min=0 max=4 default=4 value=4
>          0: Baseline
>          2: Main
>          4: High
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


