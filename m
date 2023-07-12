Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC82575093B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjGLNIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjGLNH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:07:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0571982;
        Wed, 12 Jul 2023 06:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC2B9617CF;
        Wed, 12 Jul 2023 13:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBFDC433BB;
        Wed, 12 Jul 2023 13:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689167275;
        bh=vMW1ZsFAhoE8lYwPBVV9W01svxaLeOjXsMzAPBL29Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hd/P402SCaE6/5pqtisHoEnJrzDqC4etX21mp8Sq+1iMAnXqW0M1K0e82Y4OCEX/V
         ss82SswEOPPlTYpmm9r57YFh1mepIVM/3lVn35MpoWgYbol0SnzHShuUZUekt0fNBA
         GTBk/hddzkrV20+rbpvIvgGg0nKQ2CjGZ3RAl4tTYgCfqOXTt6nAlPYsraq2okdZB2
         JoeIVJgjsaqst/65FywS5JnV7D99n2zodhNSeVEnu1YGOCd9+5NANDUWQRNg48n2LQ
         XqutJK5JhyBIp6hddomSe79JMEAo+U/Iedh1WXiWdHqAqg7bmpTVRH4w2rCu6+XA7b
         Olp4KUf6Xj0mw==
Date:   Wed, 12 Jul 2023 14:07:50 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Fei Shao <fshao@chromium.org>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH] leds: pwm: Fix an error code
Message-ID: <20230712130750.GE10768@google.com>
References: <20230711083055.1274409-1-fshao@chromium.org>
 <CAHp75VfSL5j-ZUYkezELWzq+c_V+CFL6iVQWQ=roPYrZ=h1rSw@mail.gmail.com>
 <20230712120026.GD10768@google.com>
 <CAHp75Vd4cuNEQUotVZb8Xu+JMC9KKUk_Gg5N_YsA2KoEANwBKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vd4cuNEQUotVZb8Xu+JMC9KKUk_Gg5N_YsA2KoEANwBKw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023, Andy Shevchenko wrote:

> On Wed, Jul 12, 2023 at 3:00 PM Lee Jones <lee@kernel.org> wrote:
> > On Tue, 11 Jul 2023, Andy Shevchenko wrote:
> >
> > > On Tue, Jul 11, 2023 at 11:31 AM Fei Shao <fshao@chromium.org> wrote:
> > > >
> > > > Use the negated -EINVAL as the error code.
> > >
> > > Thank you, it seems Dan had been the first one.
> > >
> > > Message ID <a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain>
> >
> > I don't know much about how other people operate, but I have no way to
> > trivially navigate to this.  Would you be kind enough to use URLs
> > please?
> 
> Use this pattern:
>   https://lore.kernel.org/r/$MSG_ID
> where $MSG_ID is a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain
> in this case.
> 
> Hence, the URL:
> https://lore.kernel.org/r/a33b981a-b2c4-4dc2-b00a-626a090d2f11@moroto.mountain
> 
> Easier way is simply run `b4 mbox $MSG_ID` and open the loaded mbox
> with your preferred MUA.

Right, I'm aware that I can manually manipulate the lore URL in this way.

However I, like many, do not have a way to do this easily from my mailer.

This is why directly navigatable / clickable URLs were invented. :)

Please could you use full / clickable URLs to messages?

-- 
Lee Jones [李琼斯]
