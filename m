Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5067345E8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 13:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjFRLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRLmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 07:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2B2E5E;
        Sun, 18 Jun 2023 04:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0197A60F6B;
        Sun, 18 Jun 2023 11:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5992EC433C0;
        Sun, 18 Jun 2023 11:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687088520;
        bh=BFmIrutDYG4LB/6zb/Nq9wLMZ8zxH9TishG/byWakZw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nyXluhSZyi5w0ELiAjionCSz2q0Fhr8mg7NxOyVCVHZZJXdVx5o4MujlqZ0mYCPhp
         uM2gXLUbGjewDDyVrJ2tAQUKyLMJ3DRhfsGLZee7v0CtSdnnPGKvBxQuOmmCtfu00S
         mfCQqO6ImWwDP8tGQ2g95k4cfnUYmRTOtf0OZFskNQlkqV5x9L64K67DNWHoHWbQrI
         CzSZWfJbVa1fEJX9tT3ltI450mR1nsaHWwaXAiDeoU77n9y7ut4cqokJw9xWxPrpNd
         +gMW+f6euw7tgL6tHFjklmCL0diW9XhwYxz/0+C97kB8SIojtktp7Z9Pw4ibvmcnvU
         hcR5HfR+C6evQ==
Message-ID: <d0d12af5-4dd6-b153-f1fc-123721bfd929@kernel.org>
Date:   Sun, 18 Jun 2023 20:41:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 5/5] arm64: dts: rockchip: rk3588: add SATA support
Content-Language: en-US
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230612171337.74576-1-sebastian.reichel@collabora.com>
 <20230612171337.74576-6-sebastian.reichel@collabora.com>
 <fa42c1ad-c411-2121-92f7-fc1e1f0f8172@kernel.org> <4844617.31r3eYUQgx@diego>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4844617.31r3eYUQgx@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 17:13, Heiko Stübner wrote:
> Hi Damien,
> 
> Am Sonntag, 18. Juni 2023, 05:10:58 CEST schrieb Damien Le Moal:
>> On 6/13/23 02:13, Sebastian Reichel wrote:
>>> Add all three SATA IP blocks to the RK3588 DT.
>>>
>>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>>
>> This patch does not apply to libata for-6.5 branch. What is it based on ?
> 
> I guess probably either mainline or my dts-branch [0] .
> 
> Most of the time we have series doing driver changes + devicetree changes
> where subsystem maintainers pick the driver + binding patches 
> (1-3 in this case) and after that I pick the devicetree changes (4-5 here).

OK. I will queue 1-3 only then. Please pickup 4 & 5.
Thanks !

> 
> 
> Heiko
> 
> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=v6.5-armsoc/dts64
> 
> 

-- 
Damien Le Moal
Western Digital Research

