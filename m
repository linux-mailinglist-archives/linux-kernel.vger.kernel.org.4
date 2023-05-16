Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC5705314
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbjEPQFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbjEPQFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:05:37 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51B130
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:05:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so21027475a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684253134; x=1686845134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8b9bU5+wXWEo/d9j4S9XaKF7bhriqhrqt+qVY4GBq+M=;
        b=ZHf08m4Xjei6lY8zGs8JNweGqgrFLvBabe9WNLfAgmUe0Wxwmx7eoQuiVrnwGcdZ27
         m9NZyYAs7hLzgpLLgWPndkCyCEUppBQ/KtxJkBV9+g2m1h5xUGMm2BKxhpKTPvMQuCSV
         DPhzWLSjCvvDvmA5a6Y+ReeZ03AKfe/KgHGqWY4VSV9A3oOIQ8yhIFSzuFa5a7Go5Wvk
         4k/EASRSKQ0IhSDF0go0H6GB1NFBIC9b5R7gRmO31HHca3TFuvm1oqT8U8Ui0u7aitlx
         zOx5fkRG4TvcS69w84hb9XzdfV4gP5B7lHZZkMO8gaC6OFd5TYA/NUQ/gP8HbFqgsRo1
         5uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684253134; x=1686845134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8b9bU5+wXWEo/d9j4S9XaKF7bhriqhrqt+qVY4GBq+M=;
        b=M3cYMtUw42nyh9WfagG88wIW4NcsCPeGOGAfrz9GDqC7P6OEI4aZrJWNpM9GiTD3EH
         r3w1njqyBWNdK7+7OYjXudA61T3TFEfqCmgjURG7LKZVyd/DWgMtL959jNH21V78YF+/
         vArROl4Y/fI9VQbgPI2ORb9Y++dnCZX4+EhrYzump5+AEROU5ViVyQlBj82yZmm+9J/E
         yqQ8y9LHYd/rKd9AR6/JFOtnjMoRm9NGwK24oCO9ovbZd2ffvbcrxOcBspWst4tMe9b2
         w8bJfjHDhEgswRzLndW8piKZ4Lk1Titj+GnNMiY4TSm1kETx+KOIj0MsOAwAjwcmR9Nu
         M0og==
X-Gm-Message-State: AC+VfDwjtgoCcJVg/8zcxeV3K5W21YtkkA8Sv5nen2OyM3qtxq2iPAW3
        B5OF409llr1l0yIAOays3L3COA==
X-Google-Smtp-Source: ACHHUZ5APjzvcRC/zhwsH3scT9OxJ9I+vsSC32GTr6Ptp3S0i/BcySQ6GNwnkotWBPVcvxDCCPdLNA==
X-Received: by 2002:a17:906:99c1:b0:947:ebd5:c798 with SMTP id s1-20020a17090699c100b00947ebd5c798mr38168194ejn.54.1684253134523;
        Tue, 16 May 2023 09:05:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id z13-20020a17090674cd00b0096ae152115bsm5206866ejl.175.2023.05.16.09.05.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 09:05:33 -0700 (PDT)
Message-ID: <bbb63fb9-69c3-9c86-c5aa-55b4beac0832@linaro.org>
Date:   Tue, 16 May 2023 18:05:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: zynqmp: Switch to amd.com emails
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        Andrew Davis <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Parth Gajjar <parth.gajjar@amd.com>,
        Piyush Mehta <piyush.mehta@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4c3426077075683b866f144b633cf5218a688c7c.1684244480.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:41, Michal Simek wrote:
> Update my and DPs email address to match current setup.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi         | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dtso   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts     | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dts      | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dts      | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dts | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dts | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dts | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dts    | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dts    | 5 +++--
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu1275-revA.dts     | 7 ++++---
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi                 | 5 +++--
>  24 files changed, 51 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> index 88aa06fa78a8..1495272e5668 100644
> --- a/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> +++ b/arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dts
> @@ -2,9 +2,10 @@
>  /*
>   * dts file for Avnet Ultra96 rev1
>   *
> - * (C) Copyright 2018, Xilinx, Inc.
> + * (C) Copyright 2018 - 2022, Xilinx, Inc.
> + * (C) Copyright 2022 - 2023, Advanced Micro Devices, Inc.

I think these should be split. Your commit suggests only update to email
but you add copyrights. While email change is trivial, the copyright
change is not (at least not for everyone and for every legal system).

What's more, there were no changes to this file after 2018. What
copyrighted work did you add in 2019, 2020, 2021, 2022 and 2023? For
this file clear: NAK

Same concerns for most of other files.

Best regards,
Krzysztof

