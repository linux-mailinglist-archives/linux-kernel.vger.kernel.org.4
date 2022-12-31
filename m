Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10065A368
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiLaJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLaJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:47:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4CED134
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:47:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id b88so26176622edf.6
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=plEdaQxR9/jUxUlAIgvL39mp2hZz/cwgZyXALQHHQ4Q=;
        b=McFa2D7g/fz/V8mvgrBMrQQt0pMv0nbHvzqhdcZmeOSAVtkunCDk5uWB7+tKAC9M1r
         Wu6p7A7/91AUV4HGWIfcpsF2egBeieXLe8spBNywCmNhYDKVL+AYv/dsQ6FvC87AY6Qb
         m41vUB8PGtLSdzcqoG/qSD3Z/mH4nyf+6+fHC6QTyDeKjGI+qYsMNQroUm/KROpgelBx
         8fLBxwSCY7/hSP5mFsN6p+fJqKrOCLw7+5FBd4Fy4DpCF0SuIIZFAuFM0iTSmQW7biCT
         xZDevV/dT+N65UWNlUjszNzdK5jg6wKB6t474i+tLkrO4l70QAhbXJEDPNMSz2HhO82z
         G4QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plEdaQxR9/jUxUlAIgvL39mp2hZz/cwgZyXALQHHQ4Q=;
        b=I5xP6LF96BsGc0K/fE5NUJj0g0RviIkjeW8ezvdP+z/NJQ2gH7/UNgGpKbSeZ0CJjL
         ZJeJhfog/HCBD86cEgbtVZlTAabkA/tDRuYVS+/CnhVbHQ9s0evIWNt2SIRuyd65wIIS
         khBM6Oi6S18NO3wNOvqA1r+QqNLI42b6BU6lHtWtsW5ToQlytK+IwhcQemqrAFTNafC3
         RNTOKiPyQCBjpSzpGwaJQAZwy26rkIVI8nlf91Iah2Eo2MwrUzK+FqI1/vp0TwPalpJ8
         EPiYYcv9nBVMlDj2S80YJE37qGjRoYLztK++BtR6rp7mdI0/A/+2o13bN8qFC6NFckYW
         tOGA==
X-Gm-Message-State: AFqh2kqFj6AAqTCvjsVQBpVVGUqVaBUBfHUoFb+NpLu1VA6NcBLV2As3
        Ep0Bx8h1kDRLkEbneZppWz+NuJvsPNk=
X-Google-Smtp-Source: AMrXdXvfNJ1lzNauSvA/MLbOCVr94kRClNUX0OvfkORekBYxaPyzqq5k6Jo2KOHWzo5SGFC67lVc6g==
X-Received: by 2002:a50:85c6:0:b0:46f:e329:8dac with SMTP id q6-20020a5085c6000000b0046fe3298dacmr6950762edh.0.1672480066834;
        Sat, 31 Dec 2022 01:47:46 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id s22-20020aa7cb16000000b00457b5ba968csm10212949edt.27.2022.12.31.01.47.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Dec 2022 01:47:46 -0800 (PST)
Message-ID: <472dc3a0-d6a8-a084-620a-e63c99182f64@gmail.com>
Date:   Sat, 31 Dec 2022 10:47:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] staging: r8188eu: merge public action functions
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221230175326.90617-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221230175326.90617-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/30/22 18:53, Martin Kaiser wrote:
> Merge the small helper functions that handle public action frames.
> 
> Martin Kaiser (4):
>    staging: r8188eu: merge on_action_public_vendor into its caller
>    staging: r8188eu: merge on_action_public_default into its only caller
>    staging: r8188eu: remove intermediate pframe pointer
>    staging: r8188eu: remove intermediate token variable
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c | 31 +++++----------------
>   1 file changed, 7 insertions(+), 24 deletions(-)
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
