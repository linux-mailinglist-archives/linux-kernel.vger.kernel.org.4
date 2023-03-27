Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4399A6C9912
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjC0Aqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC0Aqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:46:48 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8443149FC;
        Sun, 26 Mar 2023 17:46:47 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id y4so29392816edo.2;
        Sun, 26 Mar 2023 17:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1679878006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwNKwWEmP0+GBVy7Aoyp0/jnxyDCmqGAIfdYaEYV01Q=;
        b=JtsN+5D9e8csHqSMHYvyo6EvP2mKy0R29zsl3MPx8eDxeScV0UoljmM81XYMTbwJR5
         eOPbWx8UipBzCi4sVdxaoljBRNz1wezsTWSkQEjo92pPAFbbU/nqgJAYM4Re3vxDGkoi
         mJ0a9BtjTpJQpX3aoxzHISwCH1bm0Zt21sLRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679878006;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwNKwWEmP0+GBVy7Aoyp0/jnxyDCmqGAIfdYaEYV01Q=;
        b=D7Vppgsm2kNlwjZ6BGQwNGb816tKHj9o4K4fR95NEDuoyezoHy1v6Ar/GFow/0HTEa
         srMccTvAXEI4pwu+2Q9l5qttxTJ9a/YRjdxq8rqWbFjUbAEhDhaz/4Yxv/AJg6lPwgdf
         G6V6kLvdfBr6dU2zWgRW7JVhXOs5USl7YSKBW4C+kJ5aXBsfa3YEamc8MXabx7PVLA8u
         GLzE3rix3g/rf1JRU3W4jy+tC8yAM+9FyIvyfanBadSx+zpD+zJsIHVfG/BjPw0P1mvk
         O4X63GQKHTyFiriR8xfx8cjjKZdekLi0jCX0Z2ijIOImYgc/wJdmA7ZoHTPj0sFwe0UB
         P8Kg==
X-Gm-Message-State: AAQBX9dzl1w5N3Ajk9jV/PTVHrdgiUD2kDlhze1QzaleJIEwx1+cHCcQ
        9bgjpwOdQGdyhlrxFnxShefGa+RtICrV4DsKOjyCGjTs
X-Google-Smtp-Source: AKy350YxyRrBNpB+l72B0KEPxWYOuuDAh8I+xWUczm85SPuXBBnshTxQkofqnrgwImaPDip50XzGGVfk680VYgKGsNQ=
X-Received: by 2002:a17:906:eec7:b0:93e:186f:ea0d with SMTP id
 wu7-20020a170906eec700b0093e186fea0dmr4376106ejb.15.1679878005645; Sun, 26
 Mar 2023 17:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230322140348.569397-1-eajames@linux.ibm.com> <20230322140348.569397-5-eajames@linux.ibm.com>
In-Reply-To: <20230322140348.569397-5-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 27 Mar 2023 00:46:33 +0000
Message-ID: <CACPK8XfJr03L43KbWcZ44nAiVhpPF8Pao2OM4R2F36b=bkQ-fQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: aspeed: bonnell: Add DIMM SPD
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
        devicetree@vger.kernel.org, andrew@aj.id.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023 at 14:04, Eddie James <eajames@linux.ibm.com> wrote:
>
> Add the DIMM SPD to the processor I2C busses.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

I will take this through the aspeed tree.

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> index 79516dc21c01..ab99d915b50e 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> @@ -232,18 +232,38 @@ cfam0_i2c1: i2c-bus@1 {
>
>                         cfam0_i2c10: i2c-bus@a {
>                                 reg = <10>;     /* OP3A */
> +
> +                               eeprom@50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c11: i2c-bus@b {
>                                 reg = <11>;     /* OP3B */
> +
> +                               eeprom@50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c12: i2c-bus@c {
>                                 reg = <12>;     /* OP4A */
> +
> +                               eeprom@50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c13: i2c-bus@d {
>                                 reg = <13>;     /* OP4B */
> +
> +                               eeprom@50 {
> +                                       compatible = "atmel,at30tse004a";
> +                                       reg = <0x50>;
> +                               };
>                         };
>
>                         cfam0_i2c14: i2c-bus@e {
> --
> 2.31.1
>
