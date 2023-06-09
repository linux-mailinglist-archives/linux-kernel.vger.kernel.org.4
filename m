Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746E5728FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbjFIGVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjFIGVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:21:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A6630F0;
        Thu,  8 Jun 2023 23:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29561653D6;
        Fri,  9 Jun 2023 06:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A52C433D2;
        Fri,  9 Jun 2023 06:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686291677;
        bh=pjcIRBp4TxDCF1VbEyrm0rP6g/GjTwNBBru1sxq77qU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c14UQ8gX72mslbloG2zO5Sf4bloRxlz7ZzupEA7l5PAPXvl6t3gIst/Cj3HFRfFiA
         BIXoBfxutzLzu1mlwEhPPAwsAGxuNDbJqzGGPm+M0CXASp+oSvuRbqxf6DORhkvBMK
         1BdJBYgTKOAKB6g1zvsSkk4ZJmCrtiyi/hNhGr5ev7Pki6luj22P0huJNSpbWG4fA5
         xKo8VHz7rDLof33wOXRTxPhV2X++bPyPkg0CFOMtFavtn1uIES4OQOfYp03ZRrlm+C
         R9+lywgWpTai3fvdzDlVWo/vHFSeXG7/w4CP29cRSKbxlPU1giR2ADJesftiBp7Lpv
         xaTw8d0AN16SQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q7VVJ-0005E4-4A; Fri, 09 Jun 2023 08:21:45 +0200
Date:   Fri, 9 Jun 2023 08:21:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Message-ID: <ZILE-Yy8TYaicACV@hovoldconsulting.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
 <20230608154503.GO1930705@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608154503.GO1930705@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 04:45:03PM +0100, Lee Jones wrote:
> On Fri, 26 May 2023, Johan Hovold wrote:
> 
> > Add the missing module device table alias to that the driver can be
> > autoloaded when built as a module.
> > 
> > Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> > Cc: stable@vger.kernel.org      # 5.14
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/mfd/qcom-pm8008.c | 1 +
> >  1 file changed, 1 insertion(+)
> 
> Applied, thanks

Thanks, Lee. Did you forget to push these out? I was gonna see if you
merged them for 6.4 or 6.5, but I can't seem to find them in your mfd
repo.

Johan
