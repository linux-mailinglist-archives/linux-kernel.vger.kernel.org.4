Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D006F43FC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 14:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbjEBMlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 08:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjEBMlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 08:41:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716AD5FCF;
        Tue,  2 May 2023 05:41:04 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.34.213])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E9F176602097;
        Tue,  2 May 2023 13:41:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1683031262;
        bh=vtHnxY272gQwR2K0KA+cTon5g8aYzAZdrp1RngJdcho=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cVtJsCmdOoOTm7lnqIuMh2nrCUg1wTMHZANmImuHoowaNyVNUalEr27bcL85TTa+n
         B55FZs0JXLz9GitigKjpVjcKCGcPf0K/5p4YF2T/SNRRCDs8IQmQoSIycMZkqEdhfH
         V97lumjyf7V20qnVwHd/HB2Kcye34CDMwoNLtJQjXxI+Cm/1EQIZHiCsavNvurx1jV
         OdoVf/nXvSOZvzhDhsFQhlZrtoI5V4EcoaYmHVrJMq0Q5ys62aMohpFMCRwNOQYWUa
         cVERs7ISDhG3A36yEwc7aobswW3Fd+ZqSTuEw1EXgpRUFHID2I8bPpzlAZRzfL8UQh
         oRJmYVHsYRSCg==
Message-ID: <b4b43db4-d2c7-9296-5272-cdac942856ae@collabora.com>
Date:   Tue, 2 May 2023 15:40:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/8] Add RK3588 OTP memory support
Content-Language: en-US
To:     Vincent Legoll <vincent.legoll@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230501084401.765169-1-cristian.ciocaltea@collabora.com>
 <CAEwRq=pKBWsiE1EVf8+k2tZeeEqBpZFgJPCnSN2M005ajbpdmA@mail.gmail.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <CAEwRq=pKBWsiE1EVf8+k2tZeeEqBpZFgJPCnSN2M005ajbpdmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/23 11:26, Vincent Legoll wrote:
> Hello,
> 
> On Mon, May 1, 2023 at 8:44 AM Cristian Ciocaltea
> <cristian.ciocaltea@collabora.com> wrote:
>> This patch series adds OTP memory support for Rockchip RK3588 SoC,
>> while also providing a few improvements to the existing rockchip-otp
>> driver, in addition to converting the bindings to dt-schema.
> 
> I tested this on a QuartzPro64 dev board, I applied your series top of my tree:
> Collabora's rk3588-v6.3 + some DT patches to add support for the qp64 board.
> 
> Here is the output from the commands you told me to try:
> 
> # ls -1 /sys/bus/nvmem/devices/*/nvmem
> /sys/bus/nvmem/devices/rockchip-otp0/nvmem
> 
> #  od -N 64 -A x -t x1z -v /sys/bus/nvmem/devices/rockchip-otp0/nvmem
> 000000 52 4b 35 88 91 fe 21 41 5a 43 39 36 00 00 00 00  >RK5...!AZC96....<
> 000010 00 00 00 00 0f 0b 0d 0a 0a 0c 25 0e 00 00 00 00  >..........%.....<
> 000020 00 00 00 00 00 00 00 00 08 0c 00 00 00 00 00 00  >................<
> 000030 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  >................<
> 000040
> 
> This is working as expected.
> 
> You can add my T-B, for the whole series:
> 
> Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Thanks for testing!

Regards,
Cristian
