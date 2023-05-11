Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F16FEBEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 08:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237165AbjEKGwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 02:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjEKGwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 02:52:23 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B1846A6
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 23:52:20 -0700 (PDT)
Received: (Authenticated sender: maxime.chevallier@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4C45560004;
        Thu, 11 May 2023 06:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683787939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=loWLMtt1SB4E9zCWd42lbXNMFAZQMbQFf4TMhSHwRzE=;
        b=CNOkzqcnZN95xcMetZKz9SsNHIfo4oEcr3PjRBuZkeDdmZxpWgyIFKxQ0OkKous/CKSOYM
        k4irE4M8p97ocMMXVuYdSGNXUynrolMopSPFezRT//IlcdbCGK1RnsOUKmnbBANwTJcFvh
        /0e/N86Ob0c8AlZV5zcRuCd5JQAAXmxXFl9Fby7X2NmtnqrXSqCquviE6/3y+/dAcvRV1/
        WB7RjIRK6DL2JHeWcN95lcxWDsqzrWq4TTZnXFsHhwSDQJ18nL0gYkACyAQNBbmXd8XgKs
        LFKpdObn+T3rg043c1NuBjeslkaj0KkDIKKiEIPsThfpBFkCxFdnMLRdvogIxg==
Date:   Thu, 11 May 2023 08:52:17 +0200
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Colin Foster <colin.foster@in-advantage.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexis.lothore@bootlin.com
Subject: Re: [PATCH] regmap: don't check for alignment when using reg_shift
Message-ID: <20230511085217.4fe390d4@pc-7.home>
In-Reply-To: <ZFWcy/Z19vffsAg+@finisterre.sirena.org.uk>
References: <20230420150617.381922-1-maxime.chevallier@bootlin.com>
        <ZEKwxhJJNkuX7VTr@colin-ia-desktop>
        <bb836be3-456c-48fd-9b19-62279fee6b8d@sirena.org.uk>
        <20230428093010.07e61080@pc-7.home>
        <20230428094745.63677228@pc-7.home>
        <ZFU6oepWPoYDJczo@euler>
        <ZFWcy/Z19vffsAg+@finisterre.sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark, Colin,

On Sat, 6 May 2023 09:18:19 +0900
Mark Brown <broonie@kernel.org> wrote:

> On Fri, May 05, 2023 at 10:19:29AM -0700, Colin Foster wrote:
> 
> > Sorry for a really delayed response, but I just got back around to
> > thinking about this. Crazy busy times for me.  
> 
> > What about an explicit parameter in regmap_config that will disable
> > alignment checks? That seems like it might be a welcome feature
> > addition.  
> 
> You can already just not specify an alignment requirement - if you can
> configure the regmap to specify some new flag you could also just not
> specify the alignment requirement in the first place.

Ok thanks, I will try that approach then. Thanks !

Maxime
