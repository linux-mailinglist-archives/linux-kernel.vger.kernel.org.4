Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233DF665007
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbjAJXp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234326AbjAJXpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:45:14 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE9A3E875
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:45:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 7so9377869pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D57t00k03QeMUJxkWeqB58qjl0R5qo6nYcHPSFZtf2o=;
        b=yCuhKnZBRUOZ3SYBivZpOr2OXKkUmIdRHgXeV0eTbxAWuDo4JGDjypZIPd2Gjvew5y
         cRYZLDtyrYHHwr4qNEe74IVwMZ1wo61vRtnIY4bxctJwGLBLL7E5z5esNZ7qTMM39sG2
         GvNJurftxlLcSB1/GZPLFXKpWlNM6BlaAXPvPDKIw6akF6W0unmgPrCmYyDssHHOeCgj
         GK83LS77yq0uhy8otNYIvMmHxuc1KmMpKRsgwyL1N3vsToUZsZFo48VJKt2cDJ5K17nB
         Th01JUh7jWR71yfymgMyCv5GAlczPgaBg2L7ySe7YAq7Ww8BD8lxw/UbWP4T3YEMHYCL
         l6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D57t00k03QeMUJxkWeqB58qjl0R5qo6nYcHPSFZtf2o=;
        b=6lKdgVeFi2lWM/T6yrKb34Jl8nKJ3Ou5xgpuQH06ANiWmSvSC0mnc5iHRA4+kkUZdp
         1pjq+t31saos2EcbkSXs4c2Jeoh4dJR/D1d+48f+gMWgre70qPDl3l5xMs9JTCSu62Vs
         aaSY8aXalRoolcuFj8zPZV4iF2rjLMMs7Qb6o3WtkRfSNITmKEzlFmLKxX4NYs9u2kD4
         YvtrjjukMxFJcCVG+eRnLcEC8JFEEKH/6B/SN226IF9CJ7Vv/Iz/T3HTq28Se6VeIQ//
         iOvSLYz0XFbU1NZOIoQOTMuXgX2W0wlmcMPvcVLiL0NvTtDv4Th3LztRAr5H/bT4eRQW
         MOSQ==
X-Gm-Message-State: AFqh2kqohpVj8Nujlb4sjYwhr9H/cN3Nn0KlS83PKCxbOGwezgnnM4/S
        iJM+WmV4/+jcy+rVK+oB7yFF/Q==
X-Google-Smtp-Source: AMrXdXvePEWyNKMCfF1uWr1aZgxVD63FQMxYzf0mZ4lZCz88XHKwgQemgZZWXUlP7JKfcudI7qBALQ==
X-Received: by 2002:a62:32c3:0:b0:580:f1b0:2211 with SMTP id y186-20020a6232c3000000b00580f1b02211mr54504306pfy.18.1673394312982;
        Tue, 10 Jan 2023 15:45:12 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id y29-20020aa793dd000000b0056c2e497b02sm8900222pff.173.2023.01.10.15.45.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:45:12 -0800 (PST)
Message-ID: <3e91a775-c671-35e8-0966-3ec9d8999e14@rivosinc.com>
Date:   Tue, 10 Jan 2023 15:45:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: elf: add .riscv.attributes parsing
Content-Language: en-US
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        kernel test robot <lkp@intel.com>
References: <20230110201841.2069353-1-vineetg@rivosinc.com>
 <01AF458D-1EDC-47D1-A902-A686E2DF26AF@jrtc27.com>
 <6dcdd143-ff1c-41f7-9f46-0c4505575669@rivosinc.com>
 <9061941F-3221-467D-B0FC-DCA8E8FF3996@jrtc27.com>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <9061941F-3221-467D-B0FC-DCA8E8FF3996@jrtc27.com>
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



On 1/10/23 15:21, Jessica Clarke wrote:
>>> You also should handle more than one sub-subsection even if tools don’t
>>> emit it today.
>> Just to be on same page, a sub-section implies the following
>>
>>        uint32:len, NTBS:vendor-name, uint8: Tag_file, uint32:data-len, <tag><value>....
>>
>> If so, the code does support multiple of these
> That’s a sub-section, but I said sub-subsection.

The psABI documentation that we reviewed yesterday only mentions 
Tag_File = 1 and doesn't mention the term sub-subsection at all.
We need to be consistent between code and the new documentation or just 
add reference to ARM documentation which covers everything and write the 
general purpose parser.

-Vineet



