Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905A95B6E88
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 15:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbiIMNou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 09:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiIMNor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 09:44:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208EFD18;
        Tue, 13 Sep 2022 06:44:45 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id k21so1325503pls.11;
        Tue, 13 Sep 2022 06:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gFAWCYu4aqOpq9uNWyOKuuXbaEoHufDPm1OCqsRmGk0=;
        b=UMgvw//ZZ4XCviSRi/i4litBslvRky1XIgFyI86Y6oashXn1UGthQ/bf2GVW0/Eyr9
         S9hI3bfj5T1mr8Ph5xUmRAA0Hn04kKChwQON3TJm+Br890pQrcg5zDJuTmoA3BUifdZl
         SrLqgyM9sqbE0mrvAJ336nHJrXMzKBgdjk/mg5jL3CGDSSFJrLI2SR9JLIdJBXQj+VcM
         rAnShYf5Q08VDA4Z7XsOHE08Mlbx7y8pxl65sjQAYzjRMO2bX+67xlFkDdEwt/TZY5xE
         CCHYSC4NuUNqfhcQBXq2deDym72qA2Bp2JJDmd0k5Io2sH1wUyOpBgm77Jp0ORSQGF6/
         J3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gFAWCYu4aqOpq9uNWyOKuuXbaEoHufDPm1OCqsRmGk0=;
        b=Kik62ZyhI+tKY1GACxan9wio7B8ws93jMRz0fXn4ByQF/M1EKanbKzMIerbfQ/yDb0
         v/XiPD/rv7i8Q0M3bY+7BQ7RoYUyqdtJ494r62/fsOXI7rRZm5etBJSfEayM08ibeXe6
         lQJteX3vEj9z0Ljphn73jffCKwCvIwVi3whw/UBIUtIYZazBA6spTOaU4w+kuS8NsmMZ
         0uhQ48YD9prnVRCgLtwR3OADuJb1bMmIQZ+OLQKMu++SZ2y4YmfmZoCZsIgvR1x01McK
         drHr0EmxwTSXuHMxin4B8GVzfCAAfAL9mOpmN7E+zl3cxJEKrrKqWC7MtTuqfGAEIug7
         PiMA==
X-Gm-Message-State: ACgBeo3UOFuu4KuehGTW04NEMfBvhpWUvctiVnw3FjZlAGLewd/0nhbZ
        7S4M+I6bOJ3QS0nUiJLMrAuxS0VQ/1Q=
X-Google-Smtp-Source: AA6agR4r8znrf92mtkLK94fRr5qY6cWrh7I2aI9lIfywg6n4tGqCaaq2a6M89ePIWo8wDUh9f6RZtA==
X-Received: by 2002:a17:90b:4d92:b0:202:f200:a3c9 with SMTP id oj18-20020a17090b4d9200b00202f200a3c9mr4134285pjb.4.1663076685510;
        Tue, 13 Sep 2022 06:44:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id x127-20020a626385000000b0053b2681b0e0sm7903781pfb.39.2022.09.13.06.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 06:44:45 -0700 (PDT)
Message-ID: <d34d9264-1f0b-d465-bc1d-75f8c736a35b@gmail.com>
Date:   Tue, 13 Sep 2022 20:44:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH char-misc-next] misc: microchip: pci1xxxx: use
 DEFINE_SIMPLE_DEV_PM_OPS() in place of the SIMPLE_DEV_PM_OPS() in pci1xxxx's
 gpio driver
Content-Language: en-US
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-next@vger.kernel.org, gregkh@linuxfoundation.org
References: <20220912113634.167820-1-kumaravel.thiagarajan@microchip.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220912113634.167820-1-kumaravel.thiagarajan@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 18:36, Kumaravel Thiagarajan wrote:
> build errors listed below and reported for the builds of
> riscv, s390, csky, alpha and loongarch allmodconfig are fixed in
> this patch.
> 
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:311:12: error: 'pci1xxxx_gpio_resume' defined but not used [-Werror=unused-function]
>   311 | static int pci1xxxx_gpio_resume(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~
> drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c:295:12: error: 'pci1xxxx_gpio_suspend' defined but not used [-Werror=unused-function]
>   295 | static int pci1xxxx_gpio_suspend(struct device *dev)
>       |            ^~~~~~~~~~~~~~~~~~~~~
> 

What about this description?:

"Sudip reported unused function errors on riscv, s390, cksy, alpha,
and loongarch (allmodconfig):
<pci1xxxx_gpio_* errors>...

Fix these errors by using DEFINE_SIMPLE_DEV_PM_OPS."

> Fixes: 4ec7ac90ff39 ("misc: microchip: pci1xxxx: Add power management functions - suspend & resume handlers.")
> Reported-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> index 9cc771c604ed..4cd541166b0c 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
> @@ -405,7 +405,7 @@ static int pci1xxxx_gpio_probe(struct auxiliary_device *aux_dev,
>  	return devm_gpiochip_add_data(&aux_dev->dev, &priv->gpio, priv);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_gpio_pm_ops, pci1xxxx_gpio_suspend, pci1xxxx_gpio_resume);
>  
>  static const struct auxiliary_device_id pci1xxxx_gpio_auxiliary_id_table[] = {
>  	{.name = "mchp_pci1xxxx_gp.gp_gpio"},


-- 
An old man doll... just what I always wanted! - Clara
