Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633666E030E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 02:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjDMALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 20:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDMALi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 20:11:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9882DC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 17:11:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pxg3k1fL5z4xGK;
        Thu, 13 Apr 2023 10:11:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681344690;
        bh=ptjOI3AT2/hYtcYUPlZVEdbaAdsYtMWDcr1HU6xLHPk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ng1uWfFhe4z23J4cjn0ubPm9lTEthaP4Cal102stJ7NcTcam2/rK+5b1ZjgZaU1VZ
         avi9T+kduc9YFiK/0WtznbNCy6sld5Aus9ecCFuY+GwYdGZUkRe+f2V0I3A3W+WUX6
         yFKVCJT2wHKkcVOvd2+YkEJEDuN6VlIh1/9mvtXS4q0k2PT0V8fubxvhJkhwzYZbpF
         Ts9ckAEyyIjMH//NICrJmPsFWh14Z6qKQSzxgQ0DoKcVNtCpBI3wE0qgcdnJkR9+9e
         pjWphtI59QX6GbQmYfzgPLwBCRhP9C4yUEHAN/IKfJE6dPcDYCl/vgy3QttAQTu3qC
         afX5EwbzTu6MQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Anatolij Gustschin <agust@denx.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/mpc52xx_lpbfifo: Drop unused functions
In-Reply-To: <20230412150524.ojsvukh47hing6db@pengutronix.de>
References: <20221228145129.31700-1-u.kleine-koenig@pengutronix.de>
 <20230412150524.ojsvukh47hing6db@pengutronix.de>
Date:   Thu, 13 Apr 2023 10:11:25 +1000
Message-ID: <87zg7cabf6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
> On Wed, Dec 28, 2022 at 03:51:29PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>> The four exported functions mpc52xx_lpbfifo_submit(),
>> mpc52xx_lpbfifo_abort(), mpc52xx_lpbfifo_poll(), and
>> mpc52xx_lpbfifo_start_xfer() are not used. So they can be dropped and the
>> definitions needed to call them can be moved into the driver file.
>>=20
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>
> I never got feedback about this driver and it has not appeared in next
> up to now. Did it fell through the cracks?

Yeah. I was hoping someone would explain what's going on with the
driver.

Presumably there are some out-of-tree drivers that use the routines
provided by this driver?

I think rather than merging this patch, which keeps the code but makes
it completely useless, do you mind sending a patch to remove the whole
driver? Maybe that will get someone's attention.

cheers
