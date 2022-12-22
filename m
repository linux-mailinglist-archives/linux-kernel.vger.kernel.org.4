Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E7E6544BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbiLVQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLVQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:00:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4EE3AC;
        Thu, 22 Dec 2022 08:00:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF4A161C28;
        Thu, 22 Dec 2022 16:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C28C433F1;
        Thu, 22 Dec 2022 16:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671724841;
        bh=4PZEhtB+HsEMWZwH6hbUPCcu8L5AHH6AdX/rHB1wVx4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=X94iq2o+ImJJ2csjubHv2gRJ84HqxcfWtZYhbAFGE0rlPT1sL1IKCgiQ6R7AcR6TA
         kf8Gj+HhTqPRfqca3W9M5GaGJUEjIonQqE2rRLFQx1CubS3w03ZWkCpvS7nYxA5Rjn
         ksi/V56P02RnbL6kanIQH8b0hrPS81XdToisufWkmoajve2XVGSapqJa8OhdmDSfVy
         itxs6Cd74hcQJrgaMu/UGP8HBLCji3unE3ucMDirPxubDi4m3XUDiUvWTYSQdHFGhX
         fTQ3YVCiegq8sPkcBygqzxXHly6EtWBmK5HZcFAehpaQGJK+en+H+eb1cUl6NpllH/
         357mwXu+KjneA==
Message-ID: <5d21758f-4e1a-9041-b94d-1352c6a6c8a6@kernel.org>
Date:   Thu, 22 Dec 2022 17:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 6/7] ARM: dts: stm32: add ETZPC as a system bus for
 STM32MP15x boards
Content-Language: en-US
To:     Gatien CHEVALLIER <gatien.chevallier@foss.st.com>,
        alexandre.torgue@foss.st.com, robh+dt@kernel.org,
        Oleksii_Moisieiev@epam.com, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        loic.pallardy@st.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, arnd@arndb.de
References: <20221221173055.11719-1-gatien.chevallier@foss.st.com>
 <20221221173055.11719-7-gatien.chevallier@foss.st.com>
 <2e7c901c-e322-ded6-b170-6d2436d74c0f@kernel.org>
 <0bff5b2d-2837-57cb-5434-58158acc1483@foss.st.com>
 <041b77e0-40c5-e724-e5d9-f1da64d5e684@kernel.org>
 <18d0eca0-838e-92c3-4188-d8dcf480ef6e@foss.st.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <18d0eca0-838e-92c3-4188-d8dcf480ef6e@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2022 16:57, Gatien CHEVALLIER wrote:
> Result after patch is:
> 
> etzpc: etzpc@5c007000 {
> 	compatible = "st,stm32mp15-sys-bus";
> 	reg = <0x5c007000 0x400>;
> 	#address-cells = <1>;
> 	#size-cells = <1>;
> 	feature-domain-controller;
> 	#feature-domain-cells = <2>;
> 	ranges;
> 
> 	timers2: timer@40000000 {
> (...)
> 
> Or do I misunderstand you comment?


Ah, you're right. I missed that it's line removal. Sorry for confusion.

Best regards,
Krzysztof

