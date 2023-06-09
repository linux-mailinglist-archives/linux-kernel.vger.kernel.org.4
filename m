Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C6772901C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238307AbjFIGii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238410AbjFIGiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102E03584;
        Thu,  8 Jun 2023 23:38:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F9D0653F4;
        Fri,  9 Jun 2023 06:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C7BC433EF;
        Fri,  9 Jun 2023 06:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686292690;
        bh=ydU6KVz48ejvQHdgUNpVzc5R9W8cHBZ7+uugeAbS4cQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+fWnL/MgWVD4n+2VJUqCNDlZB1beMagYUj98lBZMYH3nFwBxlQyBzz6vQez2ikIn
         uUs99TfNrNyuodVNxLDROSUzk8kx7p0wivk8loqwnK42DkNs0z08ENrwEK4qUJW6Vk
         /4+rcE1+6/COI6PahY9q4OwCc2nmL50LzyHe512NHRqGTCHdCMGtRKnfQGRu6B+6vm
         KT+bAmd6FSY+zmLg02WtT1r+tOAYb3uakpqnJ2gGHbLUhEBDKkEHsJRxqbF3v20W9p
         ssa57FGXUpXVYaqeHensvFrU2PpkKP9GhjMtY5tGmdwCvid5EEbZBpTaIesRZ2k7+x
         h/6hxC99zxAag==
Date:   Fri, 9 Jun 2023 07:38:04 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: pm8008: fix module autoloading
Message-ID: <20230609063804.GB3635807@google.com>
References: <20230526091646.17318-1-johan+linaro@kernel.org>
 <20230526091646.17318-2-johan+linaro@kernel.org>
 <20230608154503.GO1930705@google.com>
 <ZILE-Yy8TYaicACV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZILE-Yy8TYaicACV@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Johan Hovold wrote:

> On Thu, Jun 08, 2023 at 04:45:03PM +0100, Lee Jones wrote:
> > On Fri, 26 May 2023, Johan Hovold wrote:
> > 
> > > Add the missing module device table alias to that the driver can be
> > > autoloaded when built as a module.
> > > 
> > > Fixes: 6b149f3310a4 ("mfd: pm8008: Add driver for QCOM PM8008 PMIC")
> > > Cc: stable@vger.kernel.org      # 5.14
> > > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > > ---
> > >  drivers/mfd/qcom-pm8008.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > 
> > Applied, thanks
> 
> Thanks, Lee. Did you forget to push these out? I was gonna see if you
> merged them for 6.4 or 6.5, but I can't seem to find them in your mfd
> repo.

I don't tend to push daily.  I can push them now if you like.

These were added for v6.5.

-- 
Lee Jones [李琼斯]
