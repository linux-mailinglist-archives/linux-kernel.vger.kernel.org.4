Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682C370B7F0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjEVIp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjEVIpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:45:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E16DB;
        Mon, 22 May 2023 01:45:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54C1561B57;
        Mon, 22 May 2023 08:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB16C433D2;
        Mon, 22 May 2023 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684745121;
        bh=AMDkX5eWT1bT4M55bmCaK6BJwJkRq6T2cCAN6skPfzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlJxQvjBp4vl2BGp/p278JcbGgtzQh8OF4n26UdAUwq3sW6IePsjD05rkGXotmYJz
         kKSdGTODErH9usfutKOM2bAMOFemp/4eZxXDRCrVyFDQ/b6knURiILODe5p2P601mr
         zAd+RD1MFNfmRILk+1iEezfwqRqTJ6EX+VmKan2nDOSsamOHzUIR0fSYo/Xp/7DnYV
         yMm+91qUejMvxbmc/GTfOwFaQo9YI9RHSRVbeU94jeBLZ+XOJL0fCvThfeSqMQ+ANy
         8gRQE8EMEEoLjaxnofFjvBq8AeRLHg2oZiZoq0PZtGf9ddMLRYzyyGpiMP4Wtgmh44
         StSlgRuON0ALw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q11AP-0004YD-Jp; Mon, 22 May 2023 10:45:21 +0200
Date:   Mon, 22 May 2023 10:45:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] clk: qcom: Add lpass clock controller driver for
 SC8280XP
Message-ID: <ZGsrocJoPne6wn4H@hovoldconsulting.com>
References: <20230518113800.339158-1-srinivas.kandagatla@linaro.org>
 <20230518113800.339158-4-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230518113800.339158-4-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 12:37:58PM +0100, Srinivas Kandagatla wrote:

> +config SC_LPASSCC_8280XP
> +	tristate "SC8280 Low Power Audio Subsystem (LPASS) Clock Controller"
> +	select SC_GCC_8280XP
> +	help
> +	  Support for the LPASS clock controller on SC8280XP devices.
> +	  Say Y if you want to use the LPASS branch clocks of the LPASS clock
> +	  controller to reset the LPASS subsystem.

And please include a defconfig update for this one as a separate patch
in the next revision as it is needed for audio on the X13s.

Johan
