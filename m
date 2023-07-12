Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EB4750CBF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjGLPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjGLPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:39:54 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC91BB;
        Wed, 12 Jul 2023 08:39:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-3457a3ada84so34973165ab.1;
        Wed, 12 Jul 2023 08:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689176393; x=1691768393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=RXSEQ1Ax3lLiaU8Cvc5wJKaD5LmTRVbKNFbrw0OwUak=;
        b=ijqvScl94mBWA87jtsL4wo/9Re066jPs/yFoEzTqJoKy2mCMUxTpaqLsJne6TkCO4c
         jYg52RrAKMuk7UvhWswsaPl+X9P0W6rJPVFRYFXN/H2Sk9JB8XN1czobE/UHTMhuaHdU
         nf3I0plmoMgqJh724TId3YonlJ7bu9018WC3cvWwS5Le6TUdwzzhUGvB6lef9axRlNHm
         6EazD3DEWPgP7OxT0TX71AcIksbNtPwjkIQ+SkVrKsnkKOvzEuq2BuF5RACBOlcnMh6P
         AlF5ayxPUh/0kHHRyIKF5Kin4LbJfL9Z6KXaaLkXu2v3m1ngItAmOkjl37Z8R8IQjjF+
         sK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689176393; x=1691768393;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXSEQ1Ax3lLiaU8Cvc5wJKaD5LmTRVbKNFbrw0OwUak=;
        b=hFPlkhUU73UTjafYmT3utt6rz7FA3K63K2HTJqsY4Yu5ntLozyEXUY+zpKDEdYydfH
         Oweh53pNsan3a2JZsGFpmakDNvUkU0K49QKxa2ODMW7X23O54WLIZDMKnpTHvFGS3J/m
         Lh9sMXHtpkpfOCnZrrKD3s9f/QAB4+W/KxDwfuKiCtHqeWP+FQcJAg2tFb9HikgogN+H
         MIRB1Cyp+T2os0l70jLrL174TK5Y3q4b5fLu2fmBRJlXCgrxWsIOkZE8kIWTm9j04dg5
         t9Hd02wjavnnMzkfacwDvi+EbLDVqNrskt8nlPoqnvc/VijJKH+RbArcCg7IiGl1yUbT
         93yg==
X-Gm-Message-State: ABy/qLYZlTsEZvWiDEiV4Qon2WxomALTP/3+rZY+pnjJ9WVU5s+qUHPy
        pmmcdvSeOhM/f/wfqt5Vbbw=
X-Google-Smtp-Source: APBJJlHM/Zzpxdoy055jByMJt5n+bzNUJakOLXKzjBCmJR6NzYt+skF/bKWCORcFSYmSoucalyqnNw==
X-Received: by 2002:a92:cd09:0:b0:345:a201:82c0 with SMTP id z9-20020a92cd09000000b00345a20182c0mr16121504iln.32.1689176393185;
        Wed, 12 Jul 2023 08:39:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y11-20020a637d0b000000b0055b149a6db5sm3729891pgc.43.2023.07.12.08.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 08:39:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4f520327-4867-8f2c-050f-48eb52d3deed@roeck-us.net>
Date:   Wed, 12 Jul 2023 08:39:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] hwmon: Remove strlcpy occurences
Content-Language: en-US
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Kees Cook <keescook@chromium.org>
References: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230712144429.2845940-1-azeemshaikh38@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 07:44, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with direct assignment.
> 
> strlcpy in this file is used to copy fixed-length strings which can be
> completely avoided by direct assignment and is safe to do so. strlen()
> is used to return the length of @tbuf.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Also, $subject should include the affected driver.

Guenter

