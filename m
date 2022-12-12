Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD5649F4D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbiLLNBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiLLNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:00:32 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5112D3F;
        Mon, 12 Dec 2022 04:59:47 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 985018539F;
        Mon, 12 Dec 2022 13:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1670849984;
        bh=VE3imvG7deG0JUgjoXPnooJn1vL7bSWBEABq2i2i02M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m0klc4rDE9mJ8SwWDc3g7AO6u3KRKoUDk1OlCwmIJGBMeKaHkSJbfrR12wSJWHt8F
         +7QlnLnzp6G6SqKY/mE1mn2+GsavgrXKrXH2CsNh06KUVMEbPRxLo/rV5dXK+Ygztu
         Kwr+cHNWJuvkekL9q5YUIdKrU/Xo7iibIABG66j7n/wKlNwkfF8wQ1MtqGmikj1N0Z
         ZyfkmEqMgTSN6BXaO1othCKYv0Qs5df02GMYu8asrT3OYFX3eWSE+lhTA15i6Gyzt9
         vCBgUTcPUVPp4vO01/6pFtKQt3Cv4FypyZyIb005dxduOJ/zGDfC9BiKNlUwDze5AB
         TBDJZOAjuL7Lg==
Message-ID: <11bcaf2e-864b-0f86-645e-5a1a619865a6@denx.de>
Date:   Mon, 12 Dec 2022 13:59:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 0/4] Fix qspi pinctrl phandle for stm3mp15 based boards
Content-Language: en-US
To:     patrice.chotard@foss.st.com, robh+dt@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alexandre.torgue@foss.st.com
Cc:     mcoquelin.stm32@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/22 09:51, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> qspi_bk1_pins_a and qspi_bk2_pins_a pinctrl phandle has been splitted in
> 2 parts. Only stm32mp157c-ev1.dts has been updated properly.
> 
> Fix qspi pinctrl phandle for other boards which are based on stm32mp15x SoC.

Typo in $SUBJECT, s@stm3mp@stm32mp@ . That's in all the patches.
