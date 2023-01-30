Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3DD681E29
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjA3WfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:35:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjA3WfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:35:11 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126E2166E7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:35:11 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1636eae256cso12835311fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vkl5MnstvM7sfqtExx7LK9V4EnomBFomGytp2U72gI=;
        b=PIwnkHlWrPqFIvng6Safqa/icO31P0eb8H9hU2DEoM9Gdg0uWsyPvtHd3Kis1MoPOW
         rLq5apHxEB4Gd5t5iw2QfFvQmTiMnDSjaIEOFRwrdkmPXdYR/ZWPsXHeHhGSwMvT6SYU
         CNuy1nImHyaMnEV4SdNE9UOi9ROOXT5n1bgYx9OSihicZdNs7aoGOaTd1DUU6Wlq5hDa
         8K21MKErMGl8hTYBg/df0xmgT/CpcQbYxXGWOdRDgNsEKtxkxtbGhZVjbW/P4n6YALUX
         u2S7ZhQsQ5zV8ygxu28gdkcmE09H37pY2gy2iSyTe3uAK9rFOGbGfDdyPVWdIWb4WfFo
         nqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6vkl5MnstvM7sfqtExx7LK9V4EnomBFomGytp2U72gI=;
        b=KIr3ShY+cdQsfY9byhfnY8ZgbPbMWTKaZsRwHE0yo1Kz/JI+VkO7HFvRZsm8UdgYP2
         3hiEOolVWrjrjmMwvUr6dGD0dgnvmeH2a3mJnAWS24TKKYWaRFtlOeT6qpOH7SAl280B
         2K6hnfGnD69W5HSwhOHPRVUNpJMDcs62wN2JNaxgzk8OSwHlB+9rDeSVZiCs7hLpYH70
         /z6xA2l3u9Bp4cpwTq8G32bL6nyQ4AqzWgCbBfis5v5CJRcV/qyQgvZqrRlKtXFm32x3
         ZyYm6m5vGSuXpzobeP1LxsM6Be9rgtwSV3IRy5SzHxK3xDNn9z3Y74zj5sXgcNNcJgzg
         QBBw==
X-Gm-Message-State: AO0yUKUg0NYW1YaCSIBh+e3EJX7QzSSF6o4iH7Cy3RLWR6G8YOS4A6q7
        +VBrq9DcPRBKT53NxV3s+0pMF6uMQNoqNA==
X-Google-Smtp-Source: AK7set91P0A+QblAjR42cjxS5IJrAYWAPelKl9P3db4zdmlJH9IROo/r+6+sUq9wYbXAmCmYiByFIg==
X-Received: by 2002:a05:6871:587:b0:163:2fc9:c24 with SMTP id u7-20020a056871058700b001632fc90c24mr13199728oan.45.1675118110001;
        Mon, 30 Jan 2023 14:35:10 -0800 (PST)
Received: from [192.168.50.134] (99-176-3-182.lightspeed.brhmal.sbcglobal.net. [99.176.3.182])
        by smtp.gmail.com with ESMTPSA id f8-20020a056871070800b00163b85ef1bfsm929788oap.35.2023.01.30.14.35.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 14:35:09 -0800 (PST)
Message-ID: <280ffa6c-3956-610b-0c31-16e2c8fedf54@gmail.com>
Date:   Mon, 30 Jan 2023 16:35:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-kernel <linux-kernel@vger.kernel.org>
From:   Walt Holman <waltholman09@gmail.com>
Subject: Re: [PATCH 6.1 000/313] 6.1.9-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.9 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Feb 2023 18:15:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.9-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Hi Greg,

This has the blk-mq patches included again, and as a result my systems all panic on shutdown.

Same issue as 6.1.2 - https://marc.info/?l=linux-kernel&m=167232897330552&w=2

-Walt

