Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BEC6956A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 03:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBNCXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 21:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjBNCXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 21:23:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8AA8A76;
        Mon, 13 Feb 2023 18:23:17 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z1so15571873plg.6;
        Mon, 13 Feb 2023 18:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ZjibeV94oq8fSxEtHuWHEuguymt3GezabpggPQomKA=;
        b=YrhcfSBlWZOoatC8HZJ8FZdgk/gaO8XqWRx9ONYSVZub0sUb23vaFhW5ujCHxeozk1
         ft6xW0HHPTAGTDuV861QXCKDrz13Mvn1uWD5oUTrgOZWuSwRkXoY+y9ZxQ4M3OeexOuB
         qUp4mjVdV+7EamPR5EWPOGSzDrrE5fqJ8sQInJhgf3A3utUJ+hFPKNP2ohbJwno8ch5t
         3CFNNV/ZktxqDDrB2lGF8XyQrlOCDaGmeCERVMbiFrQxrnsdOpLxBpisNN47+3J4C+3k
         bP7DpF7xUY97XR/SGtSFP3JEBctT839bX0AB0pQNUyL3wiFdOAfDsKID0sp90Nyu8oas
         UazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ZjibeV94oq8fSxEtHuWHEuguymt3GezabpggPQomKA=;
        b=oi+p8RZj+jCsON6AYmKJInSmUMWvGBUi+10m1h0kcc74kuceqfnM/sxJO8C2RqSwyD
         b1aga9ckStOD0+7Zx2BjtPCAfYf49BiFDqnb9ZrVCi6nKpgF7CMZx45KWsKjFQJv4vYE
         OiLgr9qxChVV/ItDrywO60n71AAErjGuPBPHmrs6mNN2UKJzI/mizfnNbZoKyHJwjnDB
         dzyzv9NMFxr4Vo4rmJdaUOLuBzPZVPNUP0xSTOHPQV0S5dRtlkm8Gd0KmxAS72prMy1Q
         3WcjaHITmVq8EgEpjVJJXf5SiJaN61FbfzYF47tczppPC0zSrF78/NHqz2oMgFJheyTC
         EmhA==
X-Gm-Message-State: AO0yUKXuim7vepumGmT7lfUIlVYSKPdTM7hcSCWlxckLdqqbCGz/bMNc
        MJvkZCRcBSDf5oK+Uz9tq5WnqHkrMlA=
X-Google-Smtp-Source: AK7set8WWCW6EofWuhdMavYIWHSKBEKKi42ONcCgZGjVg3tF2gg/96UR6FTUy9yAIc4d2ouWsJ7uVQ==
X-Received: by 2002:a17:902:f245:b0:19a:7e36:f50a with SMTP id j5-20020a170902f24500b0019a7e36f50amr785622plc.7.1676341397402;
        Mon, 13 Feb 2023 18:23:17 -0800 (PST)
Received: from [192.168.43.80] (subs28-116-206-12-37.three.co.id. [116.206.12.37])
        by smtp.gmail.com with ESMTPSA id w13-20020a1709029a8d00b00194c2f78581sm8871604plp.199.2023.02.13.18.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 18:23:17 -0800 (PST)
Message-ID: <a276d6ae-677d-e4cf-13d7-934c0a7639d2@gmail.com>
Date:   Tue, 14 Feb 2023 09:23:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: nvme boot problems after merge of mm-stable tree into linux-next
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        linux-mm@kvack.org
References: <ed33b9ff-e6f2-dae8-ede6-59dc3c649ece@roeck-us.net>
 <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230213094754.397f86af6b2dea4aafd92344@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 00:47, Andrew Morton wrote:
>> I am having problems booting from nvme in linux-next. Bisect points to 06e5887cdcc11
>> ("Merge branch 'mm-stable' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm").
>> The problem was first seen on February 8.
>>

Hi,

Can you please directly test mm-stable tree instead and bisect from there?

-- 
An old man doll... just what I always wanted! - Clara

