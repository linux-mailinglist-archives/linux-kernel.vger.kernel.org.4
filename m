Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525085EFEA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiI2Uam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiI2Uaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:30:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD16109605
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:30:38 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x92so3460668ede.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=H9rd+oTv5GMGM1TPz7tjk3H33t9w0+zXf4MssGv+aVY=;
        b=VGnB3aMFioBJTem01NR0YOvnGZlaiJTWAN8LUYpK5bFMUzeSgFrCzcx3EOwrKgT/kP
         ckNmPuYiiUKi48Iyhz/GWYBeZtYGcW9Ho26wPxj9zpIBnPDlgIknxo0eSxpMIy8HBctY
         wUWAbpJvRN/SnRG1ROO1SkbobnjlNftpCWcc1U6EtsaglrTNVd7v777H82EaDSpgFFAj
         lSZE888tSozQ5tOFag6vKCTKBqapyDEwz/HDZQRIt5+Ln3lpiArmYfM2e1q+uX/02vih
         JA3RHNqfnzH8NdLqmN2m39wEaIgQpXemobkL/jVsGlucTcN45mF9tzwMeUOBArkxCsXL
         ujYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=H9rd+oTv5GMGM1TPz7tjk3H33t9w0+zXf4MssGv+aVY=;
        b=qjueBdnURmfuKPTltMXPTzU0QQhD7gTONopWSychjjds12pp6hfhnn+hX7QrzdR4sf
         WQNH5uL3RBLaI1W0pLZ/lhJnBXeaDutBwhkCTpj5rqlJlrLkB9BiGgP/VAWd7gAVYHAL
         KXKdj4hJmQ8ANoByfJ49dm7YGEgJF/C1/eSSL5JYB+xMcJ48iu4S95v35D7dzvyi+/Jn
         o9R3PsFzSoPA2v6rGbw7gNZp2IQfLlLHqnJT8jt9WDR5pKmTOQGlILAJOVDhJYR2+y6v
         P3PzhS9i81tkY54FG2FGusMdIxVr/u2h0AI+asCSM4isv/teKB60UJaiSZDOHXVVJtzV
         O6dg==
X-Gm-Message-State: ACrzQf0vJG7qUobt5wqsJvHweh2sapLy8S1GYz3oGGlh2vbJMYNoBstJ
        4RH9rGfx7rBkxQEuS/4hB4/BRT3fU40=
X-Google-Smtp-Source: AMsMyM7YwaXyZCkAhDZChQE/PSwo0ArkF5UT2AlZFOB9epXTAvHenejXFnNRqxOP5f8q3W1LyzCGvg==
X-Received: by 2002:a05:6402:14c3:b0:457:faf8:1880 with SMTP id f3-20020a05640214c300b00457faf81880mr4755317edx.118.1664483437110;
        Thu, 29 Sep 2022 13:30:37 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906355000b0078015cebd8csm71864eja.117.2022.09.29.13.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 13:30:36 -0700 (PDT)
Message-ID: <c6a4363f-efa5-febe-a38c-c172019c1903@gmail.com>
Date:   Thu, 29 Sep 2022 22:30:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/4] staging: vt6655: Implement allocation failure
 handling
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, dan.carpenter@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1664384503.git.namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1664384503.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 19:21, Nam Cao wrote:
> This driver does not handle allocation failure when receiving data very
> well. This patchset implements better handling in the case of allocation
> failure.
> 
> Also do some necessary clean-up to implement this.
> 
> v2:
>    - squash 3 commits that were doing a single thing
>    - add new commit which removes a redundant assignment
>    - take device_init_rx_desc() out of unnecessary else condition.
>    - remove return statement at the end of void function
>    - add a missing rd = rd->next statement in device_rx_srv(): because
>      we already drop the current buffer, we should move on to the next
>      buffer in the ring where new data will be written to.
> 
> Nam Cao (4):
>    staging: vt6655: remove redundant if condition
>    staging: vt6655: change vnt_receive_frame return type to void
>    staging: vt6655: remove redundant assignment
>    staging: vt6655: implement allocation failure handling
> 
>   drivers/staging/vt6655/device_main.c | 40 +++++++++++++++++-----------
>   drivers/staging/vt6655/dpc.c         |  8 +++---
>   drivers/staging/vt6655/dpc.h         |  2 +-
>   3 files changed, 28 insertions(+), 22 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
