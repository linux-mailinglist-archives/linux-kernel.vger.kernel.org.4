Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF86DA015
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbjDFSmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjDFSmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF096A47;
        Thu,  6 Apr 2023 11:42:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A083464B01;
        Thu,  6 Apr 2023 18:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14C4C433EF;
        Thu,  6 Apr 2023 18:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680806536;
        bh=TYg6LIY1PZ5kQT6OISGeT6SEjX/2L5Unzfeoc5UztMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWeRrnzu3MAhOJg1LJp9tu1KcIN5zs5XUHT3O81/od3FX16fu7AAE3miXeUYufjiP
         nEtirGd+fwAVe/uYE1sMg+izdpuQQbl2FvJK5324yyjzWvHl6Ji30/blxzchY5745J
         O9X7DO1a84rIXgakz8tUcd5T4CCzgqSgrh1APZnKZPAMAYAaxpQeQFKgRtRUkfsKoQ
         x8cWD7Sxf17iT+5mg6ofT3cor+xBso0RgCe0fnpdbQOrwbyTXDSOyQiGtN+4E4Z4OO
         X5g3XBooU/PoWaA8p3g3n/w1b7m3XyieyQ9LiEuhiAUK1dB5KBVOmawppIT+iYKYEP
         7EjuyD0oTMR4g==
Date:   Thu, 6 Apr 2023 11:45:06 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Varadarajan Narayanan <quic_varada@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_wcheng@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 4/8] clk: qcom: gcc-ipq9574: Add USB related clocks
Message-ID: <20230406184506.65d2gjycuvrley6f@ripper>
References: <cover.1677749625.git.quic_varada@quicinc.com>
 <cover.1679388632.git.quic_varada@quicinc.com>
 <24293be77ccdcf5e9b1fa0fd219de6152f234616.1679388632.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24293be77ccdcf5e9b1fa0fd219de6152f234616.1679388632.git.quic_varada@quicinc.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:24:22PM +0530, Varadarajan Narayanan wrote:
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
[..]
> diff --git a/include/dt-bindings/clock/qcom,ipq9574-gcc.h b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> index c89e96d..96b7c0b 100644
> --- a/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> +++ b/include/dt-bindings/clock/qcom,ipq9574-gcc.h
> @@ -214,4 +214,6 @@
>  #define GCC_SNOC_PCIE1_1LANE_S_CLK			205
>  #define GCC_SNOC_PCIE2_2LANE_S_CLK			206
>  #define GCC_SNOC_PCIE3_2LANE_S_CLK			207
> +#define GCC_USB0_PIPE_CLK				208
> +#define GCC_USB0_SLEEP_CLK				209

Please split out the dt binding/include change in a separate patch, to
better facilitate picking both the clock and dts patch for the same
kernel version.

Thanks,
Bjorn
