Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0485E8C0E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 14:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiIXMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 08:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiIXMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 08:06:20 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6A998E9B1;
        Sat, 24 Sep 2022 05:06:19 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oc3vH-0007UC-01; Sat, 24 Sep 2022 14:06:19 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id DC687C0643; Sat, 24 Sep 2022 12:46:12 +0200 (CEST)
Date:   Sat, 24 Sep 2022 12:46:12 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Lantiq: switch vmmc to use gpiod API
Message-ID: <20220924104612.GB10628@alpha.franken.de>
References: <Yy08TBymyuQb27NU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy08TBymyuQb27NU@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 09:55:40PM -0700, Dmitry Torokhov wrote:
> This switches vmmc to use gpiod API instead of OF-specific legacy gpio
> API that we want to stop exporting from gpiolib.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/mips/lantiq/xway/vmmc.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
