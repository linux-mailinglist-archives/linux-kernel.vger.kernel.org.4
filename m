Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578D6F1B40
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346149AbjD1POO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346355AbjD1POJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 11:14:09 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2E555AD;
        Fri, 28 Apr 2023 08:14:08 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a814fe0ddeso745565ad.2;
        Fri, 28 Apr 2023 08:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682694848; x=1685286848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2G5YGVJMpaYxgR8YDEHDAec3LMDJyqn+fzyMxvzxI+0=;
        b=brVUMje2rJvkyiQGSjQQzsS/UTcLgnZ1Lwt79IqdoccAm62kk27VXknofgDMUAA6Ke
         cYpayxlQhxqyVr5jYblJzVBMCJXFT8cr91SGWdEoEvOKgYAUg57jVm5H/GCUHODNqrL/
         3vMooYLQH0k886U2c0q8Mel0L8s15qGG6Ll9OuN6zwGAilkQqyeTV0HxmWcgeH0X7AAQ
         G17k5KWqFp067xRtLCTeolekyiaA+1k3fNAtT/VLWL6OtB9tiZJqeL09eLpkUxzgY0UG
         vnrmjVrq3eTAo4wtbQH3iPivOy5IonoI28lU0T87l0ZgaW9khnSVDiHVMZc2492jSTEM
         Ex5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682694848; x=1685286848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G5YGVJMpaYxgR8YDEHDAec3LMDJyqn+fzyMxvzxI+0=;
        b=SFsAdH/rFM8SHmJdi7XhaU/ijr3MHjJQK6s02nAIdUdNHsY+ACiEoxJzjE43wrMSpu
         r2vCktCioh8ukzaXFEr1rJy1f90yMDBCXGVrTLAwOY0yGfQUiRMYWAn0pD5QNdWJ4++5
         o2VGEixOLWbM7B+ZSDZcXChivdEsqR0TvWtJi3zT8oTzydZY3sHbPEjiX5aT7ST35znu
         v3r1E6Flbt/nq8bSzaghTSUqM2zMnLgUF7Lmn9Ir15XWGPLS4H9CjM1OURHT5PwmmOx7
         EgEIkeoV91YSlb4rdWmnhfv34oRUh1fYI07h9pGHuVzcXtqcX7OYTd1rxZl4N4N09NNd
         Wp7g==
X-Gm-Message-State: AC+VfDykyWljPFsyDVOMxb6/H3HfdQg9yt/NUmv6t2rYW8Fis3RYZXH9
        PjxbYR0zqxMqKQuOJkDkpdo=
X-Google-Smtp-Source: ACHHUZ59NMfbLgX1zFUs0psmfAfD4RnHSdPcJ6aGXqizBLnVu2QjWGasnDp6eX0PNHIyp9kRIUInlw==
X-Received: by 2002:a17:902:d488:b0:1a6:961e:fd0b with SMTP id c8-20020a170902d48800b001a6961efd0bmr6609119plg.4.1682694848276;
        Fri, 28 Apr 2023 08:14:08 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id fv23-20020a17090b0e9700b0023d0290afbdsm15134556pjb.4.2023.04.28.08.14.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 08:14:07 -0700 (PDT)
Message-ID: <86db3414-bebc-7470-a9ed-cfc092093563@gmail.com>
Date:   Sat, 29 Apr 2023 00:14:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] Documentation/translations/ja_JP/SubmittingPatches: fix
 some typos
To:     Jonathan Corbet <corbet@lwn.net>, wangdeming@inspur.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        shibata@linuxfoundation.org
References: <20230428091018.1558-1-wangdeming@inspur.com>
 <71c91ae5-2ed7-cfd5-7b7f-6cb5a0141816@gmail.com>
 <871qk4awn2.fsf@meer.lwn.net>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <871qk4awn2.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Apr 2023 08:50:41 -0600, Jonathan Corbet wrote:
> Akira Yokosawa <akiyks@gmail.com> writes:
> 
>> Your patch is rejected by "git am".
>>
>> In the header part of your email, I see these fields:
>>
>>> X-Mailer: git-send-email 2.31.1
>>> MIME-Version: 1.0
>>> Content-Type: text/plain; charset="y"
>>> Content-Transfer-Encoding: 8bit
>>
>> This looks broken.
>> Please make sure your email header has a proper Content-Type
>> as shown below:
>>
>>     Content-Type: text/plain; charset=UTF-8
> 
> This something that git send-email does on occasion; it's truly
> obnoxious, and I have no idea why.  I end up fixing up patches by hand
> when I see it.  If the change itself is OK, I can manage it from here.

The change looks OK.

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

> 
> Thanks,
> 
> jon
