Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE216CCF2C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjC2BCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjC2BCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:02:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8D19B1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:02:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so12583814pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 18:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680051758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23vaCan2Lq1q9u9StAm7O9I/m7291tUQ22ahjedjRN4=;
        b=dosBy1l+wKb/tM9yNOAxmj/qHmJPnmO8AWmf12B0pC/Ggc14+MKjw3MgDtSv11bewV
         kb23rdUHWV0EOuKSLAxXbY5UQ/L4tFDn9dMJSlBwjb3Qvw1tSVCDAVsICaR1cJYiE2+7
         BJuyiKF/eVmbHTiOYmNJkUI83E3P7+7SmyJz8muoqUtB7Ozv5FMpI99JHV6UW+afqYfB
         aFgt0boJbPuf48wXWyo0oeQbBFd4amLrQ/MS74z8hrvFZqoTqaL3E9enHF+FUBlufUei
         722ydRoac+hIowIXFgqzEy3XSymI5pW0oXadBpSTEMbyf16dKCBdIqD1i8OuEpjNOpfF
         FSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680051758;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=23vaCan2Lq1q9u9StAm7O9I/m7291tUQ22ahjedjRN4=;
        b=SZZ95tROyjWSy59CmYc8hM8NGYYXTzxX0P/hvs6REBmbcJqBnDofhEY8LuEPBdQ16q
         LaNKYW70N4YbyFme+RYaB2evj/UPXQcqK3C9iqi7cNc+aqIJuOnaa9+G/9B4w/KWlWzf
         Zr23UOP/Vf7z9IcHg40B8la9XoI1/ax3O+jvwi1voQTf0c9C+vlFmzFZJ0TF8Uyh/9zc
         OhLMca1W6FjBtrPjlZmSmadvSQK5PDFS9SekcF5SF1IjRMPgMJzYuAV9Is5JsYh5mtNW
         aI7dsClV6+6m+KbRIjCXjSy9y+fNQ564fNyFMFXPyzG9+MAYFIQTsDRWmNyUEYiDDMxA
         dD7w==
X-Gm-Message-State: AAQBX9c4BdQPwZcy3Y279punpnbjFNG+5/iFz2kwCi4rlcry7DnAU+4e
        0fz0FMNk6JC9/8A9BvmezZkwJRRyzg3boA==
X-Google-Smtp-Source: AKy350bKXklLdR0xeAUMZspvPIIJpqEZo9q2PAfjks19lz6zcNl+gvgfe/t8aH74HnIS5Su/SteJGA==
X-Received: by 2002:a17:90b:3c49:b0:23d:19c6:84b7 with SMTP id pm9-20020a17090b3c4900b0023d19c684b7mr18610935pjb.16.1680051757795;
        Tue, 28 Mar 2023 18:02:37 -0700 (PDT)
Received: from [192.168.1.104] (111-248-155-101.dynamic-ip.hinet.net. [111.248.155.101])
        by smtp.gmail.com with ESMTPSA id h12-20020a17090adb8c00b00234465cd2a7sm137558pjv.56.2023.03.28.18.02.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 18:02:37 -0700 (PDT)
Message-ID: <df16fdf4-bb0f-ee58-0c7a-4b3d5ee98959@gmail.com>
Date:   Wed, 29 Mar 2023 09:02:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Yan-Jie Wang <yanjiewtw@gmail.com>
Subject: Re: [PATCH v3] lib/list_sort: reduce if-statements
To:     linux-kernel@vger.kernel.org
References: <20230325091654.106040-1-yanjiewtw@gmail.com>
 <20230325123216.226120-1-yanjiewtw@gmail.com>
Content-Language: en-US
In-Reply-To: <20230325123216.226120-1-yanjiewtw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 8:32 PM Yan-Jie Wang <yanjiewtw@gmail.com> wrote:
> 
> Reduce if-statements in merge and merge_final functions by using 
> indirect pointers and bitwise operations.
> 
> This will make the code more elegant and reduce the number of branch
>  instructions in compiled code.
> 
> Signed-off-by: Yan-Jie Wang <yanjiewtw@gmail.com> ---

After performing some tests, I found that the merge algorithm I proposed
in this patch is not faster than the original one.

The number of branch instructions executed per loop is still the same
(two branch instructions per loop) since the compiler will generate a
branch instruction for `node = cmp(priv, a, b) <= 0 ? &a : &b;`.

In addition, there are more memory access in my proposed one because the
use of the indirect pointer, `node`, forces the compiler to put the
local variables, `a` and `b`, in memory. This will slow down the
performance.

This is the result of the compiled assembly:
   https://godbolt.org/z/vqorfz967

The test I wrote to evaluate the performance:
   https://github.com/yanjiew1/linux23q1-listsort_merge

I would like to thank Ching-Chun (Jim) Huang for providing advice for
this patch.


Yan-Jie Wang
