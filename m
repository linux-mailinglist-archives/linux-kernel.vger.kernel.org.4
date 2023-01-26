Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9A767D020
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:25:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbjAZPZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjAZPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:25:28 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD44410C5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:25:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id e19-20020a05600c439300b003db1cac0c1fso3447577wmn.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6w50+QY2U2rrBwxg9041R7SovRfW3AKP/5TYIutQHOg=;
        b=EJRmpDzJHoWxYw21CVGGS3KiWAkFKnmB31cgFmJbaPBzPRwQFh31czVGWnJ/VijORv
         v3xLCEBErN5vcJ32H7dopS8vfLXpJrzLyF/Jcg91XNdMNIxtStuwgrk/7vK/MH1UDkWS
         CyB3dJaWE6R4ArqSJbgN+DrCJR9t/2tJY6NvFLjvcfUYgAcKvUUI9iua1W1UpUGf7CO9
         jok519YA0xs2I2iBO+NvR+RRXQl4BTTHzMWc32Lk86YG7Buo555zpJEOZ/W6cYqGBz0H
         PuhahEWGwTpZzogD59o5/4wUO/sX/uuqu6L7bcrpWWYDMLv1tNbQeilQEoF3BbWOcWBL
         TjlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6w50+QY2U2rrBwxg9041R7SovRfW3AKP/5TYIutQHOg=;
        b=Hp4MWVDjqTtL9A6eg3i8HTgv9k2V19ZA769RaljvIQ9FOXA6zgKcFsOPUt/aKmTOQ7
         kkZIqWqpfu5AhTTEebXf/0mNnkKn/JJB+LXgVTVhNcIndejBOGjW1FmvDY2YnQ8IO70O
         p1/LoARX/35wPCdegTPMg/1wYiYy6qPDLXsuoHU4T9Ii5UxMSTSTQLHuBaCBRep1Bisc
         gwZhibVbQOABFE2IDiUEu+at0kcbrj/z56hXAmUm4KG/wlYURbFmg3qR46x9jVpEVbaI
         NUPsvwluh+n3JVrc9KwdnIrgjnJZ0CvfcLTThDEI9FOCcxSr0oLF8BirHOUNwcFhNbI8
         vI7Q==
X-Gm-Message-State: AFqh2kqzun/FHkC4tgMS9YHdbcNSpG9et4xcXvnkxyHX9cWHA3yppzgS
        MQlxf64L82oQYH2dUVwpakSP8w==
X-Google-Smtp-Source: AMrXdXtLC4bCssGF+R4NoHrScxbhIKC9YqJD8l4dvSr7ep98tFgY6KRIv+siazbnR+9t4gJx5wJP+A==
X-Received: by 2002:a05:600c:3b29:b0:3da:f678:1322 with SMTP id m41-20020a05600c3b2900b003daf6781322mr37544644wms.38.1674746721426;
        Thu, 26 Jan 2023 07:25:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c2e0700b003dafa04ecc4sm1653417wmf.6.2023.01.26.07.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:25:21 -0800 (PST)
Message-ID: <83a839c1-ed36-2ee0-d691-39c239a6a351@linaro.org>
Date:   Thu, 26 Jan 2023 16:25:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 7/8] PCI: rockchip: Fixed legacy IRQ generation for
 endpoint
Content-Language: en-US
To:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        alberto.dassatti@heig-vd.ch
Cc:     xxm@rock-chips.com, wenrui.li@rock-chips.com,
        rick.wertenbroek@heig-vd.ch, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Kovanen <mikko.kovanen@aavamobile.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20230126135049.708524-1-rick.wertenbroek@gmail.com>
 <20230126135049.708524-8-rick.wertenbroek@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126135049.708524-8-rick.wertenbroek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 14:50, Rick Wertenbroek wrote:
> Added generation of legacy IRQ (INTx) for the RK3399 SoC PCIe EP core.

Here and in all other patches and subjects: Use imperative, not past tense.
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

"Fix legacy IRQ", not "Fixed legacy IRQ".

> The generation of the legacy interrupt was validated with the PCIe EP
> test driver. Generation of IRQ through the core is documented in the
> TRM and is done through the PCIE_CLIENT_LEGACY_INT_CTRL register of
> the core.
> 

If this is a fix, you need fixes tag and maybe cc-stable. Also the bug
should be described - it's effect, impact. Then the patch should be
first in the series (or even entirely separate).
Best regards,
Krzysztof

