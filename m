Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A4A6A95BD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 12:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjCCLCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 06:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjCCLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 06:02:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E045F6D1;
        Fri,  3 Mar 2023 03:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E301617ED;
        Fri,  3 Mar 2023 11:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9514DC433EF;
        Fri,  3 Mar 2023 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677841319;
        bh=FIRwj8HGUMB0w7zX1cOSIoPalGx7LYpTQXTv6H51pTs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gK7qtsDeZIFWGoDzCStnzybJ2DQ6uz/fnJ/gEDEh6lFgKoNMwOKen37TsgrluXcTb
         PYzWvzuX5VUqJoV0hcNfzQWTSo2wqrxcr1axL5nd5aCT2QdqO8jd6yVQWWycPn2I3t
         KaW3ul5uYLgSdmH8XAx1/97E7tmCvHFxxdwGE6yj8kI/Uwxsb8KUJuQlpz9Cdm37vF
         +UOK+0bS8F6r+sfnvvxOckbeljIuKNR9JFETajGJ58Qy0005fhccDLSH9R9myXxZDC
         wcHbdC2rBD0/NXV2fHLlK+h1whr3qFSJpeyKEYvmO0r3AyB4GFEu8T9XbcS3A8RBa5
         UYC6Rvyszp6QQ==
Date:   Fri, 3 Mar 2023 11:01:55 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Subject: Re: [PATCH 04/27] mfd: intel_soc_pmic_crc: remove MODULE_LICENSE in
 non-modules
Message-ID: <20230303110155.GD2420672@google.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-5-nick.alcock@oracle.com>
 <Y/joT9FM5Q8Fz7Hw@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/joT9FM5Q8Fz7Hw@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2023, Andy Shevchenko wrote:

> On Fri, Feb 24, 2023 at 03:07:48PM +0000, Nick Alcock wrote:
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules. As a consequence, uses of the macro
> > in non-modules will cause modprobe to misidentify their containing
> > object file as a module when it is not (false positives), and modprobe
> > might succeed rather than failing with a suitable error message.
> > 
> > So remove it in the files in this commit, none of which can be built as
> > modules.
> > 
> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> 
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: linux-modules@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Lee Jones <lee@kernel.org>
> 
> Please, use --cc parameter instead of polluting commit message.

I personally use this a lot.  It's better for scripting.

It's okay, I will remove this when applying.
 
> With this addressed,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> > diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_crc.c
> > index b1548a933dc3..b745ace46e5b 100644
> > --- a/drivers/mfd/intel_soc_pmic_crc.c
> > +++ b/drivers/mfd/intel_soc_pmic_crc.c
> > @@ -271,6 +271,5 @@ static struct i2c_driver crystal_cove_i2c_driver = {
> >  module_i2c_driver(crystal_cove_i2c_driver);
> >  
> >  MODULE_DESCRIPTION("I2C driver for Intel SoC PMIC");
> > -MODULE_LICENSE("GPL v2");
> >  MODULE_AUTHOR("Yang, Bin <bin.yang@intel.com>");
> >  MODULE_AUTHOR("Zhu, Lejun <lejun.zhu@linux.intel.com>");
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

-- 
Lee Jones [李琼斯]
