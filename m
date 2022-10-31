Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D99613335
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiJaKE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJaKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:04:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F70D633C
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:04:23 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso12503959pjn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 03:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ObNEkjqN+lu4jH4ydICZPkDgwHSGo3Ukk+qxm2AujQ=;
        b=T75uSG4buYYXToFBL7XmOlzbTr+TZ348vLw3zqO5tzk7mzBL1wU9s6R74VemFg9ybB
         gbObqIBV9qBXhOgL6P4N4K/8DsS6qDg8mc/WHCCRM35mv9jt5wx9bmHL9YTBs0bGzgZ6
         vx5tNKX3RLxuf0wHPGIcgtKwTI1fOxLhDOWEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ObNEkjqN+lu4jH4ydICZPkDgwHSGo3Ukk+qxm2AujQ=;
        b=EA1kQwDuAUh6MQhIY7g08CBoA3wFe4IRnaKQ5z3B/guoyPDiSKRbusbOF+1aldzk3S
         tmBSdREIJKYhH4ieIrDuKTztoDvN9wjtyKc9dgg1ApXWdO9+iB69lghytP+91fIHAZYx
         ZV906QvRI3u2mGmXbvjkRzt0Zhhzs8/GRzS+t8Ny928iP5vD+90OR1THs6ZqrQom2nKY
         lSRf0w2NRI/F4G3BrIcs81yjHv4nJzmGT1QZQI/D/n/Xe7aQr6h3NXU9leVNjexQ6VFw
         p8JlzAqakTmSo7WSDsNyer5kbe9GNfBRzoJUx5ALAu+KfjLa4s1xkq7TI0pVv9zwcfhr
         xRJw==
X-Gm-Message-State: ACrzQf1jrUbht0lsk+rna/8zKsgsFk8aIHI1GIDTh3k/QNIuy7nkrB41
        G3O33SbcwPFDO7zEsMomz+YNAg==
X-Google-Smtp-Source: AMsMyM5rmdIIAnl9/bT5xIF5fi6q/lDxI4yLFe8/1JXcsrt33hEAa/F8kD5qxLsOMJa1doRIksZtLg==
X-Received: by 2002:a17:90b:254c:b0:20a:8a92:ea5b with SMTP id nw12-20020a17090b254c00b0020a8a92ea5bmr14009867pjb.81.1667210662429;
        Mon, 31 Oct 2022 03:04:22 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id x66-20020a623145000000b00565cf8c52c8sm4301245pfx.174.2022.10.31.03.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 03:04:21 -0700 (PDT)
Message-ID: <899fc0ab-18d1-a563-10ea-b91623422570@linuxfoundation.org>
Date:   Mon, 31 Oct 2022 04:04:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V5 0/5] Add tbench/gitsource new test cases for
 amd-pstate-ut
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221031084924.1742169-1-li.meng@amd.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221031084924.1742169-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/22 02:49, Meng Li wrote:
> Hi all:
> 
> First, rename amd-pstate-ut.sh to basic.sh as a basic test, mainly for
> AMD P-State kernel drivers. The purpose of this modification is to
> facilitate the subsequent addition of gitsource, tbench and other tests.
> 
> Second, split basic.sh into run.sh and basic.sh.
> The modification makes basic.sh more pure, just for test basic kernel
> functions. The file of run.sh mainly contains functions such as test
> entry, parameter check, prerequisite and log clearing etc.
> 
> Third, add tbench.sh trigger the tbench testing and monitor the cpu.
> 
> Fourth, add gitsource.sh trigger the gitsource testing and monitor the cpu
> information.
> 
> Finally, modify rst document to introduce test steps and results etc.
> 

> 
> Changes from V4->V5:
> - selftests: amd-pstate:
> - - rename amd-pstate-ut.sh to basic.sh.
> - - split basic.sh into run.sh and basic.sh.
> - - modify tbench.sh to prompt to install tbench.
> - - modify commit messages and description informations of shell files.
> - Documentation: amd-pstate:
> - - correct spell errors.
> 

v5 series looks good. Please cleanup checkpatch errors in a couple of files.
Not too concerned about long line warnings as these seem like "echo"
statements with output text.

thanks,
-- Shuah
