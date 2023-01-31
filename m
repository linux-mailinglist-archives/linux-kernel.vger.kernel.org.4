Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D36831BB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjAaPkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjAaPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:40:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3D3521CB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:39:54 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so10927171wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dxmryiaMIfHhWze9/Btzg+33937lzrXECqTVRCjEX6E=;
        b=HJ+9lvsOIPh4qmmcIksr48LGL5dGzjtiIECJNMLe062na23dnIE/LOX6frZ33/yAg4
         hxRATS2jMhgu8IAXK52nvdZM8dhHicFmVmdfqLsnrZl+JcEX34fjKV7VNxvV0t9SnL10
         tdwVmaMRZGrMHtq4l5qsbtcr8EFoG2VotSj8l7EqbMfjWEbhfe8icjjXM0K6VQGR2IJs
         Z8w0PmDLH8oz/RHnzr8oU3fAGNAR465AuNtbcuOqjoNyWoJO830NRgnGg8XR5NEOcJge
         bjoNbAtLjvsZ5Bs/7ppchTfC8yY3Dtt14sIMNu4kb5i1SQ4gxbmNfApwV/Dw0lTEe1Mu
         FwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxmryiaMIfHhWze9/Btzg+33937lzrXECqTVRCjEX6E=;
        b=DpVGxI/YMLBA5/MRoBr3cUD3wVFdkyPQifMLmwUvlJ8r3oBQQLL/FzTpN+4TG0qE6J
         HNVhtJGaF9k3samp50gx7IxgmOneHNU0u7RMzSJPna239UTky+GMAoLZe+pTDwfykEUe
         CmGL85U8qV3eBYb68qju2cEIo86+u7s5lkLWiAKqJLk5+tFoeoAbKdDqMRMslltgGNn6
         XqHmkTlaDTn09jRdbNuakgObaxdLjxfziMZ5Km+6SmIKig51hzXN5bqV6Otpo9QzM9sF
         Nt65QgE7T396CZs3HAIzDbN/3Qji75dA5fUbrxrdRJc2Wh3W0Gq43qQt5yZcb0W/lqhg
         eR8A==
X-Gm-Message-State: AO0yUKX2tfSc3MMqEW7TQgoUkrsPHmWf/aIllVrFq0O8PuVeuS8GsuTE
        arfRORLPhj+T2hnPFCL1Fh1bcg==
X-Google-Smtp-Source: AK7set+nSv2SvvWrJMSc6LYW4dP/bhR0owoVVEtTGUpAiXM4dWaJmCNI4Iz326T228c6SXJmaVjKgg==
X-Received: by 2002:a05:600c:43ca:b0:3dd:6d69:7cda with SMTP id f10-20020a05600c43ca00b003dd6d697cdamr2678989wmn.39.1675179587384;
        Tue, 31 Jan 2023 07:39:47 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d3-20020adffbc3000000b002bdd155ca4dsm15001584wrs.48.2023.01.31.07.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 07:39:46 -0800 (PST)
Message-ID: <cb653a1e-1fbb-657f-0f61-8c27dde15655@linaro.org>
Date:   Tue, 31 Jan 2023 16:39:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 4/4] thermal: intel: int340x: Improve
 int340x_thermal_set_trip_temp()
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
References: <2133431.irdbgypaU6@kreacher> <3719164.kQq0lBPeGt@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3719164.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 19:47, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Instead of using snprintf() to populate the ACPI object name in
> int340x_thermal_set_trip_temp(), use an appropriate initializer
> and make the function fail if its trip argument is greater than 9,
> because ACPI object names can only be 4 characters long and it does
> not make sense to even try to evaluate objects with longer names (that
> argument is guaranteed to be non-negative, because it comes from the
> thermal code that will not pass negative trip numbers to zone
> callbacks).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

