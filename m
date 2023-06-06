Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D616723536
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjFFCVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjFFCVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:21:38 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D93122;
        Mon,  5 Jun 2023 19:21:34 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowADndBAjmH5kCLQdDA--.6981S2;
        Tue, 06 Jun 2023 10:21:26 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andy.shevchenko@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v3] gpio: sifive: Add missing check for platform_get_irq
Date:   Tue,  6 Jun 2023 10:21:21 +0800
Message-Id: <20230606022121.37914-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowADndBAjmH5kCLQdDA--.6981S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF1rGw4rXw1UCFy5tFykuFg_yoWfXrX_Kr
        4vkr13uay0krs5J3Z0qrZ8CF4DZw48Gr4jkr4kCrnaqw43Ja40gaykKF9Yya42qwn7K347
        WryF939xAry2qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbVAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JUCg4hUUUUU=
X-Originating-IP: [124.16.138.125]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 17:15:53 +0800 Andy Shevchenko wrote:
> On Mon, Jun 5, 2023 at 12:13 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Mon, Jun 5, 2023 at 4:49 AM Jiasheng Jiang <jiasheng@iscas.ac.cn> wrote:
>> >
>> > Add the missing check for platform_get_irq() and return error code
>> > if it fails.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 
> Actually, the change is functional and now the wrong IRQ numbering in
> the DT will fail the ->probe(). This needs an additional explanation
> in the commit message why it's not a problem.
> 
>> > -       for (i = 0; i < ngpio; i++)
>> > -               chip->irq_number[i] = platform_get_irq(pdev, i);
>> > +       for (i = 0; i < ngpio; i++) {
>> > +               ret = platform_get_irq(pdev, i);
>> > +               if (ret < 0)
>> > +                       return ret;
>> > +               chip->irq_number[i] = ret;
>> > +       }

I will submit a new v3 adding the explanation.

Thanks,
Jiasheng

