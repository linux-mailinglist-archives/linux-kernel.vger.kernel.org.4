Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099945E6FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 00:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiIVWY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 18:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiIVWYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 18:24:05 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0143EDF6B3;
        Thu, 22 Sep 2022 15:22:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id g4so7888150qvo.3;
        Thu, 22 Sep 2022 15:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=saa8hbo25uKBMMnwllcdWtUt/fTmT1MDVrESCvd9sc0=;
        b=m9IYzd96OwCCGbZKlOlHILYET6GEZh8HJ7g1jfrPgeWuB/Zl3zvc9VnSS2nL/z56MF
         vYLMEaeoSno4oWIfY6CYZx1Ld4xTGq9EgMRH31BOUDoD0t6tZwgQ8bVZQqLtwrGufge1
         MppvjwBuvp6mAltIi1PGARevxAMYJGk0mBytrRMUE16+f2gPF96ZnTWJ7rVCMDQcVMJ8
         gutJa/08z3G9fEixvtQgu2MpSAPXVp0vBjpvqwH+nDddtPIvNYxYiyvI5C/2EWh2OOrD
         7puvduluaG2MDY7gSslGHnDUlJ11GfhssZnoTMOOnwcam9o6LwI+tyXJM8EOpgqhy2Tz
         YINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=saa8hbo25uKBMMnwllcdWtUt/fTmT1MDVrESCvd9sc0=;
        b=oe+E46kDRhv3JLf0tmvOLaHyNsMkcQZNK0laxIZ7dN4p5RA2sig3FtR+A2F08Cw43P
         YnVgYh443YhZ13qQAReIb44X9KnlK2Dhu/EXBf1VSYcXJG3pJdWVzHx8vIjr7IE4bRxJ
         vW3JLby60xn2L+iLusvhx4abEGgoWHzKhv1+mnDmmNSXR/8uN+Bjm8YtjAubBBeaWwIq
         BYYSeiUHE3geKapXSnNpMwE39OarknKyQwv0Cw1MRghmFYNkOS+GB4YcZIaQiq/c2MHF
         uWI2dlbWY0eNYqp5PUZS77c7Yf9DfU3Yu6ukNE/d4u6coAlI5YqW+GZaWuEfBOGs6wU0
         qT6Q==
X-Gm-Message-State: ACrzQf2NeJl7vWpqLsHRPL8WT9Ds5s6JRMBeQT1vM2g9VlV0YWNSljG2
        cF2TyVj6HtVtnIAUTYTEErY=
X-Google-Smtp-Source: AMsMyM4AhmVrlNhzspkffG7J1M2X5fjKSA1cZOr6DRvbJTSPZJuCxDQ9YHUwVOL15V3tpUF/YfM3vw==
X-Received: by 2002:a05:6214:2528:b0:4ad:6fa4:4170 with SMTP id gg8-20020a056214252800b004ad6fa44170mr4491105qvb.113.1663885378872;
        Thu, 22 Sep 2022 15:22:58 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m17-20020a05620a291100b006cdd0939ffbsm4738880qkp.86.2022.09.22.15.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 15:22:58 -0700 (PDT)
Message-ID: <87648374-a8fe-8830-793e-eb3c15e4ac54@gmail.com>
Date:   Thu, 22 Sep 2022 15:22:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] scsi: scsi_transport_fc: Adjust struct fc_nl_event flex
 array usage
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Sachin Sant <sachinp@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220921205155.1451649-1-keescook@chromium.org>
From:   James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220921205155.1451649-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/2022 1:51 PM, Kees Cook wrote:
> In order to help the compiler reason about the destination buffer in
> struct fc_nl_event, add a flexible array member for this purpose.
> However, since the header is UAPI, it must not change size or layout, so
> a union is used.
> 
> The allocation size calculations are also corrected (it was potentially
> allocating an extra 8 bytes), and the padding is zeroed to avoid leaking
> kernel heap memory contents.
> 
> Detected at run-time by the recently added memcpy() bounds checking:
> 
>    memcpy: detected field-spanning write (size 8) of single field "&event->event_data" at drivers/scsi/scsi_transport_fc.c:581 (size 4)
> 
> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
> Link: https://lore.kernel.org/linux-next/42404B5E-198B-4FD3-94D6-5E16CF579EF3@linux.ibm.com/
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Kinda crazy way to resolve it, but looks fine.

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


