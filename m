Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8F6690C46
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjBIO5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjBIO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:57:01 -0500
X-Greylist: delayed 27665 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Feb 2023 06:56:58 PST
Received: from out-63.mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086F3EFAB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:56:57 -0800 (PST)
Date:   Thu, 9 Feb 2023 15:56:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
        t=1675954615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7pQICwV9BQwh0rqup+XjsiIjDhBDv4jvmO4frgTOT8w=;
        b=c58lg+63q4bbXysaBaqmipgYlFzuAHV1ucjwoMv2dNxMtO1TEBtlDAJE2DWALUgq46AcHo
        qmzzS74d7ZmXVTvjG9qeM+kNiyuCo2OD0jH0ZkZQKoL7k4Tm41m2LVrXLMQzGCSDi8rfc5
        cAxO6fs71HJA6LaAIG8BJ7+at01DmxQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Henrik Grimler <henrik@grimler.se>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, m.szyprowski@samsung.com,
        jenneron@protonmail.com, markuss.broks@gmail.com,
        martin.juecker@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 1/2] ARM: dts: exynos: drop mshc aliases
Message-ID: <Y+UJtZ2fpk+TSwqU@L14.lan>
References: <20230128133151.29471-1-henrik@grimler.se>
 <20230128133151.29471-2-henrik@grimler.se>
 <29d63a50-bdfe-ef50-c173-cb9e37923758@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29d63a50-bdfe-ef50-c173-cb9e37923758@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for reviewing!

On Thu, Feb 09, 2023 at 03:39:37PM +0100, Krzysztof Kozlowski wrote:
> On 28/01/2023 14:31, Henrik Grimler wrote:
> > They are no longer needed after commit a13e8ef6008d ("mmc: dw_mmc:
> > exynos: use common_caps").
> > 
> 
> Are you sure? That commit explicitly says that the caps should be set
> from DT and Exynos DT does not set it everywhere...
> 
> plus if alias is missing, then the ctrl_id in dw_mmc.c is 0 and such
> caps are applied everywhere - to every DWMMC device.

Yeah, you are right, David pointed this out in the ARM64 patchset [1]
as well, so I will look it over again and send new versions (when
discussion on this version is finalised).

> Best regards,
> Krzysztof

[1] https://patchwork.kernel.org/project/linux-samsung-soc/patch/20230203204000.14410-2-henrik@grimler.se/#25197132

Best regards,
Henrik Grimler
