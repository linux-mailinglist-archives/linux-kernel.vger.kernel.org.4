Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B848760CAEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJYLdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJYLdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 07:33:16 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B8A8E78F;
        Tue, 25 Oct 2022 04:33:01 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id EF5E141BCA;
        Tue, 25 Oct 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1666697579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/pjUimprXAN5aGuHop15W9q66+usPs8I5yURjMHny8=;
        b=pKnBbJgB7C26LzjLyROErl6S/TeGybPxmxQYDff76htpo5Ihk2iqRV/iOnLfVJO9PyjFwO
        mlSIdEpGaFQivp/0IVoNFDEfgXq06ccpEWl89NwmRcAtFWIr2QWBI70nOA/y6exqnoOCNy
        z/MOv8TECpFBK5ICX15P2onIYpZ+Q1g=
Received: from webmail.hosting.de (unknown [134.0.26.148])
        by mxbox4.masterlogin.de (Postfix) with ESMTPA id 2F75F80098;
        Tue, 25 Oct 2022 11:32:58 +0000 (UTC)
MIME-Version: 1.0
Date:   Tue, 25 Oct 2022 13:32:58 +0200
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
Subject: Re: [PATCH v4 5/6] arm64: dts: mt7622: drop r_smpl property from mmc
 node
In-Reply-To: <2bc75b20-9469-e7e3-24e3-cc80ab9b8a8e@collabora.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-6-linux@fw-web.de>
 <2bc75b20-9469-e7e3-24e3-cc80ab9b8a8e@collabora.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <842341a170221d072b188e1e919865c8@fw-web.de>
X-Sender: linux@fw-web.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Mail-ID: b3f94e45-d4d2-47a5-9be4-8caefd74f635
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
> Fixes tag please.

as 2 boards were touched (i guess r64 was copy from rfb), i have 2 
commits found
adding this property.

Fixes: 2c002a3049f7 ("arm64: dts: mt7622: add mmc related device nodes")
Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")

regards Frank
