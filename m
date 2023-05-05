Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEC6F8339
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbjEEMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjEEMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:45:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF21D95A;
        Fri,  5 May 2023 05:45:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-643a6f993a7so297982b3a.1;
        Fri, 05 May 2023 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683290739; x=1685882739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftpzKVpf3gHcuZ/AvSBZl6C8JB4tNdaeAhU/J7ju6PU=;
        b=kHJ8yb8NHQRpKxFQ/omMXFujeBCYsZa9pn6BrRj2yWzDxFe5gWiVaV2lRyYYM9k2OE
         5TdY2niQfksu6z19LkW6Uf7ldkCSvrFDVFL81Ct+qLtTFiLM/W5H9CehUCr2lm/QhwJ1
         wwzrPJM9v4rJmz451GV2+VTWCSUSqVCp6Qw6RHl9P9vUtzNCYWszpw/P3nG1swNr2E5z
         6/G/Gk4dq8MkeX4Dexwnn/7oXPJByMzYqUxTGZ8uR6ehN0rZSfCPGMxG7uteOLRU7WQQ
         XICknENf5+2hEhR0aCPExNEx7VX4UAteVeRkQs+/T5Tv/QHbapOl5hFjRGOAp2ICJbpz
         Lkcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683290739; x=1685882739;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftpzKVpf3gHcuZ/AvSBZl6C8JB4tNdaeAhU/J7ju6PU=;
        b=TG8szvYg9s97txztiaZWG5R9iCvvPj9CVSWfqQlEjES+WqhTBhiJz6N3fX44cC33Zi
         RVT2P+LuJd8gZqHs33nDioKdrezUu9yMp2XnSiKQNfPJHaWFUthek82hrReA3OQbD438
         s0p8DpHNCsQWZX/gUaTF9hwhbxmOvVgjWKV/CRaO9t7cIcqf5BL9D8m3gB1yUopjMs9P
         1xyDhRVqeXMK+xSahLhUgevspbQatmbA0lQ3P+7m7ZWnoObW/cKK7AZX9pWf1RN7ICzq
         mGVZvxKXSg1qZ+KfLdLfhkJ04N4GNyWry7B+ILuCMfRIiO/hfstiHA1xI5pk6jQEUDH/
         2zFA==
X-Gm-Message-State: AC+VfDzAqexSVhnvnlmBUB1vO41J9DQUZ5SaMXXuZMdc9jIPX3mAL6Jf
        dlTNLbNTwza5Cq4nXHO+ox0FyeZl/QhE1g==
X-Google-Smtp-Source: ACHHUZ4ttmXetM1RLowXGB3U+t8EdMvUSuVAx7z6WSVSuWhQNufpL7R9aRxoBOqGWdnowwm9Z58p9w==
X-Received: by 2002:a05:6a21:6d88:b0:f2:7c00:fe7a with SMTP id wl8-20020a056a216d8800b000f27c00fe7amr1849133pzb.10.1683290739485;
        Fri, 05 May 2023 05:45:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id a26-20020a62e21a000000b0063b89300347sm1635379pfi.142.2023.05.05.05.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 05:45:39 -0700 (PDT)
Message-ID: <ba8a28bc-d390-0ece-a4b0-e20ff0e95504@gmail.com>
Date:   Fri, 5 May 2023 19:45:32 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [BUILD] [FOUND WORKAROUND] Unable to sign drivers on Ubuntu 22.04
 LTS desktop
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Cc:     linux-kernel@vger.kernel.org,
        Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
 <59599649-6481-eb3a-8584-6653f2c511cd@alu.unizg.hr>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <59599649-6481-eb3a-8584-6653f2c511cd@alu.unizg.hr>
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

On 5/5/23 16:00, Mirsad Goran Todorovac wrote:
> Hi all,
> 
> There was no success in building 6.3+ with the Ubuntu generic config, but it has succeeded
> with the config derived from Debian one.
> 
> Still, it would be interesting to find what is preventing the Ubuntu config from signing the
> kernel modules. Up to that point the build process is fine.
> 

You will need to see Documentation/admin-guide/module-signing.rst.
Especially on "Generating signing keys", there are instructions on
generating your own signing key, because in most cases you don't
have access to signing keys from your distribution.

Anyway, when you have problems related to building kernel, always
Cc: linux-kbuild list.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

