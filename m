Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22CD6131F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJaIuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiJaIuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D11DD105;
        Mon, 31 Oct 2022 01:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABA1B6103F;
        Mon, 31 Oct 2022 08:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D52C433C1;
        Mon, 31 Oct 2022 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667206202;
        bh=C2hKUZCNbqyF/PcLDufnR6wqPlEIol7+q42sLgDlNIc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrIS4HsaFHRj8UIGblGeCBIhQOBmUegwVkuMFSO9TdZ44BP1oRftqoz/tjBvXrFPJ
         iRQI8PhMEFvhH0DG96Vt92Pt+QJ93WpxrCoxMFbPh/bzkpDZw+VFW/K6/6mia4pWqF
         kJVWfX0YtOe/s/a/uAB4oYMztQo2I2xrx9zloVEefJlHqGfvrTG0zerUAumXTgtTi2
         tZ9eJH8D4gY31YNmQdFrdaDQs9oWNxkZ7D2pQgUgQW8ZhwlYKfmFsia9RVYZuA4jip
         Q3A6PWc7TgDyEuLrlcjq+lNQNuG/YA/mUlqGNWm3SOyJ3HlcKKIIXQ/dE/ee93fEUb
         lAnNMFeBMYOrg==
Date:   Mon, 31 Oct 2022 08:49:56 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chris Zhong <zyw@rock-chips.com>,
        Zhang Qing <zhangqing@rock-chips.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: mfd: Expect specific type for
 monitored-battery
Message-ID: <Y1+MNL+fCfreAqMh@google.com>
References: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028231309.565451-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Oct 2022, Krzysztof Kozlowski wrote:

> Core schema does not define type of monitored-battery, so the schemas
> are expected to reference proper type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/ene-kb930.yaml      | 4 +++-
>  Documentation/devicetree/bindings/mfd/rockchip,rk817.yaml | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
