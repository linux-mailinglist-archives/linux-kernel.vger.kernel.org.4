Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2026B91A2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjCNL2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCNL2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:28:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E37289
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:28:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r11so8994996edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678793328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mp6lCTm0GtptxtxRrLExZCzI3QrPES0tPf35p8wWDuc=;
        b=IN+O49TT0tMAyXsSO7et5QmlDk9EAdWycwVd3xcCsZJFVlw8t4sKqzBCjOtMBt/EmU
         J4/ff2rGayurEDkrK/51oOG3j82zyymubwTkK3ANIfrwyYxUwt+MqE1lMMTll2PYJFWL
         WRyq39hwyFm9wQKJulCyEtwfCuk5f11O2lPsoGf2CmC81MVJOe654NhFIvonHEqxm7Fl
         wbw/1ZRyVr3Vijt+es8pq9lmRu3BSrjxW22OR85u9AJwWbk1l3ONtxCqXavrRTy4cXjr
         IzvIlPPrGN4vCgZvgXlDWaZYkOpoL+7MNAL1aaNCMg0DWryeeybPmu0Mzd5TCrVHLqYJ
         iPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678793328;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mp6lCTm0GtptxtxRrLExZCzI3QrPES0tPf35p8wWDuc=;
        b=FkQHhTV/Ab0Rd8dBgwf2hI+h67KoWs1RBt4Q6e5/r8UNckmPqh0CYB/yYo1lVKtHnZ
         vtlYq8zIMhwG0kxT7VPL0rRI3arUSvvziTIwxpx6SttWW683ly1VhQJy3cBmCDVphyka
         vAVAI5s3Ycd9oSaG2UAX3yxqxarAh7oxDOcXwC73y9f+mz34dPtjK97O6WK83kIVwLqP
         6M9boZ5aZzWpcE6bR165TdstJx4qLfQUIQPiiOzQUYuwXIm04TXTRPjaEtI5p37nZo1D
         uBqvq15+Up1i3bukJVsPc7Yn5NrkUCxj2yHcrIR/lfj8Pmu6VabQ7JoAWbSu3Jgc70+H
         P9Zw==
X-Gm-Message-State: AO0yUKVa6znrzLaZmJhfmj4J4Tn+jLWuiwKJgFTX4kfdoyEt4IYxeK3a
        Tow6jck/4Y3UIW6i6wfy6Y9TZA==
X-Google-Smtp-Source: AK7set9i4zvpzhWGSduo3TdWm1rOTpVUD/vPdyR6/Aca0FqX1QiLfmpn8wwIchVmyuMlzRTmg8dTEw==
X-Received: by 2002:a17:906:d8d:b0:91e:ffb9:95eb with SMTP id m13-20020a1709060d8d00b0091effb995ebmr2392511eji.39.1678793328050;
        Tue, 14 Mar 2023 04:28:48 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id gf3-20020a170906e20300b008c06de45e75sm1012769ejb.107.2023.03.14.04.28.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 04:28:47 -0700 (PDT)
Message-ID: <3beadaaa-cacb-8e42-89be-6f0cecd65578@linaro.org>
Date:   Tue, 14 Mar 2023 11:28:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 00/20] [PATCH v3 00/20] nvmem: Layouts support
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Peter Chen <peter.chen@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sebastian Reichel <sre@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 15:31, Miquel Raynal wrote:
> Hello,
> 
> This is a fully featured series with hopefully all what is needed for
> upstream acceptance, ie:
> * A bit of OF cleanup
> * Full nvmem layout support merging Michael's and my patches
> * Only the fixes not applying to this series have been kept "un merged"
> * Support for SL28 VPD and ONIE TLV table layouts
> * Layouts can be compiled as modules
> 
> A linux-0day branch for kernel test robot has been pushed to get wider
> testing.
> 
> In order for this series to work out-of-the-box it requires to be
> applied on top of Michael Walle's mtd fixes series. There is an
> immutable tag on the mtd repository available:
> 
> ----------------------------------------------------------------
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>    Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/core-fixes-before-nvmem-layouts-for-6.4
> 
> for you to fetch changes up to 281f7a6c1a33fffcde32001bacbb4f672140fbf9:
> 
>    mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER (2023-03-08 14:31:49 +0100)
> ----------------------------------------------------------------
> 
> So to summarize:
> * Rob's feedback is welcome on the remaining un-acked OF patche
> * Greg's and Srinivas feedback is welcome on the nvmem patches
> * If everybody agrees I expect the full series to be applied rather
>    early by Srinivas on top of the -rc he wants.

