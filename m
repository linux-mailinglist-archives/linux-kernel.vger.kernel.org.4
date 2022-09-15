Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093E85B9253
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 03:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiIOBsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 21:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiIOBsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 21:48:37 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635178E478;
        Wed, 14 Sep 2022 18:48:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b75so11344944pfb.7;
        Wed, 14 Sep 2022 18:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=jpawstLZ7baQ0n4gMGxZ7TutmdKIlyo5QJi8v2DcoQE=;
        b=Du5scnVL3uaQScrP4EVfUx/mpUtESuVpOjZN5EovEaLg4ZJKvRYlgqa+HoTwgwKpLU
         6JDrFH/x5wOxR+Zu9mRy1IPZOd1xL4lV3RX8chsYpeUEsoZQH6Yqn7ASQpu4JV83FKYW
         nSb1f06sULsnFwLtJXbzPI3EmGaIpGM3Hpw//Tq+EMuRpzuVENLqIHgEnikbAcUVHtfi
         ZkURhdZyEGCVRTLFA/14y7uwih1nuHpTw6Jx4aCMWZ39li1N9W8/qLt59lEIjeqbxfDl
         30Mz2rIkVWx5eOU/AqVSacig+LAKSSwHaTjoEPxEZ5MgY+BC5pMwu7m5WqjBifcrvSFi
         W6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jpawstLZ7baQ0n4gMGxZ7TutmdKIlyo5QJi8v2DcoQE=;
        b=qtc01zToS7Q1WKwEoG1Ay91sHCZ8q07K0CUMRqelBu6+wUL+jMkdlTB3VvqbbkUNPh
         RifPCPo9T37Glb4xZjI+yrGu9P0Win/P/gah7JA9sDvo6rTG8iFCb/QoY6cuO46YUK1H
         Q8RtQfCOPUyLNffau6hPVSbpOm+C1Pl+3Sw8ScaBGkj2gYvsLOStp1IW4Z/WjdeIpZTJ
         rxY+43tTQpPWyyIJFjuKS2RxBpvSM4b5jMuOvK3Ab5Lggw0cOqvfjfWlnjN5wi25LVyh
         wMN+EGPXRD8ays+v03Wd+hy5TIlZIC1kkp/KqPVLCDKCgR/gfrJAyJw6YYg9onqAgsd0
         PkoA==
X-Gm-Message-State: ACgBeo0rsNa/c3J7UhuipylRtHx77orB5HRU8N75eJTdVWEbqroeGIuo
        S5Gj0Z0WSxeXQwqBKtSNpMo=
X-Google-Smtp-Source: AA6agR6D2QFk8tfHYeY2SqVmHyRef4S904Uj/qGkzB+W0/yfNOYsaJeATniZIn5v4yzj+mo52jXPxA==
X-Received: by 2002:a05:6a00:852:b0:544:5907:7520 with SMTP id q18-20020a056a00085200b0054459077520mr15834526pfk.31.1663206515688;
        Wed, 14 Sep 2022 18:48:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-73.three.co.id. [180.214.232.73])
        by smtp.gmail.com with ESMTPSA id 75-20020a62174e000000b0054223a0185asm9471699pfx.161.2022.09.14.18.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 18:48:35 -0700 (PDT)
Message-ID: <1b161a3e-61da-a0ee-f0ce-97e445d275ef@gmail.com>
Date:   Thu, 15 Sep 2022 08:48:30 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RESEND] docs: x86: move do_IRQ to common_interrupt in
 entry_64.rst
Content-Language: en-US
To:     Tuo Cao <91tuocao@gmail.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220913152801.30966-1-91tuocao@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20220913152801.30966-1-91tuocao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/22 22:28, Tuo Cao wrote:
> do_IRQ has been replaced by common_interrupt in commit
> fa5e5c409213 ("x86/entry: Use idtentry for interrupts").
> Move do_IRQ to common_interrupt.
> <snip>...
> -   magically-generated functions that make their way to do_IRQ with
> -   the interrupt number as a parameter.
> +   magically-generated functions that make their way to common_interrupt
> +   with the interrupt number as a parameter.
>  

Above is not moving something; but rather replace mentions to do_IRQ
in the documentation with common_interrupt.

Please rework the patch subject and description.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
