Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C268F40E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjBHRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjBHRLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:11:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2B6C646;
        Wed,  8 Feb 2023 09:11:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A49E61707;
        Wed,  8 Feb 2023 17:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B848FC433EF;
        Wed,  8 Feb 2023 17:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675876310;
        bh=WpNdRqN8boUK96ynhlnTfxBli2Z0Znp3NmR7U3aHWQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mB5lAPvff8UpYMfbktih6H/JFc4oY+0gkkNhFDN36fBKupEXYRhT7/p6v89nXYMco
         932db9K7qorWaK6+gAyg7QsXw7uskXVt43g/v998NjdVYR8252PbDhv2BjmpkogQPV
         GjwffqKXJW54bItpzrgajlUVKTEaC3/gsRlbXl9jQ/1DtaICdGY4KYgx8s7MQwGzq8
         z/kx3eJYiPi8S7AjCqy/sf3YoJff2tJlHNAMf/siyaOonOCFLUzxBKlU66fenCl0yJ
         ts04MAjNXIr9carBooAK9We2+IgzJFj3QPoTk6LP99WwOFwnvkkPshkByLC06DCv24
         QGsWXuiceJZGg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPnze-00067m-JZ; Wed, 08 Feb 2023 18:12:27 +0100
Date:   Wed, 8 Feb 2023 18:12:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] phy: qcom-qmp-combo: Add support for SM8550
Message-ID: <Y+PX+vluLtye4Zmy@hovoldconsulting.com>
References: <20230207114024.944314-1-abel.vesa@linaro.org>
 <20230207114024.944314-7-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230207114024.944314-7-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 01:40:24PM +0200, Abel Vesa wrote:
> Add SM8550 specific register layout and table configs.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v4 version of this patch was here:
> https://lore.kernel.org/all/20230202132511.3983095-7-abel.vesa@linaro.org/
> 
> Changes since v4:
>  * rebased on next-20230206 which includes Luca's SM6350 phy patches,
>    like Johan suggested
>  * added missing usage of com_resetm_ctrl_reg, com_c_ready_status_reg
>    and dp_phy_status_reg
>  * dropped the .dp_tx0 and .dp_tx1 for v5 offsets changes

Looks good to me now.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
