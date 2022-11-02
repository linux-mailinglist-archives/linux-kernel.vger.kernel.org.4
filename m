Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A961603B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKBJv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:51:54 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3380E1AF36
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:51:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m6so15975865pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8gO4oBkwXoA7cXVJu0fHO5ySLapcLSIFeRuKjNXMt1c=;
        b=e9M+T/yOXfGHQ0DVOM5Tz3Qgf0kzrIEjhC3+5GeAFHLHbFOx+dKo7vlzfmlj3Ovf8U
         ed/Ff75KRUaGX78mEugrTxGXYSRwXhk7UEthFLKVrTzPCMvdM8I6FbH6bCNDfnh7UQR/
         X86/1nTfVUhv3JluABi7U0eafDbCdOdmp+3Gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gO4oBkwXoA7cXVJu0fHO5ySLapcLSIFeRuKjNXMt1c=;
        b=aE5+Pu7oyw8cW4ozuhH+fjNXMCC/iVUZp+4aUoD1kAmtZ8JY9+UpMRwkLDkuEYpWeG
         93/Eo1yX6Wi+hXuDnvY+vHnrV2yLvSL1fup/QEFiNLru4XhTWDcapo+6S3TdapaxL9CM
         9m15SHotG/JXuVfPtlHcJtqrOleDmRvTSU7Mo+iUT+OwgRD2wr6WGi1A6awtQ/1sHkVq
         iLlIsVYztSuUsiTPOxr0e5K7BEy2JK9QXzOU3wvitxTmufx7UIl6MYDvqm4U5kRR1MAk
         9EnFDguWHJmcZGBRRUvGsn81HaYBRH0XFaqspYtqo7yKVnWppsqdylFRJj2wqzBmvWWo
         Wa2g==
X-Gm-Message-State: ACrzQf3rR0zwnhX30wyjEj8IDkwR1HW6shFQ/BSj70K86E2CJ33ZTB/y
        FhBtE7LjfgX/VW7FJDqkGDT5yp4OsKBufjEt
X-Google-Smtp-Source: AMsMyM4W5hLjwS8QmYrG1hulUCgTzpLZ6aI5I6Y3ZqvRqbFiMNvL0q2GziLv1mrFdLcIxLoJJ6MfYg==
X-Received: by 2002:a63:44b:0:b0:46f:1082:32ac with SMTP id 72-20020a63044b000000b0046f108232acmr21727405pge.136.1667382712722;
        Wed, 02 Nov 2022 02:51:52 -0700 (PDT)
Received: from [192.168.0.168] ([103.99.10.63])
        by smtp.gmail.com with ESMTPSA id v18-20020a170902ca9200b00186e8526790sm7841140pld.127.2022.11.02.02.51.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 02:51:52 -0700 (PDT)
Message-ID: <58917c1e-9178-e9b7-8630-dbc935963b5a@linuxfoundation.org>
Date:   Wed, 2 Nov 2022 03:51:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 5/5] selftests/resctrl: Remove duplicate codes that
 clear each test result file
Content-Language: en-US
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221101094341.3383073-1-tan.shaopeng@jp.fujitsu.com>
 <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221101094341.3383073-6-tan.shaopeng@jp.fujitsu.com>
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

On 11/1/22 03:43, Shaopeng Tan wrote:
> Before exiting each test function(run_cmt/cat/mbm/mba_test()),
> test results("ok","not ok") are printed by ksft_test_result() and then
> temporary result files are cleaned by function
> cmt/cat/mbm/mba_test_cleanup().
> However, before running ksft_test_result(),
> function cmt/cat/mbm/mba_test_cleanup()
> has been run in each test function as follows:
>    cmt_resctrl_val()
>    cat_perf_miss_val()
>    mba_schemata_change()
>    mbm_bw_change()
> 
> Remove duplicate codes that clear each test result file.

This isn't making much sense to me. Please include test report before
and after this change in the change log.

> 
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---


thanks,
-- Shuah
