Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDDC6D7DE2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbjDENju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238312AbjDENjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F4B49F9;
        Wed,  5 Apr 2023 06:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4263062923;
        Wed,  5 Apr 2023 13:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB7FC433D2;
        Wed,  5 Apr 2023 13:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680701985;
        bh=71JyiYjAQDNGrKu+w+/togKyzP+qtWLnOs7G5jvJ0Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbkdGElrkRBoUGegV3mZmLyZa43DZoWFu3fZhnCs2uzfNnfX/SYZkeyLc3V3tToOE
         ZPPZvdYBspsu7NmdivFCcCsJ/0kJ0ft/uOsaYeA/tnKHI7HiavjM3fUsJ4D58uvGhC
         IBYGAfxgDF8TcZesH90UaLMcCpPjxWdIJtL4bhsupW1tJ62t84muKF1/rJXaZZ3rj/
         pwhYQZd92udtI+X6pJA9Ng74oTnEKOabVyVIz81i+60kogWJW20h6RTGEv8e81TL9c
         kl0g3cKf+MdCNL+x5P+LPvHP9W5kIle+tRlHVPBcjl2q6IvkN22HXBGfpO6FgaiuIX
         FVoLaFLa+AQbQ==
Date:   Wed, 5 Apr 2023 14:39:38 +0100
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
Message-ID: <20230405133938.GD8371@google.com>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com>
 <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com>
 <MN2PR03MB51685B1F84AA679FB604E738E7929@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230403140950.GF548901@google.com>
 <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZC0zA1bVsrg0XEld@smile.fi.intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Andy Shevchenko wrote:

> On Mon, Apr 03, 2023 at 03:09:50PM +0100, Lee Jones wrote:
> > On Mon, 03 Apr 2023, Sahin, Okan wrote:
>
> ...
>
>
> > > In fact, one of the maintainers suggested assigning chip_info to data
> > > instead of enumeration. Then I added chip_info and put devices into
> > > sub-structure above. I will replace chip_info with id structure in max77541
> > > device structure, right? I will use enumeration for data as I will assign
> > > it to id, and distinguish different devices.
> >
> > Yes, that's correct.  Please remove chip_info altogether.
>
> Then it will provoke casting in the OF ID table which I believe is not what
> we want. I would agree on your first suggestion to have a plain number in I²C
> ID table, but I'm against it in OF and/or ACPI ID table.

And I'm against passing MFD information through the OF/ACPI APIs.

You can put through raw platform data or a device descriptor.

Ref: git grep -A5 "struct of_device_id.*{" -- drivers/mfd

--
Lee Jones [李琼斯]
