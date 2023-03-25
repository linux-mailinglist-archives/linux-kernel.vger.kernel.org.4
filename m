Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A6D6C9058
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 20:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjCYTFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 15:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjCYTFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 15:05:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280ECDBEE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:05:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h17so4833730wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679771138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fVG1/vTeUPSv0lVRqc/slNoTE0wnNu/kVSAojkvVCso=;
        b=n5CMAAmNFnxhBVPxChS/6p5Xk9rlp/lQAqdjDsqoI1LS0BfevW5kxRRo/gDmsyPxr8
         V+atEXwHAKb3t/D0SKVghwelhUXwz0ZV4pToYDXLof5STCSM8X1Kk2tpy561F+/i5zOr
         eD36tMtaTU1LNqo/if9tNxQSQ0pyETTmlMJ4mTe5MqXZUdqsbag9R3Pu5q3/mKW6+XBm
         cCzPE9gvHUk7dqAdlSIAHwey2CC9yTkHotopqOc8cf43xZrndwDGskupJN4Juo8/lkT9
         Z7taFvKqESFKMafZSAATqWRaSLWrma38AgV72RHyeRmmNC5axgT34Fc63Uk2eNBDLQYu
         vQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679771138;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fVG1/vTeUPSv0lVRqc/slNoTE0wnNu/kVSAojkvVCso=;
        b=6o32+4WXq5zo9XX0R0naGjQ4Dx9uekHePFs388+a2jKs11Xdh8L45QxEcIh4N6lVSM
         m7/DxIG8OLB52kW3B+IIcupzVSS9D0jm8dIK2DBtNmsnZAn12N8bnz6SARDgYso6DDiv
         VbkGzNinFcM0VP1QASJ0wdwsuCNBxeVbeaoLxCQk/GecumA8S4255hm7eyAIBwTB5Q+w
         UsBpnqtRLHmhPf6sVTtFUJG24YZCrcQiiLyo1hUJSP5E9QFBJ6WNXTnP3PN/gKOl4+rx
         HhU3kW9HFV13byRNBABRMigtNc4pfZIP8zq4s8W6ICWHjTke8+JG7XCcBWXFNN/HcGpK
         FFyw==
X-Gm-Message-State: AAQBX9esjQH7QKi6C7w6CsoqNcP0rzYsSrN0N6c052VHmNsNkjSiM0CL
        2Oj1oV6ikeaInfEqRbKeCvU=
X-Google-Smtp-Source: AKy350aNp6hJbEUjWrapJV7T2v1a06DH3rhtArXO2rI85tSpZZK3Ric7a9iwL49VouIFnwXoowLxDQ==
X-Received: by 2002:adf:e552:0:b0:2d3:1c7d:a3a3 with SMTP id z18-20020adfe552000000b002d31c7da3a3mr4294560wrm.7.1679771138530;
        Sat, 25 Mar 2023 12:05:38 -0700 (PDT)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id h6-20020adfe986000000b002d09cba6beasm21357336wrm.72.2023.03.25.12.05.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Mar 2023 12:05:37 -0700 (PDT)
Message-ID: <f9ea8f1b-1b16-c780-a08e-476437331b2c@gmail.com>
Date:   Sat, 25 Mar 2023 20:05:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 0/4] staging: rtl8192e: remove rf_type from r8192_priv
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230325132823.22872-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230325132823.22872-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/23 14:28, Michael Straube wrote:
> This series removes the rf_type field from the r8192_priv structure.
> RF type is always RF_1T2R, so we do not need to store it in an extra
> variable.
> 
> I don't have any hardware to test this, so compile-tested only.
> 
> Michael Straube (4):
>    staging: rtl8192e: remove RTL819X_DEFAULT_RF_TYPE
>    staging: rtl8192e: remove redundant setting of rf_type
>    staging: rtl8192e: priv->rf_type is always RF_1T2R
>    staging: rtl8192e: remove rf_type from struct r8192_priv
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 19 +++-----------
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    |  7 ++----
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |  3 ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 25 +++++++------------
>   4 files changed, 15 insertions(+), 39 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
