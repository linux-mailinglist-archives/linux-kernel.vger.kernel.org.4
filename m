Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0E677759
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjAWJZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjAWJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:25:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775E715547;
        Mon, 23 Jan 2023 01:25:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B09060DEF;
        Mon, 23 Jan 2023 09:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21629C433D2;
        Mon, 23 Jan 2023 09:25:14 +0000 (UTC)
Message-ID: <b947e565-950f-09a2-6c72-4162d7beed8a@xs4all.nl>
Date:   Mon, 23 Jan 2023 10:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: linux-next: manual merge of the v4l-dvb-next tree with the
 arm-soc tree
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
References: <20230123100923.7899a60f@canb.auug.org.au>
 <ed0880bd-5c0a-4831-a440-2b1600890d35@app.fastmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <ed0880bd-5c0a-4831-a440-2b1600890d35@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 23/01/2023 10:13, Arnd Bergmann wrote:
> On Mon, Jan 23, 2023, at 00:09, Stephen Rothwell wrote:
>> Hi all,
>>
>> Today's linux-next merge of the v4l-dvb-next tree got conflicts in:
>>
>>   drivers/staging/media/Kconfig
>>   drivers/staging/media/Makefile
>>
>> between commit:
>>
>>   582603a95734 ("staging: media: remove davinci vpfe_capture driver")
>>
>> from the arm-soc tree and commit:
>>
>>   d2a8e92f0b41 ("media: vpfe_capture: remove deprecated davinci drivers")
>>
>> from the v4l-dvb-next tree.
>>
>> These 2 commits removed the same driver but caused a conflict due to
>> other changes to these files.
>>
>> I fixed it up (I just used the latter version of these files) and can
>> carry the fix as necessary. This is now fixed as far as linux-next is
>> concerned, but any non trivial conflicts should be mentioned to your
>> upstream maintainer when your tree is submitted for merging.  You may
>> also want to consider cooperating with the maintainer of the conflicting
>> tree to minimise any particularly complex conflicts.
> 
> I can drop my copy of the patch, but from the diffstat I see that
> there are a few other differences: Hans' version removes
> include/media/davinci/ccdc_types.h, which I forgot, while my
> version drops include/media/davinci/vpfe_capture.h (which
> is still included in the v4l-dvb-next tree, but not in mine)
> as well as the obsolete driver specific entries in MAINTAINERS
> and Documentation/userspace-api/ioctl/ioctl-number.rst.
> 
> Hans, any idea what we should do? I'd tend to leave both
> patches where they are and let Linus figure out the merge.
> If I drop mine we need a follow-up patch to remove
> the include/media/davinci/vpfe_capture.h header, while
> dropping yours would likely produce the same conflicts
> against your tm6000/zr364xx removal patches.

I'd say, leave it to Linus. If anything remains of the davinci code
after Linus is done with it, then you and/or I can make follow-up patches.

Regards,

	Hans
