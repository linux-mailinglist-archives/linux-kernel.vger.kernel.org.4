Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F686B514A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 21:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbjCJUAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 15:00:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjCJUAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 15:00:43 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F5D125DB7;
        Fri, 10 Mar 2023 12:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F390CCE2ACF;
        Fri, 10 Mar 2023 20:00:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F32C43443;
        Fri, 10 Mar 2023 20:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678478437;
        bh=/fNZAyKGwRLBd4PU5trzXlh+Td7YBsFNDekGxZ2EodI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZ54yihbW2XA0g9yhGySSywEaRLXnE0j6iKQm9DpwkqlRyG776EmdaiK+v39XYRQU
         3jRgLbmYp0Xb0IMureYNbBi2MdgVWUajXfhvrJ7Izae3Vm1R4HTyQumlFQZzQtJrp0
         3yMVfPXTNTlzlCk/42gN9R1e1UHKpuOeZW23IyjRIYalQmq8KGkD6sjFYQ2suVe8t1
         CiAIXQxsVSfI+UWsrei3A6hMpaqNZGZ+WN4Umfp4XWvQ6H/ZfYyPdfFWwAJ4l5faQO
         LpH2u8gXFYw+gHDhgKtK4UhCRfFdrOzw6zJNcNgxRiw0Vnpzz4/qPe5w5Z09sX6zMB
         /FJwNvLNXuEuA==
Date:   Fri, 10 Mar 2023 12:00:34 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC PATCH v2 7/7] arm64: dts: qcom: Add the Inline Crypto
 Engine nodes
Message-ID: <ZAuMYsH4l2XTsEZ9@sol.localdomain>
References: <20230308155838.1094920-1-abel.vesa@linaro.org>
 <20230308155838.1094920-8-abel.vesa@linaro.org>
 <4eab53fc-2d26-dc93-3ae6-c0b2546ad3e0@linaro.org>
 <ZAol5o5a6HZYgRaG@sol.localdomain>
 <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5c9aa6e-69d1-165a-4ff9-b5a9f33688e6@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023 at 09:13:29AM +0100, Krzysztof Kozlowski wrote:
> > FWIW, I tested this patchset on SDA845, and ICE continues to work fine.
> 
> Really?

Yes.

> I clearly see of_find_device_by_node -> "return NULL" and all old code gone,
> so ABI is broken. Are you sure you applied patch 1-6 and ICE was working?

Yes.

But I applied the whole series.  It sounds like you are talking about the case
where *only* patches 1-6 are applied?  I did not test that, sorry.

> > (Though if I understand the patchset correctly, the ICE clock is no longer
> > turned off when the UFS host controller is suspended.  That isn't ideal as it
> > wastes power.  I would like that to be fixed.)
> > 
> > Anyway, when you say "break the ICE", do you really mean "make an incompatible
> > change to the device-tree bindings"?
> 
> It breaks existing users of DTS and kernel.
> 
> > 
> > I'd think there would be no problem with that as long as everything is updated
> > at once, which this patchset does.
> 
> Which is obviously not possible. DTS always goes separate branch,
> always. It cannot be combined with code into the same branch! So how do
> you even imagine this?

It is not obvious.  DTS and drivers are both in the kernel source tree.
It's natural to think they can be updated together as per
Documentation/process/stable-api-nonsense.rst.

I'm *not* saying they can be -- you're the expert here, and it sounds like DTS
are considered a stable UAPI.  I'm merely saying that it's not obvious...
especially when my personal experience is that reviewers explicitly preferred a
patch breaking DTS compatibility to a patch not breaking DTS compatibility
(https://lore.kernel.org/linux-scsi/20200710072013.177481-1-ebiggers@kernel.org/T/#u)

Anyway, based on the follow-up replies, it sounds like Abel has a plan to keep
compatibility with old DTS, so hopefully that works and isn't too much trouble.

- Eric
