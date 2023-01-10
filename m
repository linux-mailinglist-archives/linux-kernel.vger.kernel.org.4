Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A005663D92
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjAJKKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjAJKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:10:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA7D50077;
        Tue, 10 Jan 2023 02:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B02836158C;
        Tue, 10 Jan 2023 10:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA977C433D2;
        Tue, 10 Jan 2023 10:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673345430;
        bh=WtkD3fgcT/V/aD9xZUmo9gan+NObb/SCd4K+6eNjohE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q/K58+8xpC4PBOm0KszxKhDcgrUj0+54le4B9SiLlb3VeWwx5RQ+DflzkjhIi5Vig
         3SYCbWl/juQd0aGsxXQU1U41tJOGGtx6J9fLoSTfzYrrGd0HFH3Y2cAy87hqp4fgL6
         xqWSo9zhmw2G1EESaVlqIuKnC7CBPBi4BcT10Rdq9BHNqhh65c1KkrRdCGbAy1x09I
         6blx9gLYfTMkb1eln/ViPPyj6m3VpTo4pLqvMEcf8Qt0G/m0cvFTePEdu4Az6D1zFH
         aa9Nog4WpannORRtelSUPTaF0AXxhLP235LdOZd2TCRgMObRL928cEpykEA5VbvI0Z
         svbMDslr+rUsQ==
Date:   Tue, 10 Jan 2023 10:10:24 +0000
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v1 1/1] leds: is31fl319x: Wrap mutex_destroy() for
 devm_add_action_or_rest()
Message-ID: <Y705kJht03zx9yzE@google.com>
References: <20221228093238.82713-1-andriy.shevchenko@linux.intel.com>
 <Y7xJexzNrs4c7WP/@google.com>
 <Y7xQcmYZ8/aSkA2v@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7xQcmYZ8/aSkA2v@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Jan 2023, Andy Shevchenko wrote:

> On Mon, Jan 09, 2023 at 05:06:03PM +0000, Lee Jones wrote:
> > On Wed, 28 Dec 2022, Andy Shevchenko wrote:
> 
> ...
> 
> > Applied, thanks
> 
> Thank you and HNY!

HNYTYT!

-- 
Lee Jones [李琼斯]
