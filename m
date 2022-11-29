Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9363C552
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbiK2Qiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiK2Qic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:38:32 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFF1554EB;
        Tue, 29 Nov 2022 08:38:29 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1433ef3b61fso17659223fac.10;
        Tue, 29 Nov 2022 08:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=AIlkOn1RGTq0BXLREQR2dL++z9UYJr3//es7sMDSy6A=;
        b=EKoyPOxWXAcv0kDDdile+YOyw3OQWwaLEiDIOyN/NHyCAVR6O2RqtkJTe76BiLFIGR
         17KRZE8DxOXE5pNAdFCrIGA17/SVtvWpg54HaTOay5RFc6fpUvhim0843hcvEN39xnZp
         0nM8qQUvVqIRZIl4AEmG0e0NQEm3wDcyeB0sM2EbHD2KigmremQkb7BGXWnfmxvk+B+l
         LqZrpShZt/virc1YvHBrCrHxAEEJXLX3fAQfO2IRykdzBo4IqiJUwN+J44VDvSXBlUme
         FpoeFTJo54oaFHYRmfJPbL32B+9DiEzbfDf6/Lg9q+5ctkp3T7vv+VknAwdajyP+6oNk
         87Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AIlkOn1RGTq0BXLREQR2dL++z9UYJr3//es7sMDSy6A=;
        b=mPVR/z8bgHhHKj1FVb0yqVMf2cWR4/oOwrLHmN2bgkP4zo4A0EHqAmB+GhxgvHONa4
         suaaW4Gk5/EFFp3S/awtC/VBbUrLFkTM1HxyJ5X9qKx7S2eVwlfsVkoy6KHumBG1m0Zf
         U573HJtkXDd6UEdCquWGnoq7fV2Fpf0+9yWc1glUBaDJPSlAIZ6/IJfZgdzkhMtZ4XMT
         vI8RNJzuyXs7E2sW/nofWn4LPMw9F9wMQh4XMn1jH32WV7LJhyk6ztDe+wSKTcHQZn/j
         LbEGs+wTYG/X5zaCxv7sWMF3HgsiIeOBpB2yw1gsX9DFWhMy1l0wE/dmWOUw0v8pGEO+
         oZbw==
X-Gm-Message-State: ANoB5pn/Xqj95QjelvicSMVk7rn3bNRRBHwxyaHBn0z6D/WxlsXB80pm
        WmYciDUMD6yKESqlWPnpZ4o=
X-Google-Smtp-Source: AA0mqf4c1P2rrkH8pFF2t7W8Qd8VY+UanFfxu3zqXTVS9B/EJybxD83c1QwxiBefdWn2vIwzBCN7Zg==
X-Received: by 2002:a05:6870:888d:b0:132:c1e9:728b with SMTP id m13-20020a056870888d00b00132c1e9728bmr21864753oam.241.1669739909056;
        Tue, 29 Nov 2022 08:38:29 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ce8-20020a056830628800b00661b019accbsm6122281otb.3.2022.11.29.08.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:38:28 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0d32c71c-9d88-26fe-60a3-e13ff64a47ad@roeck-us.net>
Date:   Tue, 29 Nov 2022 08:38:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/6] ABI: sysfs-class-hwmon: add a description for
 fanY_fault
Content-Language: en-US
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
 <20221128230219.39537-3-nick.hawkins@hpe.com>
 <46cecf77-e989-40d9-3e08-fd970ad12a79@roeck-us.net>
 <0A5DF9D5-B8C2-44A4-924A-B8957EC8A2A7@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <0A5DF9D5-B8C2-44A4-924A-B8957EC8A2A7@hpe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 08:15, Hawkins, Nick wrote:
>> This change is really completely unrelated to a CPLD or specific SoC.
>> The commit description is just confusing. It should simply state that
>> it documents the existing fanX_fault attribute.
> 
> Understood. Just to confirm should I change fanY_fault to fanX_fault
> in documentation as well as the patch description? For instance:
> /sys/class/hwmon/hwmonX/fanX_fault
> 
> It seems that the documentation around it uses fanY_ format.
> 

Now you start splitting hairs ;-). I wanted to point out that
fan[X,Y,Z,A,B,C,...]_fault is a generic attribute, not that I want you
to change fanY to fanX.

Guenter

