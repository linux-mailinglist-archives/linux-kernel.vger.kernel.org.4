Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ACE6CA763
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 16:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232493AbjC0OUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjC0OT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 10:19:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F442722;
        Mon, 27 Mar 2023 07:17:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2CC7B815F3;
        Mon, 27 Mar 2023 14:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5456C433EF;
        Mon, 27 Mar 2023 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679926658;
        bh=ST6/Tf0Hd9KxwNCo9HY/s+ET1/l38vy0oeHUythJylI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQ6IaZFvjr7xiN1RVix4oLQO7K1Vr9gUYuIiuoHmzBFbay7taWsNJO0Um/mXYW3hg
         rGCWQ6lc36khTW7dQo6RSK/O2ePhFgGcV4K/KpYunPcbEJdU5foBGsH1XmMXILjCE0
         gi16UwCMXipAXicUYe+/9sCMihX6ap+lEXbzfeVKwa+YT0d9hH8UodmRrz+F903aJK
         ghXhtorKg3HmFFtdG50t2LMYfm/BMJrD0qHk/2+UUxZBgKbxNw077/TPVIkZSbhqfi
         XnOAKnT5/QCHwRK0HQa9MKnqt7q3GhGs2Um4VsQroi15ueLqhlBKGhdcvcMK5yeCym
         b1jLBac/PGuuA==
Date:   Mon, 27 Mar 2023 07:20:43 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/12] arm64: dts: qcom: sc8180x: Introduce Lenovo
 Flex 5G
Message-ID: <20230327142043.4q62vfcd2557caen@ripper>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-13-vkoul@kernel.org>
 <cf4feba0-de96-9e81-592b-e4b7520340a6@linaro.org>
 <ZCEs57ttv67KfOua@matsya>
 <84bcb9a7-40f7-b692-0f06-4075b27b5b7e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84bcb9a7-40f7-b692-0f06-4075b27b5b7e@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 10:51:38AM +0200, Konrad Dybcio wrote:
> On 27.03.2023 07:43, Vinod Koul wrote:
> > On 25-03-23, 13:40, Konrad Dybcio wrote:
> >> On 25.03.2023 13:24, Vinod Koul wrote:
> >>> From: Bjorn Andersson <bjorn.andersson@linaro.org>
[..]
> >>> +&dispcc {
> >>> +	status = "okay";
> >> Any reason for disabling dispcc by default?
> > 
> > I think that is a good question. I would prefer disabling and enabling
> > in places it is required, we might have a headless system or a dev board
> > where we dont have display..?
> It's a double-edged sword: on one side we could disable clocks that were
> mistakenly enabled, but on the other hand we do keep some some clocks
> always-on within that driver..
> 
> Perhaps leave it on by default and shut it off per-board if need be.
> 

There is a little bit of overhead in keeping the clock controllers
enabled at all times, but I expect it to benefit us in that it would
ensure that any clocks that the bootloader might have left on will be
disabled.

So, I think we should go with enable by default and leave enabled.

Regards,
Bjorn
