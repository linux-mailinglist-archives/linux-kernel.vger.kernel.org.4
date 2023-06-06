Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFC972390D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbjFFHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjFFHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:31:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2B911D;
        Tue,  6 Jun 2023 00:31:05 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5DB726606E98;
        Tue,  6 Jun 2023 08:31:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686036664;
        bh=G9Yg0TlFYfsIFKwfhY9f+u1E2TG+wfhcVIp+pvHR+b4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q1273EtdsG0JKBag/szWRjp/W+OmD9K0OIHSeUMw0w77R7uUWJNJlMRd4dTsf1sYu
         GLEuQV4HRJoalp02WkpDphRmE8ug4K2UsKmJPnOxI0/TAn3LPxJimghjNxEl0MgCBD
         f0ue0X1AtmFhl/2GQoWwW4RYmE495iZcpzCzYPq7/BBAcydvbPW0JaKrtv4cntL9Ap
         3R2srxnNaqjSqLq8eq+TTHGMfKdvcgT349ncQS9Gmz7AoXZFwSNoLbrj9ZihsWpeJW
         xEeANv/0MysGhWD7PcDbfHNVMgqLqWQh2G9FUb+nzlU+gpVwPI4UjfHB5vNfjuPHwN
         HvvMPLObxxW+w==
Message-ID: <3400aec0-4532-ab39-52c4-13c718817ab3@collabora.com>
Date:   Tue, 6 Jun 2023 09:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/6] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS
 for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     kernel@collabora.com, Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-4-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230605162030.274395-4-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/06/23 18:20, Nícolas F. R. A. Prado ha scritto:
> The binding expects the first register space to be VDEC_SYS. But on
> mt8183, which uses the stateless decoders, this space is used only for
> controlling clocks and resets, which are better described as separate
> clock-controller and reset-controller nodes.
> 
> In fact, in mt8173's devicetree there are already such separate
> clock-controller nodes, which cause duplicate addresses between the
> vdecsys node and the vcodec node. But for this SoC, since the stateful
> decoder code makes other uses of the VDEC_SYS register space, it's not
> straightforward to remove it.
> 
> In order to avoid the same address conflict to happen on mt8183,
> since the only current use of the VDEC_SYS register space in
> the driver is to read the status of a clock that indicates the hardware
> is active, remove the VDEC_SYS register space from the binding and
> describe an extra clock that will be used to directly check the hardware
> status.
> 
> Also add reg-names to be able to tell that this new register schema is
> used, so the driver can keep backward compatibility.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


