Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A59E6D89E5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbjDEV6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjDEV6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:58:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33A17692
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:58:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id op26so2074534qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 14:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680731917; x=1683323917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=szpoCB2qwdblfPt0Wbn2EH90MaiJLksNaYH07lCeLt0=;
        b=GPQ92rmEo75tj8kmVQFx/DUN5HcwfDV0giAu/HPi5bhjcUVJyLgQF5HAhe3TdZC+Ln
         oSIyBhyl2opNiYPz2l9E4Ta9gtAaLMH0a6B6zNrksy1DYwi2k18esBbG1BXJRJGtSqrx
         ov/itszEgR1XCHLY57zsyEPBJNt9fmle+qRHChaGQmKHhhYRJVCMkwu5m8oe6AkLQy5a
         YXgUiSAZM9j0ul3KGo1UBUPov+qBvypnuNneVPm2d3BrBegEiuZeNVnICL1GEhF0UgTm
         ilbyH7XVql/TQpB9aWGOyZNM0aT9lmOLi0vUiKdavkyfe7lRTjALxASCcDrmHu9sOeva
         fxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680731917; x=1683323917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=szpoCB2qwdblfPt0Wbn2EH90MaiJLksNaYH07lCeLt0=;
        b=14RL2XuVvD/BBoClW46xTBCwpPElOVVYT/YT2hCionaPXJrNPEA3WYRoCK8jPu4QsQ
         hi5ihq1tHL+RUjMEileRc4FQAHbuGTLVEBQiD28/X/TqsSFjcA5POP3hpSsuURTEetp4
         QEJHYIBH2Ab9vF2j7seScjNmCEDhAUbfLbIEe1P93R+p+xVi/8zXyGvsK/MRyGZSL9Yp
         x1XxgCWtRw/vVJoCOFlevTsJGgznRQvwnqmt0Jk869vQBXNvjQei70ELT7IdZ+BIDp4f
         qfTr1hvBHxx+lzShlqEWQuFUnRFrLF/hRJKjC6N+u73CGV3jMsTJZjUEJREDQ6VlQgVe
         GDmg==
X-Gm-Message-State: AAQBX9fb9OkVwHxsJXaMKPeeZkBK1XJoNA49NdXyMuaQWRDcAHzbOzoZ
        3wlkwmcfpldEbj0fhJyhv1OJNjYhmuegQw==
X-Google-Smtp-Source: AKy350YajoqQ019eIOrR43NhyXS6yO4/doM/oM2EhARmsL/5Q9G6RCpH+GSTcBjZ/HFTPV6TRvlQuA==
X-Received: by 2002:a05:6214:ccc:b0:5b3:e172:b63e with SMTP id 12-20020a0562140ccc00b005b3e172b63emr1335240qvx.22.1680731917255;
        Wed, 05 Apr 2023 14:58:37 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id nf1-20020a0562143b8100b005e5afa59f3dsm15918qvb.39.2023.04.05.14.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 14:58:36 -0700 (PDT)
Message-ID: <4cb63482-82e4-36b5-dce9-078d0946c71e@gmail.com>
Date:   Wed, 5 Apr 2023 14:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/gdb: add a Radix Tree Parser
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        akpm@linux-foundation.org, kapil.hali@broadcom.com
References: <20230404214049.1016811-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230404214049.1016811-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/4/23 14:40, Florian Fainelli wrote:
[snip]
> +    shift = node['shift'] + constants.LX_RADIX_TREE_MAP_SHIFT
> +
> +    while True:
> +        offset = (index >> node['shift']) & constants.LX_RADIX_TREE_MAP_MASK
> +        slot = node['slots'][offset]

We need to check for slot == 0 here, unless there are other comments, I 
will spin a v2 with that change.
-- 
Florian

