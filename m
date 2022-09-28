Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911495EE1BA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbiI1QWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234466AbiI1QWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:22:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798A55B7A4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id sd10so28279545ejc.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lENm89wgwM3xoTs9W6eQDhRaBLFqC31LaQKt70REfBE=;
        b=GmMWpK5UmjBsdIU4aBLdxA63Wi21Vc1fPIntpDiMkUcmBtfzchz2XJg8tAdS40/NTB
         JCrV2vDkdlM3295fXukHnynEK+GqXqRCDJYQiawIXqq7oB2en70LP8curTew0EXknv8k
         Yx49TY7X89yIQXDGyeeyB5EVTxOC1mwZyRgAJJPtIxyl3r3t5owS81dj9J5SPjqMJ9Kl
         3skiEJ4VgGwZOWYc8m1E/c3PitouBrMzJOs10rxZrRjdvG/qmKCNChxpnof5Lv8ZIMsM
         2RqBe2AIkJDPo8kvE7oFfqVljF8cZRqVY2pgkggcHLToQDrRR5osowDThiiOYYuah3VF
         S4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lENm89wgwM3xoTs9W6eQDhRaBLFqC31LaQKt70REfBE=;
        b=B8O0pDhqlXL0ntT9IyQQP7DQb2IfywkGbghZpoRKMewzVAoF8WrldEN115kGdWuPhA
         PmMS2reR+CfjmdqY0GK/dSCn1yzPajf7ufz7/o3VMkTX1hZHrv0SlS01vCUZN/ViYwBt
         1kR8YlgywqDpAzs2VnOmOUXrTvtzE5ZW3TTUqHNVs3mrCslaUp4h5BzuVoAnojGHPvvy
         AIrJEcyZTtoMQ02PfMqOivzIuYfxovwCOvakoSnJm01i4Y0AaUTrqDIH+n6HqxKqjDJ7
         0WQ7/0YgKEeTbyb9BPooF6p0Y2hBo62HIReLF++4urRIVRoCBSq7e0C1RhvZ+qTH7sjU
         mUvw==
X-Gm-Message-State: ACrzQf2gMxVFbtBoDutvStHVdfi1Dx+4DmTdhxLYvwpVA5dxBn6Cw+mH
        Yh5J/mGDTIxAiodvqxC0uQg=
X-Google-Smtp-Source: AMsMyM6QsP6jYd4BfL3Y9iSMEW+zCkpaayFMCoXdCwmvHaqmhT5PJQxjaAdb6EviPWOOI11PuwsVHg==
X-Received: by 2002:a17:907:75f7:b0:77b:4579:2aee with SMTP id jz23-20020a17090775f700b0077b45792aeemr27926657ejc.529.1664382122907;
        Wed, 28 Sep 2022 09:22:02 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id bd28-20020a056402207c00b00456f8a03250sm3660488edb.3.2022.09.28.09.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:22:02 -0700 (PDT)
Message-ID: <66c1e69c-72ee-20e9-6dd5-84c5fa6a3e9f@gmail.com>
Date:   Wed, 28 Sep 2022 18:22:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: remove two wrappers
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220928083641.8275-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220928083641.8275-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 10:36, Michael Straube wrote:
> This series removes two nested wrappers around the function
> phy_RF6052_Config_ParaFile().
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>    staging: r8188eu: remove PHY_RF6052_Config8188E()
>    staging: r8188eu: remove PHY_RFConfig8188E()
> 
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c    |  9 ---------
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c    | 13 +------------
>   drivers/staging/r8188eu/hal/usb_halinit.c        |  2 +-
>   drivers/staging/r8188eu/include/Hal8188EPhyCfg.h |  1 -
>   drivers/staging/r8188eu/include/rtl8188e_rf.h    |  2 +-
>   5 files changed, 3 insertions(+), 24 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
