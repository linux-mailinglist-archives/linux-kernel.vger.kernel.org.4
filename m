Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC91E708734
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjERRsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjERRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:48:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3CC997;
        Thu, 18 May 2023 10:47:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7669865097;
        Thu, 18 May 2023 17:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B473CC433D2;
        Thu, 18 May 2023 17:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684432075;
        bh=QQbT/H+RhsbZvXK7PdSe10D3Oq+2SsaxOfRTrjkPKT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=psL702gx1GrogPBlTwC+UYcP8IbOTuo/EBujZxTKJgoxloTQ01faEClLdpWXZp1RC
         TQNWL/XkNQ5mgSbk+1L4Rf3qKNsEWnuTD2kVnFk0BaZlV4Pd3SDaJS4itJsXxO1gCG
         kAYrS73B+MjCUXkfSznKtTXWvccBjlGyEcnU+PRQWFr/nIKQl26/GohstbrdJlbLb/
         YuENcXDcLNmhz7RIz2r04Rnxks0PKHSdaHs0e7gNSQ8AM6gxw8agTyBNuF9cxJZfBe
         gleuxThJQk3owQVerm+XLkZcBdLdmDTZGo97e4y4CHDOHLInfbUuM0nozDRu6RGz2C
         u139V1XrohELw==
Date:   Thu, 18 May 2023 13:47:54 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
        arnd@arndb.de, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH AUTOSEL 6.3 6/7] powerpc/fsl_uli1575: Allow to disable
 FSL_ULI1575 support
Message-ID: <ZGZkylhlTdJoZJ3V@sashalap>
References: <20230509035455.59524-1-sashal@kernel.org>
 <20230509035455.59524-6-sashal@kernel.org>
 <62539831-1f8c-d908-bd7c-2a926702fa7f@infradead.org>
 <87jzxix9g7.fsf@mail.lhotse>
 <20230509071835.rrfefrhwtwsxlngy@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230509071835.rrfefrhwtwsxlngy@pali>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2023 at 09:18:35AM +0200, Pali Rohár wrote:
>On Tuesday 09 May 2023 17:14:48 Michael Ellerman wrote:
>> Randy Dunlap <rdunlap@infradead.org> writes:
>> > Hi--
>> >
>> > Just a heads up. This patch can cause build errors.
>> > I sent a patch for these on 2023-APR-28:
>> >   https://lore.kernel.org/linuxppc-dev/20230429043519.19807-1-rdunlap@infradead.org/
>> >
>> > Michael, I think this is your area if I'm not mistaken.
>>
>> Yes. The fix is in my fixes branch as:
>>   536d948a8dee ("powerpc/fsl_uli1575: fix kconfig warnings and build errors")
>>
>> But I don't think this commit (22fdf79171e8) really warrants going to
>> stable, it's a nice-to-have but doesn't fix any pressing bugs.
>
>Exactly. And also this patch alone without 1/8 would not work as in 1/8
>https://lore.kernel.org/all/20230409000812.18904-2-pali@kernel.org/ was
>added static inline variant of function which is used when ULI is
>disabled.

I'll drop it, thanks!

-- 
Thanks,
Sasha
