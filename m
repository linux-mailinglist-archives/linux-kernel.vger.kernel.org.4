Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDF63C72A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 19:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbiK2S0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 13:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbiK2S0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 13:26:32 -0500
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4307C627C3;
        Tue, 29 Nov 2022 10:26:31 -0800 (PST)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-13bd2aea61bso18146112fac.0;
        Tue, 29 Nov 2022 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0SKtbTyrcsLd7ib4BwIBICfnm5xqcJzzrg4yk4WZVbs=;
        b=qOFB6zNhyXBlu7D3vKW/9dqlM+E5XOJ0erfcx4Ps5eASzVnoxE/RpZ244vR7KzmfEK
         29M0/jRHKgYzwzXg58Ax+32PVMWJFWAuKl740yrdT/77PCuKzV6j2nJqgTu4TPe5/FVE
         1Dxyun5Zb3iD4dTCQ+465AywoXoW9mFBjxp7eOv9nqsoAsYhuj6ZTyEzF4OYgs1GF3Xh
         JqQHqZeo4DtSVXD0fruw1P/89CmgdR2OvhWLqoVvNTfN0P+8iustIvygjqo4vVzwhG+h
         dtkzguR+oruaFzpET36ysLNZnJGyCF0ZXcJKn7T6vNXQU8KcvOGJZLSGmkWJ2o1arbUN
         5Bkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SKtbTyrcsLd7ib4BwIBICfnm5xqcJzzrg4yk4WZVbs=;
        b=IVZW6gHJDlFc5QzpGf9Xi2GwTv40uk+WDO2Y+bIGzzr6Q3T6tJ2Z4LMqYQ3BjBiRBx
         q1m44qLhLdyzgSK6LFmtvqRqZWydk+ZLCqYL/UDwZ4nSfjWAXiJjjCkKRGuTr1vQSfof
         kCR02kMDLewWwHz+8/irapKX5nHP85CV8pZGajHwpViCRytCOMyi46HcR1Ai5hHJHymQ
         e9VyTnN1XZ6A9KL5W+sJwk5wfY279HpZfSPm5eikhFwU7Qg1zj1/85R5VEaHDfK3c8ZU
         AevBiIyBmyBDcPQOaa2KuY51TZijbZsgLgLGqUBMRCuVYvgyaNIgl58bN8qEPW/JhED0
         tO2Q==
X-Gm-Message-State: ANoB5pnef7sRL7TX5URaL4CDBK3xLWiJO1Z2aWPQwhT7zTdOXQ+5Dcte
        A1cf4274+cdiMwgQUBBcX5U=
X-Google-Smtp-Source: AA0mqf7pKujXUaAO+DZaepplUOaXjel7eKL7zhvuG5jR3cQhQbUwctGuf/PFl/tDqsFNOv0GQug7iA==
X-Received: by 2002:a05:6870:6d0d:b0:13c:8028:cbec with SMTP id mw13-20020a0568706d0d00b0013c8028cbecmr20863458oab.33.1669746390642;
        Tue, 29 Nov 2022 10:26:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l16-20020a05683004b000b00662228a27d3sm6240310otd.57.2022.11.29.10.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 10:26:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4fb6abe0-a68e-f391-5111-dab139891837@roeck-us.net>
Date:   Tue, 29 Nov 2022 10:26:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/6] hwmon: (gxp-fan-ctrl) Add GXP fan controller
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
 <20221128230219.39537-2-nick.hawkins@hpe.com>
 <20221129040232.GA1901150@roeck-us.net>
 <B3B2AA1C-0AD8-406D-B766-4CB86C39A834@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <B3B2AA1C-0AD8-406D-B766-4CB86C39A834@hpe.com>
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

On 11/29/22 09:13, Hawkins, Nick wrote:
>>> +		writeb(val, drvdata->base + channel);
> 
>> The mixed use of direct writes and regmap is odd and confusing.
>> Why use regmap for plreg_map and for fn2_map but not for base ?
>> Can this be unified ? If not, why ?
> 
> I will still require three separate areas to access these registers as they
> are spaced far apart (> 0x20000000). I will create a comment to
> explain this. As for being unified methods I believe they can be
> all __iomem's or regmaps.
> 

I understand that there are three regions. What I don't understand is
that two of them are accessed through regmap and one directly. Either
access all regions using regmap, or all regions using iomem accessors
directly. If regmap does not support access to the base region,
don't use regmap at all, explain why regmap doesn't support this kind
of access, and make sure to copy the regmap maintainer.

Thanks,
Guenter

