Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D76A122E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBWVjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 16:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjBWVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 16:39:41 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CE55C152;
        Thu, 23 Feb 2023 13:39:34 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1720887dfcdso17236686fac.6;
        Thu, 23 Feb 2023 13:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oiqYmKCBb6pTn9/ZoddN5NSvx6CSd4fhJNmnMHgMU9s=;
        b=SDLNeS2gXdtg2gCn+3+QIpnO8NNDqnczHqToUUg7R81LvyrE0d/3mx3w29Sjd6gk65
         +opeyqm+JqCOp3cRw0fjzyuSqf7BD41B6rhVsF/1LhNxKEGg8R7yA8nfMAckSGWLZNNY
         FKVDVXcdU4/cp9hzPHRxYdnwwiR/AhkdTK7hji1FVfdIUh/RummZVmpiz4c0c7arGvOF
         JMTz++TQyKmhJQPPt81bOSG15/pX7bPbrxQyy013pY/D85cHR073R5NKofIEYScFNT9H
         Zbs/DMnYl693qcts3kBZbEZGUA84ykI3l7YbYVmu7HCZLMz7I6nFyoYGcnWJb0W/Q+5+
         ZaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqYmKCBb6pTn9/ZoddN5NSvx6CSd4fhJNmnMHgMU9s=;
        b=lUFDSy5MMFENdLnSBsHoBouY1sfKIaXl6d8p+KMUreqYczxZwnMUpuKXoP2lDzh/x6
         JLYHZzkcNq8yYCRM5iVOSuiPXJSX7d2uw/Lg3gF4hB0b8bX5CwTLcue7wOxWFAlCPmpO
         tcbO/BKpumhc20Zolt2WFISGDuqimv5CjgbuJP6l+RWUuBSUru8MAKgk7kiXb3Ajhzn/
         /iGSDUe1wCM5s65litwSTPwAJviw03ru9l0DEZhoC++mgsIDwsts1+Q48AKJSCUmRBGx
         23aEAeP3/K56A87yi48EdHc14hE1EGmNbeLR5eYqMWUjHWW28m8+kliBmviYapg2bJa5
         sieQ==
X-Gm-Message-State: AO0yUKUKwXktfGgLLC0vFrNdHbbHEX0kaVm1sfLo3x2bilnsLuvYt7dr
        4uejtAnxSn4L1Rxaj9pgqMsiUNqmKgg=
X-Google-Smtp-Source: AK7set/A9A8K0Z+F/p9HhVeO46Gn31qPy7xM5/xVhS2qGOoJOSbAhmB1axNe+gYNOFcCv5+c8wR71Q==
X-Received: by 2002:a05:6870:438e:b0:172:473c:5a1b with SMTP id r14-20020a056870438e00b00172473c5a1bmr4710501oah.15.1677188373479;
        Thu, 23 Feb 2023 13:39:33 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:2586:7432:d181:902b? ([2600:1700:2442:6db0:2586:7432:d181:902b])
        by smtp.gmail.com with ESMTPSA id o2-20020a4a84c2000000b0051d13098c54sm2612189oog.19.2023.02.23.13.39.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 13:39:32 -0800 (PST)
Message-ID: <12492b9f-1961-7d75-3197-41b4bce90b63@gmail.com>
Date:   Thu, 23 Feb 2023 15:39:31 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/2] of: populate of_root_node if not set (alternate)
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20230223213418.891942-1-frowand.list@gmail.com>
In-Reply-To: <20230223213418.891942-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

Can you please test this version of the patch series?

Thanks!

-Frank

On 2/23/23 15:34, Frank Rowand wrote:
> This series is a different implementation to achieve the goals of
> https://lore.kernel.org/r/20220623105044.152832-1-clement.leger@bootlin.com
> 
> In order to apply overlays or create new nodes under the root node, the
> kernel expects of_root to be set. On some system where a device-tree was
> not provided by firmware (x86 for instance) if CONFIG_OF is enabled,
> then we will end up with a null of_root. This series adds support to
> create this root node using a builtin dtb and removes the manual
> creation of the root node done in unittests.c.
> 
> Changes since version 2: (patch 1/2)
>   - change of __dtb_empty_root_* from "void *" to "uint8_t []"
> 
> Changes since version 1: (patch 1/2)
>   - refresh for 6.2-rc1
>   - update Signed-off-by
>   - fix typo in of_fdt.h: s/of_setup/setup_of
>   - unflatten_device_tree(): validate size in header field dtb_empty_root
>     that will be used to copy dtb_empty_root
>   - add Kconfig option to manually select CONFIG_OF_EARLY_FLATTREE
> 
> Changes since version 1: (patch 2/2)
>   - refresh for 6.2-rc1
>   - update Signed-off-by
>   - fix formatting error (leading space) in patch comment
> 
> Frank Rowand (2):
>   of: create of_root if no dtb provided
>   of: unittest: treat missing of_root as error instead of fixing up
> 
>  drivers/of/Kconfig        |  7 ++++++-
>  drivers/of/Makefile       |  2 +-
>  drivers/of/empty_root.dts |  6 ++++++
>  drivers/of/fdt.c          | 27 ++++++++++++++++++++++++++-
>  drivers/of/unittest.c     | 16 ++++++----------
>  include/linux/of_fdt.h    |  2 ++
>  init/main.c               |  2 ++
>  7 files changed, 49 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
> 

