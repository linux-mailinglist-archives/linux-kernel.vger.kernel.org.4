Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467B620471
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 01:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbiKHAEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 19:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiKHAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 19:04:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460F19C0D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:04:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 78so11928164pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 16:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9oy8ZE1oFJjzlPOX73c8KrSMYviuoLcNPde29QmDF+k=;
        b=53Th6Tie3U03H0RA2dwNH6QKmYrirXYYLIpj9x0vyN7E/1dMmbcUyW5qKnBYTJZLXg
         2KepuHtx4BdPemu/pRjL2wIhAaxf1KG1wUfVkNAE4ejAIQRSvsStXZeEnHTmEI0uTuZL
         wukAbOAGvsOeQRwD1VxI3Jaf5z3e+n3Abxg/h1saSUnEI0ZEMwZL9mfvOUKU62kCbWYU
         L22nzSHi/p+VMwZzk3BDW3AOhOT92tJdZa/WPf7A96j+EzSuzTP1K1y+r88E3CXCpU8T
         Z66DlqlN/HJDue3KkfP/ivmmVQHbvkgJygjBvq/5G/TDu9VJG/jLvfA/DRtkeRi30hjM
         sh8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oy8ZE1oFJjzlPOX73c8KrSMYviuoLcNPde29QmDF+k=;
        b=JenAMNU7YRu8YQXqe7HrPxuKsm50dkc8RRe8piT6ext4sWYLaQP10WRZs225uR4GLr
         X4qk4HJAfT1B2ZH6QwjPyn9eO8Bin8/YqUMfva0vY7UaSw6lHLdOceGnVhVD0KxSPVyc
         JllmGWaAyP/GPv74ZjGg82Qvty4TqNJUfke0ubzYmotKLsoYjgy8fai8ynohpapYlucn
         IJmMJs2SpLU3/IPnQrwMblNl3GGrPurhO0l5ryGZ/ITwJapepXDDTzW/pV23w6+wgMe+
         9ditfVOghrWURseRJd6vPhBSWr82zRFtLV0+weYQ0LFutOqRz2zGocdsqdPtIMkmbbDS
         lVvg==
X-Gm-Message-State: ACrzQf0lPPJARbu1VwZbUEED2j6pfj4xu60msnnCFGo5KLvJmYthomu2
        XKSC1vrsoeeWqPFOhOsWMKw02A==
X-Google-Smtp-Source: AMsMyM4n+JMRam57i10ezHi3WCmDHZRD4TqVXA6VO8+qhnux8A9WYkDsNLJIMholOpfSkASb3lCE0w==
X-Received: by 2002:a05:6a00:218a:b0:56d:1bb6:af4f with SMTP id h10-20020a056a00218a00b0056d1bb6af4fmr50780668pfi.11.1667865872854;
        Mon, 07 Nov 2022 16:04:32 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a384900b001f94d25bfabsm6664728pjf.28.2022.11.07.16.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 16:04:32 -0800 (PST)
Message-ID: <f4887649-3933-0a65-7ed5-1bf6bd842a46@rivosinc.com>
Date:   Mon, 7 Nov 2022 16:04:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 04/17] riscv: Add vector feature to compile
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Chris Stillson <stillson@rivosinc.com>
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Andy Chiu <andy.chiu@sifive.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-4-stillson@rivosinc.com>
 <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <87zgd2d6j1.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Andy, Conor

On 11/7/22 09:21, Björn Töpel wrote:
>> +config VECTOR
>> +	bool "VECTOR support"
>> +	depends on GCC_VERSION >= 120000 || CLANG_VERSION >= 130000
>> +	default n
>> +	help
>> +	  Say N here if you want to disable all vector related procedure
>> +	  in the kernel.
>> +
>> +	  If you don't know what to do here, say Y.
>> +
>> +endmenu
> "VECTOR" is not really consistent to how the other configs are named;
> RISCV_ISA_V, RISCV_ISA_VECTOR, RISCV_VECTOR?

Good point, I've changed it to RISCV_ISA_V to keep it consistent with 
existing RISCV_ISA_C.
