Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411D55FD92E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJMM3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMM3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:29:31 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F6211B2D6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:29:30 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id f8so952090qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mWjMckfYO6R3pT1gH/T7HL/KjgENyPTv8P7zBRmvj2E=;
        b=XvDln5twKivFEbGCXI+A5Pm/le3Z6axjz7FnqktjCKTSru73E7KUZtJ7bz7/AGR3T9
         GoXY5M5rTphPUyLT9MVVaKopNZEgGXP7HGdMWURJ7oBNU4RPTdUcILdpUZIvo4bQkvt8
         dTBKnFcU9CAv/kMpWOBMi/wauHGyFlcTxPlCYS/Q0HNCSs3NraT5VllMG06lh8WjoyWM
         JhGAuQY9IE7FqV8RQhJwsfBcmmFhOh1oDkBILgi+SW+R61jamHKA91QPrMUvQmek4542
         IRA3zuOmu+XrAKPjtV3gv+uTTjbMb1D2GeH973VoqdS7S8+CoLyplGRyxhoDqmvXg27d
         qi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWjMckfYO6R3pT1gH/T7HL/KjgENyPTv8P7zBRmvj2E=;
        b=TqZcoN4ZkL7GgPqY54jh2crpvb95wnWrMIWrwGZ49uCxRYzuSOxZ1kfPeANG6RHnSb
         j/9M+7mxqc+9Ghx4L2b/8G7kp5zsUv/Af51jfHzOrccGU0d0+vBEgz8dyic16u5dvtkw
         /emrdUv8Odw+czDtDP8IdU8GGJVHTrVEDCCrYj5/n6MEcBY35BlZHQktNhFCRRxGp1s0
         ETUENbmBwPdYWAuKryC3DFfJJixTyFZZjRm5pIk/Eq4pKI18JkG1EwOeU/QSfkZ6+g/j
         sHMMc7/9u4h+5M9SDiBmB/aeYtuac+18GCAZKzxa7yMqAd9fxNBJq0Iwr1gVuBof4xey
         NY3g==
X-Gm-Message-State: ACrzQf2bJ3G//8KRjRa21DCaGM58A+1AXH+kvrWp1tAtYqqeDW1ELVsH
        XZAwCq/QarRHS/XdqCWJEAuY51LUiJZT/Q==
X-Google-Smtp-Source: AMsMyM5sv0Vga4IZ3dJIN7R/wSMuZUBhI82PmiMBNMK7yz2Vh/tmREqvUu0S6OmCnZGsdEy5COcy2w==
X-Received: by 2002:a05:620a:2891:b0:6bc:5c73:9728 with SMTP id j17-20020a05620a289100b006bc5c739728mr23863484qkp.178.1665664158502;
        Thu, 13 Oct 2022 05:29:18 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id f7-20020a05620a408700b006bbc3724affsm18599984qko.45.2022.10.13.05.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:29:17 -0700 (PDT)
Message-ID: <a7e96623-0010-a7ae-fa3d-df1defcd51ca@linaro.org>
Date:   Thu, 13 Oct 2022 08:27:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 1/5] soc: hpe: add support for HPE GXP Programmable
 Register Driver
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-2-nick.hawkins@hpe.com>
 <c6ab6116-5d92-132e-48fc-b731fd244d72@linaro.org>
 <DM4PR84MB19276978EB630CF08833E5A488229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <DM4PR84MB19276978EB630CF08833E5A488229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 16:25, Hawkins, Nick wrote:
> Greetings Krysztof,
> 
> Thanks for the feedback! I have several questions below:
> 
>>> +
>>> +static ssize_t server_id_show(struct device *dev, struct 
>>> +device_attribute *attr, char *buf) {
>>> +	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(dev);
>>> +	int value_upper;
>>> +	int value_lower;
>>> +	ssize_t ret;
>>> +	u32 trans_offset;
>>> +	u32 trans_shift;
>>> +
>>> +	/* read upper first */
>>> +	address_translation(drvdata->server_id.upper[BYTE],
>>> +			    &trans_offset,
>>> +			    &trans_shift);
>>> +	regmap_read(drvdata->plreg_map, trans_offset, &value_upper);
>>> +	value_upper = value_upper >> trans_shift;
>>> +	value_upper = value_upper & drvdata->server_id.upper[MASK];
>>> +
>>> +	/* read lower last */
>>> +	address_translation(drvdata->server_id.lower[BYTE],
>>> +			    &trans_offset,
>>> +			    &trans_shift);
>>> +	regmap_read(drvdata->plreg_map, trans_offset, &value_lower);
>>> +	value_lower = value_lower >> trans_shift;
>>> +	value_lower = value_lower & drvdata->server_id.lower[MASK];
>>> +
>>> +	ret = sprintf(buf, "0x%04x", value_upper | value_lower);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static DEVICE_ATTR_RO(server_id);
> 
>> Missing sysfs documentation.
> 
> Can you point me at the proper location / documentation for documenting sysfs? Thanks!

Documentation/ABI/README

> 
>>> +	for (i = 0; i <= MASK; i++) {
>>> +		if (of_property_read_u32_index(np, "grp5", i,
>>> +					       &drvdata->grp_intr_flags.grp5[i])) {
>>> +			dev_err(&pdev->dev,
>>> +				"grp5intsflags is missing its 'grp5' property index %d\n", i);
>>> +			return -ENODEV;
>>> +		}
>>> +	}
>>> +
>>> +	np = of_get_child_by_name(pdev->dev.of_node, "pwrbtn");
>>> +	if (!np) {
>>> +		dev_err(&pdev->dev, "%pOF is missing its 'pwrbtn' node\n", np);
>>> +		return -ENODEV;
>>> +	}
>>> +
>>> +	for (i = 0; i <= VALUE; i++) {
>>> +		if (of_property_read_u32_index(np, "latch", i, 
>>> +&drvdata->pwrbtn.latch[i])) {
> 
>> Undocumented properties. NAK.
> 
> If each child node of hpe,gxp-plreg were documented with their respective properties would this be acceptable?

I would need to see the bindings.


Best regards,
Krzysztof

