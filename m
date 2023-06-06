Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCCF724965
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237683AbjFFQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjFFQl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:41:56 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C3392
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 09:41:55 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so64593445e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686069714; x=1688661714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UJVhSFzwvoXL05SwEZRGFG8BPsH7hzDQHLdfK0N4XEI=;
        b=jKMO/zj8MTHMUyGzGIwHAMXxOmIVqnupiRJCkJli9mbhTU0IpdJFEbDGrDRo/71m2C
         uM4dtMlMedubAfYBiDCvD3x6E0c3xfvAm/11BRDR+6yynRnTUWaUbz5yFZAObPz7Ov9L
         rLKTwYLYqJ8i1J9zj66laViBXJM0zY4ahwF0G39Jx84REtgxXe9E41d8JdWuaXJWJ0T4
         oPUh0XhpF+iBwnTFb0TZW0sMMTbjMmntxMkMn73mNQPpg6Fvoc4tWzH57beDh04eFBKY
         S51Zjf7YLnKxC4mFGjI4lUGVANIeVGMHPBNR9AGH4rN8Y1Wnkrf7TRBILEYb1MFmB/p5
         sZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686069714; x=1688661714;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJVhSFzwvoXL05SwEZRGFG8BPsH7hzDQHLdfK0N4XEI=;
        b=Meze1icm9hmOPZVLaOmyHNWgzVjHPqwWrbYN32iJZ2m2CK4xmxvys89iFviUr8VZHO
         vuEr2LTETr/2ql/DSkcXfNX8zVjVfBl6t98hFOGn1HPR36niiMdzWyR5O+ywnCICBgOz
         B4bWwCJ/bWvx75edUD4w2Dy63+mNwZ14IUJcnM/6yavvIjViRHwza9Kha0lYkucJluKR
         Uf/9mzQUoHeNqXp/Ztj6AoYCFDueWxVRddZhKhuGRdzo3vjAKdXcUX8Sc56duqQ5/GV3
         Y3xQiicnEG0uoPqfBX9pVeJF8UdB2b2lLZVB/aTgbRRmHDVWXfE3ebUnRFuoH5UogmCg
         suZg==
X-Gm-Message-State: AC+VfDwaUjKIoOdprOg8wukSsmtnjanDJBpV7w0RKPTbEdszg/nCj6Hv
        wCdvJUFGIrDtTC1sgGXnI2bq/Q==
X-Google-Smtp-Source: ACHHUZ68Q3UxcFpcphCWiDRHpz1V6fxBIaMziwmeBQ/sCgLY/1mKB8AXKDG8EJbcYUMmVERBpEbrBQ==
X-Received: by 2002:a1c:741a:0:b0:3f1:789d:ad32 with SMTP id p26-20020a1c741a000000b003f1789dad32mr3040046wmc.11.1686069714005;
        Tue, 06 Jun 2023 09:41:54 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8fb:84d9:d402:6b22? ([2a05:6e02:1041:c10:d8fb:84d9:d402:6b22])
        by smtp.googlemail.com with ESMTPSA id f18-20020a1cc912000000b003f4e3ed98ffsm14492860wmb.35.2023.06.06.09.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:41:53 -0700 (PDT)
Message-ID: <0ddddee6-c01b-0989-6d49-c05568188c48@linaro.org>
Date:   Tue, 6 Jun 2023 18:41:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/7] ACPI: thermal: Move acpi_thermal_driver definition
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <2703629.mvXUDI8C0e@kreacher> <3761470.kQq0lBPeGt@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3761470.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2023 14:15, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Move the definition of the acpi_thermal_driver structure closer to the
> initialization code that registes the driver, so some function forward
> declarations can be dropped.
> 
> Also move the module information to the end of the file where it is
> usually located.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

