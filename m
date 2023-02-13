Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03460695394
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 23:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjBMWGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 17:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBMWGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 17:06:07 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709A81F905;
        Mon, 13 Feb 2023 14:06:02 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bx22so13265082pjb.3;
        Mon, 13 Feb 2023 14:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSmh8hcvEdacLAYxwiWawxw/aw6Gnl+jH1RbbwqcyDU=;
        b=BGQ8spAk5kO+nZKh5MZPpthBucpHqtzTMaqDSSXmOPf4eG0wOwcLM0SJw9wsuSxUQp
         FyV3imkhFePHZ6wQ4H6M/xfROuWSokb+b8wqXcG7Mk0Xcm+DnO6ALNyW7axyo1DuwbKn
         kirDshEZjel+zdWh+LcpTrSH3SC60XzMay2IaCoDiEUHHiYOVisQ664gJxhuQY4LWUT3
         /4Zzi706GB4EYnxPwHdXW1GACQPvXtfK0kA1hnrofiohnBMR9IRxsVUQf2B5CtwDD5bp
         ls1jGEy983PqmWs2ayVcz9tT0sYOEzYtUwxUze2qUW0hSZHcxhD/omCs2RnT+b2FhQ6a
         V3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSmh8hcvEdacLAYxwiWawxw/aw6Gnl+jH1RbbwqcyDU=;
        b=TQEjlPgPSiHhLIgakWQPx1+iWIciMvduT9nGc5RtjQRgyCmHyxGhAGohq6/WJlKUVs
         ErEE91h/i6zULLaimu/v9hiyxS8ln4/G+pn8c1ag0VJtrh1dB5FXfb16OjBDDkP6xcE1
         eUQ/uCxFX4eMI5vzIFboq3nkq1LWLqduc64V8ndK3MUg42GIs5K1RfvH09Wc0jGgTfQX
         vSRFOP5qkmmBXo8fpcX/ihpaMHDT/VxFsOb/vWsTJcKlXCAjNESOewY0aGFV+0/XZzqV
         hGbwsv31j39Y1DkitgmWrbCvZ7QO9/wVUs3f7GpKyOwRDIyQsdBJ9iWu8I+95E9m/nwm
         sbjg==
X-Gm-Message-State: AO0yUKXq3ffTTglve6nFo1TjLbO2Vo0o8CWB/1CpukoQ/8OdltgofAKt
        xlVRmhn82dH5c2v76FP4qnE=
X-Google-Smtp-Source: AK7set/51tKewf1ZoLfwCfPXAzvkXy29SMJTTGSiQS5NSOJzv/HZco4cZYDwtlwr7soPiVELZKWSBQ==
X-Received: by 2002:a17:90b:4f8d:b0:233:b20f:e646 with SMTP id qe13-20020a17090b4f8d00b00233b20fe646mr137897pjb.0.1676325961930;
        Mon, 13 Feb 2023 14:06:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hk17-20020a17090b225100b0020b21019086sm110532pjb.3.2023.02.13.14.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 14:06:00 -0800 (PST)
Message-ID: <a2feeca3-fad9-e1a5-1964-129f86a4558c@gmail.com>
Date:   Mon, 13 Feb 2023 14:05:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/8] perf: arm: Make PMUv3 driver available for aarch32
Content-Language: en-US
To:     Zaid Al-Bassam <zalbassam@google.com>,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
References: <20230213210319.1075872-1-zalbassam@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230213210319.1075872-1-zalbassam@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 13:03, Zaid Al-Bassam wrote:
> Currently, PMUv3 driver is only available for ARMv8 aarch64 platforms,
> ARMv8 platorms running in aarch32 mode dont have access to the driver.
> This is, especially, a problem for ARMv8 platforms that only have
> aarch32 support, like the Cortex-A32.
> 
> Make the PMUv3 driver available to arm arch (ARMv8 aarch32) by moving
> the PMUv3 driver from arm64 to drivers, that makes the driver common
> to both arm and arm64 architectures, then add PMUv3 arm Support.
> 
> The main work in this patchset was made a while back by Marc Zyngier
> in [1]. Patchset version 1 [v1] rebases Marc's patches to the latest
> kernel revision and adds additional patches to accommodate the changes
> in the kernel since Marc wrote the patches.
> 
> version 2 [v2] of the patchset was created by Marc Zyngier and I
> picked it up from [2].

Would appreciate being CC'd on next iterations, thanks:

Tested-by: Florian Fainelli <f.fainelli@gmail.com> # Cortex-A53 and 
Cortex-A72
-- 
Florian

