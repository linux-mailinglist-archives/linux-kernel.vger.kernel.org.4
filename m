Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467DC6CEC42
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjC2O4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2O4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BE712E;
        Wed, 29 Mar 2023 07:56:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80B28B8235D;
        Wed, 29 Mar 2023 14:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F10C433EF;
        Wed, 29 Mar 2023 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680101804;
        bh=FCJy/eYSZT7WLb3OmK/7JeXcs8+xQniddc7s7LZp8ko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CZlNV5JjqH5js/0zQleguzsHeOZkCCPx4jL1M1Y+jBMvpkJ4pvL277nYQ+sGqk2qe
         4SaOYNFvs/9Q1inf4qDJfx7hQm/4FWZBnQmLbmWFUT0wJMyIn4+rKAXCYtcjlQ9aU7
         hxzUqHVtVqo/g8ej+ooE9wQEZLslhGn/LFd1FTmo7Sf3inqF9thLJG03Q5QP9aTTcA
         kXSEAnyKzL9TY/Byv0OpBztC1Dr/4gmr1gxviXXlcVI3HSXvpgxVqXW9JpiNslorVN
         aYU/dPg06KkIG7Vp45x9JNFH3sEjPCwTKgqEm7NCm1aogS8QwJ58wrn5IJMJQ8mGC7
         mt4VfNjupKBug==
Date:   Wed, 29 Mar 2023 15:56:36 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 5/5]  mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230329145636.GV2673958@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <ZCROpw0il1VQCLPu@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCROpw0il1VQCLPu@smile.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023, Andy Shevchenko wrote:

> On Wed, Mar 29, 2023 at 03:36:15PM +0100, Lee Jones wrote:
> > On Tue, 28 Mar 2023, Sahin, Okan wrote:
> > > >On Wed, 15 Mar 2023, Lee Jones wrote:
> > > >> On Tue, 07 Mar 2023, Okan Sahin wrote:
>
> ...
>
> > > +static const struct i2c_device_id max77541_i2c_id[] = {
> > > +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
> > > +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
> >
> > Just 'MAX77540' is fine.
>
> I tend to disagree.
>
> There is an error prone approach esp. when we talk with some functions
> that unifies OF/ACPI driver data retrieval with legacy ID tables.
> In such a case the 0 from enum is hard to distinguish from NULL when
> the driver data is not set or not found. On top of that the simple integer
> in the legacy driver data will require additional code to be added in
> the ->probe().

Use a !0 enum?

The extra handling is expected and normal.

--
Lee Jones [李琼斯]
