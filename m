Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95DF168767F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjBBHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjBBHlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:41:17 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85678751AD;
        Wed,  1 Feb 2023 23:41:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id v17so1040408qto.3;
        Wed, 01 Feb 2023 23:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gv+MoihaaLJ+GntJnoIhpIsRh1NURAAHDjlWOnPclKA=;
        b=npU+WUMTVfXfrE/GDt83SsmpOwynwv5m3h+YrlAIbCTjPy4428oobWmeVV4ECyahEU
         e45Sy1TRYXz6BXvQp/fEnhOovHjmAsQEbn2blTrbO8VulFoNv1fgZTnXCULWUmFAmLvW
         GDXv68gCG7KiplAF3V46DeYQcGljxA3RNRIkNMTXHhlnI0Jn20MXwUM+GIJ36asQHIdu
         8RtFu/RC1A29np0dH+jat2w63NbNDTN6KYAbJyaW6B1W119/ngIXGxI9/BFf3quCJuTV
         owwi2Wl+3y1NENc3AaUu/tzVhFZpj/NrZSm+FRoNDCEeqXt52zvUfM8myLhi/rvHJQy5
         1coQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gv+MoihaaLJ+GntJnoIhpIsRh1NURAAHDjlWOnPclKA=;
        b=J6C1K5naSkRij20fi8/zL3LMWMdahsW/TqULsFNFIWvTeWPuVqGTWGOulroBNccrb1
         O9U+7fGAR7nrRjtO+9lV8jPFmikh0NO1HPzW2T5p9gtY9a1dBZHNH1K7gMPSyDWMWnPG
         eRetsn/ROx6Rp6liPsaSr6gpY0EAnlFcGT4Dftfl9U8+A64dR7qDQIYabEIQn/umGQSF
         0ROCal0O8IH4VoB1WEjwfF8l9MSW965ZF2MKsHeR2SEh0Pe3WfrxqIRwl5TeV1xWLdwM
         2ouTOF6/1L8rky2oOg/iykuwBIKjAaAAeZCuGKhdqh9UAOBEAlIWuL19bCTcJgMELOBM
         1SeQ==
X-Gm-Message-State: AO0yUKXU+ro5hLX12KI0d3YutQ8XCAVOXpdvQntQV9dUKiIuG9tYGAo/
        sClfu1GJutJAmpiYuUKEWPgSiskEhnV+OA==
X-Google-Smtp-Source: AK7set+NbJWFQzIoxB3hk/UHZAHjQ6Vr11sMEdvxVo73BOmAP4/ycfdf2g0lXd+woh4hfgXtS3ZLrA==
X-Received: by 2002:a05:622a:189d:b0:3b9:cd2a:f13d with SMTP id v29-20020a05622a189d00b003b9cd2af13dmr2140469qtc.59.1675323674576;
        Wed, 01 Feb 2023 23:41:14 -0800 (PST)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id n7-20020a05620a222700b006fed58fc1a3sm7746210qkh.119.2023.02.01.23.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 23:41:14 -0800 (PST)
Message-ID: <8b21feb3-624c-0c91-7dc7-708b5bb19a93@gmail.com>
Date:   Thu, 2 Feb 2023 01:41:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 5/6] cpufreq: amd_pstate: Add guided mode control
 support via sysfs
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>,
        Rafael J Wysocki <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        santosh.shukla@amd.com, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Ananth Narayan <ananth.narayan@amd.com>,
        gautham.shenoy@amd.com, Tor Vic <torvic9@mailbox.org>
References: <20230131052141.96475-1-wyes.karny@amd.com>
 <20230131052141.96475-6-wyes.karny@amd.com>
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20230131052141.96475-6-wyes.karny@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/23 23:21, Wyes Karny wrote:

> Only if the state requested matches
> with the current state then -EBUSY value is returned.

This differs from the behavior of intel_pstate, where writing the
current state to the status file always succeeds.

Why not do the same thing here?
