Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D5D6C9916
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 02:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbjC0Arr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 20:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC0Aro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 20:47:44 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D349F5;
        Sun, 26 Mar 2023 17:47:43 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn12so29355200edb.4;
        Sun, 26 Mar 2023 17:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1679878062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8U/kCluxO6B+PSARzu8RjX0sOedAO1dFag2paOw8YcA=;
        b=dzNR+8yt25epPqrGhHtRTfI5b07bmwbKE6CGWoCN4qvZpGQSvoaFIH58ldwIDKOxaL
         gMfNCAnEOFs3bpaebkk3ZzeF2CwWvAQ8J7+HllMrkMyFqwfGwGuZvQ/lN9ifWKAaFT+/
         QORmeS1KOq4GJCO3QdQFGbA047MfaG2lWfvLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679878062;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8U/kCluxO6B+PSARzu8RjX0sOedAO1dFag2paOw8YcA=;
        b=1HyL5aelbcjONaxWl3dAOh0jn/8GDJE1UXxdaYqqCJzdxqomsKAYp00LkRbc9e7ldV
         Ad7brlLgJwzoPkuL52xleC2VTVxgpc2cV6nZ6wAPYYdRO94aHH6QMb6RRXMrN9M9P/LH
         MDmz8ynwHTJKBqTEN+xVl54ag/LQAPKomg1E6XJcb9oaJpCA4Z4pwD5ghnXBKmBs5V8n
         yc2q1hXHSq5c6tOvePPbUdtYI8wymn0l1vbJVeBoDrh7C5C3ZzebXvNwfBw2l5dz+8k4
         7GXx2eP+EY8dZtA6o9p3WzwGvQhNg1gkPXHGxa1TLq8//m0l9kokwCt7Xasx9k4D1oMc
         437g==
X-Gm-Message-State: AAQBX9fYS8lh5n41KHHz5DXA8u1unhqnYOyLJ1gLRJPtvy13l9gcOGqE
        bebdOkgISUMeMhR/oW4Uraj5iy0pqaj58D721DU=
X-Google-Smtp-Source: AKy350YuUI6Ov7M1JXz/f5WFAFINfRoDgXv40HbW6V5KKxwGX+W6DfvovjGBJyDlNfwi6fursVxWYuUD1nZNzzwuPyI=
X-Received: by 2002:a17:907:7b8a:b0:931:6e39:3d0b with SMTP id
 ne10-20020a1709077b8a00b009316e393d0bmr4932622ejc.15.1679878062063; Sun, 26
 Mar 2023 17:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230321190914.2266216-1-lakshmiy@us.ibm.com> <20230321190914.2266216-6-lakshmiy@us.ibm.com>
In-Reply-To: <20230321190914.2266216-6-lakshmiy@us.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 27 Mar 2023 00:47:29 +0000
Message-ID: <CACPK8Xd70HABKrSRXKM5vA57YUCckykKOZV1ECuJc1=g70k--Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] ARM: dts: aspeed: p10bmc: Change power supply info
To:     Lakshmi Yadlapati <lakshmiy@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Cc:     robh+dt@kernel.org, linux@roeck-us.net, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, andrew@aj.id.au,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org
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

On Tue, 21 Mar 2023 at 19:09, Lakshmi Yadlapati <lakshmiy@us.ibm.com> wrote:
>
> Bonnell system supports new ACBEL FSG032 power supply on
> I2C addresses 5A and 5B. Update the device tree with new
> power supply information and device addresses.
>
> Signed-off-by: Lakshmi Yadlapati <lakshmiy@us.ibm.com>

Eddie, can I get you to review?

I will take this through the aspeed tree.

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> index a5be0ee048ec..4f959a4f8b58 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-bonnell.dts
> @@ -552,14 +552,14 @@ ucd90160@64 {
>  &i2c3 {
>         status = "okay";
>
> -       power-supply@58 {
> -               compatible = "ibm,cffps";
> -               reg = <0x58>;
> +       power-supply@5a {
> +               compatible = "acbel,fsg032";
> +               reg = <0x5a>;
>         };
>
> -       power-supply@59 {
> -               compatible = "ibm,cffps";
> -               reg = <0x59>;
> +       power-supply@5b {
> +               compatible = "acbel,fsg032";
> +               reg = <0x5b>;
>         };
>  };
>
> --
> 2.37.2
>
