Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248885F2228
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 10:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJBI7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 04:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 04:59:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E6729817
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 01:59:17 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id s2so393729edd.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 01:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=uVu0SvdloXokDRTN006ycde9T0CVjOI7b8JYiukwlsM=;
        b=NVVzoCvK7tW4W0iqLO3s7uc8Mf/czS+Ipe8F1aqxk7jXXcJ7SBRt/OGU9xfhrtRCXv
         aPB6epmYJielpX9Bi+h2wDYL/UlQnJQJisiWRC89iw9A/3Fq3MY1WnOI+SvbUISKc+a3
         hUm4UP49xEIhUAyAQ1FXggui9a84o/kvu0stGiytHGym7gRO9dNEWh3tH3OTb3k1diBf
         +cLyK+kdEbrqnD9gAnx9cLUE1rw8AYyA50X/C0f1SW42A4LIwe72M0+59nxk4fRB87vp
         OxVogXxpNq/74CqBYalixwhBW/8SWqmXXk/SGbYGwlMKw8t43ce7D95jy+Uv//DWUbPW
         w8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=uVu0SvdloXokDRTN006ycde9T0CVjOI7b8JYiukwlsM=;
        b=WKDuVioSM46i8qeOdkaFM0nKTOzTY9vHTyJXrAkf+nFzquIQTnHmXa4ISUOkZXx5b/
         JeJhv6fG89mvO6b13ADvIo6p5rk/aBLlZ/F3Fx/EF8F0GforQ2lQO5PzMaGOIHLjizVs
         NnZB85AWASu4wm8h/Hyku4w5VipooLQ/8mEZx4msRE/Ev2t0JJg9rhnoUkYH8+VYPmw8
         Fcbpeyt4ywd5KvInUBnfejWQZFsetV4TmsngcvRRTyIzIedZ3kyh+bOXiSewQg4KNB95
         mPcRS8+RcvxX0pnLEsCbAD/biQQN+dNOppeSw0q7DkwAwr05hNXl0OHMUYK0BjMb0Cqz
         2XkQ==
X-Gm-Message-State: ACrzQf3ytG1veC79gGifIHalk58bcIKexzI7cZT+wQ+s9cpX3gK9JRDZ
        UCTKIzbThXGYs+whM99qI7s=
X-Google-Smtp-Source: AMsMyM6Q725JSWV2qqiSDrNxPMcuR7pPZkXxQTyg4CVtFlRiHibRyt/1R6KkgtmR0QnmIzMEp0704w==
X-Received: by 2002:a50:9991:0:b0:458:a612:bf5a with SMTP id m17-20020a509991000000b00458a612bf5amr6286995edb.22.1664701156414;
        Sun, 02 Oct 2022 01:59:16 -0700 (PDT)
Received: from ?IPV6:2003:c7:8f3e:6a95:e9c7:da34:4bcf:58e7? (p200300c78f3e6a95e9c7da344bcf58e7.dip0.t-ipconnect.de. [2003:c7:8f3e:6a95:e9c7:da34:4bcf:58e7])
        by smtp.gmail.com with ESMTPSA id c24-20020aa7c758000000b00443d657d8a4sm4926486eds.61.2022.10.02.01.59.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 01:59:16 -0700 (PDT)
Message-ID: <3d4a383b-8029-90e3-867b-c91a19345263@gmail.com>
Date:   Sun, 2 Oct 2022 10:59:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/5] staging: r8188eu: some cleanups
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221002074827.8566-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221002074827.8566-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 09:48, Michael Straube wrote:
> The first patch of this series merges leftover macros in odm_types.h
> into appropriate other headers and removes odm_types.h.
> 
> The other patches convert some functions away from returning _FAIL /
> _SUCCESS.
> 
> Note: Converting _rtw_init_xmit_priv() and _rtw_init_recv_priv() away
> from _FAIL / _SUCCESS is a bit more complicated. I am going to do that
> in follow up patches.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (5):
>    staging: r8188eu: merge odm_types.h into other headers
>    staging: r8188eu: convert rtw_init_evt_priv() to common error logic
>    staging: r8188eu: convert rtw_init_cmd_priv() to common error logic
>    staging: r8188eu: convert rtw_init_mlme_priv() to common error logic
>    staging: r8188eu: convert _rtw_init_sta_priv() to common error logic
> 
>   drivers/staging/r8188eu/core/rtw_cmd.c         | 16 +++++++---------
>   drivers/staging/r8188eu/core/rtw_mlme.c        | 12 ++++--------
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c     |  6 +++---
>   drivers/staging/r8188eu/include/odm.h          |  3 ++-
>   drivers/staging/r8188eu/include/odm_RTL8188E.h |  7 +++++++
>   drivers/staging/r8188eu/include/odm_types.h    | 16 ----------------
>   drivers/staging/r8188eu/include/rtl8188e_hal.h |  1 -
>   drivers/staging/r8188eu/include/rtw_cmd.h      |  4 ++--
>   drivers/staging/r8188eu/include/sta_info.h     |  2 +-
>   drivers/staging/r8188eu/os_dep/os_intfs.c      |  8 ++++----
>   10 files changed, 30 insertions(+), 45 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/odm_types.h
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
