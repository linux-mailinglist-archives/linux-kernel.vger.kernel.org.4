Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F586C77B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 07:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCXGQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 02:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCXGQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 02:16:32 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C721040B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 23:16:30 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32O6Fqf7000597;
        Fri, 24 Mar 2023 01:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679638552;
        bh=JD2IR6ZsDed8ikDETfJm5lFslMUDHpJ9I6SBy6b9m+I=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=h3/7oiSUc2DAO3Yb9kvZwqBlp50cZ+mapUf394M/rC/acDdz9N3zC5bAmbxJcblsQ
         QQVpp3+bARBQ4xLReBM+bh/Zhfq379G3yjEyNHpJZZS+ZAKQWu56CK+aKwP/qHqpbx
         8bV1o+dF9JO0zTsDEXzpRJHyeBLncHv6QjDMeDUM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32O6Fqsd099210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Mar 2023 01:15:52 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 24
 Mar 2023 01:15:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 24 Mar 2023 01:15:51 -0500
Received: from [172.24.145.83] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32O6FlmG000614;
        Fri, 24 Mar 2023 01:15:48 -0500
Message-ID: <96475152-6add-f359-3cfb-d274f296a713@ti.com>
Date:   Fri, 24 Mar 2023 11:45:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [EXTERNAL] Re: [PATCH v2] arm64: defconfig: Enable CAN PHY
 transceiver driver
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <dmitry.baryshkov@linaro.org>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
References: <20230323113324.361991-1-b-kapoor@ti.com>
 <20230323135323.GA309305@hu-bjorande-lv.qualcomm.com>
 <CAMuHMdUF5x=nVMKFFffbbe6S2nGWzq2UZWX36JgyXBGLBVL1rw@mail.gmail.com>
From:   Bhavya Kapoor <b-kapoor@ti.com>
In-Reply-To: <CAMuHMdUF5x=nVMKFFffbbe6S2nGWzq2UZWX36JgyXBGLBVL1rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/03/23 21:39, Geert Uytterhoeven wrote:
> On Thu, Mar 23, 2023 at 2:53 PM Bjorn Andersson
> <quic_bjorande@quicinc.com> wrote:
>> On Thu, Mar 23, 2023 at 05:03:24PM +0530, Bhavya Kapoor wrote:
>>> Enable CAN PHY transceiver driver to be built as a module.
>> Please use the commit message to describe why the driver should be
>> enabled. The patch and the subject already states clearly that the
>> driver is being enabled.
> And if no one has inspiration: I wouldn't mind "because it is needed
> for CAN-FD on the Renesas White-Hawk development board" ;-)

Ahh , i do have the inspiration,lol 😁. I just wanted to keep it 
concise. Lemme send a v3 with necessary details.

Thanks.

>
>>> --- a/arch/arm64/configs/defconfig
>>> +++ b/arch/arm64/configs/defconfig
>>> @@ -1292,6 +1292,7 @@ CONFIG_RESET_QCOM_PDC=m
>>>   CONFIG_RESET_RZG2L_USBPHY_CTRL=y
>>>   CONFIG_RESET_TI_SCI=y
>>>   CONFIG_PHY_XGENE=y
>>> +CONFIG_PHY_CAN_TRANSCEIVER=m
>>>   CONFIG_PHY_SUN4I_USB=y
>>>   CONFIG_PHY_CADENCE_TORRENT=m
>>>   CONFIG_PHY_CADENCE_SIERRA=m
> For the actual change:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                          Geert
>
