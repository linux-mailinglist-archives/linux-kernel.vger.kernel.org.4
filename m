Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A78E662CD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbjAIRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234593AbjAIRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:33:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C8B89;
        Mon,  9 Jan 2023 09:33:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 691EFB80EB5;
        Mon,  9 Jan 2023 17:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845B3C433EF;
        Mon,  9 Jan 2023 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673285588;
        bh=c9HaNWf+qRzsAPgswmDVpuIDjXWxSu2Z5YT0YjFnKeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikRrQot6KCXH1qhQA0JrxmN7jM5I/mAVmtc0TYELFhQ9HBD/V1LzuwrMOUoHfTOUn
         ODo7OufFVhG9B7pXAtvJG3MmhGyRcKjDWCk/uigVPKWWDRHFTLQTEv/H387R8eVo2W
         k5Sf0+ACu194kvxA4le1GTfY+kXAbfjyuRuQ/79qNAqUIL/cc0BaRV4VdoJMUpVcGv
         iwvVhrLBSw9ucWSQ+5CvIUQk0QB7JowrOnbCgZCvCTY7WW69M+S3wEQ9m0aXRxmwQK
         Nvk5JhXNlc/YOHsLqRYKOdQUdIRm+YoSIy208IYMs5tuCZLWNkAgmPdP95Utt7tA/B
         vrPBAxMt50kpg==
Date:   Mon, 9 Jan 2023 17:33:03 +0000
From:   Lee Jones <lee@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v11 2/2] mfd: max597x: Add support for MAX5970 and MAX5978
Message-ID: <Y7xPzz4Dtse9+Czd@google.com>
References: <20221116205822.1128275-1-Naresh.Solanki@9elements.com>
 <20221116205822.1128275-3-Naresh.Solanki@9elements.com>
 <Y3YJ2EkYNW+gA+/R@google.com>
 <5d9e41b8-7b2a-d60b-3e92-641cea5a9f4a@9elements.com>
 <Y5HXWk4d5J9VgFBV@google.com>
 <921915e5-6b36-9d2d-ebd7-632403e3086a@9elements.com>
 <Y5mbyICg22UVFASw@google.com>
 <50212c7a-6525-4a91-f9a3-c60024b5e91d@9elements.com>
 <Y6WgtNZfeLMwPhCh@google.com>
 <01d39bc6-338d-fd1f-1718-15e0594af0f1@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01d39bc6-338d-fd1f-1718-15e0594af0f1@9elements.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Naresh Solanki wrote:

> Hi Lee,
> 
> On 23-12-2022 06:06 pm, Lee Jones wrote:
> > On Wed, 14 Dec 2022, Naresh Solanki wrote:
> > 
> > > Hi Lee,
> > > 
> > > On 14-12-2022 03:17 pm, Lee Jones wrote:
> > > > On Wed, 14 Dec 2022, Naresh Solanki wrote:
> > > > 
> > > > > Hi Lee
> > > > > 
> > > > > On 08-12-2022 05:53 pm, Lee Jones wrote:
> > > > > > On Fri, 18 Nov 2022, Naresh Solanki wrote:
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > On 17-11-2022 03:45 pm, Lee Jones wrote:
> > > > > > > > On Wed, 16 Nov 2022, Naresh Solanki wrote:
> > > > > > > > 
> > > > > > > > > From: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > > > 
> > > > > > > > > Implement a regulator driver with IRQ support for fault management.
> > > > > > > > > Written against documentation [1] and [2] and tested on real hardware.
> > > > > > > > > 
> > > > > > > > > Every channel has its own regulator supplies nammed 'vss1-supply' and
> > > > > > > > > 'vss2-supply'. The regulator supply is used to determine the output
> > > > > > > > > voltage, as the smart switch provides no output regulation.
> > > > > > > > > The driver requires the 'shunt-resistor-micro-ohms' property to be
> > > > > > > > > present in Device Tree to properly calculate current related
> > > > > > > > > values.
> > > > > > > > > 
> > > > > > > > > Datasheet links:
> > > > > > > > > 1: https://datasheets.maximintegrated.com/en/ds/MAX5970.pdf
> > > > > > > > > 2: https://datasheets.maximintegrated.com/en/ds/MAX5978.pdf
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> > > > > > > > > Co-developed-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > > > > > > > Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> > > > > > > > > Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > > > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > > > > > > > ---
> > > > > > > > >      drivers/mfd/Kconfig         |  12 +++++
> > > > > > > > >      drivers/mfd/Makefile        |   1 +
> > > > > > > > >      drivers/mfd/max597x.c       |  93 +++++++++++++++++++++++++++++++++
> > > > > > > > >      include/linux/mfd/max597x.h | 101 ++++++++++++++++++++++++++++++++++++
> > > > > > > > >      4 files changed, 207 insertions(+)
> > > > > > > > >      create mode 100644 drivers/mfd/max597x.c
> > > > > > > > >      create mode 100644 include/linux/mfd/max597x.h
> > > > > > > > 
> > > > > > > > Ignoring my comments won't make them go away. :)
> > > > > > > > 
> > > > > > > > Please tell me why you need a whole new driver, instead of adding
> > > > > > > > support to simple-mfd-i2c?
> > > > > > > > 
> > > > > > > I felt current implementation to be simpler, clearer & straight forward.
> > > > > > 
> > > > > > If you can make it work with simple-mfd-i2c, please do so.
> > > > > simple-mfd-i2c doesn't has mechanism to pass device type(max5978 vs
> > > > > max5970).
> > > > 
> > > > `git grep silergy,sy7636a -- drivers/mfd`
> > > I did check the driver but there is no mechanism to distinguish between chip
> > > variant i.e., 597x-regulator driver should be able to distinguish between
> > > max5978 vs max5970 chip type.
> > 
> > How is it doing that presently?
> Using i2c_device_id. driver_data hold chip variant info based on compatible
> match.
> > 
> > Why can't the Regulator driver read the DT or match on the parent's
> > compatible for itself?
> There are three drivers i.e., max597x regulator, led & iio driver.
> I'm not sure if checking compatible in each driver is ok.
> Recommendation ?

Sure it is.  The leaf devices can know that they are children and can
read their parent's device tree node without issue.

> > Providing a 100 line driver just to figure out a single value that is
> > only going to be used in a single driver is a no-go.  Please find a
> > better way to solve this.Yes but simple-mfd-i2c doesn't help in
> > distinguishing chip variant & in
> situation like absence of device id register, mfd cell driver cant determine
> chip type to initialise accordingly.
> Can you please recommend me an approach that can also handle this kind of
> scenario.

Place the hardware IDs in DT.

-- 
Lee Jones [李琼斯]
