Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A7160CAFB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJYLfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232266AbiJYLdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:33:53 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC6139C28;
        Tue, 25 Oct 2022 04:33:52 -0700 (PDT)
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
        by mxout1.routing.net (Postfix) with ESMTP id 29D1541ACE;
        Tue, 25 Oct 2022 11:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666697631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6+ancf2wzKVgZhIR1zetpELJHo8pX+zT23hmRzLhVa0=;
        b=NsW6nDG1Xn6VMNRS1jgiNdi2iDX84NesJgDr5ju/njAmDLJACoym/JduZ8Qxp9gOK/K4od
        i7ycy9+lTFKgFeEBEQE4Xccm/l13NZmpYTVw275G27TbZEiE4hBxAgyIFdmlladRB9Zni7
        l6g5T4sXGJvk8d2vNG7XklIsJCTBEgw=
Received: from webmail.hosting.de (unknown [134.0.26.148])
        by mxbox2.masterlogin.de (Postfix) with ESMTPA id 5F4AD10031F;
        Tue, 25 Oct 2022 11:33:50 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 25 Oct 2022 13:33:50 +0200
From:   "Frank Wunderlich (linux)" <linux@fw-web.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: mt8183: drop drv-type from mmc-node
In-Reply-To: <3b366319-5257-a536-4dba-919cb5fdf477@collabora.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-5-linux@fw-web.de>
 <3b366319-5257-a536-4dba-919cb5fdf477@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <5ccd67c45c9f384296bfd1f19dd019a1@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: 944cef20-d0fc-480a-bfc1-5ee2059ae4d4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-10-25 12:52, schrieb AngeloGioacchino Del Regno:
> Il 25/10/22 09:42, Frank Wunderlich ha scritto:
>> From: Frank Wunderlich <frank-w@public-files.de>
>> 
>> This property is not defined in binding and driver.
>> 
>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> 
> This commit needs a Fixes tag :-)

i hope it is ok adding it here instead of resend full series...

Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")

regards Frank
