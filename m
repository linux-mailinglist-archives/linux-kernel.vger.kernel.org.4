Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4236965968C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbiL3JIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:08:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72FDF1;
        Fri, 30 Dec 2022 01:08:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2BCF7B81B8E;
        Fri, 30 Dec 2022 09:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD2FC433F0;
        Fri, 30 Dec 2022 09:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672391305;
        bh=OyOL3jvK8XMXQa3fSSzTplR8AvGV2xbJAMhfDGO8o6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aXyRCmeqDu0niQMK9f4SM73rNmTJ6VCbHA2Ks6+1IKjBU8v0G+W0GkS8AHXrgUqQ/
         3wlHiBe7ywTis6dYjg0v/NyffHxcjaMqReQmIoZYi8mO+gBh3tZA31Mt64f2WGAQ8p
         xD77G4STdvFqzId+6Qu+JR6yF5OXH2TP4+sS/M8NWdKA7zltmRMOOfhznXgkT9ZO47
         uXClPfhCuq8XdSne5NYdtAP5je6EmGq6ZvtJzmOVBq//TxiMQkuJspFQO5U8IEYV7Y
         ykZJV0os0nGiGOIet4R+oDyzzO0TVvwr2Qmm1YwRV1euui6wcIZPc7fEpP4VuX3EE4
         yNYveMrLFN/vg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pBBNR-0002ik-19; Fri, 30 Dec 2022 10:08:33 +0100
Date:   Fri, 30 Dec 2022 10:08:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: Add RTC support
Message-ID: <Y66qkR+WWkopNzQ4@hovoldconsulting.com>
References: <20221230085010.717423-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230085010.717423-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Fri, Dec 30, 2022 at 10:50:10AM +0200, Abel Vesa wrote:
> The PMK8350 PMIC has an available RTC block. Describe it in
> sc8280xp-pmics dtsi and enable it in Lenovo Thinkpad X13s specific dts.
> Mark it as wakeup-source to allow waking the system from sleep.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

I'm currently working on proper RTC support which implies reading and
storing the time offset from EFI.

This patch in itself is pretty much useless as the returned time is just
some random time from the epoch (e.g. in the 1970's).

So I suggest waiting another week or so until I'm done.

Johan
