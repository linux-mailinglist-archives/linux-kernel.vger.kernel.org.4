Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7845E73BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiIWGOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIWGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:14:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3451191A2;
        Thu, 22 Sep 2022 23:14:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50EBDB8274C;
        Fri, 23 Sep 2022 06:14:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56E2C433C1;
        Fri, 23 Sep 2022 06:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663913666;
        bh=OQTnh0dPbWoKamrOJwnvSKKtEfSByR/Nd0plk54BbF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=anA3Qp1vfNjYW6I4ZMEGlLc0jRC6MHrE/pVH9iLiRWvCrgk2G22gaCswcBU4G3YD1
         WyDat91xZKDrCIqAw8nevTkQggZWoWmli1UgsarsyinZXaU9hb0DX/Tnn4aSbc97ZW
         Qtr9HFXBLZ2hbGWSQzndvIKQmCMliu3d+FC9uIxjzHlRsD3UHvGKoWu35M9U1j9KFz
         HHkGKaFGHpna72haf4gwjpWmElvDCjP0/EcbEi4OaB/RgGeG+58+VoGF/yGZKtnXmv
         vurzvfEJF9s6LsSg3JkPym2qKjXm0RpoLZwxGihek0K4lSFtxm7VO62h1joMjyRgbv
         qR0qfMjgUvdOQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1obbxF-0006Fp-1X; Fri, 23 Sep 2022 08:14:29 +0200
Date:   Fri, 23 Sep 2022 08:14:29 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] phy: qcom-qmp-combo: drop redundant DP config flag
Message-ID: <Yy1OxS7NjUmaV2Aw@hovoldconsulting.com>
References: <20220920073826.20811-1-johan+linaro@kernel.org>
 <20220920073826.20811-18-johan+linaro@kernel.org>
 <8de63b63-f88a-7342-d286-8826a55e78ab@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8de63b63-f88a-7342-d286-8826a55e78ab@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:02:49PM +0300, Dmitry Baryshkov wrote:
> On 20/09/2022 10:38, Johan Hovold wrote:
> > Drop the DP_COM control block flag from the configuration data, which is
> > set for all combo PHYs and hence no longer needed since the QMP driver
> > split.
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 63 +++++++----------------
> >   1 file changed, 18 insertions(+), 45 deletions(-)
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Thanks for the review, Dmitry.

Johan
