Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53106609DF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJXJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJXJ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:26:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B12638D8;
        Mon, 24 Oct 2022 02:26:38 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id e4so4568811pfl.2;
        Mon, 24 Oct 2022 02:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNKYGrwrK0cpA3fcw6J1pwYaCpS3s0DcyB3MFt+Te4w=;
        b=H5HyNVPyQsQEIPFmGCPl7qd5oTwwhARQh1RihZ0opF4mdYpzKPhnZgpYs1CWnNHdaS
         tZqSUON5M+fC6umKHt6ob3yqyWmLOHHE9gIYL8DsEtJGNOZ/bwZrDWpuO98aYPNZANZ/
         +yjvcIyGUSsMSUBu22UG0lHcK7Iia0PDvfRgfK1ctS1sZ5BuOOi1BJsOFUwEVFWZ2yZR
         S3R37emw/5aklylF0ztq2wXs1NIE4mST/Mf1INk6AXmw5yIKvEn4FeaIX6sg++HncWGn
         tv+cfxaMi/L/F2fbyditYGxp9X+zzQoyFeJKZPQNnopyPuiXwhT2mTSXB04WS5zi/s2p
         LR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNKYGrwrK0cpA3fcw6J1pwYaCpS3s0DcyB3MFt+Te4w=;
        b=llQZUXT1TgPhKdpK1cTJlRpZjACDV5taFvv9D3DzSGeC6N4Dh+S552e0uBSbVFxCy6
         8lC4Csu0SdI4D9lq11y6PJAUgB6FbB1Pci/WClciolGZU8LlmkSulKgJ7SLjXsfD76Zr
         g/cfZ4mTcLgPb3wcvbbV4oBtT8Y2W4NltM4sETa8uCLrpRd03bYj2rE1DZAzZ+4/fETt
         N4z10QPRrzBwXuRrvfxJJOmBRwlke0wGa/vT8D4/a9ifBw3ogMG2Xd6mTeuhMvTL7jdT
         XMhgFoCWApOhC5Nzogs2jT8E6butwBZORIIad1PYzcxjkdLCo5Oz7psKb8qPiYkyW+Ih
         SODw==
X-Gm-Message-State: ACrzQf2U1pCZVTHMTd7Thn79qhdJ/JOmYFu2xE63L3PUCX0yt3dnael4
        P+5EqtoXoNQmioS1wbcdMFM=
X-Google-Smtp-Source: AMsMyM6NC+X1837XLdpYBbrQivwmd+kRYl7x2qijnfBC1NdNrP+77dpntq8PQcKEC7ZY94Hw1mo98Q==
X-Received: by 2002:a63:db58:0:b0:443:575e:d1ed with SMTP id x24-20020a63db58000000b00443575ed1edmr27123879pgi.468.1666603597970;
        Mon, 24 Oct 2022 02:26:37 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-6.three.co.id. [116.206.28.6])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b001868ba9a867sm3773275plb.303.2022.10.24.02.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 02:26:37 -0700 (PDT)
Message-ID: <d4058412-b8f7-fdf2-6aab-9cedda43fb20@gmail.com>
Date:   Mon, 24 Oct 2022 16:26:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] kconfig: fix segmentation fault in menuconfig search
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Johannes Zink <j.zink@pengutronix.de>,
        Ariel Marcovitch <arielmarcovitch@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20221023191055.85098-1-masahiroy@kernel.org>
 <Y1YAyQ4s+wxfAPAU@debian.me>
 <CAK7LNARxGhRHRAQuw7bkY79Z8tAuRdZ=Ayr1_JyS5Cwo=2ERmQ@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAK7LNARxGhRHRAQuw7bkY79Z8tAuRdZ=Ayr1_JyS5Cwo=2ERmQ@mail.gmail.com>
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

On 10/24/22 11:53, Masahiro Yamada wrote:
>>
>> You missed the prerequisites: search EFI and press 1 to jump to
>> CONFIG_EFI.
> 
> 
> Try the command in my commit description.
> 
> "allnoconfig" disables EFI.
> 

I can also reproduce the segfault by allyesconfig then disable
CONFIG_EFI.

-- 
An old man doll... just what I always wanted! - Clara

