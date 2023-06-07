Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3746672550E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238670AbjFGHJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjFGHJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 03:09:14 -0400
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6251A7;
        Wed,  7 Jun 2023 00:09:11 -0700 (PDT)
Received: from ed3e173716be.home.arpa (unknown [124.16.138.125])
        by APP-05 (Coremail) with SMTP id zQCowAA3P4vlLIBk8SHQDA--.699S2;
        Wed, 07 Jun 2023 15:08:22 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     andy.shevchenko@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linus.walleij@linaro.org,
        brgl@bgdev.pl, palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: Re: [PATCH v3] gpio: ath79: Add missing check for platform_get_irq
Date:   Wed,  7 Jun 2023 15:08:19 +0800
Message-Id: <20230607070819.48553-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3P4vlLIBk8SHQDA--.699S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF15Gw4kWr4kGrWxAF1fJFb_yoW8Gw17pF
        W5KFWvka1kGa1j9wn7ZrWruFW0yan3KryrArWrta45Kwn8ZF9a9r4fKw4Y9FyxCry8Awn2
        vw4ruan0gF9rZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
        nxnUUI43ZEXa7VUjGXdUUUUUU==
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

On Tue, 6 Jun 2023 17:46:36 +0800 Andy Shevchenko wrote:
> Tue, Jun 06, 2023 at 12:28:17PM +0300, andy.shevchenko@gmail.com kirjoitti:
>> Tue, Jun 06, 2023 at 11:18:41AM +0800, Jiasheng Jiang kirjoitti:
>> 
>> Is this v4?
>>

I will submit a v4.
 
>> > Add the missing check for platform_get_irq() and return error
>> > if it fails.
>> > The returned error code will be dealed with in
>> > module_platform_driver(ath79_gpio_driver) and the driver will not
>> > be registered.
>> 
>> No, this functional change and has not to be for the fixes unless _this_ is the
>> regression you are fixing. Did the driver work before at some point as after
>> this change?

I will remove the fixes tag in v4.

> 
> To be more clear, answer to the following questions:
> 1) does driver work with wrong DT configuration?
> 2a) if yes, does it make sense, i.e. the hardware functioning usefully?
> 2b) if yes, can we guarantee there are no broken configurations in the wild?
> 
> Depending on the answers correct your code and/or commit message.
> 
>> Otherwise you have to _justify_ that this functional change won't break
>> existing setups (with broked IRQ in Device Tree, for example).

Sorry, I do not quite understand what you mean.
I have no idea how these questions are related to my patch.
Do you mean I should not fail the ->probe() if there is wrong IRQ numbering in the DT?
Please tell me the relationship between these questions and my patch.

Thanks,
Jiasheng

