Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565D8687C23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjBBLZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjBBLZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:25:00 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832B8B300
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:24:58 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m14so1356445wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 03:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7zqbU6ksyPOFoWFtHkzD3bR/obP416i9A2wkuzfdxJ0=;
        b=nfzggKzeDy8Fooxs4/UnxsxkTaMMYY+vYKXApetalDGXsi+1ZE3gfu4/Jm8pAqAcMu
         BaI3NoNKmY4o74pbEkItGnXS0M5ssMpD91pXu8pvr6ikBC3JoUn1fS7YdtY2j40F3hjE
         ytvhGarE4ic4hEMccuGYb14jNbckApiwPTVOyfcvUpEY+MADIgylv/jYiyylg2CGBrFs
         rkPoP3xyN8PARxGU52/b4uZOf3SLFRI+WAI3BefsRfS1eOghIxuAAiENzc8AeJYutlai
         NBAiIodDauAaYMEQ6btEe7yuGuWPBrOzj0AznkmSdXd0eOe2i/ZCa9+0lPprpIMlCvAP
         OE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7zqbU6ksyPOFoWFtHkzD3bR/obP416i9A2wkuzfdxJ0=;
        b=L8I1g/g4RRdmT43RDhBg+RWHu5xhhWHu7gh8rLgYGepek/xsMhRZ1zNh5ej9eA0X34
         ksMSbBPIXu1mfmDZIqD63kpBTGW8uQN5Gj0IiqpdJ01+oxnjHkgC/m7UJhE0je+6XOXx
         go/v4Fw6rcCVf8zXevX8LQcEu4Tseg77bqyEv+/7m+Xn0IYKDE5xIiSmYs96n2yIM/Dh
         osz5pZp1Vp0g1HRsklEg2e+h8tCE7K3JJG0Tcng/ujaUNrhghaoa/pNAwdhff2zMhLQ0
         h5ZZ8f3RGGYwXXRZCQNFVnDlzZnm6fGStRfuTZMg6g0DxA0Tg0mnc52tZwH8aFZ0FAln
         4PSw==
X-Gm-Message-State: AO0yUKWA+hNlI+brK8L9ykp8d+tYF31eEkJrJ361ZQQmyuc7G9KvqiLO
        XIG7vqqGdwHZFujQjgNaidyX2h9RMR+oObMg
X-Google-Smtp-Source: AK7set98EFchu7XA6DGE+bwS7G96dmBZBGUFjUewEpnT2s44kbYug0/j1in/D/oPN9QUp16+dJZwGQ==
X-Received: by 2002:adf:b355:0:b0:2bd:c83a:6e3 with SMTP id k21-20020adfb355000000b002bdc83a06e3mr4916892wrd.7.1675337096963;
        Thu, 02 Feb 2023 03:24:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v9-20020a056000144900b002c3b2afae00sm4783977wrx.41.2023.02.02.03.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:24:56 -0800 (PST)
Message-ID: <35911bc7-6973-d4b0-18d4-22e93962f3c5@linaro.org>
Date:   Thu, 2 Feb 2023 12:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] mfd: sec: Remove PMICs without compatibles
Content-Language: en-US
To:     David Virag <virag.david003@gmail.com>
Cc:     Lee Jones <lee@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-rtc@vger.kernel.org
References: <20230131183008.4451-1-virag.david003@gmail.com>
 <20230131183008.4451-2-virag.david003@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131183008.4451-2-virag.david003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 19:30, David Virag wrote:
> The S5M8751 and S5M8763 PMIC chips have no corresponding compatible
> values, so since board file support was removed for this driver, there
> is no way to specify these PMICs as present in boards anymore.
> Remove leftovers of these chips since it's dead code.
> 
> Signed-off-by: David Virag <virag.david003@gmail.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>  {
>  	int ret = 0;
> @@ -448,9 +362,6 @@ int sec_irq_init(struct sec_pmic_dev *sec_pmic)
>  	}
>  
>  	switch (type) {
> -	case S5M8763X:
> -		sec_irq_chip = &s5m8763_irq_chip;
> -		break;
>  	case S5M8767X:
>  		sec_irq_chip = &s5m8767_irq_chip;
>  		break;
> diff --git a/include/linux/mfd/samsung/core.h b/include/linux/mfd/samsung/core.h
> index f92fe090473d..07aae649a86f 100644
> --- a/include/linux/mfd/samsung/core.h
> +++ b/include/linux/mfd/samsung/core.h
> @@ -36,7 +36,6 @@
>  struct gpio_desc;
>  
>  enum sec_device_type {
> -	S5M8751X,
>  	S5M8763X,

Drop also S5M8763X

>  	S5M8767X,
>  	S2MPA01,
> diff --git a/include/linux/mfd/samsung/s5m8763.h b/include/linux/mfd/samsung/s5m8763.h
> deleted file mode 100644


Best regards,
Krzysztof

