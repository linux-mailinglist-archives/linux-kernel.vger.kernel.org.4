Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021E6EE248
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjDYM6z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDYM6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:58:53 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EC8D30E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:58:52 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a95aef9885so24770305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682427531; x=1685019531;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a9OgNuS/xliARf6ZCvKP0eSIo+wREw7sCzWFZKpnW+8=;
        b=EZkzlGlw5ot01gmpM0s8hrBiyKTvUkY5qigPnw0TGrfX6XvtzXaEQSNaFYHqdBsGiT
         Q98GjOBe76sK0lC125znl+M1/Zj+A9K/U670nEthQd3BhDVIy10xzZ2K3IStJgiZFhCy
         DzIaYipu0kg114EtEzo8ieStQOZJvb+9evXRernazhBcwF5r5EKPzvc+5BaxuzN5hgKu
         YrHO5Qfu05ks5g710FU+5FiAqXGS6l7eUXcgR6UTx5Zyb0G3ksgF15PACcsU1p60QffI
         ABwrOFfrmThSO0zMkzq28hqfYr2iI433p91ChmwefGEtRTAbc9ju4NdLAT1EYfVPZUzS
         FH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427531; x=1685019531;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a9OgNuS/xliARf6ZCvKP0eSIo+wREw7sCzWFZKpnW+8=;
        b=Gi56bWxzoiSqQRgJ2JhGE/tgjSPUq9j60PNZzoSiR5jN4eJtMk3+jE0WL9JG8b/UE2
         sy+jBZLPW8//Bu86/BzGmacqshTQNpzvK5q/hBJUHBYh2BWn/e8UwkIS26hZ5xeTEusO
         swAmIW+wJ2Zo2m67NsOoZOPrHL289oF3lBMvG/+0EmPApfWDwJ3Ch2Ety3p7KZzvjPCN
         2T0S7/8Ck7nTOcMEtvWwmyGotoEi/R2EV/jr7zW3z169b6gIijuIbWcUeL23c7JtbbSs
         z2hpGxWMmVheX5wdzuglUSE/2+Oy/wz2j71Uy6cMZbm9qxkAAevCGbfDJKWoFXOCYLyN
         PRbw==
X-Gm-Message-State: AC+VfDx6VK9Np5C/+X7WAny7s8nICcIM53WWpRfJjD7pQ+UFIK17O9//
        BWLMHpZRSbyzbY2Sn1pY9ho=
X-Google-Smtp-Source: ACHHUZ7+gjY+b/5LdLr5m+KEgaLt1yYVkFLHhS0cLpROPR+3ndTu8/KjhG9tdhOikJGQJXXBoJqE9A==
X-Received: by 2002:a17:902:e543:b0:1a9:7cf7:d959 with SMTP id n3-20020a170902e54300b001a97cf7d959mr6266635plf.19.1682427531156;
        Tue, 25 Apr 2023 05:58:51 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b001a6d781eda6sm8275836pla.120.2023.04.25.05.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 05:58:50 -0700 (PDT)
Message-ID: <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
Date:   Tue, 25 Apr 2023 21:58:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] extcon next for 6.4
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
Content-Language: en-US
In-Reply-To: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Gently ping for v6.4.

Best Regards,
Chanwoo Choi

On 23. 4. 17. 00:28, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.4. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:
> 
>   Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.4
> 
> for you to fetch changes up to 4e30418def07f8359c7927d5815788043afbb482:
> 
>   extcon: Drop unneeded assignments (2023-04-17 00:14:12 +0900)
> 
> ----------------------------------------------------------------
> Update extcon next for v6.4
> 
> Detailed description for this pull request:
> 1. Clean-up extcon core without any behavior changes
> - Add extcon_alloc_cables/muex/groups to improve the readability
>   of extcon_dev_register.
> 
> - Fix kernel doc of property and property capability fields to aovid warnings
>   and add missing description of struct extcon_dev.
> 
> - Use DECLARE_BITMAP macro and sysfs_emit instead of sprintf
> 
> - Use device_match_of_node helper instead of accessing the .of_node
> 
> - Use ida_alloc/free to get the unique id for extcon device
> 
> 2. Update extcon-usbc-tusb320.c to support usb_role_switch and accessory detection
> - Add usb_role_switch support on extcon-usbsc-tusb320.
> 
> - Add additional accessory detection for audio/debug accessory
>   and then pass the deteced accessory information to typec subsystem
>   on extcon-usbsc-tusb320.c.
> 
> - Add the support of unregistration of typec port on both error handling
>   and driver removal step on
> 
> 3. Update extcon provider drivers (apx288/qcom-spmi-misc/palmas)
> - Replace put_device with acpi_dev_put on extcon-axp288.c
> 
> - Use platform_get_irq_byname_optional for getting irq of
>   usb_id and usb_vbus on extcon-qcom-spmi-misc.c.
> 
> - Remove unused of_gpio.h on extcon-palmas.c.
> 
> 4. Fix the devicetree binding document
> - Rename misc node name to 'usb-dect@900' on pm8941-misc.yam
> 
> - Fix usb-id and usb_vbus defintion on pm8941-misc.yaml
> ----------------------------------------------------------------
> 
> Alvin Šipraga (3):
>       extcon: usbc-tusb320: Unregister typec port on driver removal
>       extcon: usbc-tusb320: add accessory detection support
>       extcon: usbc-tusb320: add usb_role_switch support
> 
> Andy Shevchenko (13):
>       extcon: axp288: Replace open coded acpi_dev_put()
>       extcon: palmas: Remove unused of_gpio.h
>       extcon: Fix kernel doc of property fields to avoid warnings
>       extcon: Fix kernel doc of property capability fields to avoid warnings
>       extcon: Use DECLARE_BITMAP() to declare bit arrays
>       extcon: Use sysfs_emit() to instead of sprintf()
>       extcon: Amend kernel documentation of struct extcon_dev
>       extcon: Use device_match_of_node() helper
>       extcon: Use dev_of_node(dev) instead of dev->of_node
>       extcon: Remove dup device name in the message and unneeded error check
>       extcon: Use unique number for the extcon device ID
>       extcon: Use sizeof(*pointer) instead of sizeof(type)
>       extcon: Drop unneeded assignments
> 
> Arnd Bergmann (1):
>       extcon: usbc-tusb320: add USB_ROLE_SWITCH dependency
> 
> Bryan O'Donoghue (2):
>       dt-bindings: pm8941-misc: Fix usb_id and usb_vbus definitions
>       extcon: qcom-spmi: Switch to platform_get_irq_byname_optional
> 
> Bumwoo Lee (4):
>       extcon: Remove redundant null checking for class
>       extcon: Add extcon_alloc_cables to simplify extcon register function
>       extcon: Add extcon_alloc_muex to simplify extcon register function
>       extcon: Add extcon_alloc_groups to simplify extcon register function
> 
> Luca Weiss (1):
>       dt-bindings: pm8941-misc: rename misc node name
> 
>  .../bindings/extcon/qcom,pm8941-misc.yaml          |  14 +-
>  drivers/extcon/Kconfig                             |   1 +
>  drivers/extcon/extcon-axp288.c                     |   2 +-
>  drivers/extcon/extcon-palmas.c                     |   1 -
>  drivers/extcon/extcon-qcom-spmi-misc.c             |   4 +-
>  drivers/extcon/extcon-usbc-tusb320.c               | 153 +++++++--
>  drivers/extcon/extcon.c                            | 368 ++++++++++++---------
>  drivers/extcon/extcon.h                            |   8 +-
>  8 files changed, 354 insertions(+), 197 deletions(-)

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