Applied this series to nvmem tree.


thanks,
srini



> * Once time for the final PR I expect Greg to merge the immutable tag
>    above with Michael's patches before taking this series in.
> 
> Thanks,
> Miquèl
> 
> Changes in v3:
> * Rebased on top of nvmem-next and handled a few conflicts.
> * Minor changes in the OF commit logs.
> * Fixed a missing header reported by kernel test robot.
> * Mention immutable tag.
> * Collected more tags.
> * Fix of/module.c license.
> 
> Changes in v2:
> * Included all initial core nvmem changes.
> * Merged all the relevant fixes.
> * Updated the commit logs of the Fixes tag when relevant.
> * Followed Rob advises to migrate the module related helpers into
>    of/module.c and get the useless helpers out of of_device.c
> * Added my Signed-off-by when relevant.
> * Collected tags.
> 
> Colin Ian King (1):
>    dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
> 
> Michael Walle (8):
>    nvmem: core: introduce NVMEM layouts
>    nvmem: core: add per-cell post processing
>    nvmem: core: allow to modify a cell before adding it
>    nvmem: imx-ocotp: replace global post processing with layouts
>    nvmem: cell: drop global cell_post_process
>    nvmem: core: provide own priv pointer in post process callback
>    nvmem: layouts: sl28vpd: Add new layout driver
>    MAINTAINERS: add myself as sl28vpd nvmem layout driver
> 
> Miquel Raynal (11):
>    of: Fix modalias string generation
>    of: Update of_device_get_modalias()
>    of: Rename of_modalias_node()
>    of: Move of_modalias() to module.c
>    of: Move the request module helper logic to module.c
>    usb: ulpi: Use of_request_module()
>    of: device: Kill of_device_request_module()
>    nvmem: core: handle the absence of expected layouts
>    nvmem: core: request layout modules loading
>    nvmem: layouts: onie-tlv: Add new layout driver
>    MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer
> 
>   .../nvmem/layouts/onie,tlv-layout.yaml        |   2 +-
>   Documentation/driver-api/nvmem.rst            |  15 +
>   MAINTAINERS                                   |  12 +
>   drivers/acpi/bus.c                            |   7 +-
>   drivers/gpu/drm/drm_mipi_dsi.c                |   2 +-
>   drivers/hsi/hsi_core.c                        |   2 +-
>   drivers/i2c/busses/i2c-powermac.c             |   2 +-
>   drivers/i2c/i2c-core-of.c                     |   2 +-
>   drivers/nvmem/Kconfig                         |   4 +
>   drivers/nvmem/Makefile                        |   1 +
>   drivers/nvmem/core.c                          | 160 ++++++++++-
>   drivers/nvmem/imx-ocotp.c                     |  30 +-
>   drivers/nvmem/layouts/Kconfig                 |  23 ++
>   drivers/nvmem/layouts/Makefile                |   7 +
>   drivers/nvmem/layouts/onie-tlv.c              | 257 ++++++++++++++++++
>   drivers/nvmem/layouts/sl28vpd.c               | 165 +++++++++++
>   drivers/of/Makefile                           |   2 +-
>   drivers/of/base.c                             |  18 +-
>   drivers/of/device.c                           |  75 +----
>   drivers/of/module.c                           |  74 +++++
>   drivers/spi/spi.c                             |   4 +-
>   drivers/usb/common/ulpi.c                     |   2 +-
>   include/linux/nvmem-consumer.h                |   7 +
>   include/linux/nvmem-provider.h                |  66 ++++-
>   include/linux/of.h                            |  18 +-
>   include/linux/of_device.h                     |   6 -
>   26 files changed, 851 insertions(+), 112 deletions(-)
>   create mode 100644 drivers/nvmem/layouts/Kconfig
>   create mode 100644 drivers/nvmem/layouts/Makefile
>   create mode 100644 drivers/nvmem/layouts/onie-tlv.c
>   create mode 100644 drivers/nvmem/layouts/sl28vpd.c
>   create mode 100644 drivers/of/module.c
> 
