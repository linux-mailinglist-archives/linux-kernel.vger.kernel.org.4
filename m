Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F0A71F335
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjFATwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFATwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:52:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF14C0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:52:08 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so322267a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 12:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685649127; x=1688241127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7DB5CslY4RTslJ0wxKBSVyRAvd6TEsp6LGdNHwa6Dc=;
        b=bnI3uYKh0j3Emc7pF/vIYc4D5CIhjvZpe3qGmWyJ+ZSWP9DyCTlxQ2Mdl6BwK5MxFG
         KfOXEWN1kIaiNfNukWUzL4umaL45baI1jRA/L+j5v6RlW6yaEgm9XsV1PGhkUH91op8J
         Q2Fc909JGXyamRxQbEoh3DdrqEo9+XLB/AAZZgJLiN9RSJ82+eJJQQVXbEHTdhqp6+P3
         y7WRWT1PedCU8lsERyLNvIcwXXmRzTXRPrJ74/gsmkzftBYVcxByVVGMSvusOmbqqZpo
         beqQplFeo09l+oiTxcra4lWk8TLwrcV3pBQYbWKVO5uiCySvmS5itHTiLAuwJCzMu5ju
         ktPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685649127; x=1688241127;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7DB5CslY4RTslJ0wxKBSVyRAvd6TEsp6LGdNHwa6Dc=;
        b=ii8XPxMXqzzUJs+6f5v13Mi+jYFSgUyzy9yEIlqzcMaW9AMb59G/3x3dQwfcCi2C2T
         B3Dj5BB93dynusPoCuqV8SKJqLENX+ah6uPAiaZwrPGdbrwyc1x/NaLfPwgnJMk5yMJp
         dAO8r330uaQ/pymKH8pJfm8Zf/A8Ewd+d1Xx22aA2cLnNS+buBqvIDo86vBB5Oy0xbAj
         6PM1NNbFsvagBXD9gRJ+TRb5P2C2ve5fJf7k+lwGYAzFLBUpKOxJ4JYwOfnEx0oUYdse
         NAc5pNjjNRZrxQodtj/Fs4ugwLUihFZvLK02BXmo8myaygGt0fqquXbq7z9kETrJ+wOm
         L35w==
X-Gm-Message-State: AC+VfDymqdiuk95jGBRXQr+bUBP4zCrG9o4dqRw9RsgoiAGztFDFKz1f
        a4Gl4eDZPFSNkMaSM0nemRo=
X-Google-Smtp-Source: ACHHUZ7fAPZnig5m698Cu+gHvUy/7RIb2kjOm1Yh665aOdluUqFAd2uxKS3L09CfVg4Odk29c4FBoQ==
X-Received: by 2002:a05:6402:3593:b0:514:2dd2:d1b9 with SMTP id y19-20020a056402359300b005142dd2d1b9mr4964865edc.3.1685649127152;
        Thu, 01 Jun 2023 12:52:07 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402015500b00501d73cfc86sm7537325edu.9.2023.06.01.12.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 12:52:06 -0700 (PDT)
Message-ID: <eb13f84f-786c-f00e-4076-19d29e608b17@gmail.com>
Date:   Thu, 1 Jun 2023 21:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: remove blank lines
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230531053118.17053-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230531053118.17053-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/23 07:31, Michael Straube wrote:
> Remove unnecessary blank lines reported by checkpatch.
> 
> Signed-off-by: Michael Straube<straube.linux@gmail.com>
> ---
>   .../staging/rtl8192e/rtl8192e/r8190P_def.h    |  8 ---
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 16 ------
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 20 -------
>   .../staging/rtl8192e/rtl8192e/r8192E_phyreg.h |  4 --
>   drivers/staging/rtl8192e/rtl8192e/rtl_cam.c   |  2 -
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    | 29 -----------
>   drivers/staging/rtl8192e/rtl8192e/rtl_pm.c    |  2 -
>   drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  1 -
>   drivers/staging/rtl8192e/rtl819x_HT.h         |  6 ---
>   drivers/staging/rtl8192e/rtl819x_Qos.h        |  1 -
>   drivers/staging/rtl8192e/rtl819x_TS.h         |  2 -
>   drivers/staging/rtl8192e/rtllib.h             |  3 --
>   drivers/staging/rtl8192e/rtllib_softmac.c     | 52 -------------------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c  | 16 ------
>   14 files changed, 162 deletions(-)

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
