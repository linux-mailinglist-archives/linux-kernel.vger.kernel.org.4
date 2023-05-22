Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B613370B60A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjEVHNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjEVHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AFB1BE4
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82ED611E7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 07:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2818C433EF;
        Mon, 22 May 2023 07:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684739508;
        bh=bPc6DG7EIpMS8l+3ed0J/taaFDruLws311RgarkqA+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arYxZNaqxfUq21zN3hGw2jolA5KV6RfzSkj3vnXn6A0V2ffz0JtMor861TaA3WCCo
         hGATASNAJnEihjySK6KU1CJ7pd2zRrWnIpm3mhTzsUIm2IDKYeZ3VTv/570hlAsTgI
         9T9ogKHpahTzM4SbGQ/6JuJO1KOtAkQnUlbvARLIr2WrcbXKYQM6DozSit1qBiYStA
         q1uoZrbrw6Y17cHDIeRQrwFRR+RU013/oMzwv/k0tf70YG6epHfJoJXUTOVtgoZhRa
         99a4Pp9V/vBFV8NP3ex/9AevDN9woG/pjczjN/1AclPZCEyjAJBYU4D0HJQlAivwFx
         UHt8pNJDf1y4A==
Date:   Mon, 22 May 2023 08:11:43 +0100
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: max5970: Rename driver and remove wildcard
Message-ID: <20230522071143.GO404509@google.com>
References: <20230427113046.3971425-1-Naresh.Solanki@9elements.com>
 <20230518101423.GE404509@google.com>
 <14badbda-9f27-bd5d-bd59-5515c9824886@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14badbda-9f27-bd5d-bd59-5515c9824886@9elements.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 May 2023, Naresh Solanki wrote:

> Hi Lee,
> 
> On 18-05-2023 03:44 pm, Lee Jones wrote:
> > On Thu, 27 Apr 2023, Naresh Solanki wrote:
> > 
> > > The previous version of this driver included wildcards in file names
> > > and descriptions. This patch renames the driver to only support MAX5970
> > > and MAX5978, which are the only chips that the driver actually supports.
> > 
> > So multiple devices are supported:
> > 
> >    MAX5970  ... AND
> >    MAX5978  ... thus
> >    MAX597X  ... does make sense, no?
> >   What are you trying to achieve?
> Understood. It is important to note that there are indeed other unrelated
> chips in addition to MAX5970 and MAX5978. Examples include MAX5971, which is
> a Single-Port, 40W, IEEE 802.3af/at PSE Controller with Integrated MOSFET,
> and MAX5974A, an Active-Clamped, Spread-Spectrum, Current-Mode PWM
> Controller, among others.
> 
> With this change, the intention is to be specific about the chips the driver
> supports. Instead of using wildcards or a broad "MAX597X" designation, the
> patch aims to exclusively support the MAX5970 and MAX5978 chips.

It's a tricky situation when engineers/marketing people name devices in
a nonsensical manner.  However, "max5970" just as misleading in this
context as "max597x", thus the patch doesn't improve anything.  It's
more of a maneuver side-ways.

> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > >   drivers/mfd/Kconfig                        |  4 ++--
> > >   drivers/mfd/simple-mfd-i2c.c               | 18 +++++++++---------
> > >   include/linux/mfd/{max597x.h => max5970.h} | 16 ++++++++--------
> > >   3 files changed, 19 insertions(+), 19 deletions(-)
> > >   rename include/linux/mfd/{max597x.h => max5970.h} (92%)

-- 
Lee Jones [李琼斯]
