Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992346BA582
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 04:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbjCODIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 23:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCODIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 23:08:34 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C0818B05
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:08:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h8so18627124plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 20:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678849712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGdr/E0FzAuLt5/y1L44Qzrzo3DseJLo/0lbocJS4d0=;
        b=lUU+a1nb4qPlGxHNNl5mWOoqEE/TMs4d5haeafClSauEE3ogFGBxpEzy61TXLtFUIT
         xnaHJWlgKw0QEFRL9MegHUP15Unh26RAvWQsqTyzHzSgupq79zoeBXIrestY+hmDoV6N
         2fD9GySpetzio8aUJAiefcLxLoR98llFA/wE0mwR9NrgE1i/K1D5/IS/PMh5hbxgvDAA
         yt0UEI2oy++/NCneEsg5bvsXfU5YniScOH4KeVerGKpAjA9HnCUT0wCoqcXxoR8bluc9
         A9Sf7CVSux4k1Lunv2FYqwbWMNO7Z1OiPBtfqkkFm1UabFoZ1c/uYrNsMUn7lVQSuX+/
         IC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678849712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGdr/E0FzAuLt5/y1L44Qzrzo3DseJLo/0lbocJS4d0=;
        b=CJ2yyHX7QowP3UJZ2SWi9QKZpqWTNSBY6Sb9iJ1lRdYMxmwHPw0H2ZF2oPkBNhRXav
         n626J/yjNHTphBJcJ6rp2hWhT4WfXsgIAPyTRluJlRSJ/TZ0i/CC2tcXvw9VU+vC6lwL
         QckMObcgByPVqmXF9SUkY4dcvZKkAwUeJmdZ07WSR7HAX1Oamy3GVkmr0+XzErShxD7N
         7ICimoX6125nQM5/PkCOnYbkZBMJxbbvHY6bg1Qx3HeG1LDhOpJObt2wpCpTZG7hFqnK
         YYE8PSaRm0KhXS1e97zJKrYAWiVOS1ELea9ReEGhlEAoS0i2ATBKjTgZ2yN3TceX4nXH
         h0xQ==
X-Gm-Message-State: AO0yUKVk2buo9T7I8OIof1aGY8CWtA/lphKMTSTNpRLr2dDHU5DeLT9/
        wxpDFNLkPoFn5n7BBSVJyPAdUhDIpJA=
X-Google-Smtp-Source: AK7set9EAQBxtnXIxdV5KDYNlpbU34hJfwqcNMvp3CNiDs4ZMK3xnx8EESF6RVJN+80hQpSZ3q3DEA==
X-Received: by 2002:a17:903:1112:b0:1a0:4b23:84a with SMTP id n18-20020a170903111200b001a04b23084amr1347869plh.46.1678849712255;
        Tue, 14 Mar 2023 20:08:32 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0019a7bb18f98sm2439582plm.48.2023.03.14.20.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 20:08:31 -0700 (PDT)
Message-ID: <5fd67671-8e21-ffa8-8571-d8b5533b4758@gmail.com>
Date:   Wed, 15 Mar 2023 10:08:27 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Content-Language: en-US
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        outreachy@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld> <ZA/+JlgWfdg2wH8B@debian.me>
 <ZBCS7DR9dZH1yds8@aschofie-mobl2>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <ZBCS7DR9dZH1yds8@aschofie-mobl2>
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

On 3/14/23 22:29, Alison Schofield wrote:
>> Fixes: <commit that introduces these camelcase function>
>> ```
> 
> Why are you asking for a Fixes tag on this? 
> Seems unusual for a staging driver cleanup.
> 

I thought this style cleanup also warrants Fixes: since
it fixes coding style problem on existing code (see
Documentation/process/submitting-patches.rst).

-- 
An old man doll... just what I always wanted! - Clara

