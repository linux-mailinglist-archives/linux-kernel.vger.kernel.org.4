Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3727771F854
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjFBCPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFBCPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:15:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBBC138
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 19:15:35 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-256797b5664so809717a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 19:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685672134; x=1688264134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XApgtkN2jCC5pzmqScCzReitzogZdYBuknqg9aRwaW4=;
        b=Je4uXOOXr5Iu0HBDznyQs/8vrgnYEJnSfl8pKC/3I4DEgRpOW8B/PjbPIyh81karbo
         t4KZWp7KlYnpYiqjZWaVkKNgl0Cr1wVcuh6hkMcbntLLcRqT47+QXekhckdh9L4Iwj5+
         ZnxGVipQ17ocROuiwwf5MpF6U3IGBBnm2Wg11G/B/cuOj0850EQQ2t1KVYF4IBZ0C+eN
         qoeCMCa2AokgnJJmQzR0X7iPwVYIJVOkMzP3INhp52cmZ+bEfHQyQgYZX0oYYZcOfC28
         mZUsbOFCORX1Uc2yziJ9blp6b6eMPNZnv34ay9kHCTF2GkGzju0RWznuDvOeN60sqEPv
         X+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685672134; x=1688264134;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XApgtkN2jCC5pzmqScCzReitzogZdYBuknqg9aRwaW4=;
        b=bYAglElGFRAcVRbNxQ3hl9HOg5U0eSlJhpEVCVIix/cOfw0qVHThfaWxTavmdG9q6f
         l1NZ0lGYOiLHVaBzD1i+H2xuFRnL8L5WQoCHcFzu+AsZ05sAqMh0pGE5ejVzQ+DlemgU
         WkoZ8YHnGD5CdbRBtZRSl9gGkSD8WM6p2+iIpjACNYV8+ehbFk4PAEVQMU1tcXL9Iufv
         eaqEgWCv3oWokOsDh/ullcwZCiGWrn1eUVVhbPOTm91krd78aAD/0Ia9H6Z9jKQuNpB3
         ZQECJY4LjMsgfUBTPhseH0jqiacB9uwdXahm6Rlw36mn759OYi9JxPFsS/3nIYF5fUlS
         4lew==
X-Gm-Message-State: AC+VfDwAs2qso2peAKSD2VumAZvTZMMGPk2p+Z1YiMP8ZTREZh/gQwcP
        7b6GEMCUn+lXfhHPiJrhbFU=
X-Google-Smtp-Source: ACHHUZ4IbqD5NoHEPFTuiYkAqTB2hoX7awrX/5FQVh9gjb+2PG+UajTM2aTqq5bq/8zMTHZ19VR8SA==
X-Received: by 2002:a17:90a:617:b0:258:9a26:38db with SMTP id j23-20020a17090a061700b002589a2638dbmr802342pjj.16.1685672134273;
        Thu, 01 Jun 2023 19:15:34 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-49.three.co.id. [116.206.12.49])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a0c0800b00256a6ec8507sm2163004pjs.19.2023.06.01.19.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 19:15:33 -0700 (PDT)
Message-ID: <74b8e4c0-a557-b047-4507-c243c9aad216@gmail.com>
Date:   Fri, 2 Jun 2023 09:15:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: Started to get "memfd_create() without MFD_EXEC nor
 MFD_NOEXEC_SEAL"
To:     Kees Cook <keescook@chromium.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>,
        David Herrmann <dh.herrmann@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Hugh Dickins <hughd@google.com>, Jann Horn <jannh@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stuart Foster <smf-linux@virginmedia.com>
References: <69dad53e-9363-c551-111a-d0051bb0265f@gmail.com>
 <38f847ed-69dc-d5da-5822-bd9da753fc30@suse.cz>
 <202306010710.7F5C39B7A@keescook>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <202306010710.7F5C39B7A@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 21:12, Kees Cook wrote:
>> Hm indeed it seems to have introduced 2 new flags and immediately warn if
>> any process doesn't use them. Maybe it would make sense for some of the
>> non-default values of vm.memfd_noexec, but it's too early to warn
>> unconditionally everywhere, no?
> 
> This is pretty standard for getting new options like this noticed by
> userspace -- there is no regression in _behavior_. It's just a reminder
> to fix userspace code.
> 

Telling regzbot:

#regzbot invalid: not a kernel regression, but userspace fix is needed

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

