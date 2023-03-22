Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4E06C4088
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 03:52:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCVCwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 22:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCVCwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 22:52:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5681A4BEA8;
        Tue, 21 Mar 2023 19:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC78761E10;
        Wed, 22 Mar 2023 02:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFA1C433D2;
        Wed, 22 Mar 2023 02:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679453526;
        bh=Izwao8nr3IGO8OyqNDeMr7/hC8B2ahj8Sv6MkEDqtz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t3n2vwfmSa9C1uQ5pIG5Hh2iEnuCQMcW5v9YdyANAzp6TwHRvV2bG27kI3U05I9na
         pG0qFEpw1fUUeVhmueIpvcIHmOHorpaaEY4I+xDXD7ayNHBnHOhAU7FT+qg7gIPqdg
         ZEkYrE/pCuf0vR38toqyyQowseArfC+3lXUb5ytFYmETs5xPyv5IEkeMPC4hjmeGbe
         Y1zcxFBbFrOKhnbrGqO/zgrPnvhUEjfU6K3APQ3/VtCn5n+2L1GVwKCKbLXPZPga1v
         d1q9Z+gZRnYH62L9InHP9DrE3zQSv0bMxHLB8E1/EpU0O32zM9qWtctyxeY5Da2qVQ
         VjGuQCK7jJEPA==
Date:   Tue, 21 Mar 2023 19:55:19 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8775p: add symbols to dtb
Message-ID: <20230322025519.a5vrqljezo74qxwi@ripper>
References: <20230309233945.1199358-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309233945.1199358-1-echanude@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 06:39:48PM -0500, Eric Chanudet wrote:
> ABL uses the __symbols__ section to process the DTB before passing it
> forward. Without it, the bootstrap is interrupted.
> 

If the reason is that ABL refuses to boot without it, then please have
ABL fixed. If on the other hand there is a valid reason for ABL to
require the dtb to have __symbols__ defined, please describe that - if
nothing else so that others know when this is supposed to be used.

Thanks,
Bjorn

> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
> Depends on initial sa8775p-ride.dts:
> https://lore.kernel.org/all/20230214092713.211054-3-brgl@bgdev.pl/
> 
>  arch/arm64/boot/dts/qcom/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index b63cd1861e68..72e85ab31d74 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> +
> +# Enable support for device-tree overlays required on sa8775p-ride.
> +DTC_FLAGS_sa8775p-ride := -@
> +
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
> -- 
> 2.39.1
> 
