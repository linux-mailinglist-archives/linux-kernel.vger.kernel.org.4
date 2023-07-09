Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB1A74C443
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjGINKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 09:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGINKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 09:10:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102D3FA;
        Sun,  9 Jul 2023 06:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=gexUvKKIc9oDoq/NsirfrhorBTnN0Cb1DAtE70BoWvM=; b=ag36sDrMwjfnkB3dAcxl63zNfz
        gJ6ykzI0aQN221xWuTFehjev7jovx15LwGm3lvAkKQQ7749MbzKFquJ1KY4AzW/Py4JIDOnzl2UW2
        /t4HEzsg3lMPO9MTflpcZRBFeq4JGZ0b72DjMB55Rk6b1PADrfJGB1MIkvWV7PO4YQlJ6UzWS09gb
        eGQHmImlU6JwPLd9oETxROD3tV7P2akXvdZPUJ+a5/zPutGjMqtHExWiN/Iwv6ufg6Nnfs9AUaAdF
        F22TSBUdaUDouBBtFnWRxAZhXAmSnaem/rMnEFPANKFvqe52PJPim2giwc+uZfRYhzZREFIalqbn6
        daNjYc8g==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIUAk-0098nP-2j;
        Sun, 09 Jul 2023 13:09:54 +0000
Message-ID: <93529a87-f794-8c51-7963-66277ef5e1d6@infradead.org>
Date:   Sun, 9 Jul 2023 06:09:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Build regressions/improvements in v6.4 (wireless/airo)
Content-Language: en-US
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
References: <CAHk-=wi7fwNWfqj-QQqEfZTUOB4bbKT8QiEUDHoPk0ecuYA7cA@mail.gmail.com>
 <20230626081950.2090627-1-geert@linux-m68k.org>
 <39abf2c7-24a-f167-91da-ed4c5435d1c4@linux-m68k.org>
 <2f6ffd1c-a756-b7b8-bba4-77c2308f26b9@infradead.org>
 <300ea73d06587f493a2eeb962e5f62776f3676ac.camel@physik.fu-berlin.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <300ea73d06587f493a2eeb962e5f62776f3676ac.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/23 00:38, John Paul Adrian Glaubitz wrote:
> Hi Randy!
> 
> On Sat, 2023-07-08 at 19:45 -0700, Randy Dunlap wrote:
>> Adrian, what toolchain do you use for arch/sh/ builds?
> 
> I'm currently using the sh4 toolchain from here:
> 
>> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/11.1.0/

I use the crosstools from there also.

How do you avoid the build errors as listed here?
  http://kisskb.ellerman.id.au/kisskb/buildresult/14948832/

thanks.

-- 
~Randy
