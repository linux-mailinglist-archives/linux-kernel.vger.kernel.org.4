Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC47278E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjFHHeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjFHHeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:34:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439BD9E;
        Thu,  8 Jun 2023 00:34:12 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0DFB56606F10;
        Thu,  8 Jun 2023 08:34:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686209650;
        bh=xJ+I3bcwd9Bg/yM7l1pEkI+rXFRK/dFMKrA5l7XRALw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=km6m0nsnZRM5AqYkLkmQK8jZf+krqDHQTD5jwbqzg9CEN8j1ZTkuIZpfO+jPNL9uI
         xo6weoeh4iJWh/ox5PKnHfQd42Pny82ooWWQHeE2zzMO9hS6CTPPy9J3Xf70I6BHM7
         fBHYrPnq2xWOZyv3IPJODjh3HfjT4NUnXI4MeYHsmn4PBX5YWq73BmtsV028Pj4zxK
         HsMH+JGnVkVGSIfZBfOTsdZv+M9arh1g1hXPri3yEfF+tO/Xz86iJR4NqEnAP5wzKJ
         KmxJBy1o5J3NlJmlqtMx5DSHAyG/X1tvAqDuM3j4BGM1K62w9I1X4lTsBetMNU9mRz
         uLeWf4WG0lOQQ==
Message-ID: <b40de764-3673-fe5c-1eba-c17e63af55f5@collabora.com>
Date:   Thu, 8 Jun 2023 09:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status
 from clock
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230607205714.510012-1-nfraprado@collabora.com>
 <20230607205714.510012-4-nfraprado@collabora.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607205714.510012-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 22:53, Nícolas F. R. A. Prado ha scritto:
> Remove the requirement of a VDEC_SYS reg iospace. To achieve that, rely
> on the "active" clock being passed through the DT, and read its status
> during IRQ handling to check whether the HW is active.
> 
> The old behavior is still present when reg-names aren't supplied, as to
> keep backward compatibility.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


