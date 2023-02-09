Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD3568FBE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjBIAP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjBIAP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:15:58 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5FE206B4;
        Wed,  8 Feb 2023 16:15:57 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id w3so289085qts.7;
        Wed, 08 Feb 2023 16:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2g6mB0/Sbx4Gs5Si9V+xdYfL/m4mgF6UDvbmxWdXlE=;
        b=l0Y++TGmrtgNClFRLplnapK9EDwNRif6MD/CsaYnGYPcMhfEol/WrTBbcyjlARr23u
         5wcc81hnLoOcxCCj8oUR0pBo/eoaxVgjt60MvgipZxOsxV7s+7C3Qww5ztM7wYTr4JBW
         GRKXbrxa2xjCw+zGy3fZRj1EKP2vw5u5cz5AOdEcS3JznmDqlMFe20aTZBMzkBzHJEbs
         gNEVc2z/wovT4MeLD73AwxfqwejRdr/aBx9s72jQ5h1cY7Vma1XAFDM6vmxqP4xqPNm1
         Oy0vpsYMsdzQLJdzt0gjqWhRG/HDZXVUmGiy/8cyYkZnvStb2sy4TmLuzKJCu7mFvt0C
         /Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2g6mB0/Sbx4Gs5Si9V+xdYfL/m4mgF6UDvbmxWdXlE=;
        b=HroP0OPR6jA3y/Xfa7TJ0g5AdWDSAN9t9Zooysc5rT0566bBvizBKai5r3/WikDdx1
         lQglN5uFXbYwcmaiMAa8xayBAI56k4Lmc9Si9KmQ1fqLpMcCN6sF2Mqn+8Hd+eCuzSa9
         KjVLqaLOzNtsaalNi2rQDAzhJBydbGlcOWSlgIet5nNt2BXV/Wa2qvEDOX0jIveceD1m
         emEKrE/fuAEA5FNgbxZym0LXpe5mDUdHHfNzidLqY/3E/DhqW80bieFpFdf8sscRY/t1
         ENsFVot9L9SXqtwJ+2WXEN0lc2RbEasTyBlyzrg52m2+L7REoIuWttnae20RgwKGTQS2
         dhgQ==
X-Gm-Message-State: AO0yUKX4eCV4GeEIVuRXTF/iouNSCB28Oa2f2LC+hSPX/67r/nBs/r0z
        uzisFRZuRvpC9GsradpWueE=
X-Google-Smtp-Source: AK7set+fesB0uqos8P2kUQ4mFFM5Nr5bh777x1pGzlQ0PUr7JyxfE3l0HEJ/8JqI9U4CiTIgm35WrQ==
X-Received: by 2002:ac8:5f06:0:b0:3b8:6b30:7e30 with SMTP id x6-20020ac85f06000000b003b86b307e30mr12964744qta.54.1675901756717;
        Wed, 08 Feb 2023 16:15:56 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u9-20020ac87509000000b003b646a99aa6sm167464qtq.77.2023.02.08.16.15.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 16:15:55 -0800 (PST)
Message-ID: <6abb6cef-a9b3-7542-6e8a-fb463449ddf6@gmail.com>
Date:   Wed, 8 Feb 2023 16:15:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/8] perf: arm: Make PMUv3 driver available for aarch32
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>,
        Zaid Al-Bassam <zalbassam@google.com>
Cc:     Jesus Sanchez-Palencia <jesussanp@google.com>,
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
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
References: <20230126204444.2204061-1-zalbassam@google.com>
 <86fsbgyutf.wl-maz@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <86fsbgyutf.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/23 08:40, Marc Zyngier wrote:
> On Thu, 26 Jan 2023 20:44:36 +0000,
> Zaid Al-Bassam <zalbassam@google.com> wrote:
>>
>> Currently, PMUv3 driver is only available for ARMv8 aarch64
>> platforms, ARMv8 running in aarch32 mode dont have access to
>> the driver. This is, especially, a problem for ARMv8 platforms
>> that only have aarch32 support, like the Cortex-A32.
> 
> FWIW, I've pushed out my own interpretation of this series to [1],
> including the changes I suggested. The results seems to correctly work
> in a 32bit guest on a 64bit host, which is what I (used to) care
> about.
> 
> Feel free to pick it up.

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks!
-- 
Florian

