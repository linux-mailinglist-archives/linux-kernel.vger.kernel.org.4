Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10EB6F9060
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjEFHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjEFHyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 03:54:20 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5CE9ED1;
        Sat,  6 May 2023 00:54:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so24320434b3a.1;
        Sat, 06 May 2023 00:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683359659; x=1685951659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+wGe49R3eLqMVQC+9UHnKCD8ZBhmoA1b2SIqaUWZ/M=;
        b=C2Fkrk/K8h7dvTizBHYzhj8CIzyPMWa7S33MNnJmbQmTmqy/hY2vvFDUnQAcIbvz8z
         BWuw+9xEYCHiifHT74IMW+daCk52iZBoImsTTAD3d+jKPXWj1A7zaTS0A8wL9HAQzvDp
         5xlyvGczVE9nWew2FLl6O3h0pExmJAg4pXTswGpEyH+D2umGv7s65Z2ZBqAgwTfS0oDf
         sGIs1+6nINLk6btzVxswcntLBqhNIb3S9k6Wwmi0XkexPUSzWbfWmykRrEsYDXzEZ+FJ
         2wCrsSGwlPRgYMNhdEW2dIiKdUu6nGsYZf9LVMzmdm6wSNGJdDP1ER2RyaMVikhOxpzF
         kkVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683359659; x=1685951659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+wGe49R3eLqMVQC+9UHnKCD8ZBhmoA1b2SIqaUWZ/M=;
        b=gLI++m2WM8yc0srjoTw7Go6QM4tjaUWge1OfSetf/R2Wn0if/4jwJLFTzPQ+N88bKP
         3ldKfaDBgrOzq26lBPeG47jzfFQcz5CSLty0pYcog6x+Fceljw337Ns39///Yxwrh3mB
         Xk4nbvBMgKjDaECq/Ik8F1kwPNs8W3RBjuaFtv8xmG5IgAcrK3eoNfakMjavfvlbdq1x
         XGY1WkzKrWxFd3hNdLE4JI2cVQ1X78SRelTfyUVKLaOGgV31SGvsxkeuCzlOvy0hcCMv
         0Qi5d7q0q5GrwBjPbB65I44pe9oDz7pNNxBGngJGlvv5Khrkwc8CnhZ4g7DgNC5B26To
         eygg==
X-Gm-Message-State: AC+VfDwQBUNpxLm66NOPknI6tiMo4lqGmYHkvU2WD8t0CfdC+Afpzx2W
        Gy1Adbd8tjUuGJIwGHz0ZCc=
X-Google-Smtp-Source: ACHHUZ5yndMq3xw7azYXGoa7MnesSYtWqs8Q3MVobwi3lvYFYXtU5YeuSilhyyL36ai+yQZRf3btJw==
X-Received: by 2002:a17:902:db01:b0:1a6:b971:fae9 with SMTP id m1-20020a170902db0100b001a6b971fae9mr5257162plx.8.1683359658665;
        Sat, 06 May 2023 00:54:18 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902c60b00b001993a1fce7bsm2960152plr.196.2023.05.06.00.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 00:54:18 -0700 (PDT)
Message-ID: <9911e550-2589-75f9-e064-70b2b914b236@gmail.com>
Date:   Sat, 6 May 2023 14:54:13 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: confusing documentation about Development Process
To:     Costa Shulyupin <costa.shul@redhat.com>, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     open list <linux-kernel@vger.kernel.org>
References: <CADDUTFy29Cn6y56XLB-me0FneXrMED0LuHLb-7KD_NoiXZSZrg@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CADDUTFy29Cn6y56XLB-me0FneXrMED0LuHLb-7KD_NoiXZSZrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 12:39, Costa Shulyupin wrote:
> References:
> 
> "Working with the development community":
> https://docs.kernel.org/index.html#working-with-the-development-community
> 
> - "All development-process docs" linked to "Working with the kernel
> development" community: https://docs.kernel.org/process/index.html
> 
> -  - "How the development process works":
> https://docs.kernel.org/process/2.Process.html
> 
> - "A guide to the Kernel Development Process":
> https://docs.kernel.org/process/development-process.html
> > Development tools and processes:
> https://docs.kernel.org/index.html#development-tools-and-processes
> 

Have you RTFM above?

-- 
An old man doll... just what I always wanted! - Clara

