Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F76B2FDD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 22:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCIVw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 16:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjCIVwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 16:52:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C2FAFBF;
        Thu,  9 Mar 2023 13:52:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A124D61D0B;
        Thu,  9 Mar 2023 21:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9D3C433EF;
        Thu,  9 Mar 2023 21:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678398744;
        bh=s627jAj2kVljutcqH7pExotsSn1sgfGVSZniU6lArww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rm3leIH4JH5N5Fa1BTwtxFY4sqjOVKGMsQI4ok8wJxLqTCVvYRgBEmDkS20Ui2K8O
         7ZXsqZT4YhrsVESCvlaJtzwSe++0GOKE3U/OUwB715wsw3rBnxuZcNPjWWtGjIES92
         oMj/FyBNOOw72EHFdeNii1E+HSLXXPiAaA8HSCHfiD6wDHKNEcrkmmU4WELPSry8S7
         xzGoUXEWeZ5V7BFYgQdInAWxXDyopcIGZcXI+F2V0EZD6L5I06MUHS6ckLYBJpjS5W
         sYI79JOj07RYW5DOs2YFkckO+t/XTKTueMWkZgRxNYo2NFdJZejiRNsEoySXEfxAMe
         iSntFtpop5X0Q==
Date:   Thu, 9 Mar 2023 13:55:53 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Brian Masney <bmasney@redhat.com>
Cc:     quic_shazhuss@quicinc.com, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sa8540p-ride: correct name of
 remoteproc_nsp0 firmware
Message-ID: <20230309215553.pe523cmw6nc4pmnw@ripper>
References: <20230307232340.2370476-1-bmasney@redhat.com>
 <1a915c33-ef32-852c-a856-10c8d35be151@linaro.org>
 <ZAh6O9TbX/pnOnxp@x1>
 <8f7bddf8-84de-27b5-26a3-d80b2e2f0097@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7bddf8-84de-27b5-26a3-d80b2e2f0097@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 01:36:52PM +0100, Krzysztof Kozlowski wrote:
> On 08/03/2023 13:06, Brian Masney wrote:
> > On Wed, Mar 08, 2023 at 12:02:04PM +0100, Krzysztof Kozlowski wrote:
> >> On 08/03/2023 00:23, Brian Masney wrote:
> >>> The cdsp.mbn firmware that's referenced in sa8540p-ride.dts is actually
> >>> named cdsp0.mbn in the deliverables from Qualcomm. Let's go ahead and
> >>> correct the name to match what's in Qualcomm's deliverable.
> >>
> >> I don't think vendor deliverables matter. linux-firmware is here more
> >> important. The file will be cdsp.mbn in the firmware, won't it?
> > 
> > cdsp0.mbn and cdsp1.mbn for the sa8540p are not in linux-firmware and I
> > far as I know there's no plan for someone to submit those since QC would
> > need to approve that. I can ask though since the DTS for these two bits
> > has been submitted upstream.
> 
> If they are never going to be submitted, vendor is allowed to rename
> them all the time in their "deliverables". Are you going to rename the
> file every time Qualcomm decides to rename them? There is no single
> guarantee the names would be fixed, because vendor is allowed to do
> absolutely anything.
> 

cdsp0.mbn and cdsp1.mbn are better names, so let's use this patch to
define that if/when they are pushed to linux-firmware it should follow
this scheme.

> Sorry, but any argument in upstream DTS that "someone downstream does
> something" is deemed to fail in many cases.
> 

That is indeed an insufficient argument, in many cases.

Regards,
Bjorn

