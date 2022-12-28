Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB26657272
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL1ED3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiL1EDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:03:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79D1D13B;
        Tue, 27 Dec 2022 20:03:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81FB2B81205;
        Wed, 28 Dec 2022 04:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45C7C433EF;
        Wed, 28 Dec 2022 04:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672200200;
        bh=8ZRP2tXKd0dMQ760LBzjUQzvT6qVBWagB9uvUEDeto0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oSUkn4On7DpXQPoXnWoWfTf+wNL9Go/NRBcSN3uyl54OzRYXkrG/X9GYKHSU/NeL4
         /qJmERzXg8XW3ZRlMD+I42RqQqIFc20GurrlJyaEp4CNQN8ghtBvF9/yeVbXpKm9RG
         yIrUTLf1defvgVukP4DT03diQMDydIdR5Xu95wBrv20Fs/XOvHgcVzxeHyI2J0o+M3
         VAL9iJjpB7smmgU8U7672BMaOYhZ5/L6d+EY/DjbFvSY2SHGCMHnuE8VNLOA0rN/l9
         RefqUrU4JAi22MVhxDR0tsNnjnTJYKzqKhwtw8kEi+oZTPBI+nTmJGN80V4VcFnw6e
         DAk2rEzrRn82Q==
Date:   Tue, 27 Dec 2022 22:03:17 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sdm845: drop 0x from unit address
Message-ID: <20221228040317.wmfjq2il5q4uzdtx@builder.lan>
References: <20221210113340.63833-1-krzysztof.kozlowski@linaro.org>
 <5d21408f-cc99-35f3-c4ce-b13f02c1c1f3@linaro.org>
 <f260fd4e-a25b-6ae5-0952-63f68b5330fc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f260fd4e-a25b-6ae5-0952-63f68b5330fc@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2022 at 09:15:36PM +0100, Krzysztof Kozlowski wrote:
> On 10/12/2022 13:26, Konrad Dybcio wrote:
> > 
> > 
> > On 10.12.2022 12:33, Krzysztof Kozlowski wrote:
> >> By coding style, unit address should not start with 0x.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> > We somehow keep running into solving the same style issues :P
> > 
> > https://lore.kernel.org/lkml/20220930191049.123256-8-konrad.dybcio@somainline.org/
> > 
> 
> Eh, this should have been just applied long time ago...
> 

That's patch 7 in a series, which I would be expecting to see respun
per your request for changes.


@Konrad, please put fixes like that first in your series - or just send
them separate from the series.

Regards,
Bjorn
