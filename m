Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C49F6780A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbjAWP65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:58:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWP64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:58:56 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237B40FC;
        Mon, 23 Jan 2023 07:58:55 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 1421E8559D;
        Mon, 23 Jan 2023 16:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674489534;
        bh=fNFR+fJDgXwcN3vLbyUFRJIRCgrPvqcQIkvyKdUmwg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TMRpMBGEjnVjuESy/SalYJUHYbYl+FTkjCC5iag3nBqm/txxy85Vx67oDKvX3YDra
         HYM5xCVzFUBkbeBVB9ljTrcZICc5tUyLMpw+BBGyvPjfTnGIrMV4OhCpIaW8bbAHc4
         k/f6/L2Mm9WYKYlJYwm/nl/jEMvtIEUk/Yu3ANC17+j0kd4QlsqVIY2HY0wpaUVH9L
         tApj0Jj6wmKf7hG6o0JAg17XA7b0bNmm4l1erDhByGU/aBcfu2vVMh05YvYe41N0/W
         Q+t2xsCR38Q2fohE0UDTIa6I7cYibFVerWPGsVBoQ7mrQTUH3zHzguhyT793jtKfvZ
         omdWJWMECtDtA==
Message-ID: <1d935d49-495f-bce4-d74b-305da7032721@denx.de>
Date:   Mon, 23 Jan 2023 16:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arm64: dts: imx8mm: Fix pad control for UART1_DTE_RX
Content-Language: en-US
To:     Pierluigi Passaro <pierluigi.p@variscite.com>,
        Fabio Estevam <festevam@gmail.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>
References: <20230115213503.26366-1-pierluigi.p@variscite.com>
 <CAOMZO5APGzugbBZf0uAaF3vB61KuWDtAU9OHXVM5p8U8yipuXg@mail.gmail.com>
 <AM6PR08MB4376C1F6E729E9608B472801FFCA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <AM6PR08MB4376C1F6E729E9608B472801FFCA9@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/23 01:37, Pierluigi Passaro wrote:
> On Mon, Jan 16, 2023 at 8:26 PM Fabio Estevam <festevam@gmail.com> wrote:
>> On Sun, Jan 15, 2023 at 6:35 PM Pierluigi Passaro
>> <pierluigi.p@variscite.com> wrote:
>>>
>>> According section
>>>      8.2.5.313 Select Input Register (IOMUXC_UART1_RXD_SELECT_INPUT)
>>> of
>>>      i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
>>> the required setting for this specific pin configuration is "1"
>>>
>>> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
>>
>> Fixes: c1c9d41319c3 ("dt-bindings: imx: Add pinctrl binding doc for imx8mm")
>>
>> Reviewed-by: Fabio Estevam <festevam@gmail.com>
>>
> Thanks for reviewing.
> Is there any further action required on my side ?

Wait for Shawn to review/pick the patch , that's all.
