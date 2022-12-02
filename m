Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1B9640FC9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 22:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbiLBVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 16:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234410AbiLBVHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 16:07:22 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE3CEAB51
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 13:07:19 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id td2so14258458ejc.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 13:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEh4M8JHePZNHK/0YUY232n5+7zr7GGL4e0QmQT5TpA=;
        b=kf5Ar+cTkU3HPMXa8IylNRTsy0ocxNGSu2AEO/1awYW8lrnSTFQqOsvbRD6DKCKUkR
         aNzlfrnr+V3OECOCi7BmEwHKEPW+d3NIkkrR2TgXDq+d0oNeL9KGk1jP6mBs01kzIf68
         V90sNjb1HL+5RnEC1LReHGTX5xtdoSCgQQAxvc+V01vihGRKiu4c0ssOKvsSPEgQkt6X
         txAyJIH4+gUtyS5Z0XTNd8Fbv5YDl25FOcN9QP6DDq6bXG2PAGVcSSTQPt2a7zdh7U+b
         AxP59YBUmuEeyssqXWxGyFnvayZps6mdHxhmjEl2D0OKpKLTZOScN4qt4Qto/GPvfWpa
         em0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hEh4M8JHePZNHK/0YUY232n5+7zr7GGL4e0QmQT5TpA=;
        b=aX1u4bSE1HUz5bd8K2D5EUtrqkYGaapNbG5dSYLw4yI+JqyOUbD3LagwYwJxbBZH5T
         vSyyx/CY/hg99lsRgrtHgJwHygvNDIAaVfEVDxjACtjgba5UF/M8WzlHDqXPSwFhcKVz
         vH/gaA6myEHRVEHA/MN4GFRn29gYCoKtOWii5cKqiG6M4yNTq/zoDvtFyP0XgCa4oLwg
         pzBSwRNIyvnHKfC0UppwYU0GePxpc3mfnuco9HTof0i/6NhdBk/tmnLma8OUQROg8EyY
         zxBsX9oMMu3ji0na2jv49LN1Tbhxri8W+qdpjWltMsuR9MHPQ8zay5tOpt0WljV+nb/j
         39GA==
X-Gm-Message-State: ANoB5pmB2L6XYYEhgiGs4HVbVo9XPk4IbJyIMXKjvOL3a1LrDwNK8B7F
        Mum6TvEqudIye5W808iDd4A=
X-Google-Smtp-Source: AA0mqf4n6Nm+faLQOpzCo048LVTN3CKUERvfKJ8kn3FfCsPE3ayIIA5C7x/ZDD6nRFzYxttvg/aoCA==
X-Received: by 2002:a17:907:cf92:b0:7bf:7a65:b242 with SMTP id ux18-20020a170907cf9200b007bf7a65b242mr22207251ejc.356.1670015238405;
        Fri, 02 Dec 2022 13:07:18 -0800 (PST)
Received: from [192.168.1.101] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id u10-20020a170906c40a00b007c0cd272a06sm749375ejz.225.2022.12.02.13.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 13:07:17 -0800 (PST)
Message-ID: <c702b54a-51e9-9e95-8858-a5b957ded8da@gmail.com>
Date:   Fri, 2 Dec 2022 22:07:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] staging: r8188eu: use ieee80211 helpers for subtype
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221202093159.404111-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221202093159.404111-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 10:31, Martin Kaiser wrote:
> Use the ieee80211 helper functions in some places where the frame subtype
> is checked.
> 
> Martin Kaiser (2):
>    staging: r8188eu: use subtype helpers in collect_bss_info
>    staging: r8188eu: use subtype helper in rtw_check_bcn_info
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 26 +++++++++-----------
>   drivers/staging/r8188eu/core/rtw_wlan_util.c |  7 +++---
>   2 files changed, 14 insertions(+), 19 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
