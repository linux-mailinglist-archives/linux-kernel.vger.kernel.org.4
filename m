Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35A1728066
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235687AbjFHMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjFHMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:48:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1811FE9;
        Thu,  8 Jun 2023 05:48:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26EC56122A;
        Thu,  8 Jun 2023 12:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51D8C433EF;
        Thu,  8 Jun 2023 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686228523;
        bh=jPcGpn8aAgVyQF0FLkHjbbdweYMC3zhE3JcaVkwmgRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uvvws6kDhjhKdaTfLujdUw8Uqpo7SoSYo/1a8kQmSxZx+7QJiAnJM1CVA86DZhYqS
         ndTQoOGv48XKwGx/el8nJn1yCikoeCD6mftLErEVhyDKRkTA8TPUsKXUZ6sy8O+J1I
         f+y3nkq9mQDMlKQ52o5hMCDV+7Rj4exO/yZwK6BMKUv6GMywNjoqWUXCJlcTU2YH+i
         4n+hDURD0AnIiOmQpY7GWfiivUQx+O6rDs4vYLNAttp5T7AqakIiWAQ/5tMSbtZhey
         TkGL8nk9D/o8x42NISurByK3SbWAX+TVlzJ3Mf/WPjjnRruv3ritJ3vYxLZJbMkglM
         Pgj6oqnWCkZiw==
Date:   Thu, 8 Jun 2023 13:48:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2] leds: qcom-lpg: Fix PWM period limits
Message-ID: <20230608124838.GK1930705@google.com>
References: <20230515162604.649203-1-quic_bjorande@quicinc.com>
 <ZG4gBE1rqkMIllV3@hovoldconsulting.com>
 <20230602091928.GR449117@google.com>
 <ZHtfvyklEmonogf2@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZHtfvyklEmonogf2@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 03 Jun 2023, Johan Hovold wrote:

> On Fri, Jun 02, 2023 at 10:19:28AM +0100, Lee Jones wrote:
> > On Wed, 24 May 2023, Johan Hovold wrote:
> 
> > > Pavel or Lee, could you pick this one up for 6.4 as it fixes a
> > > regression (e.g. broken backlight on a number of laptops like the X13s)?
> > 
> > I don't presently have any plans for a -fixes submission.
> > 
> > If anyone else would like to submit it, please be my guest:
> > 
> > Acked-by: Lee Jones <lee@kernel.org>
> 
> That was not the answer I expected, but sure, I've sent it on to Linus:

Sorry, soooo busy right now.  Trying not to drop too many plates.

> 	https://lore.kernel.org/lkml/ZHte5sPkB6-D-94G@hovoldconsulting.com/

*fist bump*

-- 
Lee Jones [李琼斯]
