Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAD6099DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 07:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJXFdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 01:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJXFdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 01:33:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575B07B7A3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:13 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e18so27123740edj.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 22:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtHptBjk8kIZkL1NlEJYM02aKu6ZiaEAAGqFry1nchk=;
        b=oC+rgEmDJBLhp+V+/+qfAVduz4E5q6S4Rt1lRj6dHhDPMEdloeP1OJaL/XqJmpTIqK
         lOP2B8UK6DdzGHo5ST/WGJ6MnOiuIpHhZjq2mutun7fNEAouMVMDwXJyIJ3ggDX8lkSL
         AkqXxo3D9DfH6QN/CQWVbG9inCsgJBWopDlNqqvAIZ/PDKsOjE5C/mt2Sk/UXBoT0egs
         g6YdEZ9bDzuitkcmSuKjDjhTod2IlYAoQ7F8LzOCO9iIK7iLhFXQju8OcbbP+lktVaye
         fP5FQ8JUJJotyYjn13btYvB6irLACYvYga9UqYY1IUVPcJL/fA5KJjXlvbNI2Xk2RV7e
         pS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtHptBjk8kIZkL1NlEJYM02aKu6ZiaEAAGqFry1nchk=;
        b=5agDwqzmoxHti1vZlQMDmFxaKD3M+wbWmt0QBLwgHoN7CgfdNR0nFZ0dkB9jFuop51
         yXPNw51kEC09l6NSm8KMfvvthL/OsdFbdFnUZPheNg/VAMx21MsSEqEaUM/I6z42dnXg
         fHn5k4zv3WKJKJQNl3idTTZic87IHVfu4LrVpE/mSRFFRVEmKUGWke5J0clDmkh1X8oj
         2ZIH6Yqg//TOONYiryG57zdc4ywzBl9oe++EQAnExmx4vUUIH5m5RB9ej9fYVwAj09Ux
         EYu9ZZyYKt5Yc0aNfa8uYCgntzMasIPxjdJgV7wXm69pdlN/QbDkRiH1Jn1FqiASNV2w
         wsmg==
X-Gm-Message-State: ACrzQf0DGS0E6otaCajkTj2R4bySlSoVu7BdejoQpjVoFgdc74IgC/DW
        KiyVCKm0gmmaNMG+qtRmFGZjPQhjdv8=
X-Google-Smtp-Source: AMsMyM6lbF5HanzI2YWSqPBNqKtOsiOk93FPMQoTSH07lG6y3jDPjd8TwYh2BtydZGExNoWDpG32BQ==
X-Received: by 2002:a05:6402:5cd:b0:446:5965:f4af with SMTP id n13-20020a05640205cd00b004465965f4afmr28787999edx.12.1666589591868;
        Sun, 23 Oct 2022 22:33:11 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id r27-20020a056402035b00b00459012e5145sm17895410edw.70.2022.10.23.22.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 22:33:11 -0700 (PDT)
Message-ID: <91249bf7-1cab-dcde-1736-e536159b5e91@gmail.com>
Date:   Mon, 24 Oct 2022 07:33:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] staging: r8188eu: cleaning up unused variable
Content-Language: en-US
To:     Kang Minchul <tegongkang@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221023200532.259276-1-tegongkang@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221023200532.259276-1-tegongkang@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/22 22:05, Kang Minchul wrote:
> This patch series cleans up unused variables in r8188eu
> causing coccicheck warnings.
> 
> Kang Minchul (4):
>    staging: r8188eu: remove unnecessary variable in ioctl_linux
>    staging: r8188eu: remove unnecessary variable in rtw_recv
>    staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
>    staging: r8188eu: remove unnecessary variable in rtw_ap
> 
>   drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
>   drivers/staging/r8188eu/core/rtw_recv.c      | 3 +--
>   drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
>   4 files changed, 5 insertions(+), 10 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
