Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE0715F467A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJDPTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 11:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiJDPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:19:27 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4D6113C;
        Tue,  4 Oct 2022 08:19:20 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 0556840065;
        Tue,  4 Oct 2022 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1664896757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6izbKtpoHFD6qmOo0fCt+lv7soo5yVhz/PTmUqEE4+0=;
        b=Lyn5udvtRruwFzBdXJfjhj0jTfQQmYWgseFDEP2B9x8hJTrVICH7Q5wvStzXDjLFxv/Qgs
        nDpRzmEXrJ6UW9cZE/uRRMY0FFZxIHn2S2oE6XM3HtkjLhayIAbi9owgbD4PhRJE5+LHlX
        Ygzmz+rLvZwIYocg09UwvTYa5ioP0i0=
Received: from [127.0.0.1] (fttx-pool-157.180.227.240.bambit.de [157.180.227.240])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id C73B040604;
        Tue,  4 Oct 2022 15:19:15 +0000 (UTC)
Date:   Tue, 04 Oct 2022 17:19:11 +0200
From:   Frank Wunderlich <linux@fw-web.de>
To:     Rob Herring <robh@kernel.org>
CC:     linux-rockchip@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: rockchip: add PCIe v3 phy
User-Agent: K-9 Mail for Android
In-Reply-To: <20221004150929.GA1506199-robh@kernel.org>
References: <20220825193836.54262-1-linux@fw-web.de> <20220825193836.54262-2-linux@fw-web.de> <20221004150929.GA1506199-robh@kernel.org>
Message-ID: <EC42D2C8-ACA5-4B6A-BC95-534CBDFC36C8@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mail-ID: b7d83da3-dbaa-494c-a955-e55f0f933e90
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 4=2E Oktober 2022 17:09:29 MESZ schrieb Rob Herring <robh@kernel=2Eorg>:
>On Thu, Aug 25, 2022 at 09:38:32PM +0200, Frank Wunderlich wrote:
>> From: Frank Wunderlich <frank-w@public-files=2Ede>

>> +properties:
>> +  compatible:
>> +    enum:
>> +      - rockchip,rk3568-pcie3-phy
>
>The driver also has 'rockchip,rk3588-pcie3-phy'=2E Please send a fix=20
>adding it here or removing from the driver=2E Are they not compatible wit=
h=20
>each other?

Hi,

Right,
original driver has rk3588 support,but we can't test it=2E Initialization =
and lane-mapping (bifurcation) was bit different=2E So we wanted to upstrea=
m rk3568 first (but have not removed this part from driver)=2E

I see that someone added rk3588 basic support and if he can test rk3588 i =
can send compatible for it=2E


regards Frank
