Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93629744684
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 06:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGAEX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 00:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGAEXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 00:23:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0422B18B;
        Fri, 30 Jun 2023 21:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=qIdEH/3QpbvyE6cOYWqfNPu7Y9otckUPETZUqn5G5cg=; b=XvV6wlT54mzxpr6yUqBuT0xy/t
        wbAbVXjPVdM1KPWxQCCVhBeX9tOxe2N9Bsm97GuCkmS5hwbHwdFeGnKNHJkKFmqsf02+RDoXPHzw0
        Cc45hM+dg8pskbn+7SkQiwYZiEeCS7uKfeD99ROtwcCLEuYxt5aHKuQa9rATqlLZlx79PZtANah1I
        jE7t/kfewSvEQQRMJE/esFTBCHVazdYqYOz2ix2y3jDHbK/XISmJmfOqy42t0YAHkBO5MqIChDsqs
        lQ78ZB5lt8qbvm8jau6ZGgWE7fO53EgU4wMLKWqS5WoXY+WxwO3AwcI6XjgASD2RLGiSHjjXcyE9L
        QEBgLd6Q==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qFS8T-0058Lu-24;
        Sat, 01 Jul 2023 04:23:01 +0000
Message-ID: <e98fdf36-92bb-2655-41dc-6e31eb128f37@infradead.org>
Date:   Fri, 30 Jun 2023 21:23:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] kconfig: menuconfig: remove jump_key::index
Content-Language: en-US
To:     Jesse T <mr.bossman075@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230629160351.2996541-1-masahiroy@kernel.org>
 <20230629160351.2996541-2-masahiroy@kernel.org>
 <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAJFTR8Txd-6-=5RSoHhgg1a6mr4rEAUv2Ta1F5OLsC3NC4U-Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 6/30/23 21:08, Jesse T wrote:
> On Thu, Jun 29, 2023 at 12:03 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>
>> You do not need to remember the index of each jump key because you can
>> count it up after a key is pressed.
>>
>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>> ---

> 
> One slight off-topic question.
> The names of the menu-based config programs have names similar to their
> corresponding file gconfig ('gconf'), xconfig ('qconf'), menuconfig ('mconf'),
> and nconfig ('nconf'). The only exceptions to this one-letter naming are mconfig
> is not memuconfig and qconfig isn't xconfig. Would it be possible to
> add an alias
> to fix this?
> 
> Side-side note config isn't in the docs.

I'm not following what you mean here.
Are you referring to 'make config'?

So: what documentation is missing and where would it be found?

thanks.
-- 
~Randy
