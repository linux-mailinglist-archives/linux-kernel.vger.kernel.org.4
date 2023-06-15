Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFA7323C8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjFOXpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFOXpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:45:33 -0400
X-Greylist: delayed 456 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 16:45:32 PDT
Received: from mail.mleia.com (mleia.com [178.79.152.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8252944;
        Thu, 15 Jun 2023 16:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1686872275; bh=A6u4x3jb4/LgEVxlUE3uiaMkSr1fIxiRRK9Z09fHPs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cgQ+IxqM9hQOpJGD4SPGH7AjRTFcxnmYJG8UnJ8d24xHf7XplBzVmnxcfBtf6T+gA
         rFqNQZnbIxRXB4bYsblXlg5ppkBfjpYHvHiVmwe4grj6Yd5hNXT1VEBFK0z0Mn+ZVq
         YLzEJXhQn1aF9Y8ZhfE9mcd/uul2jbPAtPcThihGBr5FmEYSyb3x44sZlUTwQA+G1h
         2+5sF7GVjGGCnZiFxK62fwsyk7FEABEk3AC67w3jTXbzOrR+X9CavmW2ckoKetNal8
         s8fHuoPbNXXNzw03aihH8KqtdnbbQEw8yweGHlHzoYINVYAIM3JvxifFkZjePhtbhW
         royYMB/E7xveg==
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 15DF142C531;
        Thu, 15 Jun 2023 23:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
        t=1686872275; bh=A6u4x3jb4/LgEVxlUE3uiaMkSr1fIxiRRK9Z09fHPs0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cgQ+IxqM9hQOpJGD4SPGH7AjRTFcxnmYJG8UnJ8d24xHf7XplBzVmnxcfBtf6T+gA
         rFqNQZnbIxRXB4bYsblXlg5ppkBfjpYHvHiVmwe4grj6Yd5hNXT1VEBFK0z0Mn+ZVq
         YLzEJXhQn1aF9Y8ZhfE9mcd/uul2jbPAtPcThihGBr5FmEYSyb3x44sZlUTwQA+G1h
         2+5sF7GVjGGCnZiFxK62fwsyk7FEABEk3AC67w3jTXbzOrR+X9CavmW2ckoKetNal8
         s8fHuoPbNXXNzw03aihH8KqtdnbbQEw8yweGHlHzoYINVYAIM3JvxifFkZjePhtbhW
         royYMB/E7xveg==
Message-ID: <ee48b34f-b948-0008-63ae-a6b2b396446a@mleia.com>
Date:   Fri, 16 Jun 2023 02:37:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v1 1/1] gpio: lpc18xx: Remove unused of_gpio.h inclusion
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
References: <20230615162519.21244-1-andriy.shevchenko@linux.intel.com>
From:   Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20230615162519.21244-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20230615_233755_113557_A2856BF7 
X-CRM114-Status: UNSURE (   6.83  )
X-CRM114-Notice: Please train this message. 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 19:25, Andy Shevchenko wrote:
> The of_gpio.h is not and shouldn't be used in the GPIO drivers.
> Remove it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Thank you for the correct change.

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
Best wishes,
Vladimir
