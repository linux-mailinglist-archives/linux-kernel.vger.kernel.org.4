Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505769EF62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjBVHeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjBVHeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:34:00 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD11E9F5;
        Tue, 21 Feb 2023 23:33:59 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q189so3594972pga.9;
        Tue, 21 Feb 2023 23:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tke6k69A+usZWkifY31rjXvzEvWLk7GDHoTg2tUCQfg=;
        b=T+zk4z0BjizZQUKsFdfFLf3IcQTrWu2G+lmzvDo88fpEDU1KD7B3K/kzJKCE3CjCSV
         s/g8iPlywFDYqtGcxXD78mEnI+Z1kqVU6ABYBN85ndidcf7IUwmMHoiP5Gv37/IgAmnx
         6qiwPhPjyMb1yLXU2ufjPsgQCqJW/iDfBMNiqeahrDQodFYYcaEx5DlL1VHWT6UHJV4+
         SumrL+03B9XVfo6iELGudiNYDmXZ2EKilL8zsNqBryag+9JBTVzRWglMUh9OftETbXfD
         CEPw0dru0NSTXIZ8L+/fByBSB4BVqtLPaa7W0ePlZNiq6dWIA9p0CDEyVg7JUeWvyCZ+
         wOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tke6k69A+usZWkifY31rjXvzEvWLk7GDHoTg2tUCQfg=;
        b=VKTJjyb4LhEkkrhm+cWQfcktuhDLWA2dH6Wb5cRCjCCRkZS6ww1DlrJBXFGEGRKtKL
         TQLRHrh5vxCtazf3ICVWLVBYJBa2l/9SyAYH+1Em1yzRCIrxTpwS7p0gSqaBc48nPJ00
         ewP/eFt8pwySq3/JRrD7m8U7aG+x0FCf7Y7nrn9HyRRIIrf37lXUhpGbqkZ9iCqyGlno
         ZZ1Du04UyVBUrz4lNybPfKBOnZt1YTcD9ZFdVTaSjIF5yRd1XgtagLsytw/aH7skT/Bd
         bGPx0DookHGrsGuBX21VeMGtpxMk95t2F97a8pPPkijzMPLGldiFKgsBUbCSLpH3ru/3
         z57Q==
X-Gm-Message-State: AO0yUKVs34Z+mRBXNEL7lscxdaE5Jgc+WTCP5Q9e1LK2FNMf7u7fic3M
        9mkGDAsHU8lRLcju+88NIxo=
X-Google-Smtp-Source: AK7set9b5KsJSVkLu281wycw4iSJyEYhbMJIYdjnq7VoR3Iv8VkAkmLbhjOJxEizJUq5upCzF9wObw==
X-Received: by 2002:a62:1a8d:0:b0:5ab:be1b:c760 with SMTP id a135-20020a621a8d000000b005abbe1bc760mr5213258pfa.12.1677051238977;
        Tue, 21 Feb 2023 23:33:58 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id c22-20020aa781d6000000b00593fa670c88sm315272pfn.57.2023.02.21.23.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 23:33:58 -0800 (PST)
Message-ID: <1666a6a9-4757-0e1d-f807-618c95e0b6ae@gmail.com>
Date:   Wed, 22 Feb 2023 14:33:53 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] docs: kbuild: remove description of KBUILD_LDS_MODULE
To:     Sangmoon Kim <sangmoon.kim@samsung.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CGME20230222004609epcas1p2eb7e213b2b3503d018fcd6d58b9497b2@epcas1p2.samsung.com>
 <20230222004550.13469-1-sangmoon.kim@samsung.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230222004550.13469-1-sangmoon.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/23 07:45, Sangmoon Kim wrote:
> Commit 596b0474d3d9 ("kbuild: preprocess module linker script")
> has removed KBUILD_LDS_MODULE variable.
> 
> The KBUILD_LDS_MODULE variable is no longer available, so this patch
> removes it from the document.
> 

What about "Commit <commit> removes KBUILD_LDS_MODULE, yet the variable
is still mentioned in kbuild documentation. Remove the reference to
the now-nonexistent variable."?

-- 
An old man doll... just what I always wanted! - Clara

