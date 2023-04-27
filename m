Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79266F0379
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbjD0JhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242895AbjD0JhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:37:13 -0400
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C22D69
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682588227; bh=7GwSg/VETfevsc3piSQWo4R9qz03aZ3BJS+mJ+1KmqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Gw6XWpfO52Txf3GnQMRel2fpYOy85kLi+OBVcUngZ8b6W5jBrrNGoctMDZ/B9ndUV
         zHv6hsq5jVplnrsIEP0N3rJqxOFLXJvGQXO2K5BnUzpVueGSVGaxUq4nKHct3MV3D5
         ON0nlxfX/fLPMAWqfkzHI2VaemjoCjWG6tRuPRZM=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 91BAA2AE; Thu, 27 Apr 2023 17:36:27 +0800
X-QQ-mid: xmsmtpt1682588187tigkwr02y
Message-ID: <tencent_D9A598A810BDC656BE2BC15A6D0FC76C5C07@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjDF03k4K0vSOU3wg7BGGYLofnVha6/an8Aa/x9/8DpfwPP21hQr
         2Kny59+lA3mDsczPLeIBmCS1gSizPT0UoVZUzDYgt63Tn9iP0nq6vFt3A6H40oVkGYkFIKDCwlad
         B8PI96uF2vElvY9aOzRZUj0BOgrOUy+bcz/lrr3gAh351iBSf2NaKo6VPqYxHsTfOrbz8ritH0/0
         5mqEkAc8xQTkPGcDvr2RIggy9v+denE9SjJeMoiJzFxpEqdlupvjlLPPu9jSU4HUves4m476ricW
         kjhJGy6geNVa+POtdQlYToO/BI8PEqUOyl5Y2r0QIMIoXuvgFgIc3pA80Wl6GmEDAdvig/guuWI+
         RDqybH5517LDK4TJPbVwa/woWWbG4tRVfjgKK7zUG8F9mB0BFHaoXxGQk4ExCs5u0AuSA9P8V+YI
         oxUJUeTGCV41EUDBCxJQw2wyQ/inldOUNeQDkqkr/jiK1chwIhBdbCUlsscWShnXD1NTgyfHWpaC
         u9a7dDJ9HCgKX48JYTCzlHrEZ2LSJEocV6JRojlZGFuLtmYNvBprK0XI5m2WgHWGjpvxpeb9kHdl
         27s6fXY6I7BCEeJv59f8gt4w3EEVXUVBmYvoGY2d7/PLjC2DK5p4ZYQn1ZZMjYXItRjVjadY0Xc5
         My+9I8QsV9cRkZ8GoGFj5mterx2ZKy/XuoBsWAA3FKqtswj6QdCDySTPDA7+pBDXIFL/zD7lIqvz
         TPnH8nTvBU/2UzFz0G3bb4TZ8z6tAjQWC/s1l+HRMHlMoQmIOssoBZJNZPWPtUOMWOd8MvnhIuex
         PMlHW+HRlMvmwEB6D4RX3x2wzGjwvMgjz8JE/8qAQCcG7GohTKYjA5e7Y1jOdV2ZXCnuovRIb43O
         7F7toposXsS4F1U+8gikXkY6hlKMp4d/beQbVmsP9n50uVjsRyK02716efJ6gQ//JaKVtiZsMpU/
         etznZH4ZiPQPUvN6A0b0Fcb96FHJ0Z9IIcXMklGgzuENsDUq34Mw==
From:   Yangyu Chen <cyy@cyyself.name>
To:     conor.dooley@microchip.com
Cc:     ajones@ventanamicro.com, aou@eecs.berkeley.edu, conor@kernel.org,
        cyy@cyyself.name, i@zenithal.me, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, soha@lohu.info, twd2.me@gmail.com
Subject: Re: [PATCH 1/2] riscv: allow case-insensitive ISA string parsing
Date:   Thu, 27 Apr 2023 17:36:25 +0800
X-OQ-MSGID: <20230427093625.155634-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427-unveiling-kiwi-631e966f77cc@wendy>
References: <20230427-unveiling-kiwi-631e966f77cc@wendy>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Conor

I have a different opinion about whether the isa string length should be
checked.

On Thu, 27 Apr 2023 10:04:34 +0100, Conor Dooley wrote:
> Preventing the input of absolute rubbish is dt-validate's job & if the dtb
> itself has been corrupted somehow I suspect that we have bigger problems
> than checking for "rv" will solve.

> > also do a strlen(isa) >= 4 check first, though. of_property_read_string()
> > will succeed even when the string is "".

> I don't think that checking that there are at least 4 characters isn't
> even sufficient. Either we should confirm that this is a valid riscv,isa
> to run on (so rv##ima w/ ## matching the kernel) or not bother at all.

What will happen if we have a bootloader in the future which allows
overriding isa string in the DT or ACPI table, the memory corruption could
happen if we didn't check it first.

Although the kernel will not boot in this case, anything about the user
input string should be parse carefuly that you never know what the future
code will be but leave a checker here will remind someone who will change
the parse in the future to check the length carefully.

So I agree with drew, we should do check strlen before check the first
two characters.

On Thu, 27 Apr 2023 10:04:34 +0100, Conor Dooley wrote:
> It's a different issue though, and I'd be inclined to revisit it in the
> future when the ACPI stuff is in, along with perhaps the cleanup parts
> of Heiko's series too.

Agreed.

Thanks,
Yangyu Chen

