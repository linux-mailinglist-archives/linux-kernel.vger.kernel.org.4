Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C59732AE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343519AbjFPJBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344261AbjFPJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:01:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA0C035A0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:00:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3E921FB;
        Fri, 16 Jun 2023 02:01:43 -0700 (PDT)
Received: from bogus (unknown [10.57.96.87])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C74083F5A1;
        Fri, 16 Jun 2023 02:00:57 -0700 (PDT)
Date:   Fri, 16 Jun 2023 10:00:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     =?utf-8?B?546L5piOLei9r+S7tuW6leWxguaKgOacr+mDqA==?= 
        <machel@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Conor Dooley <conor@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "opensource.kernel" <opensource.kernel@vivo.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQw==?= =?utf-8?Q?H?= v1]
 drivers:base:Fix unsigned compared with less than zero
Message-ID: <20230616090054.b3lxtsj67oyp6s3h@bogus>
References: <20230614133549.3774-1-machel@vivo.com>
 <20230614-passcode-stimulate-70eecb6d81d2@spud>
 <SG2PR06MB374351CD57614B51FF2E71CABD5BA@SG2PR06MB3743.apcprd06.prod.outlook.com>
 <20230615-cathedral-concur-969e91b8c792@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230615-cathedral-concur-969e91b8c792@wendy>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 07:50:45AM +0100, Conor Dooley wrote:
> Hey,
> 
> For some (probably good) reason, this doesn't appear to have made it to
> the lists.
> 
> On Thu, Jun 15, 2023 at 02:05:18AM +0000, 王明-软件底层技术部 wrote:
> > 发件人: Conor Dooley <conor@kernel.org>
> > > On Wed, Jun 14, 2023 at 09:35:36PM +0800, Wang Ming wrote:
> > > > The return value of the of_count_cache_leaves() is long.
> > > > However, the return value is being assigned to an unsigned long
> > > > variable 'leaves',so making 'leaves' to long.
> > > 
> > > But you actually made it an int?
> > > 
> > > > silence the warning:
> > > > ./drivers/base/cacheinfo.c:300:5-11: WARNING: Unsigned expression
> > > > compared with zero: leaves > 0
> > > 
> > > I'm dumb, why is comparing an unsigned value with zero a problem in
> > > and of itself? Zero is a valid value for an unsigned type, no?
> > > 
> > > If you actually look at the function, it only returns positive,
> > > non-zero values anyway, so returning an int is a bit pointless, as
> > > are the checks, no?
> 
> > Thank you, I see. This doesn't need to be fixed.
> 
> Right, but I was suggesting that you should change the function to not
> return a signed value anymore & remove the check for whether it is
> zero, instead of your patch.
> 
> Cheers,
> Conor.
> 
> +CC Sudeep, Pierre: FYI. Original posting is at
> https://lore.kernel.org/all/20230614133549.3774-1-machel@vivo.com/
> in case threading is broken, as I think the in-reply-to header in what
> I am replying to is corrupted.

Also if the original thread landed, I couldn't have responded because of
the disclaimer 🙁.

-- 
Regards,
Sudeep
