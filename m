Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975346C8DA0
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjCYLwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCYLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:52:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8E2CA0C;
        Sat, 25 Mar 2023 04:52:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4B7860C3D;
        Sat, 25 Mar 2023 11:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E77C433EF;
        Sat, 25 Mar 2023 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679745136;
        bh=S81O2f+uuTmPTwheCDEyFysXHkEUR3+b1qgwrMEBup0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IBYsba9Jyohl3v3hp+AEXp1EQUKY2GwfXLyl5PGKVRIPu4L44xbzNe7B5YT9p/UBD
         kEgiOXQiikTN8ur7MS71R/V1P9JcYTMc3KpNRRU3wi0tDUPj5X1VG9yIbGvyha15Zb
         0HPnT2s6a2KBgAMMvt74cLaKOqlHk7RMIg9aSR9dEwbu4bupwEIjHMpQ67KxMKHEfh
         smLCsNP8nttxHMdi2u0kJiyma9N6Jd/+8uS+CI9mS8i29itoXO/1P62/k982V1POQD
         n91in6GS40x5LyYb8i80lhVy00zmydqCvSM6Yx40REXVTLszTnhGbG9Az5DkGdDF/K
         E6+wXhNfSoXcQ==
Message-ID: <b2fce18f-62e7-a374-2300-02ff2ae9935b@kernel.org>
Date:   Sat, 25 Mar 2023 12:52:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/4] dt-bindings: Add doc for FriendlyARM NanoPi R2C
Content-Language: en-US
To:     Tianling Shen <cnsztl@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>, Peter Geis <pgwipeout@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Chris Morgan <macromorgan@hotmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Vincent Legoll <vincent.legoll@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230325074022.9818-1-cnsztl@gmail.com>
 <20230325074022.9818-2-cnsztl@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230325074022.9818-2-cnsztl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2023 08:40, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R2C.
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +


Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

