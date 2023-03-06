Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DE26AB977
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCFJPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCFJPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:15:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27905211CE;
        Mon,  6 Mar 2023 01:15:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 01A9BCE0E39;
        Mon,  6 Mar 2023 09:15:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B19C433EF;
        Mon,  6 Mar 2023 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678094124;
        bh=QEWZK5qYN8B6VsrcJ5WqF6bIpQ5efSCBN9vwh4fhU5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lp4448rGiIWcfNF57X07KDQfakOLjYpcQflP9gBuz9UaFJeEbN6QSVhoFhplm1BcZ
         6G/HVW0uqc3IxHe2mzMVQ7P60Ro/S/GIsKm6F5bNSjEIjlX9S6lG7nhC0eDequ3LT0
         F3lPg3GOXoqsQSyckZy9kc7pyLh+Bm0damYyDjZD3tzedGPf7MNwzUK//QgpHQDpDq
         i2ygR6QeX87yQJX9ekGm26yJVMDHlnMdcG4pnwYkXwpcYhzFSLDE5FvdkNs8h/RBA8
         ayHzrpx3lZFwia9d/DUFy6+t7j2L9HcvRs8Bs4axWG/ascsmbi75AUlzjOTIyr4oJF
         nOdhKa+wqP93A==
Date:   Mon, 6 Mar 2023 09:15:18 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH 03/10] mfd: rt5033: Fix comments and style in includes
Message-ID: <20230306091518.GD9667@google.com>
References: <cover.1677620677.git.jahau@rocketmail.com>
 <606950da6f4b36f5a124ff13756c78644fc89804.1677620677.git.jahau@rocketmail.com>
 <20230305104835.GH2574592@google.com>
 <1c110bcc-7e65-fc01-44ec-1a79cfe49795@rocketmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1c110bcc-7e65-fc01-44ec-1a79cfe49795@rocketmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Mar 2023, Jakob Hauser wrote:

> Hi Lee,
> 
> On 05.03.23 11:48, Lee Jones wrote:
> > On Tue, 28 Feb 2023, Jakob Hauser wrote:
> > 
> > > Fix comments and remove some empty lines in rt5033-private.h. Align struct
> > > rt5033_charger in rt5033.h.
> > > 
> > > Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> > > ---
> > >   include/linux/mfd/rt5033-private.h | 17 +++++++----------
> > >   include/linux/mfd/rt5033.h         |  7 +++----
> > >   2 files changed, 10 insertions(+), 14 deletions(-)
> > 
> > Applied, thanks
> > 
> 
> Thanks! Does this mean I should skip this patch in the next versions of the
> patchset? Or should I just add the Acked-for-MFD-by tag of yours? In the
> first case I'm not sure what base to use for the next versions of the
> patchset. Sorry, I'm not so much familiar with the procedures.

You should rebase onto -next before sending out your next submission.

This patch should vanish from the set.

If it doesn't, please wait another 24hrs and try again.

-- 
Lee Jones [李琼斯]
