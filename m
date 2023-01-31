Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8096682CCB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbjAaMmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAaMmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:42:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320FF59F8;
        Tue, 31 Jan 2023 04:42:23 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id jh15so5873289plb.8;
        Tue, 31 Jan 2023 04:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVPlqWdyzakqT8A0oiBlN6ELSaA4FijmFZ/f8hBpSb0=;
        b=XNjSuciVozPlCMf5ihdSXuioYZPON6d+ZFbO1IfiSBrGttMPr5hyxsABsNk7bxuk+A
         Rld4u0v8FcZYDzsz+Vusi90Dmj+5hUv+9buwFU92ikWhQ8x4on2alV2a5cHEJDbG3As8
         mhfv1ZyzY2cmgw1IWdW1MbtzrgKqZ1usAILviUaxHnmPsuS2xJhx5Ep8kk90xgmv38TF
         DhrrFv6MNBTPMlG4XuEm7MudCDrMOEwgOl6RSWGmQxQfVy2t0d2Lct3xySX66H1n7MZJ
         TaobB772CSK6XCZHXRv6Hcf7NHJDsF+Qrazg6ZCJn8QKagX3RwS6YVU3Pbf4ZgIUn9qT
         uG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVPlqWdyzakqT8A0oiBlN6ELSaA4FijmFZ/f8hBpSb0=;
        b=vaUgTeBeicxJe0NEXLL/sJycCIBK+d0nCqAWjI2bRaHDl8sLLw8SVic+NmUtOYV0/3
         aA5s/cxSW/nfXMaVe+nJeDX8FZfpQoQdBE5B42rzSmFi91DHKxoYbntJO7HSyOJl1hM2
         WW3key+6oYgq4g3cNZbUyFVStbzXRTqM4cAdGrHVnAkntTj8eAMssGD2nFoCh/ZKnMA3
         q2WHXS0IzK58XRL7S6WsR73YoIayCj33pn/sk4XPMYDulQTHDcjIPBgOwL3UVpm80QF5
         TXE26icnrImheNUyaF6pozIUsA6XTeiz4/uk6MoJvvF+YvFdYFzn5gckgtSfU2/n9ff7
         3CKg==
X-Gm-Message-State: AO0yUKVV4gAVsomM52J1yy9dvucrI6/daXa6oiZVe/sRfiDaFsKDr4F9
        TliwyOs5iwiSC0exeee+TOw=
X-Google-Smtp-Source: AK7set9LJLOYk1jCM9i+2oLYrMZvin4DbigkZZE5RXUHNhyJVfOknN7WGNZT0ELlQhpHLXkZzNDp3Q==
X-Received: by 2002:a17:902:da92:b0:196:7df6:2d38 with SMTP id j18-20020a170902da9200b001967df62d38mr9687039plx.7.1675168942642;
        Tue, 31 Jan 2023 04:42:22 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-4.three.co.id. [180.214.232.4])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709028c9300b001965f761e6dsm6949475plo.182.2023.01.31.04.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 04:42:22 -0800 (PST)
Message-ID: <65c16136-025a-f2f0-402f-a341f3da2723@gmail.com>
Date:   Tue, 31 Jan 2023 19:42:15 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 6/6] Documentation: amd_pstate: Update amd_pstate
 status sysfs for guided
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, santosh.shukla@amd.com,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-7-wyes.karny@amd.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230131052141.96475-7-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/23 12:21, Wyes Karny wrote:
> diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
> index 5304adf2fc2f..56a3d11f51a5 100644
> --- a/Documentation/admin-guide/pm/amd-pstate.rst
> +++ b/Documentation/admin-guide/pm/amd-pstate.rst
> @@ -303,13 +303,18 @@ efficiency frequency management method on AMD processors.
>  AMD Pstate Driver Operation Modes
>  =================================
>  
> -``amd_pstate`` CPPC has two operation modes: CPPC Autonomous(active) mode and
> -CPPC non-autonomous(passive) mode.
> -active mode and passive mode can be chosen by different kernel parameters.
> -When in Autonomous mode, CPPC ignores requests done in the Desired Performance
> -Target register and takes into account only the values set to the Minimum requested
> -performance, Maximum requested performance, and Energy Performance Preference
> -registers. When Autonomous is disabled, it only considers the Desired Performance Target.
> +``amd_pstate`` CPPC has 3 operation modes: autonomous (active) mode,
> +non-autonomous (passive) mode and guided autonomous (guided) mode.
> +Active/passive/guided mode can be chosen by different kernel parameters.
> +
> +- In autonomous mode, platform ignores the desired performance level request
> +  and takes into account only the values set to the minimum, maximum and energy
> +  performance preference registers.
> +- In non-autonomous mode, platform gets desired performance level
> +  from OS directly through Desired Performance Register.
> +- In guided-autonomous mode, platform sets operating performance level
> +  autonomously according to the current workload and within the limits set by
> +  OS through min and max performance registers.
>  
>  Active Mode
>  ------------
> @@ -338,6 +343,15 @@ to the Performance Reduction Tolerance register. Above the nominal performance l
>  processor must provide at least nominal performance requested and go higher if current
>  operating conditions allow.
>  
> +Guided Mode
> +-----------
> +
> +``amd_pstate=guided``
> +
> +If ``amd_pstate=guided`` is passed to kernel command line option then this mode
> +is activated.  In this mode, driver requests minimum and maximum performance
> +level and the platform autonomously selects a performance level in this range
> +and appropriate to the current workload.
>  
>  User Space Interface in ``sysfs``
>  =================================
> @@ -358,6 +372,9 @@ control its functionality at the system level.  They are located in the
>  	"passive"
>  		The driver is functional and in the ``passive mode``
>  
> +        "guided"
> +                The driver is functional and in the ``guided mode``
> +
>  	"disable"
>  		The driver is unregistered and not functional now.
>  

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

