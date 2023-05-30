Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5F71590F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjE3Iwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjE3Iw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:52:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A361B2;
        Tue, 30 May 2023 01:52:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-2562cc85d3dso3529414a91.1;
        Tue, 30 May 2023 01:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685436746; x=1688028746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vG5ToyO9hEsBuY0qBBoen1Ge6L134iohzwm7Csge9X8=;
        b=mrTLmaNUUkeRHYIFE1wsMJMAhGCCFPJkTtcPzPBXb1EKVXE2C+0b85C4RlrvxzZIsK
         k1JcDIyS+wHXzzPyeK/8v+tZKrOxTActAtfBrtW+9nP/oWYf4/8PDLlc7UMNhQ+89Fpn
         hUKIHlXkDalbE5gQokdExRCFYcPI/Z0gnLDN2lopodHfVOEhUuaJsIadrxdUhUVVqkT8
         u8IjM3+Td9eH9UVNmZWMQLc3CGYONWI4017JSrT24597AZbnXewFadarGr/wtZKy4mLO
         PFmK18aSnZLTNKyyCYnuqvsWO5mQ31J2ms6ot0XQZgyXCmT5nqxFpHK1hBB+ok6glVUt
         trSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436746; x=1688028746;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vG5ToyO9hEsBuY0qBBoen1Ge6L134iohzwm7Csge9X8=;
        b=gzdqofVWcVfNZFxmntY6rdYSWRRoTHSB+tYSwVPWXukGjGZ+/phKtWaJ1kubgZs2dx
         exDwJw0vPWD8etJJhurPolEXSOgrPw7o0jEudo5Wn3Cx4UCGToDlrm28bjNFWZplh8kK
         b3Pzxnrv9hc73imCxfgWMWLfI5OQhsSKWQBLvfy77+pNxffEnXG0eSPJa4uZ4c9T7eBO
         /GYIypj82TWwdJn6Q06wM1lSAUGNvHuogdGLdadZYXrtl+1E/xNsIysUNgGaRAOmssr+
         j87SlFIgETpJulwdtOJBey8VUEMcwhJ8+JRQZtp52yg/zoxSU/JAaKF3iW8wqcVam+CX
         qy2g==
X-Gm-Message-State: AC+VfDytvtDOz3+QD8WlKJx2ljVvqKwKU2mff8eRHlqEViBL5THBjYnJ
        5dYRB43/oLEOkRImRl+a6xg=
X-Google-Smtp-Source: ACHHUZ6vvkxwEe5OYLK8YQg+8LmiqJRvWkmYJeD3vJZ391NjmaDS+ncR8p67II4zp2ZWno3Ev8+0fA==
X-Received: by 2002:a17:902:ecc3:b0:1ac:5717:fd5 with SMTP id a3-20020a170902ecc300b001ac57170fd5mr2152890plh.60.1685436746416;
        Tue, 30 May 2023 01:52:26 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-74.three.co.id. [223.255.225.74])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902ab9500b001b00f9c4578sm7837069plr.138.2023.05.30.01.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 01:52:26 -0700 (PDT)
Message-ID: <8c028dd1-aa6b-a33d-dcd9-178077fc8b3a@gmail.com>
Date:   Tue, 30 May 2023 15:52:20 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] docs: split subtitle of Submitting patches
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Rong Tao <rtoax@foxmail.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230425072644.868535-1-costa.shul@redhat.com>
 <f569e819-9391-0a52-fcda-24946687690d@gmail.com>
Content-Language: en-US
In-Reply-To: <f569e819-9391-0a52-fcda-24946687690d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/23 08:20, Bagas Sanjaya wrote:
> On 4/25/23 14:26, Costa Shulyupin wrote:
>> Motivation:
>>
>> The original long page title in the left Content pane spans three lines:
>>
>> Submitting patches: the essential
>>   guide to getting your code into
>>   the kernel
>>
> 
> I think it's OK to have that, if the title can't be further condensed.
> 

Oops, I mean it's perfectly OK to have long title written as-is if it
can't be further condensed to convey the doc theme.

-- 
An old man doll... just what I always wanted! - Clara

