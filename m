Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75CA6D4480
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjDCMeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbjDCMeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:34:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA1E83;
        Mon,  3 Apr 2023 05:34:19 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4C5F866016BD;
        Mon,  3 Apr 2023 13:34:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680525258;
        bh=bZWnxp0bmfhUOl9W6PR6jXsq2ZiL2l8XmKiI0uwrGKI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mNDoX1UIjO7KohkWNTn7UmYVG5AY8Wfd1h3EYaQpO0uflyzTgx1SkPK5BxDvy1N3S
         bOLKt/OO31eXcfTHoDzqBU4ia7eg8UtapJ6N7d2MofX0vhxgW6YrV/Y2Y628G41hdX
         lDcnQsuOXdGhKBFx7dxA8nkXgPPvRTRBsF4VrPk9YceVtG9cFnPGkcdhR4/g7/Huas
         GykxQURTzOFo4QDtHd0RFL9HpRFBHrwz8te/Tahs7SOxpzLpmrvyi3/oocRLMOk4Vp
         wCJ8N9ukrUI0eSSi51IhIgNIRLMHwuRndt+05oLM7RvwtIFRhGknUQmZvgnhUkks+D
         Lex+Dki7uvDVQ==
Message-ID: <8e7584d6-92a1-e948-302e-489af8cf6394@collabora.com>
Date:   Mon, 3 Apr 2023 14:34:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 7/7] usb: mtu3: add optional clock xhci_ck and frmcnt_ck
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
 <20230403025230.25035-7-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403025230.25035-7-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 04:52, Chunfeng Yun ha scritto:
> Add optional clock 'xhci_ck' which is usually the same as sys_ck, but
> some SoC use two separated clocks when the controller supports dual
> role mode;
> Add optional clock 'frmcnt_ck' used on 4nm or advanced process SoC.

This needs more details, because from what it seems, `xhci_ck` could be
a children of `sys_ck`, in which case there would be no need to add that
to this driver, as it'd be handled by the clock API instead.

What SoC is this for?

Regards,
Angelo

