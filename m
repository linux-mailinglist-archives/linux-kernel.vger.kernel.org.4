Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC86F0A22
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbjD0Qo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243665AbjD0QoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:44:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE3E49FC;
        Thu, 27 Apr 2023 09:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A07D063E58;
        Thu, 27 Apr 2023 16:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7389FC433D2;
        Thu, 27 Apr 2023 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682613861;
        bh=c3LZjV/jiKmjxjorTiw6SfDRxZNWLX6lW/xXacYiA7I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CO+OTuUyWQxcMzOKzhW3UOvAl34YsyYK4LVIHE5fquqor16ccbmPx1gW5TCL+wkR6
         buEJTdJVUgQSA1YaGv6Pqa9i1tCDBtel0qNjwYZ7KspO1uH/jWfFtSxABOsfXw64fo
         HJFRMl4yNfs6mLYEiajdu2GR3a1+HpA+jz9b7ELHlaHSH1WKH3yN66oIGBE5Q1nYEu
         z4B5E24+x3iYU8qvIqFVQoGhSoA0q5qIGsgesRJ6FMVFETkxRHeitoR4/bRih6huFH
         hIQyCM9yxjqlBQSNEbYBYcdRmKkE1IGHyGKG4EY7S+RD+qCwbP5n8pVgrlt0m7KH2b
         Dcr/GQ9yCDqrQ==
Date:   Thu, 27 Apr 2023 17:44:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v6 2/2] leds: bd2606mvv: Driver for the Rohm 6 Channel
 i2c LED driver
Message-ID: <20230427164416.GB620451@google.com>
References: <20230419111806.1100437-1-andreas@kemnade.info>
 <20230419111806.1100437-3-andreas@kemnade.info>
 <20230424131740.GE50521@google.com>
 <20230424210634.70c26688@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230424210634.70c26688@aktux>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023, Andreas Kemnade wrote:

> On Mon, 24 Apr 2023 14:17:40 +0100
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Wed, 19 Apr 2023, Andreas Kemnade wrote:
> > 
> > > The device provides 6 channels which can be individually
> > > turned off and on but groups of two channels share a common brightness
> > > register.
> > > 
> > > Limitation: The GPIO to enable the device is not used yet.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > ---
> > >  drivers/leds/Kconfig          |  14 +++
> > >  drivers/leds/Makefile         |   1 +
> > >  drivers/leds/leds-bd2606mvv.c | 160 ++++++++++++++++++++++++++++++++++
> > >  3 files changed, 175 insertions(+)
> > >  create mode 100644 drivers/leds/leds-bd2606mvv.c  
> > 
> > Applied, thanks
> > 
> contrary to the binding doc, it does not appear on
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/log/?h=for-leds-next
> 
> Any problems with applying it?

Now applied to the correct branch, thanks.

-- 
Lee Jones [李琼斯]
