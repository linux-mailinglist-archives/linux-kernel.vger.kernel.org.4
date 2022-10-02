Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804B55F23FD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbiJBQGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:06:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FB327DEA;
        Sun,  2 Oct 2022 09:06:18 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v1so7802926plo.9;
        Sun, 02 Oct 2022 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date;
        bh=oQ13gYSWb4S1WuifTJon9HYrTMGDmTftpXlb+B+NlJY=;
        b=I7Psg0evd5eP89ZF8a99ENA4c6v5o0wtUuvZGO/CnHmrwiRzPlYw3E9tEDCqmYZukn
         /7UtEAtqZnDoKUsWeZDQx1QphkBJJjxRAQmOIcYC9hUHXHw9oj6EAgLmQ7jplXuENgeh
         gF6fe/wpMMQKtqonBgxantitj54Hqe3UBTfTSHS3iK/urXHgg0Rs3G2i07VnprBelHsa
         sLZRA88l64QvGTIsaAN5yGWJHSKhQxoe8gqiCpBh82UuSSLuEnmmZbyzeJRWTnhNYFYL
         2uCj9rpfoT1afp4TLRp+sptB/cDTzmFpk0CeTH3OgvkiOZaGLytIXcuirwvAhMOdS6OU
         B0vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oQ13gYSWb4S1WuifTJon9HYrTMGDmTftpXlb+B+NlJY=;
        b=x2ss6qZfeC6cF/QlTUXes/F3l/NQRnuDy89xxLgo1EiAeXyWWeoP+whqPsYawcEdem
         LnwQNirPjzIQnOuBAakQg2VsmzPjTU+n+pxYrWQhzC5Bl1gRY2d2gdAUvQrJswq6LeIe
         Tu0cg+deOd9u8XG3mvyJ6U3sfvvU4FvKna5QfTOuqI2nuuzBsBSUQr4w4aadIQ/z1zps
         x289h7r1uZf0QYzFki8scjnQT/4eH1eVbjJp7CrPJMBfrg5MgZZRxWN7LAuOZt8+kiCm
         KbgmkH++VsM7GoC1qKwsSq+8wTW7rsL2u5hafR8gEq8fPCJPrU+40Jrlx+eSOCgRGJzL
         8A9w==
X-Gm-Message-State: ACrzQf3rM/iBkXY65PP6F37nFlFwIdfk3OqIqC2NVdSz50dvWnzzhy+i
        XUG7yhcmr2tdhckkdUkqba9BK9WOBZKCfw==
X-Google-Smtp-Source: AMsMyM6Drmyv7niSRAeND4bOvYx8IS/OQAdwLC+qONeHVHbvc2xn6N0sW0p60B+OwgUiHZ2vAZFW8g==
X-Received: by 2002:a17:902:7c8f:b0:176:cdd8:7258 with SMTP id y15-20020a1709027c8f00b00176cdd87258mr17528909pll.49.1664726777456;
        Sun, 02 Oct 2022 09:06:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w20-20020aa79554000000b0056177786676sm111503pfq.102.2022.10.02.09.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:06:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e229439-1d2b-5ba3-32a3-9b70ae6dfbbd@roeck-us.net>
Date:   Sun, 2 Oct 2022 09:06:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        wim@linux-watchdog.org, shubhrajyoti.datta@amd.com,
        michal.simek@amd.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        git@amd.com
References: <20220927110257.41963-1-srinivas.neeli@amd.com>
 <20220927110257.41963-3-srinivas.neeli@amd.com>
 <c1e34c50-50ac-0e06-3af7-a1eec886bf07@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
