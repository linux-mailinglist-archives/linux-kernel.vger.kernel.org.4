Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149E470F7C9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235180AbjEXNj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbjEXNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:39:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FBDE7
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:39:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso1045427b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684935561; x=1687527561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hPsAoeioL5fBV6oESCE3p4zCum2vadqzjSJd4gAo1As=;
        b=UerkxAe1cuAxMa0tMwzHRnm4yoFoo00xmDBj9EJfjTIpxnl1u9y/hQqnjm8YEhVTT8
         MMUWAqbxySMSY+RpXGj5k7H2lEU5qkq3UiFziaJqOIZHRGjSQL5ihhcNaJf5my3W5Twk
         fiIwWjmlRLOgCf5ICcpGIxE3vlIEqiIzZsIbie8lsr9T41dAEasU1oKiTlkgpEcKE1aS
         nAKi6S1P4xSLNyKwAUctQiHvx3FZ3W0uVxsNKW3fe1hTf6pDPTRSXwVuYAJOKhUxnoop
         Rpl+MgcRgmRRD3DkGdSnUJCMBT9cr9nqhVXPAbQPOt+uU7HrcDIizGzIC+jz1kzQlk/H
         58oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684935561; x=1687527561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPsAoeioL5fBV6oESCE3p4zCum2vadqzjSJd4gAo1As=;
        b=YbP9bqMkRybiZq6TKqS3xB9CQeU9o8n3/VakWkcj4xI50hzbXGpAOkFXFpaNL9YHCh
         j6jw0Q+ysnwT1IPSQHBsjDCnym5PLS7Z63uNmqELnc4EKWgvngrWuZ9u9QaPeZml5Lji
         O8cHc1V5HEH+eWOusnfl0crRSL1YW184h42cZKO5bSmrf0THw9m8/2eguZfzmLGyk3Zz
         3dpW4qSIBZMhxR38lqgyLYMO7Gj4XX6MusrDBbXdMB+b7ZcUtqyieHgnygMq5OBqLH3I
         HceySXob+Su7GUKn1n1hcJPjEnAtLavkpjkgcrPRcjvddUM4gYAsQZ8fupXA2xct2oZi
         oO8A==
X-Gm-Message-State: AC+VfDzOYoexkXZVWWUi7Oh9CoRiScogCHf5JVWsKQjJZlk8BYbLgYBR
        irVJhvObwG/kN+Fje6VJPLw=
X-Google-Smtp-Source: ACHHUZ6+4ecfLPKCvweUFLek2AuikwAHHFdmp7lDN93yiPKuONCVLxG+xoNnfueMOPPVRsYfibfDxA==
X-Received: by 2002:a05:6a00:b52:b0:64d:5f1d:3d77 with SMTP id p18-20020a056a000b5200b0064d5f1d3d77mr3858529pfo.34.1684935561609;
        Wed, 24 May 2023 06:39:21 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-11.three.co.id. [180.214.232.11])
        by smtp.gmail.com with ESMTPSA id y4-20020aa78044000000b0064928cb5f03sm7461051pfm.69.2023.05.24.06.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 06:39:21 -0700 (PDT)
Message-ID: <5df92692-296e-3956-24fa-2bd439337953@gmail.com>
Date:   Wed, 24 May 2023 20:39:16 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Fwd: ./include/linux/mmzone.h:1735:2: error: #error Allocator
 MAX_ORDER exceeds SECTION_SIZE (v6.4-rc3 build regression)
Content-Language: en-US
To:     Doru Iorgulescu <doru.iorgulescu1@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Zi Yan <ziy@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Disha Goel <disgoel@linux.vnet.ibm.com>
References: <2a1cd5e6-01f7-66f9-1f9d-c655cc3f919b@gmail.com>
 <5d22e1e9-0307-3664-8b4a-99caaaaa4315@gmail.com>
 <CA+39qUjOA53UO4oYOzrUJqdYq8A3hbnnxpSV8nfqh0T5KiNL9A@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CA+39qUjOA53UO4oYOzrUJqdYq8A3hbnnxpSV8nfqh0T5KiNL9A@mail.gmail.com>
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

On 5/24/23 20:11, Doru Iorgulescu wrote:
> Glad to hear it! 
> Thank you

tl;dr:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top

(IOW, I have no idea what you're referring to. Please stop top-posting;
reply inline with appropriate context instead.)

Also, don't send HTML emails as many mailing lists (including LKML)
don't like it.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

