Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FF3640AEE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiLBQh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiLBQhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:37:25 -0500
Received: from mail1.systemli.org (mail1.systemli.org [IPv6:2a11:7980:3::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D19E460;
        Fri,  2 Dec 2022 08:37:23 -0800 (PST)
Message-ID: <8f4aa3af-004e-e479-9b75-2a01a97a6b76@systemli.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=systemli.org;
        s=default; t=1669999040;
        bh=nkBMNsdfmdehnVkOzVukiBB3XyA1WIc2UEileVdjQa0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c1mBjL+8rvPfCaBscfO3FnDSc7MUSTZLGvpx71DwfsDtVzk59EF1y7FVZYZ9ngWQP
         OVtM/dVTbqyoGTB7uLq5tnMfUwi4mET/IeO9nN9CmKX9Sod+uBGR6zEUApZQX/xLbk
         06AbAAXKEqjY9r2a2r8+7gm0aEeedUWM/S+jp8xvZHKd013TxivBIBtM9l7zVTjZv0
         clChHT06iG++ycyA0kYXKXsFD65Z4VC+TREeYxdiLfVfZmnIh1gtdOW8hrP06u+RZ/
         ST4RKXTljsL3P6PsSMS9oYQE1vPS+vLU+grl0MuTYe64VXFj30oKPwdMuoaK7gPMAJ
         8roykGap91Cxg==
Date:   Fri, 2 Dec 2022 17:37:16 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] gpiolib: fix compiling when CONFIG_GPIO_CDEV_V1 is not
 defined
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-next@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221202140454.273333-1-vincent@systemli.org>
 <Y4oMCYksMaQ6KYwU@smile.fi.intel.com>
 <CAMRc=Mc2XtcbZPh5pic_uYiOuie0+5KdMO2hJav2HYGc_3ygfw@mail.gmail.com>
Content-Language: en-US
From:   Nick <vincent@systemli.org>
In-Reply-To: <CAMRc=Mc2XtcbZPh5pic_uYiOuie0+5KdMO2hJav2HYGc_3ygfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 15:48, Bartosz Golaszewski wrote:

> Yeah, if Nick is fine with that, I'd like to squash it with the
> offending commit or we'll break bisectability.
Go for it. :)
