Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96726238B2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232217AbiKJBMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiKJBMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:12:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B070322B06
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:12:07 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id q21so221794iod.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRttdnBGDRc8zkuTurK+53sAbJg4J4HZIc55dFQ5x3I=;
        b=bsSsaPYXbJ97VEFpT/xHPuJy5kbXi5DQ1kKtYYIsL6lSUtsM/boQmlhCm3gV91mijB
         OBrQEDGphLBcLWNjs5JjibfMc/qsG7kVtak4TcgsNO+qHFy3iD3JZIA9sxqcgOFCbFFm
         rBJ3zTOGT7vdI0MJbOEdjIHfD0VfqlFhui4jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRttdnBGDRc8zkuTurK+53sAbJg4J4HZIc55dFQ5x3I=;
        b=A7wyF+nrL9m6EbEx+eD8mRBbL4s7MGpP7zyVO3pJUwleDLpkWFDR1w6Xl//WxbC5cW
         cFrQ+4MlyI7aZyCdHqntgI6oix1WsKvUXXkZw0QQflKqp3GxSeN+o0ipcWU8n7XxVnfO
         rEM7IH6YhndgGWSlqDH7nIs62t9QlVFI/oEqsWQ6uwwoMyfF9dfpuaSXPBG5aBfL4tI2
         hhv89lUDhAgW9yEriWIfnq2md3xzhMVLOLOedzEfm5rRGko5ht37ucFRBiRJljTJiMSB
         vHAef0e3Gj9sofXE3snKvtt8RF5RM/eliFNaz8GMgnZO/ArVQaXy5yMPlkk38Ebuv2HZ
         hEEA==
X-Gm-Message-State: ACrzQf2m0rVYB+ZI6CK8NGHNyIDs58m0pv9Enf6D3UkntRVq+z1EfJUQ
        4PAKLh/jF898HuMZabGNC7rUIg==
X-Google-Smtp-Source: AMsMyM7BpwHMtKvGDw4KrXYY8bvFA5l/C+UxDe7zSUHzHLkY/2f2geG+qqOP0AJJnQeIIXAS4aWc2A==
X-Received: by 2002:a05:6638:12c1:b0:342:a36a:b2b1 with SMTP id v1-20020a05663812c100b00342a36ab2b1mr36265428jas.275.1668042727063;
        Wed, 09 Nov 2022 17:12:07 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a65-20020a029447000000b003633748c95dsm5412250jai.163.2022.11.09.17.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 17:12:05 -0800 (PST)
Message-ID: <84bf1608-dcb3-aae1-fe56-f2472c2d47a8@linuxfoundation.org>
Date:   Wed, 9 Nov 2022 18:12:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 2/2] selftests: proc: Mark proc-pid-vm as x86_64 only
Content-Language: en-US
To:     Punit Agrawal <punit.agrawal@bytedance.com>,
        akpm@linux-foundation.org, shuah@kernel.org
Cc:     adobriyan@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
 <20221109221104.1797802-2-punit.agrawal@bytedance.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221109221104.1797802-2-punit.agrawal@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 15:11, Punit Agrawal wrote:
> The proc-pid-vm test does not have support for architectures other
> than x86_64. Mark it as such in the Makefile and in the process remove
> the special casing in the test itself.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> ---
>   tools/testing/selftests/proc/Makefile      | 2 +-
>   tools/testing/selftests/proc/proc-pid-vm.c | 9 ---------
>   2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
> index 743aaa0cdd52..db953c014bf8 100644
> --- a/tools/testing/selftests/proc/Makefile
> +++ b/tools/testing/selftests/proc/Makefile
> @@ -11,7 +11,6 @@ TEST_GEN_PROGS += fd-001-lookup
>   TEST_GEN_PROGS += fd-002-posix-eq
>   TEST_GEN_PROGS += fd-003-kthread
>   TEST_GEN_PROGS += proc-loadavg-001
> -TEST_GEN_PROGS += proc-pid-vm
>   TEST_GEN_PROGS += proc-self-map-files-001
>   TEST_GEN_PROGS += proc-self-map-files-002
>   TEST_GEN_PROGS += proc-self-syscall
> @@ -29,6 +28,7 @@ TEST_GEN_PROGS += proc-multiple-procfs
>   TEST_GEN_PROGS += proc-fsconfig-hidepid
>   
>   TEST_GEN_PROGS_x86_64 += proc-empty-vm
> +TEST_GEN_PROGS_x86_64 += proc-pid-vm

Same comment as before. Add proc-pid-vm conditionally to
TEST_GEN_PROGS

thanks,
-- Shuah
