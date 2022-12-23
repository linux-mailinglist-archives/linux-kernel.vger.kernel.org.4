Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81065506F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiLWMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbiLWMgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:36:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D8CE14;
        Fri, 23 Dec 2022 04:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 82BD1CE1C02;
        Fri, 23 Dec 2022 12:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2346C433EF;
        Fri, 23 Dec 2022 12:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671798969;
        bh=n7o5FyRp8aqmeQey/jwHnRjsTG0BSFtAdy5HqXln5+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZkTtw+XehNlk0wWO3Dti5b/jDFAyOMVmly6pmFI1jIk4C5u3KB/gQDMDZxZsTpdn7
         vEq4efzlnfePoRH5uXAcJ2Hc0clgvZLb8A5acvdfygnkIJxn+9mws2FhLcVtGn67iB
         8YpKwcztjWr+KSCpWxPARMV/loh/buV11OQWNgJhAwewyf45d6Pnv4z5x+PWz4um1o
         XOnuzVn6a9MaYLlAQiWoGle3iyaaOseDK4wWcKq8zAginc7tJiQYWOaNEBS1cxXgYZ
         5p0szPTJJtJj166RayMIVRRbBSHNrWE03Og18MUE0vUuQ1PsQyrsSJNNJ+RXg07d/y
         yp7Oz8tQhb4wg==
Date:   Fri, 23 Dec 2022 12:36:04 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <Y6WgtNZfeLMwPhCh@google.com>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
 <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
 <Y5HXWk4d5J9VgFBV@google.com>
 <921915e5-6b36-9d2d-ebd7-632403e3086a@9elements.com>
 <Y5mbyICg22UVFASw@google.com>
 <50212c7a-6525-4a91-f9a3-c60024b5e91d@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50212c7a-6525-4a91-f9a3-c60024b5e91d@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022, Naresh Solanki wrote:

> Hi Lee,
> 
> On 14-12-2022 03:17 pm, Lee Jones wrote:
> > On Wed, 14 Dec 2022, Naresh Solanki wrote:
> > 
> > > Hi Lee
> > > 
> > > On 08-12-2022 05:53 pm, Lee Jones wrote:
> > > > On Fri, 18 Nov 2022, Naresh Solanki wrote:
> > > > 
> > > > > 
> > > > > 
> > > > > On 17-11-2022 03:45 pm, Lee Jones wrote:
> > > > > > On Wed, 16 Nov 2022, Naresh Solanki wrote:
> > > > > > 
> > > > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > 
> > > > > > > Implement a regulator driver with IRQ support for fault management.
> > > > > > > Written against documentation [1] and [2] and tested on real hardware.
> > > > > > > 
> > > > > > > Every channel has its own regulator supplies nammed 'vss1-supply' and
> > > > > > > 'vss2-supply'. The regulator supply is used to determine the output
> > > > > > > voltage, as the smart switch provides no output regulation.
> > > > > > > The driver requires the 'shunt-resistor-micro-ohms' property to be
> > > > > > > present in Device Tree to properly calculate current related
> > > > > > > values.
> > > > > > > 
> > > > > > > Datasheet links:
> > > > > > > 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> > > > > > > 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> > > > > > > 
> > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > > > > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > > > > > Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > > ---
> > > > > > >     drivers/mfd/Kconfig         |  12 +++++
> > > > > > >     drivers/mfd/Makefile        |   1 +
> > > > > > >     drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
> > > > > > >     include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
> > > > > > >     4 files changed, 207 insertions(+)
> > > > > > >     create mode 100644 drivers/mfd/max597x.c
> > > > > > >     create mode 100644 include/linux/mfd/max597x.h
> > > > > > 
> > > > > > Ignoring my comments won't make them go away. :)
> > > > > > 
> > > > > > Please tell me why you need a whole new driver, instead of adding
> > > > > > support to simple-mfd-i2c?
> > > > > > 
> > > > > I felt current implementation to be simpler, clearer & straight forward.
> > > > 
> > > > If you can make it work with simple-mfd-i2c, please do so.
> > > simple-mfd-i2c doesn't has mechanism to pass device type(max5978 vs
> > > max5970).
> > 
> > `git grep silergy,sy7636a -- drivers/mfd`
> I did check the driver but there is no mechanism to distinguish between chip
> variant i.e., 597x-regulator driver should be able to distinguish between
> max5978 vs max5970 chip type.

How is it doing that presently?

Why can't the Regulator driver read the DT or match on the parent's
compatible for itself?

Providing a 100 line driver just to figure out a single value that is
only going to be used in a single driver is a no-go.  Please find a
better way to solve this.

-- 
Lee Jones [李琼斯]
