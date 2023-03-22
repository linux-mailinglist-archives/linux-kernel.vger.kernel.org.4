Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFA06C4F6C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjCVP3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 11:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjCVP3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 11:29:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CE01ACF1;
        Wed, 22 Mar 2023 08:29:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 39B2BCE1DF3;
        Wed, 22 Mar 2023 15:29:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CABC433D2;
        Wed, 22 Mar 2023 15:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679498940;
        bh=KRPwiG/5FUOiZ7gi7L7ko7esh2lf3p5g5u0jSTfe0Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jdKcKxsKaG/DJA4MoepVyR5mQXFWlrMBeFX2fFxEHJ+F/kFbjWSJpMHuNIravx+E/
         JB1yOVyiIZ6rhP3HiFXqyTiIVem2AmHq9brazMfKHy/WEyasJwA/wWsc9puVV5V1yw
         WsgBCujcxv1EAFmqK24Sj1UWEXAuyv1arZEPxDk83hsXy61yx8fTb/ApmdpeAd6eXb
         BQj6KRMZbH0DzNUsVsVL0sLX0c1i38YdvdYi0UYZ2WUAL9gfhD0J577fAyxj37ku2a
         3An0yLmSt0HyGePckND2y5wn3iHTFGN0J+m6Fiy847oU45LXfOzoZSEL5L5Wo5hxrP
         ltaB8WZjLlmKQ==
Date:   Wed, 22 Mar 2023 15:28:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the leds-lj tree
Message-ID: <20230322152855.GH2673958@google.com>
References: <20230320114816.2abe5751@canb.auug.org.au>
 <20230322105517.06e4508a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322105517.06e4508a@canb.auug.org.au>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Stephen Rothwell wrote:

> Hi all,
>
> On Mon, 20 Mar 2023 11:48:16 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the leds-lj tree, today's linux-next build (x86_64
> > allmodconfig) failed like this:
> >
> > drivers/leds/rgb/leds-mt6370-rgb.c: In function 'mt6370_check_vendor_info':
> > drivers/leds/rgb/leds-mt6370-rgb.c:889:15: error: implicit declaration of function 'FIELD_GET' [-Werror=implicit-function-declaration]
> >   889 |         vid = FIELD_GET(MT6370_VENDOR_ID_MASK, devinfo);
> >       |               ^~~~~~~~~
> >
> > Caused by commit
> >
> >   55a8a5c16eb3 ("leds: rgb: mt6370: Add MediaTek MT6370 current sink type LED Indicator support")
> >
> > I have used the leds-lj tree from next-20230317 for today.
>
> I am still getting this build failure.

Fix applied and pushed.  Thanks for the reminder.

--
Lee Jones [李琼斯]
