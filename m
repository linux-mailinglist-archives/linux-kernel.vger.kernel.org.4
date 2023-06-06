Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45DD724BF1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbjFFS50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjFFS5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:57:24 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8052E5E;
        Tue,  6 Jun 2023 11:57:23 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38c35975545so5675728b6e.1;
        Tue, 06 Jun 2023 11:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686077843; x=1688669843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv8Ks5VknCrBV7fguzxWAsRwOt3HZe11aW2Iq4UrTBg=;
        b=mzF7dlcjs1aqIOKqMUcngvetyn348AsS+v/JNutN/G4doXsdC2+o8E5nZ61gtA9Wal
         Y4/PqmeBWQzJdNX6IS6Q0/lBhUU6PfhXwf0qnAvww4JcYJxGh8+seIbokCyhxSXKHngd
         f14CA1dCTckMVJNqVgMVunxUiWJC+GjVzfJ99GxnFyQ6STpyHWW2bXahoNXq0+MjgS28
         JK38r2MCjpDp2zTKmcly+i7tZRd+qnkIEl1hm6JVI0Vj6NWf56Fp6nmhOUqiwLDS9WS4
         y4quww4pCraqVYoEhKWS7L/AzjnvAsii5em2IxsbG2m3ac87uwdXY9PwQoy0HQOPipad
         4duQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686077843; x=1688669843;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nv8Ks5VknCrBV7fguzxWAsRwOt3HZe11aW2Iq4UrTBg=;
        b=i+SVMHggsSHJJp/g+8otfcTSBd2HqEpByFiL81gn+zGQQB4xSGxMuoajCo5mUiSr+M
         yxe/j5zRClhqDvIehinpNQiZMjxxCbgVbFRJoGSQ/MvWqxLRlyutmeCi0rAFXooH+UgN
         zYTcrBT+bOl2E6E88hL2+85DQ1R9u6/eu8vFWE5dXyXI21sWMgB8HtHtPYmBsajVvGsd
         hGADh4AvhhoPv0ZLNpvy63a1/tGaYsv23GD9VDfexq9xeQwUo/74yLRR+BiTFR2xd807
         HMNzgXElDujTDWwW8KT9+w5IaSY3Lrgi39G5RoudEovfVAsuN9rtz/05GenP2YyhmlMT
         rTgg==
X-Gm-Message-State: AC+VfDxKT1SNj9pFI8Kj06lu3012AgjcT6FXKBbUuT4MYt0Udf18A0Eo
        0NXT4tmMCEmvxIZV+WvGFjI=
X-Google-Smtp-Source: ACHHUZ6B/A/3nViomnN8HTpuupYrWqpCSRaMyl/QKITf0tbPxrbJpZCpZkZjeD8b26SOo2XvGVjWsA==
X-Received: by 2002:a54:4893:0:b0:39a:b35b:a06c with SMTP id r19-20020a544893000000b0039ab35ba06cmr3088402oic.30.1686077842810;
        Tue, 06 Jun 2023 11:57:22 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f59e:5ad5:28cc:2003])
        by smtp.gmail.com with ESMTPSA id w14-20020aa7858e000000b0064ca1fa8442sm7381091pfn.178.2023.06.06.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 11:57:22 -0700 (PDT)
Date:   Tue, 6 Jun 2023 11:57:19 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Peters <mpeters@embeddedts.com>,
        Kris Bahnsen <kris@embeddedts.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 28/43] input: keypad: ep93xx: add DT support for
 Cirrus EP93xx
