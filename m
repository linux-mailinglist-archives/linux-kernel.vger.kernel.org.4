Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087BA63258A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 15:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiKUOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 09:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiKUOWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:22:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE031121;
        Mon, 21 Nov 2022 06:22:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B1DA6126C;
        Mon, 21 Nov 2022 14:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A0AC433C1;
        Mon, 21 Nov 2022 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669040555;
        bh=7FCnuULVVR720/Z8cmKwHyUcR9KpvBB36hU267VS2Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BoCuh3MxQmdnGuhI+b/zF5e6f2AWwukQApG2V1cr+T0DZiAvK+7+F2rmGKdHSNDz7
         LU73Sqd0CnM9bEhIWRzUAeAR5Pz01Ez7YvOQFB0eCriT12kvA7fBeBA6AHijzivox6
         ESRc9E2DmePd90L4GHU6XeBYKLzgjz4GBauTfZE5kq/0T2+i9B8xW2Xi084D0mEwg4
         aBxqULfVGhPtynTDlHN83d7U33LquF6l2dYyNBK0cszIH6hVA6VnVgHY/0rseV5v30
         tMEG0I7Yp124nf0VqNl70pGhkL7xb8dpazS1kR+eItEtoW8kFsiuU88FiKoS7D2eac
         hbBrUwKBoW1qw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ox7gU-00007K-8S; Mon, 21 Nov 2022 15:22:06 +0100
Date:   Mon, 21 Nov 2022 15:22:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: sc8280xp: add audio support
Message-ID: <Y3uJjo820Ij3aKAr@hovoldconsulting.com>
References: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121130403.161817-1-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 01:04:00PM +0000, Srinivas Kandagatla wrote:
> This patchset adds audio support for sc8280xp Lenovo x13s.
> Support for Headset Playback/Capture, Speaker Playback and DMIC is
> tested.
> 
> A prebuit ASoC topology file available at
> https://git.linaro.org/people/srinivas.kandagatla/audioreach-topology.git/tree/prebuilt/SC8280XP-LENOVO-X13S-tplg.bin
> 
> 
> Thanks to Johan and Kryz for reviewing v2.
> 
> Changes since v2:
> 	- removed lots of stray lines.
> 	- ordered include files.
> 	- moved all the nodes before pinctrl
> 	- fixed subject line to include x13s.
> 	- rebased to latest qcom dts branch.
> 
> Thanks,
> Srini
> 
> Srinivas Kandagatla (3):
>   arm64: dts: qcom: sc8280xp/sa8540p: add gpr node
>   arm64: dts: qcom: sc8280xp/sa8540p: add SoundWire and LPASS

Only noticed now, but the commit prefix here should just be:

	arm64: dts: qcom: sc8280xp: ...

sa8540p is based on sc8280xp but you don't have to point that out in
every commit (there was one exception where I was also updating the
sa8540p dtsi due to platform differences).

>   arm64: dts: qcom: sc8280xp-x13s: Add soundcard support
> 
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    | 213 +++++++++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 359 ++++++++++++++++++
>  2 files changed, 572 insertions(+)

Johan
