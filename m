Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D47658F12
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 17:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiL2Qch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 11:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiL2Qc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 11:32:26 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996F711A32
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:32:25 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id m18so46066436eji.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 08:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUcRrqj7KVVFNBxTEMN+gtchFt3l7f47KAVCKCtQJX4=;
        b=V9C1Rce+meqGk+jTLxjCr2AcH6Pg3UnTKtfJ/z2d61mNLw1dVXaJbA2guD7+ytxM/Z
         MdPWJJ1SXBOrYYuyeUkSfwq8WMbi/tkBrOJgHrHACj4BgKagdZmexxCX8NpG9A0TeDCC
         QuvUCueN6PxTP8/8Tf+b8T4xM1L5B/vPaqo38n+X7vjH9KjiUNzf+hOQA7x8lakz/kgP
         t6LlEznUiZQQUKq5AiilscXFvICLO1PugpBMFxDkbA+yhkTPuXQi8abRbTyOJtCZ1lm6
         W291cOrdXKyxMyI9qfmyXEY4OMnIxo1LRU8e7+JzZ5vOonkwbjkGt3U1Qx9ALM+crmwu
         HpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUcRrqj7KVVFNBxTEMN+gtchFt3l7f47KAVCKCtQJX4=;
        b=LopeEH07/wpbhWZ2fojUip7kX+4x7ZVNfzw/zSp6oOG5k8o1e+Qq4jVk02O1UjvIEa
         wL3d6p2N/h47gyfGOJNKMEsu51/Zrb9ltrg58vF1+ouVIoCKOrboiMhg2Mn2ApXHuSzZ
         JUXUCny3YnHOWK4i30eqRQUq0TTIIITlwzvrosYBA4jCUg3MrCrgUIDs9pU4AGHP1DDc
         jipylFKHfMp2EFElvGtgGl50YORVtrfxmSAeLbOBpzYZUEnLq08e9GT/epSjvbj8DolR
         mEqbiAfN1vu291xGTJ+FV0fx0ZBbplScnY3hTa72g1KcsGfXVgffFdSI+wCR0xVWr2+C
         Y9Zw==
X-Gm-Message-State: AFqh2krGKvR0C3SN5XSzHaTEIEq1ZOc5qv3RBNXMU7icGtDjUAl/zfct
        5MoYEd9lJ8uCFW+940XTGEE=
X-Google-Smtp-Source: AMrXdXtR5Lh3briAqybdca5viWLw7hYZ3/jLgEtA5lRgRnOGkfQBXcogBBqSpFwa5brOCKLiN0mgtQ==
X-Received: by 2002:a17:907:3f8d:b0:7b9:62ab:dc3d with SMTP id hr13-20020a1709073f8d00b007b962abdc3dmr6922779ejc.1.1672331544220;
        Thu, 29 Dec 2022 08:32:24 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b0084c70c187e8sm3275793ejh.165.2022.12.29.08.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 08:32:23 -0800 (PST)
Message-ID: <4a1642a0-35a8-c978-8016-94d9235a37d6@gmail.com>
Date:   Thu, 29 Dec 2022 17:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/7] staging: rtl8192e: Rename variables from r8192_priv
 start with ChannelPlan
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1672330343.git.philipp.g.hortmann@gmail.com>
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

On 12/29/22 17:25, Philipp Hortmann wrote:
> Rename variables to avoid CamelCase which is not accepted by checkpatch.
> 
> Philipp Hortmann (7):
>    staging: rtl8192e: Rename ChannelPlan, eeprom_ChannelPlan and CckPwEnl
>    staging: rtl8192e: Rename TSSI_13dBm, Pwr_Track and NumTotalRFPath
>    staging: rtl8192e: Rename CCKPresentAtt...
>    staging: rtl8192e: Rename TxPowerLevelCCK...
>    staging: rtl8192e: Rename TxPowerLevelOFDM24G...
>    staging: rtl8192e: Rename MCSTxPowerL.., LegacyHTTxPowe.. and
>      AntennaTx..
>    staging: rtl8192e: Rename SetRFPowerSta.., RfReg0Value and
>      bTXPowerDa..
> 
>   .../rtl8192e/rtl8192e/r8190P_rtl8256.c        |  14 +--
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  78 +++++++-------
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 100 +++++++++---------
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  10 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  42 ++++----
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  30 +++---
>   6 files changed, 137 insertions(+), 137 deletions(-)
> 

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Bye Philipp
