Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10FC69568C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBNCRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbjBNCRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:17:00 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1F97EF2;
        Mon, 13 Feb 2023 18:16:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id mg23so7182152pjb.0;
        Mon, 13 Feb 2023 18:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rbigrDxGll9VSVfP6VuZv/A2wMng7CjCUezyWsqQ0MY=;
        b=P7ojf9+jHPMBl8X2GLb+w6RrmrJrO3TCcMwHpeoYA4bGKP4CGM2j/o/Vz01LgLdpM2
         P+kY8LAWgT9+gu4cNx2JbhDVYPJBCCF5AaS88JXQ0zsQL/ly+HaSXG6X+MLJ72lDYwpy
         kQNMvrS4/URdeGTCM1reA2BgIDXI8b8q9TzWedweQghB+AONe2z5ebH2edO2+V64VytB
         VzRcv7t2Em1x1fKIrs7fsdYWeGZmsDdDV1qaqktszRMiEF19+UQZci4dUeyy1z0lWi5F
         aCDYF9A/Zq1A81h/bEQfERBJTB3u3AyoGCjyl2cCX04QcnI4LuRrQZNg5wAIPvMFK6um
         ErZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rbigrDxGll9VSVfP6VuZv/A2wMng7CjCUezyWsqQ0MY=;
        b=gI4jqcUpGZZe6KJi35aaLtRZ4ABb4v1AypW1Y3Hoso/fNkYbgVTGdXjAK3n/SXdRju
         caP/rwe9RTilrxJEBDkxDsp12a7I0xGHC9Q+GDd6bPlmBFRz3cooNBM/wx4BBMJhqKWI
         PeUbRxVVDpxMGyVW8XNsQCvbggjHfIAlLxGInXc/6ZK5SKECAD14Sgqx3fm8zObE8UzD
         hhPR+Ywfm7eF3oWE0Y+r28LFCSgM+4TB34eTAF2aMkO1qTEO5rWYNlTENeMiC9xTggro
         Li0NfF35fWIdU9yy602PHISiowVm4cZLtQ6kR9sDe/o6TEtnLmopDK6EXLLbPtWuR+z1
         C+Hg==
X-Gm-Message-State: AO0yUKXRF9oEq4zMu603pYsxCYAZBopj61IWLCoNscoDV0uzmCcOnAcj
        BB9fb3qsr1idD/HD+r4icmo=
X-Google-Smtp-Source: AK7set9Oc+MPdB112yVNp5k5KJwNdP6haZBEVYzKHPhsYHer+brcbAlhIPeodAVrkgboHWjANgBpBw==
X-Received: by 2002:a17:90b:1b52:b0:230:af67:b847 with SMTP id nv18-20020a17090b1b5200b00230af67b847mr599932pjb.31.1676341015985;
        Mon, 13 Feb 2023 18:16:55 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-37.three.co.id. [116.206.12.37])
        by smtp.gmail.com with ESMTPSA id f63-20020a17090a704500b00233e8a83853sm3036567pjk.34.2023.02.13.18.16.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 18:16:55 -0800 (PST)
Message-ID: <7d1774f2-0548-88ef-039e-dc4026299a12@gmail.com>
Date:   Tue, 14 Feb 2023 09:16:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/3] Documentation: powerclamp: Escape wildcard in cpumask
 description
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Power Management <linux-pm@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
References: <20230213100800.28333-1-bagasdotme@gmail.com>
 <20230213100800.28333-3-bagasdotme@gmail.com>
 <8367d92de90afaaa7ec5fac1dbcc0337ab641cb6.camel@linux.intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <8367d92de90afaaa7ec5fac1dbcc0337ab641cb6.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
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

On 2/13/23 17:17, srinivas pandruvada wrote:
> Hi Sanjaya,
> 
> On Mon, 2023-02-13 at 17:08 +0700, Bagas Sanjaya wrote:
>> kernel test robot reported htmldocs warning:
>>
>> Documentation/admin-guide/thermal/intel_powerclamp.rst:328: WARNING:
>> Inline emphasis start-string without end-string.
>>
>> The mistaken asterisk in /proc/irq/*/smp_affinity is rendered as
>> hyperlink
>> as the result.
>>
> I submitted a patch 
> 	[thermal-bleeding-edge][PATCH] thermal: intel: powerclamp: Fix
> warnings.
> 
> Thanks,
> Srinivas
> 

OK, thanks for your parallel!

-- 
An old man doll... just what I always wanted! - Clara

