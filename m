Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50925F241B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJBQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJBQ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:29:38 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5EA2FB;
        Sun,  2 Oct 2022 09:29:35 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c3so3450185pfb.12;
        Sun, 02 Oct 2022 09:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=W/mvBMf1l3yRdnUZGfVhcWENOCg0qj1cA36GbcBdRGs=;
        b=pc5lxh/93I0420BOdhHVU0ZejliAddDij6xeEyfW71RDgjct2r166qOY5lEydELyIr
         ocksYuZiMulcBEL75+c234yPrqfLWwCi9q5fdirjO4bzp5kmskw2dLkKfQ04ay0rUkHw
         LhbMT7dQ7Z565nj7Y2bD3K6NXeZhYbWfGcTHF4gffFsz76+nrY0eFoPb09zpHHkX/t2p
         fij+YPfKQxAXX1xgM7fg2EY5b6UY4GFho+2qMeA03IZJwDwT/j5HT52ohlTd1Y5Jwrtg
         WUWfwQf3BYyKJjhGvAW/zzeE/TENYc+6kvn/SF3vVONGNBSKHZf0yzm2pN58NuEGG+bF
         rsiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=W/mvBMf1l3yRdnUZGfVhcWENOCg0qj1cA36GbcBdRGs=;
        b=OIHUqB7QYXMrluFX5dqabtFeoDUuR16HNiM4nXOP7A9wpIvjo/+F/wTApPPjufDmXZ
         BJfHQihfpa9As8jZ9LZ4jcKTaHYU6Fz156M7DsObiagyggcUf56GUEKE9kZhHr8fRCX6
         acndayxlxFbysSorLT/Jh4nD6Zc1xT2P+CnA0wOhG7fuoHhVPKOomBMqZ8DjghvnskeO
         Dc0G5KHC8rFU1BkQA4WvIy71JOKbIQl/kXNAGGXt1qdAvRHTf4u2egPA9Yn/0Z1po5nr
         bHao5VN5tDyI2LVrrtFTPUJFsPN5VTUKICtQLuN4reNfzF2Muvu0sQG1CBh32pPcgG2t
         GQOQ==
X-Gm-Message-State: ACrzQf1dricbGTd/cgOqEtTA/isFlMXX0D1pCYlc1F7V89CMo0k8PL0k
        EKHDcGG254YnbABbXHjM+Dk=
X-Google-Smtp-Source: AMsMyM4Xilj4glB6Ba2j6F0ZyyDyJsIw+Psqqfq8MIUonaXcQGuf/KYl9gbQF1Rrqgw2kl+kSrJGKg==
X-Received: by 2002:a05:6a00:189d:b0:53e:79de:3fc1 with SMTP id x29-20020a056a00189d00b0053e79de3fc1mr18461328pfh.2.1664728174572;
        Sun, 02 Oct 2022 09:29:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c6-20020a170902d48600b00178143a728esm5547388plg.275.2022.10.02.09.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:29:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1cb7fdb7-ebad-a61e-490c-80e6c9feab2b@roeck-us.net>
Date:   Sun, 2 Oct 2022 09:29:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] watchdog: xilinx_wwdt: Add Versal window watchdog
 support
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

After looking into the entire driver code, I see the problem:
clk_disable() is called in the stop function. That is wrong;
if the clock is disabled in the stop function, it needs to be
enabled in the start function (which is not currently the case).
In that situation, using the devm_ callback when unloading the
driver isn't possible (or, rather, would require checking if the
clock is enabled before disabling it).

Thanks,
Guenter

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
> Best regards,
> Krzysztof
> 

