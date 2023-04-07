Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009A16DAE8B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjDGOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjDGOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 10:06:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E485597;
        Fri,  7 Apr 2023 07:06:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9AC36518A;
        Fri,  7 Apr 2023 14:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8C0C433EF;
        Fri,  7 Apr 2023 14:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680876400;
        bh=wqeuVoAaNoYpVt6qlVjSjBoOo8adJxZIFyzl3Ygp30Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQQoQfKiS2I8tLhHvEGWTdYr/OVkmf54uxnEeEvnZEdHUF61+hcDHdwS750H2B4jX
         IDdJTU67PijQcbxfG63agdHWy2RDTPf3pI6aUTHNgINiPIlgPZ9nqKfhR5V3tleplP
         McxqX0pSzmoD8cfjZALOyvPj+3a78mgFEV2euA/90jkQuk/xJRYiHS1UtNu/LVchP1
         CrvMnXJfEs38LGvIrE0Nssb9pk1HZsWkkW6rdiR4eHx2z/uUmLCJMFaeSOphxaXBWc
         P97Aae/rNi2nhRo/Xu2tVuGnreikZUhKicbjA+KFC7ryPpahERiFhKBccgN30yihkG
         eTqfIr7raikWA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pkmjd-006irx-Et;
        Fri, 07 Apr 2023 15:06:37 +0100
MIME-Version: 1.0
Date:   Fri, 07 Apr 2023 15:06:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de,
        marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org,
        geert+renesas@glider.be, rafal@milecki.pl, nfraprado@collabora.com,
        broonie@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com,
        quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com, quic_poovendh@quicinc.com
Subject: Re: [PATCH V11 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
In-Reply-To: <c74b40fe-92b9-9a53-1a9f-b19a7090a12c@quicinc.com>
References: <20230404101622.5394-1-quic_devipriy@quicinc.com>
 <20230404101622.5394-4-quic_devipriy@quicinc.com>
 <d410c51ee4beeb4dfee80e13d54d598b@kernel.org>
 <c74b40fe-92b9-9a53-1a9f-b19a7090a12c@quicinc.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4755f212ee8e12139cb11162c3fa2e11@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: quic_devipriy@quicinc.com, agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de, shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com, dmitry.baryshkov@linaro.org, geert+renesas@glider.be, rafal@milecki.pl, nfraprado@collabora.com, broonie@kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, quic_srichara@quicinc.com, quic_gokulsri@quicinc.com, quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com, quic_anusha@quicinc.com, quic_poovendh@quicinc.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-07 11:21, Devi Priya wrote:
> On 4/4/2023 4:33 PM, Marc Zyngier wrote:
>> On 2023-04-04 11:16, Devi Priya wrote:
>>> +            #address-cells = <1>;
>>> +            #size-cells = <1>;
>>> +            interrupt-controller;
>>> +            #interrupt-cells = <3>;
>>> +            interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> 
>> Missing target CPU encoding.
> Okay, will update the interrupts as below. Hope this is the 
> expectation?
> Please let us know if we are missing something
> interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | 
> IRQ_TYPE_LEVEL_HIGH)>;

Yup.

         M.
-- 
Jazz is not dead. It just smells funny...