Message-ID: <ZH+Bj7T7SvE4Os/p@google.com>
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-10-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601054549.10843-10-nikita.shubin@maquefel.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 08:45:33AM +0300, Nikita Shubin wrote:
> - get keymap from the device tree
> - find register range from the device tree
> - get interrupts from device tree
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     - fixed header
>     - dropped coma in id table
>     - take debounce, prescale from dt
>     - remove ep93xx_keypad_platform_data
>     - move flags to module params
>     - drop setting clock rate, it's useless, as was never used,
>       it seems we are okay with default clk rate used
>     - move usefull defines from platform file here
>     - drop platform header
> 
>  drivers/input/keyboard/ep93xx_keypad.c | 78 +++++++++++++-------------
>  1 file changed, 40 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
> index 55075addcac2..8b0e73f56216 100644
> --- a/drivers/input/keyboard/ep93xx_keypad.c
> +++ b/drivers/input/keyboard/ep93xx_keypad.c
> @@ -20,6 +20,7 @@
>  #include <linux/bits.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> @@ -27,7 +28,6 @@
>  #include <linux/input/matrix_keypad.h>
>  #include <linux/slab.h>
>  #include <linux/soc/cirrus/ep93xx.h>
> -#include <linux/platform_data/keypad-ep93xx.h>
>  #include <linux/pm_wakeirq.h>
>  
>  /*
> @@ -61,12 +61,18 @@
>  #define KEY_REG_KEY1_MASK	GENMASK(5, 0)
>  #define KEY_REG_KEY1_SHIFT	0
>  
> +#define EP93XX_MATRIX_ROWS		(8)
> +#define EP93XX_MATRIX_COLS		(8)
> +
>  #define EP93XX_MATRIX_SIZE	(EP93XX_MATRIX_ROWS * EP93XX_MATRIX_COLS)
>  
>  struct ep93xx_keypad {
> -	struct ep93xx_keypad_platform_data *pdata;
>  	struct input_dev *input_dev;
>  	struct clk *clk;
> +	unsigned int	debounce;
> +	unsigned int	prescale;
> +	unsigned int	flags;
> +	unsigned int	clk_rate;
>  
>  	void __iomem *mmio_base;
>  
> @@ -80,6 +86,17 @@ struct ep93xx_keypad {
>  	bool enabled;
>  };
>  
> +/* flags for the ep93xx_keypad driver */
> +#define EP93XX_KEYPAD_DISABLE_3_KEY	(1<<0)	/* disable 3-key reset */
> +#define EP93XX_KEYPAD_DIAG_MODE		(1<<1)	/* diagnostic mode */
> +#define EP93XX_KEYPAD_BACK_DRIVE	(1<<2)	/* back driving mode */
> +#define EP93XX_KEYPAD_TEST_MODE		(1<<3)	/* scan only column 0 */
> +#define EP93XX_KEYPAD_AUTOREPEAT	(1<<4)	/* enable key autorepeat */
> +
> +static int ep93xx_keypad_flags;
> +module_param(ep93xx_keypad_flags, int, 0);
> +MODULE_PARM_DESC(ep93xx_keypad_flags, "EP93XX keypad flags.");
> +
>  static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
>  {
>  	struct ep93xx_keypad *keypad = dev_id;
> @@ -133,23 +150,20 @@ static irqreturn_t ep93xx_keypad_irq_handler(int irq, void *dev_id)
>  
>  static void ep93xx_keypad_config(struct ep93xx_keypad *keypad)
>  {
> -	struct ep93xx_keypad_platform_data *pdata = keypad->pdata;
>  	unsigned int val = 0;
>  
> -	clk_set_rate(keypad->clk, pdata->clk_rate);
> -
> -	if (pdata->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
> +	if (keypad->flags & EP93XX_KEYPAD_DISABLE_3_KEY)
>  		val |= KEY_INIT_DIS3KY;
> -	if (pdata->flags & EP93XX_KEYPAD_DIAG_MODE)
> +	if (keypad->flags & EP93XX_KEYPAD_DIAG_MODE)
>  		val |= KEY_INIT_DIAG;
> -	if (pdata->flags & EP93XX_KEYPAD_BACK_DRIVE)
> +	if (keypad->flags & EP93XX_KEYPAD_BACK_DRIVE)
>  		val |= KEY_INIT_BACK;
> -	if (pdata->flags & EP93XX_KEYPAD_TEST_MODE)
> +	if (keypad->flags & EP93XX_KEYPAD_TEST_MODE)
>  		val |= KEY_INIT_T2;
>  
> -	val |= ((pdata->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
> +	val |= ((keypad->debounce << KEY_INIT_DBNC_SHIFT) & KEY_INIT_DBNC_MASK);
>  
> -	val |= ((pdata->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
> +	val |= ((keypad->prescale << KEY_INIT_PRSCL_SHIFT) & KEY_INIT_PRSCL_MASK);
>  
>  	__raw_writel(val, keypad->mmio_base + KEY_INIT);
>  }
> @@ -220,17 +234,10 @@ static int ep93xx_keypad_resume(struct device *dev)
>  static DEFINE_SIMPLE_DEV_PM_OPS(ep93xx_keypad_pm_ops,
>  				ep93xx_keypad_suspend, ep93xx_keypad_resume);
>  
> -static void ep93xx_keypad_release_gpio_action(void *_pdev)
> -{
> -	struct platform_device *pdev = _pdev;
> -
> -	ep93xx_keypad_release_gpio(pdev);
> -}
> -
>  static int ep93xx_keypad_probe(struct platform_device *pdev)
>  {
> +	struct device_node *np = pdev->dev.of_node;
>  	struct ep93xx_keypad *keypad;
> -	const struct matrix_keymap_data *keymap_data;
>  	struct input_dev *input_dev;
>  	int err;
>  
> @@ -238,14 +245,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	if (!keypad)
>  		return -ENOMEM;
>  
> -	keypad->pdata = dev_get_platdata(&pdev->dev);
> -	if (!keypad->pdata)
> -		return -EINVAL;
> -
> -	keymap_data = keypad->pdata->keymap_data;
> -	if (!keymap_data)
> -		return -EINVAL;
> -
>  	keypad->irq = platform_get_irq(pdev, 0);
>  	if (keypad->irq < 0)
>  		return keypad->irq;
> @@ -254,19 +253,15 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	if (IS_ERR(keypad->mmio_base))
>  		return PTR_ERR(keypad->mmio_base);
>  
> -	err = ep93xx_keypad_acquire_gpio(pdev);
> -	if (err)
> -		return err;
> -
> -	err = devm_add_action_or_reset(&pdev->dev,
> -				       ep93xx_keypad_release_gpio_action, pdev);
> -	if (err)
> -		return err;
> -
>  	keypad->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(keypad->clk))
>  		return PTR_ERR(keypad->clk);
>  
> +	keypad->flags = ep93xx_keypad_flags;
> +
> +	of_property_read_u32(np, "cirrus,debounce-delay-ms", &keypad->debounce);
> +	of_property_read_u32(np, "cirrus,prescale", &keypad->prescale);

Please use device_property_read_*() API for this.

> +
>  	input_dev = devm_input_allocate_device(&pdev->dev);
>  	if (!input_dev)
>  		return -ENOMEM;
> @@ -278,13 +273,13 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
>  	input_dev->open = ep93xx_keypad_open;
>  	input_dev->close = ep93xx_keypad_close;
>  
> -	err = matrix_keypad_build_keymap(keymap_data, NULL,
> +	err = matrix_keypad_build_keymap(NULL, NULL,
>  					 EP93XX_MATRIX_ROWS, EP93XX_MATRIX_COLS,
>  					 keypad->keycodes, input_dev);
>  	if (err)
>  		return err;
>  
> -	if (keypad->pdata->flags & EP93XX_KEYPAD_AUTOREPEAT)
> +	if (keypad->flags & EP93XX_KEYPAD_AUTOREPEAT)
>  		__set_bit(EV_REP, input_dev->evbit);

I think this should be controlled by "autorepeat" device property.

>  	input_set_drvdata(input_dev, keypad);
>  
> @@ -315,10 +310,17 @@ static int ep93xx_keypad_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static const struct of_device_id ep93xx_keypad_of_ids[] = {
> +	{ .compatible = "cirrus,ep9307-keypad" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ep93xx_keypad_of_ids);
> +
>  static struct platform_driver ep93xx_keypad_driver = {
>  	.driver		= {
>  		.name	= "ep93xx-keypad",
>  		.pm	= pm_sleep_ptr(&ep93xx_keypad_pm_ops),
> +		.of_match_table = ep93xx_keypad_of_ids,
>  	},
>  	.probe		= ep93xx_keypad_probe,
>  	.remove		= ep93xx_keypad_remove,
> -- 
> 2.37.4
> 

Thanks.

-- 
Dmitry
