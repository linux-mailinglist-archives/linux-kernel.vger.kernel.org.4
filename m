Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC9569BEE0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 08:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBSHYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 02:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBSHYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 02:24:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42F126D0;
        Sat, 18 Feb 2023 23:24:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB9160BCA;
        Sun, 19 Feb 2023 07:24:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73731C433EF;
        Sun, 19 Feb 2023 07:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676791489;
        bh=liv9/odC6dqixxDcMf8gGxmXFcG5g9OJqDJ0PNV9N/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aV3cJ9OgUjNlZ51/PpmCPg5jDVj1owLo/mmvYQcS2UrYr1XRofeuK9o37hfaepQk8
         djUtbSJOay0PX3b52oNMPzDB5OheGlIu3Q8xjrpTKEWatNuD+lXxFB31Lq2qBHa+j1
         /d2ajXr4HSa6eLVnfYFWpZBcZYoX48BSvtu1jhN8=
Date:   Sun, 19 Feb 2023 08:24:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ramon Fried <rfried.dev@gmail.com>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>
Subject: Re: amba pl011 non amba/sbsa driver
Message-ID: <Y/HOvIMTE5XZaelm@kroah.com>
References: <CAGi-RULY-9eS7JUA7bW_tJ0JjA_hJTjvOyGyj7_7aVtRk2BaFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGi-RULY-9eS7JUA7bW_tJ0JjA_hJTjvOyGyj7_7aVtRk2BaFg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 09:56:39PM +0200, Ramon Fried wrote:
> Hi.
> Our upcoming SOC is using pl011 ip, but we have a different NOC than
> AMBA and we don't want to use the SBSA, as it provides limited
> functionality in the UART.
> 
> My question is should we develop a new driver or add more
> functionality to the current driver.
> The pl011 driver is a bit messy, and the functionality we actually
> need is actually supported in the current driver, but I can't
> differentiate my HW using AMBA id.

If it's the same IP block, please use the same driver.  That way it will
be easier to maintain over the long-term.

thanks,

greg k-h
