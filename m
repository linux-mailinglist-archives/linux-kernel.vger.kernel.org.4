Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED5632B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiKURlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiKURlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:41:09 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BC7D02CB
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:41:07 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id s10so9151183ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JHEfteEybO+yp2SunH1PQLLQWxGsRzq9s733waC4EBI=;
        b=YrPjnY+l7Yx1QoELLV8g4hz/vCDSV07YK47/RAEfsby2Se/JnVFY7lM3nP1IaDN/EK
         eULmPWR7bCOt1fdWWi43hTWo2VdvIf0aI/Xn9Yk7Kf3UcZVFYYywYXujefvRvxFd59BO
         2RZGFNd6+KEB+mlgDwdVu2VyoI4guXBylXyz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JHEfteEybO+yp2SunH1PQLLQWxGsRzq9s733waC4EBI=;
        b=ZXFXPdesSRKC/9VPcp2B721jQV2oB0vTgJrMCQmDr890uEKIxh7PuIKQPY+Oh//9RV
         XggaLjHprdfEf3FcEpa+BrI+jpWBLmOAwJNjxkl+ebPDCGNaXEEyLIK247wyZyRxnAH3
         fp8XesTYpntMPuqpHnVQqiyEtfKCOq29cR6UOUrQOvvbnpc26/lg/eQ/Dzz8eNUA0hiO
         8DbDJbwoIuzi5rZVdcczgGpXWXEl4A7kGY/Q58Ltvh0HVr+HHE/pWXOR8mooH4o9rwXp
         tk5D3BPwxjrc8SlFT6rx/Jy0a69zQcmsAFSZxjm2gZbfpnTl+VXN1TSZmgRobDCC2Gg1
         VEJQ==
X-Gm-Message-State: ANoB5ploynmFJ3gMlj3jIXf9jNFsCcSHS5kacYGAOb/iho+GYeCmhJjM
        z+hnr/L7o5iWoVCe3B63Dx6EvA==
X-Google-Smtp-Source: AA0mqf7Sd1S45yKTMXH8j2Pet6i40PTju9sZ3R/eXSOJB0VD57SllNSL2g9L414wfXpnq3nm1i4qkQ==
X-Received: by 2002:a6b:bc87:0:b0:6d5:1edb:2b9d with SMTP id m129-20020a6bbc87000000b006d51edb2b9dmr720959iof.185.1669052467107;
        Mon, 21 Nov 2022 09:41:07 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o12-20020a92c04c000000b002eb1137a774sm4024220ilf.59.2022.11.21.09.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 09:41:05 -0800 (PST)
Message-ID: <9d8b88ee-d83b-c0ed-3fe6-5c0a69fe4f9e@linuxfoundation.org>
Date:   Mon, 21 Nov 2022 10:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] Add Georgian translation for cpupower
Content-Language: en-US
To:     Zurab Kargareteli <zuraxt@gmail.com>
Cc:     trenn@suse.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20221119100320.10022-1-zuraxt@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221119100320.10022-1-zuraxt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/22 03:02, Zurab Kargareteli wrote:
> Signed-off-by: Zurab Kargareteli <zuraxt@gmail.com>

Thank you for the patch.

Missing change log. Also please use thr right prefix in the
subject:

cpupower: ------

thanks,
-- Shuah


