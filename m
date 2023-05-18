Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FFC70849E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjERPGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjERPEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:04:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DAC1;
        Thu, 18 May 2023 08:04:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFA6F64FF7;
        Thu, 18 May 2023 15:04:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6832C433EF;
        Thu, 18 May 2023 15:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684422245;
        bh=9coiIoDSLt6aq3KVeKbA2q4XvvilbXfwH2OTRGzvFiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=edVxBLEcTirKho7l5YrVS4cJykVwJHI4p5TW0tqs5jg65xJWkyzsqwITK81cyO3IQ
         zJVa/OTHRr6gDVapFd8KaLRsUBNZj3+VEyT5a/WTRrHBJ10axHqVwG8XpykyAgu6Km
         NESfKOtBofL4SfKk+1LsJloBkxMR1+0LQpDDa45UhFGDxHzdoEPNYL0MnhQ+QsHHnJ
         4NoO2vWMCoSEXh/cG2mS98lviHis1tzdjhMMBlbxl+VW2GIlSaGHR46tXBoQ6VHfCX
         d9jmZ5e4JX7Rpc52epuEcj1gKe+jtdL9ZW5sTT8DPTJegoJqcVWCTfjMwtVBIqSuJr
         er1Q+9nsOg8tg==
Date:   Thu, 18 May 2023 16:04:00 +0100
From:   Lee Jones <lee@kernel.org>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mfd: axp20x: Add support for AXP192
Message-ID: <20230518150400.GL404509@google.com>
References: <20230511092609.76183-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511092609.76183-1-aidanmacdonald.0x0@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023, Aidan MacDonald wrote:

> The AXP192 PMIC is similar to the AXP202/AXP209, but with different
> regulators, additional GPIOs, and a different IRQ register layout.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> v1->v2: No changes
>         https://lore.kernel.org/all/20230510151542.312588-1-aidanmacdonald.0x0@gmail.com
> 
>  drivers/mfd/axp20x-i2c.c   |   2 +
>  drivers/mfd/axp20x.c       | 141 +++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/axp20x.h |  84 ++++++++++++++++++++++
>  3 files changed, 227 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
