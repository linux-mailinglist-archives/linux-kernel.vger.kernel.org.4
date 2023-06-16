Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A264073252D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240723AbjFPCUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240650AbjFPCUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:20:45 -0400
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70321296F;
        Thu, 15 Jun 2023 19:20:40 -0700 (PDT)
X-QQ-mid: Yeas52t1686882009t655t64710
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [183.159.171.58])
X-QQ-SSF: 00400000000000F0FPF000000000000
From:   =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 16673244459846436147
To:     "'Andy Shevchenko'" <andy.shevchenko@gmail.com>,
        "'Michael Walle'" <michael@walle.cc>
Cc:     <linus.walleij@linaro.org>, <brgl@bgdev.pl>,
        <shreeya.patel@collabora.com>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230607081803.778223-1-jiawenwu@trustnetic.com> <CAHp75Vdbq3uHOyrfT-KFYRSj6v+s9GgOQjQ9a8mGn-4HSCpB9Q@mail.gmail.com> <15e2fc098a1e63317368f4812290ca35@walle.cc> <010401d99f6f$26d41600$747c4200$@trustnetic.com> <b9af98d801d2808de3460c9e4fec8bdd@walle.cc> <CAHp75VcgAhaSARXMnRzsDE3x57AjnwS6Ep25Mz7SnizUccG6BA@mail.gmail.com> <012b01d99ff7$e51075e0$af3161a0$@trustnetic.com>
In-Reply-To: <012b01d99ff7$e51075e0$af3161a0$@trustnetic.com>
Subject: RE: [PATCH v2] gpiolib: Fix GPIO chip IRQ initialization restriction
Date:   Fri, 16 Jun 2023 10:20:08 +0800
Message-ID: <012c01d99ff9$12760da0$376228e0$@trustnetic.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJryWnquP8Y9u98p8GNjzLx69HVGQGrRNiSAZtbv08BxPTBjAH/YNofAf5b6aMBhxotga4T2uWQ
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I used to be rough at fixing in my test, I tried to set gc->irq.domain = NULL
> after calling irq_domain_remove() in gpiochip_irqchip_remove().

I'm sorry I remember wrong, 'gc->irq.domain = NULL' was set in regmap_del_irq_chip()
and then called gpiochip_irqchip_remove(). :)

