Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02046C325E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjCUNMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjCUNMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:12:42 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE51749F4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:12:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so20163217pjt.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679404361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAjXByyNeVsllWRRDtI/FHQctq+3KZulJN/OLUyCO0Y=;
        b=FVqUv2LQHwvg/vVQtrGj4ZriCG8kiq0Mq2nJuDX8CzetcsSLFWAq8LjPk8hJkqsJkF
         E2X6Sv4Ncdspvnro9L1YmdOlWqyHhjJTbIy94zFkISeWejHNO8ySKiGB5jIOtUbOEn4d
         VRIW6wS746nkKBXuzmgv82W4PN288lvt4C6SGvecN4ZR+WQm7JtQXqbbg9feBHlPL9yB
         CJWUHmlHG6AwwM3ejx6pK8F8UmINAvZw8UyaXPQQ3jA7W0XCVYrHvSNAR0nJA0PXRK2I
         q0lhYtMm3lu64R8y5ZOHgampujPUwuMvWoUTWadi/WVqBBFcPwOJyaBZ8z0Ze6y1kk5Q
         wjvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAjXByyNeVsllWRRDtI/FHQctq+3KZulJN/OLUyCO0Y=;
        b=jrM81m+XELfgMBvYnyFVnp5f7rWQ0JDAwj3aorl66V9pigPnJmAgXhIYel3mXLka7V
         O9nn4LDWhq1DUxhXR/vvP4VP4xVIQ2c0ODNhwDJAOQQeM9SwQlw8GUmrEBJziPaOVeq/
         l0JOUTQ4aytqximmFPwPIKwEFw9p/NVrbXXjoZSrfw8lagViXT9Uuue+6yJxM2iqMnZT
         EmpvxBZ7u3E0eN3xV/QqT6pgDk8SzguUlIpukeIr+S8L8E8zL9dVX/ADsxNcrV2A3A6Y
         DBjxui+3tf6vwk3tyMIIb4l8/dM62Xy8ftqBN6JqlarZa1kTEMUaragBb96Qr8c66Vst
         fGqg==
X-Gm-Message-State: AO0yUKUUMoHox+4svttURiCsRcr3ab2j9gy4YDEFT5EBd98iU8jiGJ6k
        yZth0dkqCFycxgGn12zkuaOIy8bE2KQ=
X-Google-Smtp-Source: AK7set+Fux4yS6sb9QMc/wWCWwfKerztUvonr+R6TXeModNpu54XsFqCCe8a6xFun9iV4ReqvZDBSA==
X-Received: by 2002:a05:6a20:a8a5:b0:d8:afd4:4ac7 with SMTP id ca37-20020a056a20a8a500b000d8afd44ac7mr2315740pzb.4.1679404361134;
        Tue, 21 Mar 2023 06:12:41 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-50.three.co.id. [116.206.28.50])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b005d4360ed2bbsm8222947pfm.197.2023.03.21.06.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 06:12:40 -0700 (PDT)
Message-ID: <a05cfc82-a9e9-ea96-aaca-612ff9c14219@gmail.com>
Date:   Tue, 21 Mar 2023 20:12:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/package: add back 'version' for builddeb
To:     David Wang <00107082@163.com>, linux-kernel@vger.kernel.org
Cc:     masahiroy@kernel.org
References: <20230320110819.23668-1-00107082@163.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230320110819.23668-1-00107082@163.com>
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

On 3/20/23 18:08, David Wang wrote:
> Fixes: 36862e14e316 (kbuild: deb-pkg: use dh_listpackages to know
> enabled packages)
> The 'version' variable is still needed for building
> debian 'linux-headers' packages, add it back.
> 
> Signed-off-by: David Wang <00107082@163.com>
> ---
>  scripts/package/builddeb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index c5ae57167d7c..5102d0903f9c 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -215,6 +215,7 @@ install_libc_headers () {
>  
>  rm -f debian/files
>  
> +version=$KERNELRELEASE
>  packages_enabled=$(dh_listpackages)
>  
>  for package in ${packages_enabled}

Hi,

Again, your patch looks like corrupted (tabs converted to spaces).
Please resubmit; this time; generate the patch via git-format-patch(1)
and then send the resulting patch with git-send-email(1).

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

