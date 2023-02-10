Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503F6923F0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjBJREX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjBJREW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:04:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA52E6FEB0;
        Fri, 10 Feb 2023 09:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC7661E3E;
        Fri, 10 Feb 2023 17:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BFDC433EF;
        Fri, 10 Feb 2023 17:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048660;
        bh=y+EPIGFUVVARFvU3KUSU5GU0uDCLVbF2YQCe4wFPOEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PpsvrHrAuEAmKn8XkOkTeJW3XKo07eQPSatZjL/ZVTTNIaCvIl9+c8WJB1OoYjkl3
         gxc2DnCTVbtG3+nud67KRkxhsrYE5zSt7x7cGGBYvIGQuCwZG9c68G5HQaFp6Y/Lp4
         /8Y7Bb+14HrDxGEivZ6hRK6tmScfpTK14MlvMymNH6YvLL+kYbaZjwyL121Qg4lzR0
         +VoFxyxBiIF72avuFafhcopNO9ifNe8ktLj7+M9S2Mrz7DOV2A0a5YuwEAD2iKPW6A
         v6EISxj6hbH2TVNALeWDYeew9Br/+mSQ7PFc4Tba4jkDqrH1UL+7U5yeJ9OI+8XL/8
         +NGfk4AL8drmw==
Date:   Fri, 10 Feb 2023 22:34:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan+linaro@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v6 0/6] sm8550: Add USB HC and PHYs support
Message-ID: <Y+Z5EKjMtOBWjPdU@matsya>
References: <20230208183421.2874423-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208183421.2874423-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-02-23, 20:34, Abel Vesa wrote:
> This patchset adds support for USB for Qualcomm SM8550 platform.
> 
> This patchset is based on top of the following patchset:
> [1] https://lore.kernel.org/all/20230208180020.2761766-1-abel.vesa@linaro.org/

Applied, thanks

I got a minor conflicts on two patches please check the merged code

-- 
~Vinod
