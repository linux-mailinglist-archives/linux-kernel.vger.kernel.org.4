Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19906BAABD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 09:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjCOI1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 04:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjCOI1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 04:27:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7BC22004
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:27:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o11so110993ple.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 01:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678868858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvusehUWrfc+/66ASlnNjlCPuPY5wXOImDMvoYp/fQ0=;
        b=b0+CCgmuim/LJMpI+1XEMUV+egXJuxybJv47FXV6QaM5cQ6eGSui32XGbEIXO7Fl1O
         ls2azq9pMBcSoNmho287e6ZKCLBWjFb2QAFTdAdphWSeQjDWEL5YpHa6uQysglgg0YC9
         UgCKhy1mffMMqgipSAglwGVrjfSc7xIwcrEaacXjc02GxiTFToZhRMmqY1dVp+fffmjg
         09ofhKqwk6sTzvUDfrTdjtU5CumLFYh71DmsAxMBUY0RXsxD6O5eAGAfsPps6hniPDCA
         FOIHV7863+GyCtjwZPKO5Keo/gNMIn4gfay3pHLNsR3YEeixOVW+hNy3BIZHRFVSIyNX
         3hXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678868858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvusehUWrfc+/66ASlnNjlCPuPY5wXOImDMvoYp/fQ0=;
        b=iE3IJmbWYMs5zN0E9dhGt/SsON8kuRpfhHed0MLiSsaiZQhnlRvqVrQ+TzAOtZl/fR
         b/1BZlskx68eeZcTbtQbi2V6BPKOm6tnmcmccB8B3yMx3Q/hsxMNYMACWv6yviJTqoBq
         xEyhUbS3j6FQ/XtXYPJ8MwGC6isbCZ4mA9ujaK/utRU0KehD2lcDJgikcp2xgy/6x3lh
         6gcecbPeT/p+s8vXmD8AZUpGnS59ZsGUVngTfStbtXFYjOL9g9Y3xzhM/3hcICfGs7RJ
         qhVp/4StYzMwxaxf1whKl0eX52q2upzF+IrrVpIk5+m4XiAtZJSri/Vo0ZlR4WaUndkF
         SAnQ==
X-Gm-Message-State: AO0yUKXX4vAw7cpJhhRGXpIv9DRHjp+pjv0sE9eetHcWPmGSIClebki2
        7cAF+KFt9ytWHASjmGv2Oi8=
X-Google-Smtp-Source: AK7set/s9DyM1IvIoJZp/5FCKzk1RL4bAAZfu6rRARRGJOJc8MnUCdLhy0CFwafIHI2dxVOoP6eOVQ==
X-Received: by 2002:a17:903:2311:b0:1a0:7446:ed98 with SMTP id d17-20020a170903231100b001a07446ed98mr2175603plh.47.1678868858342;
        Wed, 15 Mar 2023 01:27:38 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-41.three.co.id. [116.206.28.41])
        by smtp.gmail.com with ESMTPSA id o12-20020a1709026b0c00b0019a97f180fcsm3048943plk.37.2023.03.15.01.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:27:38 -0700 (PDT)
Message-ID: <32c49665-73a7-b506-172e-975d55f423ba@gmail.com>
Date:   Wed, 15 Mar 2023 15:27:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld> <ZA/+JlgWfdg2wH8B@debian.me>
 <ZBCS7DR9dZH1yds8@aschofie-mobl2>
 <5fd67671-8e21-ffa8-8571-d8b5533b4758@gmail.com> <ZBFPnZbvdI46Ah6r@kroah.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZBFPnZbvdI46Ah6r@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/23 11:54, Greg KH wrote:
>> I thought this style cleanup also warrants Fixes: since
>> it fixes coding style problem on existing code (see
>> Documentation/process/submitting-patches.rst).
> 
> No, sorry, Fixes: is for real bugs, not style issues.

OK, renouncing the tag.

-- 
An old man doll... just what I always wanted! - Clara