In-Reply-To: <c1e34c50-50ac-0e06-3af7-a1eec886bf07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 03:35, Krzysztof Kozlowski wrote:
> On 27/09/2022 13:02, Srinivas Neeli wrote:
>> +
>> +static void xwwdt_clk_disable_unprepare(void *data)
>> +{
>> +	clk_disable_unprepare(data);
> 
> If watchdog is stopped and then device unbound, don't you have double
> disable? IOW, where is matching clk_enable?
> 

See clok_prepare_enable() in the probe function. This kind of code
is quite common in watchdog drivers. Alternative is to have a remove
function and call clk_disable_unprepare() from there. The result is
the same, and the code here is preferred.

Can you be more specific with your concerns ? This is quite common
code for watchdog drivers, so any concern would be important to
understand.

>> +}
>> +
>> +static const struct watchdog_info xilinx_wwdt_ident = {
>> +	.options = WDIOF_KEEPALIVEPING |
>> +		WDIOF_SETTIMEOUT,
>> +	.firmware_version = 1,
>> +	.identity = "xlnx_window watchdog",
>> +};
>> +
>> +static const struct watchdog_ops xilinx_wwdt_ops = {
>> +	.owner = THIS_MODULE,
>> +	.start = xilinx_wwdt_start,
>> +	.stop = xilinx_wwdt_stop,
>> +	.set_timeout = xilinx_wwdt_set_timeout,
>> +	.ping = xilinx_wwdt_keepalive,
>> +};
>> +
>> +static int xwwdt_probe(struct platform_device *pdev)
>> +{
>> +	struct watchdog_device *xilinx_wwdt_wdd;
>> +	struct device *dev = &pdev->dev;
>> +	struct xwwdt_device *xdev;
>> +	int ret;
>> +
>> +	xdev = devm_kzalloc(dev, sizeof(*xdev), GFP_KERNEL);
>> +	if (!xdev)
>> +		return -ENOMEM;
>> +
>> +	xilinx_wwdt_wdd = &xdev->xilinx_wwdt_wdd;
>> +	xilinx_wwdt_wdd->info = &xilinx_wwdt_ident;
>> +	xilinx_wwdt_wdd->ops = &xilinx_wwdt_ops;
>> +	xilinx_wwdt_wdd->parent = dev;
>> +
>> +	xdev->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(xdev->base))
>> +		return PTR_ERR(xdev->base);
>> +
>> +	xdev->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(xdev->clk))
>> +		return PTR_ERR(xdev->clk);
>> +
>> +	xdev->freq = clk_get_rate(xdev->clk);
>> +	if (!xdev->freq)
>> +		return -EINVAL;
>> +
>> +	ret = clk_prepare_enable(xdev->clk);
>> +	if (ret) {
>> +		dev_err(dev, "unable to enable clock\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, xwwdt_clk_disable_unprepare,
>> +				       xdev->clk);
>> +	if (ret)
>> +		return ret;
>> +
>> +	xilinx_wwdt_wdd->timeout = XWWDT_DEFAULT_TIMEOUT;
>> +	xilinx_wwdt_wdd->min_timeout = XWWDT_MIN_TIMEOUT;
>> +	xilinx_wwdt_wdd->max_timeout = XWWDT_MAX_TIMEOUT;
>> +
>> +	ret = watchdog_init_timeout(xilinx_wwdt_wdd,
>> +				    xwwdt_timeout, &pdev->dev);
>> +	if (ret)
>> +		dev_info(&pdev->dev, "Configured default timeout value\n");
>> +
>> +	spin_lock_init(&xdev->spinlock);
>> +	watchdog_set_drvdata(xilinx_wwdt_wdd, xdev);
>> +
>> +	ret = devm_watchdog_register_device(dev, xilinx_wwdt_wdd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_info(dev, "Xilinx window watchdog Timer with timeout %ds\n",
>> +		 xilinx_wwdt_wdd->timeout);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id xwwdt_of_match[] = {
>> +	{ .compatible = "xlnx,versal-wwdt-1.0", },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, xwwdt_of_match);
>> +
>> +static struct platform_driver xwwdt_driver = {
>> +	.probe = xwwdt_probe,
>> +	.driver = {
>> +		.name = "Xilinx window watchdog",
> 
> Do you see spaces in other names of drivers?
> 

Easier to say that platform driver names must not include spaces (or dashes,
for that matter).

Thanks,
Guenter

> Best regards,
> Krzysztof
> 

