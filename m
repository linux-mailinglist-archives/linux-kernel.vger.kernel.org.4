Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262CB682FD4
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjAaOya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjAaOy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:54:29 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58EF4C32
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:54:27 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id n13so3522727wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=U1gmdK1mDg1zXMeo9AzCeVEhqun7C86SLHRMj1eeXyIZS9J0znt/vxMkCyhMXjdUGm
         70pwillMsx44XgTNdVRuC9r4ESvPFel8T/9sN2UULu4N3qpxmzOdsoiNQC7dm9vRnSO6
         rsuwa3v7CFzmMzzvloT7pKdXO1GNd4VB0QIAtg0Y+8pO4y3vPRosA9zTZz/6/bdZYMU/
         7iMXpCVbZJynygpzlnCHWJY4MWGece8+lCHprC3Rm+4PBmnDhmkP9KvLYakzTOiVn/8z
         wPYZ7fetI6LXuEmhRg8OksRjq1U/QQExZhtZiqVHgH2PaAYSULt7O2BM6fvBnOJYECLR
         hQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMo1Uvj2rFI4YHTrqKmdTiIi+u7MqVqqdbblHM1ubeA=;
        b=MSc/4bkUkvvttOXViSloF/Q+gT7/inBKF8uwmTrX3yCbqU1K5qsgbn2W2YFTTBiQQ5
         NfOx3xvidjDdt89qKJHSVPDB1WfeL0008TEVNv6ZhJ4CSH4hgce5Ai2/tsYYr0LjyRBc
         KGFQZgynw+36KIDB2d1WiClvup9HR4XzI1RQqopKpLqmCPSKOvuCIVj9Dn5GL1iv7GUf
         ngkCAFlgbdCvm/ZA5Ri/niNfndJvoFT2PPrVQDytWftk21GPp6Eh0YN4X24QsJTj36xM
         65LmTRLZhqhWsfb32pDEt+2gQw5c/oXbEtCWPL4ZP70LqJIf9XeYlKtBvQ2IeKrICgSK
         KDMQ==
X-Gm-Message-State: AFqh2kr5ipAqKus7glN3cCVhrGlHLT+eJfeE7K3hnW3fEqRg2UZ0d/Ps
        9vR0WkgMu1oKOgJHX3PteeqGAw==
X-Google-Smtp-Source: AMrXdXuVNI/fGcr+n0nvKM/UOZFxcx1zbF0nVo7thEMqG/mXeX7Hn3IyCzxxEmVHkfvjc+6TXlXiJg==
X-Received: by 2002:a1c:6a10:0:b0:3da:f665:5b66 with SMTP id f16-20020a1c6a10000000b003daf6655b66mr57672654wmc.6.1675176866283;
        Tue, 31 Jan 2023 06:54:26 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id f24-20020a05600c491800b003dc0cb5e3f1sm15316325wmp.46.2023.01.31.06.54.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:54:25 -0800 (PST)
Message-ID: <f26ac524-3a74-94de-8817-11ab13802493@linaro.org>
Date:   Tue, 31 Jan 2023 15:54:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 2/8] thermal: intel: intel_pch: Eliminate redundant
 return pointers
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Box <david.e.box@linux.intel.com>
References: <1751684.VLH7GnMWUR@kreacher> <1847763.CQOukoFCf9@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <1847763.CQOukoFCf9@kreacher>
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

On 30/01/2023 19:59, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Both pch_wpt_init() and pch_wpt_get_temp() can return the proper
> result via their return values, so they do not need to use return
> pointers.
> 
> Modify them accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

