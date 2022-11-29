Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBEA63B8C5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 04:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiK2De0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 22:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbiK2DeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 22:34:23 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E91FF8A;
        Mon, 28 Nov 2022 19:34:22 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id p10-20020a9d76ca000000b0066d6c6bce58so8297175otl.7;
        Mon, 28 Nov 2022 19:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bYwdY1J95omVb9JxopVcwTJmuo3xeuEqQ7A2D5mZyKE=;
        b=RGNv+nxzg+6H/fnxpQOoa/26j6bW/KUmoBbpieRyJZ/jguakTsZXObkUOMkJJQItaq
         nRkTA2IstplPSY58p3CBBVSSUK9E3g7aQ9Uas+YwdHp4/RoZsJggdayjhNAkI4CG1Ra0
         NUc9q/M+SkgAp/nVKF7gO6ZCTJrX9XYWUrhm3dlL0iuFy4ZWVPK21V3oqY3EMMRAtRuY
         iW4pNa70QpFKn7wQtV+j8bSGChFj7IQx/xlMCazAeCE9lbpLjzLeVoNGpojbdzk/Pm2I
         MTptWCAAnX59gfFcXF/YDXiFLO2AtwFmtiZAHg4IO9OO66zYOaIizMLUKh4uZAinVkz6
         fiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bYwdY1J95omVb9JxopVcwTJmuo3xeuEqQ7A2D5mZyKE=;
        b=QXa1z9k0z1+hZ500nWwQck8kL6FgUbULffC7e5LvqxMQWtdp3BABLCg9QtGUD5MOw2
         DEuWeoNoNpC260eEuSY10iKlUVKZOh6vNYsIiwJSW5z7xHGrFl3M44zfHB0t9gyDo6sU
         nEpoYwm/ZlQkjDkfFNG0hYNqRoIwFcQor//z31yeDP4mWLTgtM2TJ+ttZNdYZSxGB2+0
         vjSaEO0AdV086bnzXqgMwjoq9R/o7cV5NvsWB2jf0nFbrrnXikJ2D5dVF11C4Sd8Um9S
         qoNzjiPFrVv1wn1zrP1sOKdmNpLw42i7dwOMPACt+0dYQ9idklnhVr4pGTKZRhpQzcpY
         FUNQ==
X-Gm-Message-State: ANoB5pksgRI9NiCon5Ge+Z1osw2e87/GuInNLSI09hhmN7sa9V1ip1ST
        jnsXZVy3OIJixippj7WaFHI=
X-Google-Smtp-Source: AA0mqf6XD8PdcjCfIJRBAQKPmcxQBfWha5Zlca4QDLFB278WIwj5bgyb1b/qnQBdizla2nw4jvev/w==
X-Received: by 2002:a9d:7d16:0:b0:66c:4819:8104 with SMTP id v22-20020a9d7d16000000b0066c48198104mr27997346otn.361.1669692862267;
        Mon, 28 Nov 2022 19:34:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 67-20020a4a0946000000b0049ef7712ee5sm5053002ooa.11.2022.11.28.19.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 19:34:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46cecf77-e989-40d9-3e08-fd970ad12a79@roeck-us.net>
Date:   Mon, 28 Nov 2022 19:34:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/6] ABI: sysfs-class-hwmon: add a description for
 fanY_fault
Content-Language: en-US
To:     nick.hawkins@hpe.com, jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221128230219.39537-1-nick.hawkins@hpe.com>
 <20221128230219.39537-3-nick.hawkins@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221128230219.39537-3-nick.hawkins@hpe.com>
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

On 11/28/22 15:02, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> The fans are capable of reporting a fault to the CPLD controller which
> then reports it to the GXP SoC via PLREGS. This patch enables hwmon to
> be able to report these failures up to the HOST OS.
> 

This change is really completely unrelated to a CPLD or specific SoC.
The commit description is just confusing. It should simply state that
it documents the existing fanX_fault attribute.

Guenter

> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> 
> v2:
>   *No change
> ---
>   Documentation/ABI/testing/sysfs-class-hwmon | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-hwmon b/Documentation/ABI/testing/sysfs-class-hwmon
> index 7271781a23b2..638f4c6d4ec7 100644
> --- a/Documentation/ABI/testing/sysfs-class-hwmon
> +++ b/Documentation/ABI/testing/sysfs-class-hwmon
> @@ -276,6 +276,15 @@ Description:
>   
>   		RW
>   
> +What:		/sys/class/hwmon/hwmonX/fanY_fault
> +Description:
> +		Reports if a fan has reported failure.
> +
> +		- 1: Failed
> +		- 0: Ok
> +
> +		RO
> +
>   What:		/sys/class/hwmon/hwmonX/pwmY
>   Description:
>   		Pulse width modulation fan control.

