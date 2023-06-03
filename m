Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72648721103
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 17:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFCPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 11:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFCPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 11:43:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84999E;
        Sat,  3 Jun 2023 08:43:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F5686154E;
        Sat,  3 Jun 2023 15:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3A3C433EF;
        Sat,  3 Jun 2023 15:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685807026;
        bh=MRCNOGwBQtQYgskHmZ8uVAw4G9kKVgVW8/KJuALlKWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsy0rCifsX9DUfnadBxF1OAPMtKRa8eTcrAEjEjz+N4c9PSJm5IGELZwaW2OjLIIV
         Yph9IaJYi2iH07S/YSWScPOkrMJiMvlhxkAnr9iyc+wWhNA2WNR/ZHQ93HLYqtwpH0
         zJ5OPgX+MHKEd3Yx9sv8noKxF1O+Glf0utD4Jfs58YK5xYtGT90EJ36eYivBLA6ho0
         jvV36B88tDTSTlvg1gJSB9uzn1zI3PW2DxcrF3szCpy7iMTL+KU1FbEd9hrz6rXEOu
         lJSDpuqrDqr0sDrxHOXLW71WrOCOQIEzAQGifBjuJ9Y4mQWXeowR2ZAXrH9FjvlVO1
         UXl0H/LjGm3/Q==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5TQ7-0002bH-7y; Sat, 03 Jun 2023 17:43:59 +0200
Date:   Sat, 3 Jun 2023 17:43:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Pavel Machek <pavel@ucw.cz>,
        Anjelique Melendez <quic_amelende@quicinc.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH v2] leds: qcom-lpg: Fix PWM period limits
Message-ID: <ZHtfvyklEmonogf2@hovoldconsulting.com>
References: <20230515162604.649203-1-quic_bjorande@quicinc.com>
 <ZG4gBE1rqkMIllV3@hovoldconsulting.com>
 <20230602091928.GR449117@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602091928.GR449117@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:19:28AM +0100, Lee Jones wrote:
> On Wed, 24 May 2023, Johan Hovold wrote:

> > Pavel or Lee, could you pick this one up for 6.4 as it fixes a
> > regression (e.g. broken backlight on a number of laptops like the X13s)?
> 
> I don't presently have any plans for a -fixes submission.
> 
> If anyone else would like to submit it, please be my guest:
> 
> Acked-by: Lee Jones <lee@kernel.org>

That was not the answer I expected, but sure, I've sent it on to Linus:

	https://lore.kernel.org/lkml/ZHte5sPkB6-D-94G@hovoldconsulting.com/

Johan
