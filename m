Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC045BE0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiITIxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiITIxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:53:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE6362AA4;
        Tue, 20 Sep 2022 01:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DEEFB81C65;
        Tue, 20 Sep 2022 08:53:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA406C433C1;
        Tue, 20 Sep 2022 08:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663663986;
        bh=+hOCXBX7pNsUScAiy6Ygg+Obl2q7g6sqoTjVLyRJbTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I1S2+C5xu3tMXDm5//ouBzNJzmjYq06Ry/kZrjXRUN8giXKc/sUE5LmlB5BtydVWa
         f09HrCmK+y8kNw+OTC4D68B/BhjzG9jxGd4hxgISuJXZdIPzZNzmYDQ+nOBQHS0lVh
         XpJt6jzIGGfusIoq5TC4le5dEdzF6x18GmxZsxJkUju2hO77RTL1OuCAcPnAVGtNmh
         IA4nioYgkbB4kEwZ+WBmMGTtm8o/1R6+CbEb+4jSnImGixha06K9t09ke2cTe1Ooht
         EO+NYHh6Mzkuu7c48hrK8q9NawryxWGtrY2Zb5iJdzWBDnuvrGjZgj7taRYCjw5FMi
         +Qh+jk+dxHFkw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaZ09-0002Ge-Ax; Tue, 20 Sep 2022 10:53:09 +0200
Date:   Tue, 20 Sep 2022 10:53:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Message-ID: <Yyl/daUAcbJmgxDu@hovoldconsulting.com>
References: <20220915141601.18435-1-johan+linaro@kernel.org>
 <20220915150907.yxmulr3xq4uwvi7f@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915150907.yxmulr3xq4uwvi7f@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 10:09:07AM -0500, Bjorn Andersson wrote:
> On Thu, Sep 15, 2022 at 04:16:01PM +0200, Johan Hovold wrote:
> > The size of the UFS PHY serdes register region is 0x1c8 and the
> > corresponding 'reg' property should specifically not include the
> > adjacent regions that are defined in the child node (e.g. tx and rx).
> > 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>

I can't seem to find this one in either the arm64-for-6.1 or fixes
branch for 6.0. Did you just forget to push it?

Johan
