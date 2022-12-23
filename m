Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7E965503C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbiLWMRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:17:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BC51705D;
        Fri, 23 Dec 2022 04:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96E37B81F79;
        Fri, 23 Dec 2022 12:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9641FC433D2;
        Fri, 23 Dec 2022 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671797855;
        bh=y53x8lXyYR64l/smz2zQgk8Lf7afZG/j/c9CVS9PjXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mR6xYiP7fo++adZlDGC72FMuad71kevsTrvr+/2sNcmeqIpqOm2ub3ONgLARt43zc
         +cUOPE8Kns+OWMVFi3WyUrSCfwgJxPGNqpvfWr8TeY9kZB5is7SJGKUZOmQAYC/cWt
         eGiCET+r1Dgbbek1BX/AxvSyjp870LBSPbUPQfiZDpkRR+Rs+/2XioAO5JWUzG/CC+
         KHhVu9joAmYXLhApfkgGw7sHwtNGTOez3szbutNxOeiRhpHGwS9HHYCtly/iVCoKW2
         bnJbAXJaq7Y7TfQBhUL7GL6ld23l+3JhYgR0MUOj9XnaDmHxr8AB7lvEyroGLNxTwH
         vkF9u+RL8VKpA==
Date:   Fri, 23 Dec 2022 12:17:30 +0000
From:   Lee Jones <lee@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        lee.jones@linaro.org, michael@walle.cc,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] drivers/mfd: simple-mfd-i2c: Add generic compatible
Message-ID: <Y6WcWo1QoymocA/l@google.com>
References: <20221202113226.114465-1-Mr.Bossman075@gmail.com>
 <52c581ff-c2ee-8832-1f49-bcf40847d0b5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52c581ff-c2ee-8832-1f49-bcf40847d0b5@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022, Jesse Taube wrote:

> Are there any updates?

Please refrain from top-posting.

I'll get around to it after the merge-window has closed.

> On 12/2/22 06:32, Jesse Taube wrote:
> > Some devices may want to use this driver without having a specific
> > compatible string. Add a generic compatible string to allow this.
> > 
> > Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> > ---
> >   drivers/mfd/simple-mfd-i2c.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> > index f4c8fc3ee463..0bda0dd9276e 100644
> > --- a/drivers/mfd/simple-mfd-i2c.c
> > +++ b/drivers/mfd/simple-mfd-i2c.c
> > @@ -73,6 +73,7 @@ static const struct simple_mfd_data silergy_sy7636a = {
> >   };
> >   static const struct of_device_id simple_mfd_i2c_of_match[] = {
> > +	{ .compatible = "simple-mfd-i2c-generic" },
> >   	{ .compatible = "kontron,sl28cpld" },
> >   	{ .compatible = "silergy,sy7636a", .data = &silergy_sy7636a},
> >   	{}

-- 
Lee Jones [李琼斯]
