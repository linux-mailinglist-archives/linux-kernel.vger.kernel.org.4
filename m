Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B74E5B8D8F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiINQxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbiINQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF648304F;
        Wed, 14 Sep 2022 09:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72881616D9;
        Wed, 14 Sep 2022 16:52:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F48DC433D6;
        Wed, 14 Sep 2022 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663174363;
        bh=hL5TRZptT4oiN1u/wFEsqNLy0oe4FZh2S3ISQT+e0E8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRq5BSeePf1pQzQ8hVLRJnJIXra8g19FCSlqYytbRVcjsRphXJ36vnLsv2P99WuMa
         oWRN7uk0+mFtXUMoL/QcOEQ6H3qjjIX/p+d2DT1Hq4mYW6NnmWP+gydeQRGGmLL6Rc
         6RVKEsN0QdpudFhmzCQWInLUAoCdUYSP912nP8zha534lUnAKQOrdBVJEd6jEgExKD
         YG9mugLtZvuXRjIAK6uGHqDKWvRDueT8SPTZLAjJPAj65VdJE/iCECSqRnQ3coj1To
         73LPmzuKvcmxARRj4ZtKgMr6s4Xv0wddMA2//7BSraqkrkp78VKesKjX69zYuGbGg+
         uY+xKR0UQMRHg==
Date:   Wed, 14 Sep 2022 22:22:39 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        David Dai <daidavid1@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 2/2] spmi: pmic-arb: Add support for PMIC v7
Message-ID: <YyIG19E/EMNQzqcr@matsya>
References: <20220914112139.3680354-1-vkoul@kernel.org>
 <20220914112139.3680354-3-vkoul@kernel.org>
 <20220914141044.jaepzwcqyo2nt4cw@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914141044.jaepzwcqyo2nt4cw@builder.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-09-22, 09:10, Bjorn Andersson wrote:
> On Wed, Sep 14, 2022 at 04:51:39PM +0530, Vinod Koul wrote:
> > From: David Dai <daidavid1@codeaurora.org>
> 
> David Collins wrote the downstream patch that this is based on, so this
> should be David Collins <collinsd@codeaurora.org>

Thanks updated and posted v5

> 
> > 
> > PMIC v7 has different offset values and seqeunces, so add support for
> > this new version of PMIC
> > 
> > Signed-off-by: David Dai <daidavid1@codeaurora.org>
> 
> Ditto.
> 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # SM8450 HDK
> 
> The rest looks reasonable to me.
> 
> Regards,
> Bjorn

-- 
~Vinod
