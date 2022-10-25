Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211BC60C6AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 10:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJYIkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 04:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiJYIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 04:40:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C743F3ED42
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:40:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q71so10857249pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TKgdvBwQcDmO6Tl3CpXGM8STYPUj3pHThyCnIymdUNs=;
        b=AAVv0IU5rXyFW7Yxdp/j1h1H+DtZf8UEfpbWxxs1YHbnF0t5eRXPZBKZcwEJeoLl3i
         hPreeukM9dnaAlrg3Sn1uKhbeLMnORXDrCQ0gi5ZIkK9zoi5nwyJqWRljjQmDkzAn4dn
         xeQwKwYDibfxA/CMLYLVEANz0fpeh/XTYHOR0p2fwRswzbETFPf+VAo/2oIVH2a7jcWt
         BGVhi7lsC4WDHNYkkrfkUWyfxu2VZD8nNbfIJar80RgoFu4cUudj4geKEAXyswnAh+ry
         7tRRMhdarFjKh/CmcLAPv+EFqk+ERukAQ/7vlxm0riUQTXm0V0oykh7gFaWVqyuSZTkR
         /zOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKgdvBwQcDmO6Tl3CpXGM8STYPUj3pHThyCnIymdUNs=;
        b=OjCfH5o17V+aDLeK5DJpRAcelkIlJkfEy3zFKE/Fuu6iPFqO3O367Rwc83IoyIRJOB
         u+UknY1iW0IT4PmWP+9hRv8Hr5cOaO/nqJwnWj4seLBE9GZ9xr8TNxLUdLoudKNQIFdg
         +xfvYr1n6aSqa2ZBvxtXI16DF6vRMUfPynq6Of5jFsLXQkkkeArwQnr8zwmjfpHqLRwY
         dtXquodzZvHOwewNK7mtcMkEYGdcsEZ77brI1ZW5XF8esdBNngJVE3qFU6m5rUGSWjLL
         IOb6u/UTbz/Wa1w84rUWcAPnIa6uHOm8T4WPd633FkFVVMuybpQzMlfjtkXXGxNaekp4
         wbsA==
X-Gm-Message-State: ACrzQf2V2vDWCxnl+GGYrS9BwqkGU1k6Vx9Lbtt7IxAXfcwmkxJlrOCT
        9Mxgh9nMdAS9ipBQFX7CyWI=
X-Google-Smtp-Source: AMsMyM5FuAx7BmlcTfsaY9DEFHErq9QwY7jDHuAonThmIgQuiJ+odMNjhaI3vo0sshmVNQ+ZwYy6JA==
X-Received: by 2002:a05:6a00:1ac8:b0:563:7d18:7a15 with SMTP id f8-20020a056a001ac800b005637d187a15mr37697327pfv.59.1666687245192;
        Tue, 25 Oct 2022 01:40:45 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-58.three.co.id. [116.206.28.58])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090ad0c600b00209a12b3879sm961655pjw.37.2022.10.25.01.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 01:40:44 -0700 (PDT)
Message-ID: <f3189f3d-53b4-dd6f-625f-5572d5a416e3@gmail.com>
Date:   Tue, 25 Oct 2022 15:40:37 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 0/6] zsmalloc/zram: configurable zspage size
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20221024161213.3221725-1-senozhatsky@chromium.org>
 <Y1dXSeqwX/WfUcjt@debian.me> <Y1dbKxlwiaMx9E4u@google.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Y1dbKxlwiaMx9E4u@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 10:42, Sergey Senozhatsky wrote:
> On (22/10/25 10:26), Bagas Sanjaya wrote:
>>
>> Sorry, I can't cleanly apply this patch series due to conflicts in
>> patch [1/6]. On what tree and commit the series is based?
> 
> next-20221024

Hmm, still can't be applied (again patch [1/6] is the culprit).
Please rebase on top of mm-everything. Don't forget to pass
--base to git-format-patch(1) so that I know the base commit
of this series.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

