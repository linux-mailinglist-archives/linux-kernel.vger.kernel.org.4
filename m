Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B127419DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjF1UrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjF1UrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:47:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C5A2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:47:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-98dfd15aae1so6142566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687985232; x=1690577232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvhvp++Fmkno+9Wkxssy9/RZIvwRvbSrouh/UrjrNS0=;
        b=Q+wWNqK1i8blrA2COVOU9mkWoZXQ8R39jB3tiQ/ojlnaVE1lHg11CJgiYqSvppEjFi
         W6bFHpqarB8kSdofMJpg/Yd0+vWnShUGlss3SIOMyN6QE2HERPpE2j25zfLxmW1VijML
         tufK8uCem+HSNxkOvboxHGQDYPNm/6WnVPv9VaWZ0V6zOWYH14ILU7Rpl3BN1VxuYprW
         8RKzqK2R8Ipt3ocXC7zG7wnZhcwG0tRCQCw+GUoQXX1FYugYK+ocDENvWPB2ri44Uw1c
         dlad2ZmVloulVUrnDLudzjVTTm/PBvF93jmFqp6Y6B80sNAyW0x9KrA1wTFjXgi2HefX
         oo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687985232; x=1690577232;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvhvp++Fmkno+9Wkxssy9/RZIvwRvbSrouh/UrjrNS0=;
        b=SqaBCOzsZqcC4TMgcRcpj/Om0BibCv8XMx6Bd0GYi+XkKSKZV+RZkZvALv3X+dzvt+
         u8N0z22yZ0xCCj5BRq58A3xotIyQMIZ6m+gNHQfR4aKCfITXL5IJdOWtENJUKkNlWTpx
         A+Lqm1wI3SLn3IdTpaTPy3thphsEinPK5zmnyoB//9MkEM+0rlEnzgMBPKSY/9xo3SY8
         q+dfC5SHHWOM+f4umHPhIckiyyA8bPxT4GN8uXhxWqkpi+ym323Rk9V1DFCyzsydN8cU
         wMJOH6xpOcaZ5s0rTcuJO7ou6jWBR0bZxLvgsp/f9/OsqugJt8hwT9aXUwr0rz4k4obX
         AhpA==
X-Gm-Message-State: AC+VfDy/l9YBgHtnr1Thm907NxcJyu9ezibVFGrsDCS7GRDC8JcfrNCS
        llV0ldgDIMTZmLfitgyr8lk=
X-Google-Smtp-Source: ACHHUZ5H/7pjTQI3ejfHhGJqIbm+0QAe0YmuknMuDAvqDeFeKsFYxqQcqGAseUMHnHn58q7PxEa0OA==
X-Received: by 2002:a17:906:729e:b0:988:c8bb:e3ac with SMTP id b30-20020a170906729e00b00988c8bbe3acmr21097955ejl.7.1687985232347;
        Wed, 28 Jun 2023 13:47:12 -0700 (PDT)
Received: from [192.168.0.101] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id b6-20020a1709064d4600b00988c6ac6b86sm6030668ejv.186.2023.06.28.13.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 13:47:11 -0700 (PDT)
Message-ID: <e6e3f64e-9df8-cafe-9a83-42f3bbb14962@gmail.com>
Date:   Wed, 28 Jun 2023 22:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] staging: rtl8192e: Rename function IsHTHalfNmodeAPs to
 is_ht_half_nmode_aps
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <ZJp93mCd9ogrGZbx@tacos.darkphysics>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZJp93mCd9ogrGZbx@tacos.darkphysics>
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

On 6/27/23 08:12, Tree Davies wrote:
> Rename function IsHTHalfNmodeAPs to is_ht_half_nmode_aps in order to
> fix checkpatch warning: Avoid CamelCase
> 
> Signed-off-by: Tree Davies <tdavies@darkphysics.net>
> ---
> v3: Fix email parch as v2 info was placed above the ---
> v2: Rename is_ht_half_nmode_a_ps -> is_ht_half_nmode_aps
>   drivers/staging/rtl8192e/rtl819x_HTProc.c | 2 +-
>   drivers/staging/rtl8192e/rtllib.h         | 2 +-
>   drivers/staging/rtl8192e/rtllib_softmac.c | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
