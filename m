Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3C370EB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 04:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjEXCka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 22:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjEXCk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 22:40:28 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC78C135;
        Tue, 23 May 2023 19:40:27 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-64f47448aeaso242359b3a.0;
        Tue, 23 May 2023 19:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684896027; x=1687488027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m11oLmOsg5qTk0p1Yo+3M/oic04UBX8h0JdyD2CrEew=;
        b=mN+6WFS11k3WyOyZgIDw6iHqLGXKBXzwIJP5z5HBZjVYjh0xVheTsc7P1EcKVk3nWE
         rBBtEqakah9Yd5Ly14dYPnPz20PsH+4ZtDZKHav02rfBwM3lEhvHSkUgQ4nIDvLoaxUA
         IlGTsNB6E+YzfwWs3JUjFAXnxZvJtfap6Z1Qkvl3fnZV7xOVt5HsfqkhUDSno0EM4MJo
         Au43lLj6yEwX0HH7xZD1UFhqSUZVF+SRDb9itYcQjVVJ5nhQKemAPxCP7nIk1MaaM/FM
         jszmMuiToJbSNWIS/3RjcI47Yh+qlUaSevSQC8lUeZr8ZZ6IG4eDIazk7SvCPVmqGzW/
         Yqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684896027; x=1687488027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m11oLmOsg5qTk0p1Yo+3M/oic04UBX8h0JdyD2CrEew=;
        b=PrTzoshJl5HPcG8m7GMjraCzNo8chwCEk68WuUpMWYrcufV27TH9ygPFGixGM/SLlV
         S2uCinINLo3pXQHF8Ovdtq31jtgJT6Lol2+z9ur/ZZzEYvRcc9hPrZPt3LRlsIQCGK4e
         PVvIwmqF0i2l3TEgHa8ejZ5uBLu+hNxLFCLNNQm7HA4JvPwpPebto1Ik/Zr0TYHRdett
         sQAkAK1MeDV/KCywZ2+gufdhg1iuv+3kByPI5IhcwDjjU8UJ5CNMCaIoys/6890cAAjt
         YBMhmwlS7pwrLEUyrTOTPOBXeo0xxLT36q0YKCmkvwfOUjxxXwSryXGxJ7hYjJFeD031
         /xzA==
X-Gm-Message-State: AC+VfDx74XiCXhRlFpgdpOBfSVCpMbCoNHxszjC5EzVX3WblJtQAcEVI
        t/lhCfM1z58IjGeaQU0zKRo=
X-Google-Smtp-Source: ACHHUZ4mftEHSRSEOLAZy5ZLxr8q23K9bEIgIjf8VYHFK9UZzcL1IupihI4ZTV7g5sMBNYywCPuT8A==
X-Received: by 2002:a05:6a00:190e:b0:64f:3fc8:5d0f with SMTP id y14-20020a056a00190e00b0064f3fc85d0fmr1363740pfi.8.1684896027086;
        Tue, 23 May 2023 19:40:27 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-68.three.co.id. [180.214.232.68])
        by smtp.gmail.com with ESMTPSA id g20-20020a62e314000000b0064d48d98260sm6102046pfh.156.2023.05.23.19.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 19:40:26 -0700 (PDT)
Message-ID: <1955521c-b3eb-d084-71c8-31db72753932@gmail.com>
Date:   Wed, 24 May 2023 09:40:21 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] Documentation: module-signing: Mention
 default_x509.genkey template
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Keyrings <keyrings@vger.kernel.org>,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <20230511043852.25803-1-bagasdotme@gmail.com>
 <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAK7LNATY7EEWy6krs+J-XzXDzmuKQ4Ae4RrxEH6mX=SmcWCiPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/23 23:55, Masahiro Yamada wrote:
> On Thu, May 11, 2023 at 1:39 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>>
>> Commit f3a2ba44e93e2c ("certs: check-in the default x509 config file")
>> adds default x509 keypair config file template, but forgets to mention
>> it in kernel module signing documentation.
> 
> What did it forget?
> 

I mean not mentioning the template.

-- 
An old man doll... just what I always wanted! - Clara

