Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDCF69FE39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 23:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjBVWNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 17:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjBVWN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 17:13:29 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA922D176;
        Wed, 22 Feb 2023 14:12:59 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id v1-20020a9d6041000000b0068d4a8a8d2dso1843743otj.12;
        Wed, 22 Feb 2023 14:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=adprV6tEj+TovGrXWEy89UTylRMHMYVXMFhKg7qo/Fo=;
        b=QEU8n9ZE0dM2OFOYGeOuEkzpYN1G8AEx/lVIt0TuCuc0zcWgREiOrDie5z+kxY8SgI
         xgysWpV6ZDVC1RpoFzKG3wNvUyRn/CdAkKrCFJhs7vZXH6LOr8bJa9AwO4W/e5/n6ZQc
         yruEM3iH7diF4FEURgHs+rkvMh5CO2Y+BpGYv5lTZfOT18GA7dxt5WwHYXFJh149X3yZ
         PK3i72ZbN6o7pPbGnPmvBhqLGViswIbARsXGZfwBXzHHOwukvo61ZGKZJZ4+9HGMHXSv
         F9+U+Msbn6XMQLoXc5mgDxUn24pF/bRbJOMs+LqLCEDsXFhxM9NS0ZGix9VHrg0pewD5
         +jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adprV6tEj+TovGrXWEy89UTylRMHMYVXMFhKg7qo/Fo=;
        b=SUw1yIOY7+q+ejoTET+7P+g7HtHzCFSG3hl4SkBlJHhJLVtjyjkUzy+lQNEJzyA7uZ
         yTna1soLy7MD32+QabhzDwYIV375hfkS1vS7ixfUe5dNKSHf0+R2eG+HtwwBdhUhrJyU
         U7+90mvlIn+hZUXxqwapA2HkzllXg7Be+i2sMw56yIEANiALtVeHS8NKJ2phxZcFEqkT
         GBpw4iBA0goMoh5r0HfTJPMmS05+054M+yWSaSoRlEbekH8pSjUTlkUM4CiDoQExTsOW
         G75+ZIuil30Yh+l/dOieTJy4ZO4bHEcP6LMaDA1c5Iti1yU8nTx4msx2YzXUmBW8bVcq
         7laA==
X-Gm-Message-State: AO0yUKW4CRzher5ypdmGwjv7rQNvWSVDLXp7WhqO1XM+LjladgFTsVtg
        RldnhYgKdg9wxUgb5q2QKqI1Dmaq23c=
X-Google-Smtp-Source: AK7set9YJHuhFilf/KVSqse3uwpPRC/5CBRLxt2U4xG69Vkqi0o8q0i7yKTjqK5DPJ2H76lcSY8SwQ==
X-Received: by 2002:a9d:86f:0:b0:690:e457:a69 with SMTP id 102-20020a9d086f000000b00690e4570a69mr5159384oty.0.1677103978579;
        Wed, 22 Feb 2023 14:12:58 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:456:5512:fbf3:df92? ([2600:1700:2442:6db0:456:5512:fbf3:df92])
        by smtp.gmail.com with ESMTPSA id z15-20020a9d468f000000b0068bbc9e7cc9sm1720641ote.53.2023.02.22.14.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:12:58 -0800 (PST)
Message-ID: <db732d8a-b90b-ccf9-ad9b-a9a6455ed841@gmail.com>
Date:   Wed, 22 Feb 2023 16:12:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] of: populate of_root_node if not set (alternate)
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
References: <20230222035452.803375-1-frowand.list@gmail.com>
In-Reply-To: <20230222035452.803375-1-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 21:54, Frank Rowand wrote:
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
> Changes since version 1: (patch 1/2)

Email subject lines should have said "v2".  I resent the series with the "v2".

-Frank

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

