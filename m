Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010A46E78B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjDSLh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231935AbjDSLhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:37:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A796649F1;
        Wed, 19 Apr 2023 04:37:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D60D63D66;
        Wed, 19 Apr 2023 11:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EB1C433EF;
        Wed, 19 Apr 2023 11:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681904237;
        bh=Wpdj7G4cWFIHbyiPcbEdRIFvJJamrB2n3W+jlljl9/0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WU+pUPIUxpZ0CnAKU7/nPI0ad/TR7YcvhLELr+VtCfx7qePq/3WFaaKX1ykVRTQeJ
         jwWW7c9aSKdb6pmUGci1Fz6/owgqRUauX0RgPGQJcMY5NtejJECvZJA4l2Uf/YoeiD
         r+ZntSvZLHDs4q9zZiqHFTenh1A4gKxodpGACffJoEGufnGOMhvMoT757NvkDkWvys
         EcqT/yC739YqHmU8KFYJbmdtk3Nrfxt62k9hK+e5vzG58E1DrRa+w1n1/uqnFRzVnk
         X4yTJUZVq+/IQaOtUayayigzF+zmBlKnivtE5TNW4s1tS3otey4LE3rvfE9HGRPXqL
         nKiLsj6cS0lJw==
Message-ID: <3026af3a-63ce-5f70-46a5-376f8845811e@kernel.org>
Date:   Wed, 19 Apr 2023 14:37:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-am62a: Add timers, wdt and fixup
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Tero Kristo <kristo@kernel.org>, Bryan Brattlof <bb@ti.com>
References: <20230418012717.1230882-1-nm@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230418012717.1230882-1-nm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 04:27, Nishanth Menon wrote:
> Hi,
> 
> This is a series that adds wdt, timers to am62ax support, and adds the
> missing description for uart1 and wkup_uart that is used by firmware.
> 
> Nishanth Menon (3):
>   arm64: dts: ti: k3-am62a: Add general purpose timers
>   arm64: dts: ti: k3-am62a: Add watchdog nodes
>   arm64: dts: ti: k3-am62a7-evm: Describe main_uart1 and wkup_uart
> 
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi   | 141 ++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi    |  56 ++++++++
>  arch/arm64/boot/dts/ti/k3-am62a-wakeup.dtsi |  11 ++
>  arch/arm64/boot/dts/ti/k3-am62a7-sk.dts     |  36 +++++
>  4 files changed, 244 insertions(+)
> 

Reviewed-by: Roger Quadros <rogerq@kernel.org>
