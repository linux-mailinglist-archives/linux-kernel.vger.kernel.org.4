Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBE6B3D27
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 12:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCJLDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 06:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCJLDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:03:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC81C97C8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:03:49 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso3173702wmo.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678446227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f2cqaQ7P3+QlFidPWZAuEu2duN2TwjDZBG31X7oHFQk=;
        b=pXW/fXq1BSv1IPdAh0bFQhD5mDGZW4TKqVFC7WBT4PG+9tpctEcpKkMtEzEXovXcbW
         b2NA7ywFBB3/PR4SineOULUiVDAoZ6PMUYM23RuHN9DVWAApvqttgaV3KQI/ruILANSB
         V0CA8pJ1fAIHS+tQmWgy+/uRBKY1dRdA+saFYqpZa4dtYXkUkarkcClKwoF5IPohwM0b
         62hgP1Oc0CAwxdKakHjx8PmLsgen8XdUumBT1bak1t78tQtuesCrV5Ab7ZG4lE2fukZm
         qcWdWXoL3yTu0BujG5pNCqro5Dn2RL07aC/hU10qUJGSak/KT+TjAu44XEK4PaafRw6i
         AlxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678446227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f2cqaQ7P3+QlFidPWZAuEu2duN2TwjDZBG31X7oHFQk=;
        b=fiBxqOm73l7bYbe9ajIyZrRvQVKmpg4/g+fjYQYCd+/ZdbiZQZ2bsNBN0Q5QXEXC+3
         ojAfiH6wtL8ySrr48qpPqpWdSkAZVrqXsP1BxAK1EsyVK1x5ALdqIGP12NG3mSj8zYlZ
         1DDJP/+EMlRrzg7BNQmJ6CFpW6otcyy6L8r6WTfaL9RoE6t06t26sGkIOXegelw5W2XH
         J/zT1j4G54qd7Czi+LuD1b0N8qPnVscjZjwvD4zNg7pcSD2apIUWIOsKbfumd1upW5In
         LTCAD23/1OFu2LBJfTAmqhqsHQadTORnePxHnwVKvDyeZr5Pd2d4BljW8FuO7rqa1JEH
         EsPA==
X-Gm-Message-State: AO0yUKVelAdHV6KThwTFaWIq6umSpCqLmvCiJ34QA6eAqnm5vxMrPaLn
        ZOdrtkUQbUpREJyDS9msZTYh1g==
X-Google-Smtp-Source: AK7set9MxonTrQIssC7Z8UMeHgkpnv2EPMV7DEIuDlDQUmWtedQcdBRMlZISj50c2oYgxOBjDojdNA==
X-Received: by 2002:a05:600c:4450:b0:3eb:36fa:b791 with SMTP id v16-20020a05600c445000b003eb36fab791mr2152882wmn.31.1678446227516;
        Fri, 10 Mar 2023 03:03:47 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id d20-20020a1c7314000000b003e1202744f2sm2582484wmb.31.2023.03.10.03.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 03:03:46 -0800 (PST)
Message-ID: <54e7ee75-6035-c2e9-fb8b-fe96adbb571a@linaro.org>
Date:   Fri, 10 Mar 2023 11:03:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 17/20] nvmem: layouts: sl28vpd: Add new layout driver
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
 <20230308153200.682248-18-miquel.raynal@bootlin.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230308153200.682248-18-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/03/2023 15:31, Miquel Raynal wrote:
> +
> +static int __init sl28vpd_init(void)
> +{
> +	return nvmem_layout_register(&sl28vpd_layout);
> +}
> +
> +static void __exit sl28vpd_exit(void)
> +{
> +	nvmem_layout_unregister(&sl28vpd_layout);
> +}
> +
> +module_init(sl28vpd_init);
> +module_exit(sl28vpd_exit);
Looking at this pattern in two drivers, we could come up with some 
helper macro like.

#define module_nvmem_layout_driver(__layout_driver) \
         module_driver(__layout_driver, nvmem_layout_register, \
                         nvmem_layout_unregister)


--srini
