Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B83666151
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjAKRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbjAKRCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:02:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75739F8E;
        Wed, 11 Jan 2023 09:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38D15CE1C0E;
        Wed, 11 Jan 2023 17:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589D5C433EF;
        Wed, 11 Jan 2023 17:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673456425;
        bh=gw3qhEGU4Lybqbh3XH+6ho9+3sZW9wrUYwNViNOpF2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GWFbkAeXa3dgeVgoV7FZW+JvWRCMnrhNvl7f9+eMdZyo+ISiwFQdrqiGIjLcg4Sy3
         4YYtP5mv1rHb2kPNaQ9zWzKDuOY8ZVnjEfkj1wjqhERUwBP9tZT3bIhi8/8oiqN+0Y
         4BRmyYEubqoWAJmdot/ydxLgns1ngE+5TJWf6GJFrnXPqNUZ7p9p9rmh83+qchZdjj
         llsF5PZ1E0kK+3eQo/kY5IomChXpW3pH1jj45pjdNJenchMYVL86TAtOy2JpLKo8An
         DhjPJ4+PzYM5WutRn6XVYZp+cmwaD29iJl0tewbW4WVNcpaQUW2wFBMgECxFJGtn7a
         MIiLx4RUPYAug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFeSf-0003f9-RB; Wed, 11 Jan 2023 18:00:25 +0100
Date:   Wed, 11 Jan 2023 18:00:25 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/13] usb/serial: Rename dtr/rts parameters/variables
 to active
Message-ID: <Y77rKQfIYyiPwz3S@hovoldconsulting.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
 <20230111142331.34518-14-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111142331.34518-14-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:23:31PM +0200, Ilpo Järvinen wrote:
> Use active consistently for naming parameters and variables.
> This converts all USB serial drivers + CDC-ACM.
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/usb/class/cdc-acm.c          | 4 ++--
>  drivers/usb/serial/ch341.c           | 4 ++--
>  drivers/usb/serial/cp210x.c          | 6 +++---
>  drivers/usb/serial/cypress_m8.c      | 6 +++---
>  drivers/usb/serial/digi_acceleport.c | 6 +++---
>  drivers/usb/serial/f81232.c          | 4 ++--
>  drivers/usb/serial/f81534.c          | 4 ++--
>  drivers/usb/serial/ftdi_sio.c        | 6 +++---
>  drivers/usb/serial/ipw.c             | 8 ++++----
>  drivers/usb/serial/keyspan.c         | 6 +++---
>  drivers/usb/serial/keyspan_pda.c     | 4 ++--
>  drivers/usb/serial/mct_u232.c        | 6 +++---
>  drivers/usb/serial/mxuport.c         | 4 ++--
>  drivers/usb/serial/pl2303.c          | 4 ++--
>  drivers/usb/serial/quatech2.c        | 6 +++---
>  drivers/usb/serial/sierra.c          | 6 +++---
>  drivers/usb/serial/spcp8x5.c         | 4 ++--
>  drivers/usb/serial/ssu100.c          | 6 +++---
>  drivers/usb/serial/upd78f0730.c      | 4 ++--
>  drivers/usb/serial/usb-serial.c      | 4 ++--
>  drivers/usb/serial/usb-wwan.h        | 2 +-
>  drivers/usb/serial/usb_wwan.c        | 6 +++---
>  drivers/usb/serial/xr_serial.c       | 4 ++--
>  23 files changed, 57 insertions(+), 57 deletions(-)

You should split this up as CDC-ACM is not a USB serial driver.

But this all seem like unnecessary churn to me. It was one thing
changing the parameter name in drivers that used something ambiguous
like 'on_off' but 'on' is just as clear as 'active' (and its shorter
too).

So please drop at least the USB serial changes as all drivers already
use 'on' consistently. 

Johan
