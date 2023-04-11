Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB36DDB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 14:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjDKMjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 08:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDKMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 08:39:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A101FE4;
        Tue, 11 Apr 2023 05:39:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC51061D98;
        Tue, 11 Apr 2023 12:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7516DC433EF;
        Tue, 11 Apr 2023 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681216752;
        bh=WD5G8dd/ugfMV6qpUG9CIug356YcoMv3nLMJmwxq5Zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quqRXFEc/A8hl0a7talcM3w/aUNpdbuZ/BWrcwkOKU8zHrz2+MUDjywi/R9/UKr1d
         MGjYiZDgL2iEPqa8Jw5Q2MCtRtwXeGdfne2IPNc6xMgJgtDvi2+55Jx1VfIVT1f2gg
         rniRywNXVpsLeHRmQXkB9ASUx9ZRnpx/Q81BhtQp1tD4FZDi1AIC3LMDkTkWk/j9sL
         d2wOS3oX/5iWtdRl+xr8ve26cv2kjiy8WeQJC+kPNtW+pG72XX3HROBudhR5K9/vSP
         q7AtM1RvdeyPj0WGrlBXmjaoDinlXW+QTjTOgbmyck73QazZ8B+z5nDnmxev9Br4kI
         YdFuFnNnhppPw==
Date:   Tue, 11 Apr 2023 05:42:54 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v3 3/3] arm64: dts: qcom: qrb4210-rb2: Increase load on
 l22 and l24 for uSD and eMMC
Message-ID: <20230411124254.r4sk7fn4wdrdt6qy@ripper>
References: <20230411072840.2751813-1-bhupesh.sharma@linaro.org>
 <20230411072840.2751813-4-bhupesh.sharma@linaro.org>
 <ff5691b4-df1a-57a8-6e96-f997bbe340f4@linaro.org>
 <CAH=2Ntytn2GnBJkiZ4+xBf1X-fUUTD4iHWv-Sv66Jp1ePUDV3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH=2Ntytn2GnBJkiZ4+xBf1X-fUUTD4iHWv-Sv66Jp1ePUDV3A@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 05:43:51PM +0530, Bhupesh Sharma wrote:
> On Tue, 11 Apr 2023 at 17:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> >
> >
> > On 11.04.2023 09:28, Bhupesh Sharma wrote:
> > > Increase the l22 and l24 load used for uSD and eMMC VMMC.
> > > These need to be increased in order to prevent any voltage drop
> > > issues due to limited current happening during specific operations
> > > (e.g. write).
> > >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > You could have simply squashed this into the patch where
> > you enabled the controllers, so that that commit works
> > reliably for e.g. bisect
> 
> Yes, but Bjorn asked me to send this separately (via irc).
> I am fine with squashing this with the previous patch [PATCH 2/3] as
> well, if Bjorn is OK with it.
> 

I was trying to say that I was fine with you just fixing the small thing
I had asked for and then you could send a separate patch for this when
you found the time.

I can squash the two while applying, unless anyone else have any
concerns with the patches.

Regards,
Bjorn
