Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E22729BCF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 15:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjFINom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjFINok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 09:44:40 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDE030E4;
        Fri,  9 Jun 2023 06:44:39 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-652a6cf1918so1508543b3a.1;
        Fri, 09 Jun 2023 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686318279; x=1688910279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvl1ODfYpXdx5tiAQ2WeY28wbqmcjr4dGt9a9iD0Qkc=;
        b=RqLUiqe3bKvGMoQWoC9hgzNFXKbZgVj5odcAej97eabKbRmt+tz2anHGDAk8bfz+vH
         /EdWl9n43tr9OkVKFZhyb8hrp9y0QXJDsHXIvlf8wFZv8Ta0ndCEKe3dc8KhR8nw3ayq
         Z+VpAVGflI5TnnKLR5TwzujcSl192nvfvwtM7/w6rFErnXTk7tZzDeeA2rxIijcal4Cs
         VU6CGK5rwDZxGQ7xlSHC/E49eM0kiZLK762eo2qfY+xJ4H2GGWcKMuRU7gHlPPRtHh02
         fqG6dtOb/MI5ibyJzf1GAXiu9KPeBamu1lboul6ICMdnE0reLhVyhm8ZuxbLUBDIjMJK
         SARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686318279; x=1688910279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvl1ODfYpXdx5tiAQ2WeY28wbqmcjr4dGt9a9iD0Qkc=;
        b=CpxVihmCbL96cS0vfslHoys86tfxvGEDRNu82BjaUnANoP2CohjGdvweMwfqYRz8rc
         m0zNKyI/fzRmgWmFjzSrxHAYXkKKS/nn1qf+SNnV+1WBVo0kEY1JYcpZt3qRxR/my/RI
         wX/xmvNpObJirdsAzewHRffCdrtOglcCT9GFxDy9T3Z2FFcPkjnMAnE5GsMz/L7D7wKd
         jto3fM2FdNYAGR/2y5oXmA4IXXHno9wL3kX63xQbm4xYPceE16mgXxkwQtglu0/0a05P
         Rvy0rN8zf1uAfFw9KiS+jRuDgLzY5hwaR1etPZ3CA+YSbH9qrgpSgMZZ/PPDM5j56rgl
         u4aQ==
X-Gm-Message-State: AC+VfDya4phKjPfzs7DtBfcknXDQ4+iM4t1gZgw/jAMDTdozzJwyEgaC
        1MacTIqIgcxUbObVamFqYKU=
X-Google-Smtp-Source: ACHHUZ5riBRDaiPf46nnW5WFnf6pFsL8GqhhPnOabQB9l8wewVAzCQqFkI4KTsewTCuT0ULe3sl7eQ==
X-Received: by 2002:a17:902:7c94:b0:1b0:4b65:7a10 with SMTP id y20-20020a1709027c9400b001b04b657a10mr983932pll.53.1686318279053;
        Fri, 09 Jun 2023 06:44:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b001b0034557afsm3310111plw.15.2023.06.09.06.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 06:44:38 -0700 (PDT)
Message-ID: <88c195a1-21ee-2b9c-3606-8c3928e3dff2@gmail.com>
Date:   Fri, 9 Jun 2023 20:44:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] Documentation/hwmon: Fix description of
 devm_hwmon_device_unregister()
To:     Yongsheng Yang <iyysheng@gmail.com>, jdelvare@suse.com,
        linux@roeck-us.net, corbet@lwn.net
Cc:     linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230609075510.1305-1-iyysheng@gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230609075510.1305-1-iyysheng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/23 14:55, Yongsheng Yang wrote:
> diff --git a/Documentation/hwmon/hwmon-kernel-api.rst b/Documentation/hwmon/hwmon-kernel-api.rst
> index c2d1e0299d8d..6cacf7daf25c 100644
> --- a/Documentation/hwmon/hwmon-kernel-api.rst
> +++ b/Documentation/hwmon/hwmon-kernel-api.rst
> @@ -66,7 +66,7 @@ hwmon_device_register_with_info.
>  
>  devm_hwmon_device_unregister does not normally have to be called. It is only
>  needed for error handling, and only needed if the driver probe fails after
> -the call to hwmon_device_register_with_info and if the automatic (device
> +the call to devm_hwmon_device_register_with_info and if the automatic (device
>  managed) removal would be too late.
>  
>  All supported hwmon device registration functions only accept valid device

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

