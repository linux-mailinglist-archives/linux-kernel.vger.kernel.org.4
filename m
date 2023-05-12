Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093CB6FFFD8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 07:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239812AbjELFQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 01:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjELFQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 01:16:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D835A0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:16:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4f2510b2b98so6495864e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 22:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683868564; x=1686460564;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YItu8HOFGjYbDrIPqGGARNcDK3pUy+l3/DwuX5PBOMY=;
        b=bEsKpiJvKUTBv1g5LUaLwpyRPv+OK55MbS7suNx4ObvbZKT4LM+Azxm8g4Zsg3BMt7
         2V/gJIDjieQa3gBjOfYjgKsWDpcLzs/Lkbo+4LZNNVBUlOr1A8o/V4Yp6mkOEgYqw47u
         KjULcu/2+YI74c56daRLU/GgMo796idjRtzgW7D4rJxURF1qI/4Ki1YrQuRvLNYJierS
         v5+CRtPkxUOLwxtXGvCRgzi1IZqskcb0SMuBlCl6AenvAz7Uxa50w0Qh7JXu70ihNbSA
         jqGZygtnGnAunYRSFYUBz7LKxEVvkcKbZWV/qzvLYROoyl1OJTZUdC9ixw46c1y5tLWL
         QkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683868564; x=1686460564;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YItu8HOFGjYbDrIPqGGARNcDK3pUy+l3/DwuX5PBOMY=;
        b=MM0wUKjpLDuWx34pUHbqos+uoPKCe+glx7IiWBHSGOh8hUnq8IdY5KpQflLKuuKT91
         cQAy458YTCArCMUrUAmgj1WHyd1QGItYAJNRM8hGw/Vp7xe8Q1doE5pvQA/DZMP8HKA7
         emyGkIM80h1Rv30S0+NA8roDcC/U/Pa//6sgz342Ys4LRMGUF9Oj/5c2foqrMPiZcsTv
         MZcTOXSXHgcz5YCp0OQDlCHWOPvYPCFF5Hdp23W8wYyt64DJbCeHDT/D1CashxIjOkqM
         lmi39ReFtgwDfVy6u8CkmB7tQnwtK0vI63Iy3k3Hj6M5Am6VvfooxCfUMO+vZmRahnE4
         YT9A==
X-Gm-Message-State: AC+VfDwhRAFn0RE1iPU9ocS7ZQXgY5kTFed/tRu/1zL1v5g+Diissmo0
        hy7QReGCCD49mTZG3AQ67nSydLqPue4=
X-Google-Smtp-Source: ACHHUZ7xqbSiYWWJw+ymmfXp8GvtwoAJrLwf2Ob1CzonIyAw/QsmMJarpqeDK7MkXNJDYIICn8j1Xg==
X-Received: by 2002:ac2:41cb:0:b0:4ec:a18e:f985 with SMTP id d11-20020ac241cb000000b004eca18ef985mr2847376lfi.13.1683868563709;
        Thu, 11 May 2023 22:16:03 -0700 (PDT)
Received: from [192.168.1.126] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id i4-20020ac25d24000000b004edb2cb3500sm1341672lfb.279.2023.05.11.22.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 22:16:03 -0700 (PDT)
Message-ID: <a1ad0e10-23d2-a860-e9a1-2680313d643f@gmail.com>
Date:   Fri, 12 May 2023 08:16:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <46296e39-dbc1-4f27-b89c-af6f08d9f318@kili.mountain>
Content-Language: en-US, en-GB
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal()
 warn: passing zero to 'dev_err_probe'
In-Reply-To: <46296e39-dbc1-4f27-b89c-af6f08d9f318@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 13:48, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   ad2fd53a7870a395b8564697bef6c329d017c6c9
> commit: 7c1d1677b3227c6b18ac999f2b84778baa280b8f iio: accel: Support Kionix/ROHM KX022A accelerometer
> config: openrisc-randconfig-m041-20230509 (https://download.01.org/0day-ci/archive/20230511/202305110245.MFxC9bUj-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.1.0
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <error27@gmail.com>
> | Link: https://lore.kernel.org/r/202305110245.MFxC9bUj-lkp@intel.com/
> 
> smatch warnings:
> drivers/iio/accel/kionix-kx022a.c:1053 kx022a_probe_internal() warn: passing zero to 'dev_err_probe'
> 
> vim +/dev_err_probe +1053 drivers/iio/accel/kionix-kx022a.c
> 
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1000  int kx022a_probe_internal(struct device *dev)
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1001  {
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1002  	static const char * const regulator_names[] = {"io-vdd", "vdd"};
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1003  	struct iio_trigger *indio_trig;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1004  	struct fwnode_handle *fwnode;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1005  	struct kx022a_data *data;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1006  	struct regmap *regmap;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1007  	unsigned int chip_id;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1008  	struct iio_dev *idev;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1009  	int ret, irq;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1010  	char *name;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1011
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1012  	regmap = dev_get_regmap(dev, NULL);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1013  	if (!regmap) {
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1014  		dev_err(dev, "no regmap\n");
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1015  		return -EINVAL;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1016  	}
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1017
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1018  	fwnode = dev_fwnode(dev);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1019  	if (!fwnode)
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1020  		return -ENODEV;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1021
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1022  	idev = devm_iio_device_alloc(dev, sizeof(*data));
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1023  	if (!idev)
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1024  		return -ENOMEM;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1025
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1026  	data = iio_priv(idev);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1027
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1028  	/*
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1029  	 * VDD is the analog and digital domain voltage supply and
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1030  	 * IO_VDD is the digital I/O voltage supply.
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1031  	 */
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1032  	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1033  					     regulator_names);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1034  	if (ret && ret != -ENODEV)
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1035  		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1036
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1037  	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1038  	if (ret)
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1039  		return dev_err_probe(dev, ret, "Failed to access sensor\n");
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1040
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1041  	if (chip_id != KX022A_ID) {
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1042  		dev_err(dev, "unsupported device 0x%x\n", chip_id);
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1043  		return -EINVAL;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1044  	}
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1045
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1046  	irq = fwnode_irq_get_byname(fwnode, "INT1");
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1047  	if (irq > 0) {
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1048  		data->inc_reg = KX022A_REG_INC1;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1049  		data->ien_reg = KX022A_REG_INC4;
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1050  	} else {
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1051  		irq = fwnode_irq_get_byname(fwnode, "INT2");
> 7c1d1677b3227c Matti Vaittinen 2022-10-24  1052  		if (irq <= 0)
>                                                                      ^^^^^^^^
> This code assumes fwnode_irq_get_byname() can return zero.
> 
> 7c1d1677b3227c Matti Vaittinen 2022-10-24 @1053  			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> 
> But fortunately, it can't otherwise this would return success.
> 

Ouch. Actually, the fwnode_irq_get_byname() can return zero on 
device-tree mapping error. I did actually send a patch to address this 
some time ago:
https://lore.kernel.org/lkml/cover.1666710197.git.mazziesaccount@gmail.com/

but got stuck on not knowing "the right way" of handling an smbus 
use-case. Later I forgot this.

It seems I did describe this very same error in the cover-letter - and 
right after that I fell on this very trap I described... :/

Thanks for the heads-up Dan!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

