Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05A15EC20D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiI0MFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbiI0MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:05:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9069413CE1;
        Tue, 27 Sep 2022 05:05:28 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id s14so14748076wro.0;
        Tue, 27 Sep 2022 05:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=aMFz74PifNUSu/W0zEbEDzLNbyXt9EcYY4KaI+IEVt0=;
        b=G+gMsz+4fAGkT5Px+9K2xvQvfj9D9TKBj+P18qWucd+8pQw+U/rOWuTlHv5B+ULWgT
         5y7QcT8rOOYXt6E2TDNxd5r7cd86ngoHaw5Qxuxys3fzcgGygoE0f++c7fNDk1eXEYl1
         6Z/wo+8NHwi1sqwA5Z3kjzgK1LP2QNOmlaO0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=aMFz74PifNUSu/W0zEbEDzLNbyXt9EcYY4KaI+IEVt0=;
        b=bJx33mF6zJh126LPomwxUd2lBlESZEQQ5UyPU9e6ePi5FmUL6vZE/FsbP+PPvFajQd
         tW96aBzMvB9KRE9gWuClbigZ7TGndR8PZtoagOiMpxaP4EwW2COYbe4GF3KU/43BXRcW
         Cqqqmyd89/eq1fXbECre2YHRica9kQWV2EJN3mYw6xbcjewpjJ1VjhL+9Cd7LNCpR+ZW
         KdekCTLK4C6Na+LQ6D9ZZM2th613emZf0lFMp3yPCmsSvm+bdG8RN6DjdQAkcxjQ9mDH
         jyJuTb32pZJpFuzf37G+0y91jTskWyWUJIptIt7Os03sA1mml1IIsQPXaoPiDtugxi75
         Nniw==
X-Gm-Message-State: ACrzQf025lMgBkYAsIeyfpf8ADOnhVI7GbgG14ito6ODPjzHibA9N1hi
        FVLmoOT7rf4v/YwjFqTeqEnbSA9xbZXO2PkJK1IpV0Dv
X-Google-Smtp-Source: AMsMyM7nMLB0IrCPb2M/nxRoglUKQkXLXDTvev/T6b71kPxYN6T7MwuZB65wnFvN2X+RV+DTVJ2yZoF81QdnU8NDvZ8=
X-Received: by 2002:a5d:4bc3:0:b0:22a:4b7a:6f60 with SMTP id
 l3-20020a5d4bc3000000b0022a4b7a6f60mr16447585wrt.549.1664280326958; Tue, 27
 Sep 2022 05:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220927114515.GA22344@hcl-ThinkPad-T495>
In-Reply-To: <20220927114515.GA22344@hcl-ThinkPad-T495>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 27 Sep 2022 12:05:14 +0000
Message-ID: <CACPK8XdHaExSzdHpCXNzSEK7L-QDDSkz2rud3OynBC-KhEApFA@mail.gmail.com>
Subject: Re: [PATCH v6] ARM: dts: aspeed: Yosemite V2: Enable OCP debug card
To:     Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sept 2022 at 11:45, Karthikeyan Pasupathi
<pkarthikeyan1509@gmail.com> wrote:
>
> Added IPMB-13 channel for Debug Card communication.
> which improves the readability of the machine and makes
> it easier to debug the server and it will display some
> pieces of information about the server like "system info",
> "Critical sensors" and "critical sel".
>
> Signed-off-by: Karthikeyan Pasupathi <pkarthikeyan1509@gmail.com>

Thanks, I've queued this.

Thanks Zev for your help reviewing.

> ---
> v6:
>  -Fix the commit format
>
> v5:
>  -Updated commit message
>
> v4:
>  -Resolved syntax error
>
> v3:
>  -Updated the title and commit
>
> v2:
>  -Updated the title
>
> v1:
>  - Initial draft
> ---
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> index 8864e9c312a8..84236df522dc 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-facebook-yosemitev2.dts
> @@ -215,6 +215,17 @@
>         };
>  };
>
> +&i2c13 {
> +       status = "okay";
> +       // Debug Card
> +       multi-master;
> +       ipmb13@10 {
> +               compatible = "ipmb-dev";
> +               reg = <(0x10 | I2C_OWN_SLAVE_ADDRESS)>;
> +               i2c-protocol;
> +       };
> +};
> +
>  &pwm_tacho {
>         status = "okay";
>         //FSC
> --
> 2.17.1
>
