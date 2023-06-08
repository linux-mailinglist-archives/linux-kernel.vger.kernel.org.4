Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FD8727BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjFHJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFHJwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:52:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEE1E62
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:52:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5149aafef44so579014a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686217957; x=1688809957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t5znM0Sg3qBPgK9r8lu4Yq3qyvTtElPPD1tqhDg87gc=;
        b=j076dw8fP3wXOv9e2WqEpY2QF6SYNUbvo0gkiOWPZUiOkR1i/ulZgw17MjkbeC4Aud
         TfXVP9l6U9lyejmaL7Vh6cfct69KOealR5fXpZXiVo/6ecrSOGzn1E85Dz5MmkwNS1w/
         eUmDqxUwffEvCcOeGO0IFa+nMH1KRdeAORXLTfpE/DbZY29Go2Z0IiWbFTRA+5kW+tml
         BvoW84h+bbzuLcBn3ug65kfEP+5yA8wvlYPjiigLwJUNwTufnkW7VVPQhfc4LFmeKLQI
         KUjZIjgrQJ0YN2ewvd3/1AShNnG2JYr6o1H219NpulZLaNCctjh0pjTCoUb+5PSKDXf0
         zYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686217957; x=1688809957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t5znM0Sg3qBPgK9r8lu4Yq3qyvTtElPPD1tqhDg87gc=;
        b=POGFGhelIDKs6qLp6QkCRGy8IzyA02VZjdgFReNuLdm4KqemI8MKt/kfAkG9h4L4PL
         n+Cd2hgVrpD2NdoZMcroy6zJR8MG8wHTO5NDp4B4KLVR/yOXeHEXTEXoQX4FMeBDDAQK
         vTgAyKmV6+pRbDwXkcEZsuk+1q+CB2GX3Qp7ABMDM9TM1psIvi299mjOMwz/1PtFKDZW
         tbeg5rORQ6tfrVlqUMz4r/rYl3NSryvyvBQrGSOKImpUtLGaabAyg9t/zow8+eQGRp4v
         4vqbns/eu5WMq9TP/II26xJ/toh4oOaem0yEB1fUjGm1i5/CpoCYi5pl1JSvW8Qb7XVb
         FKUQ==
X-Gm-Message-State: AC+VfDzoqLGevTUGLUapfTfHcsn00BgUBfxg4/vGoAD2iP5tBIuX3Yjb
        eQXoqFAW5QayIsHdVq8YEvpAkgMHa8o=
X-Google-Smtp-Source: ACHHUZ5kfjub+ODMLrmnC7fqYqQvwSWogzCc70iAF1ZGg4x76S0iHFl43/CsnTN+lnSqEFz78H92Vg==
X-Received: by 2002:a17:906:6a0b:b0:970:1b2d:45bf with SMTP id qw11-20020a1709066a0b00b009701b2d45bfmr10195784ejc.61.1686217956868;
        Thu, 08 Jun 2023 02:52:36 -0700 (PDT)
Received: from [192.168.50.244] (83.8.122.24.ipv4.supernova.orange.pl. [83.8.122.24])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906370d00b00977d0f1c5bcsm465087ejc.69.2023.06.08.02.52.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:52:36 -0700 (PDT)
Message-ID: <f8b532eb-5233-f7a1-9e36-7f762208e903@gmail.com>
Date:   Thu, 8 Jun 2023 11:52:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] drm/panel: s6d7aa0: remove the unneeded variable in
 s6d7aa0_lock
To:     Andi Shyti <andi.shyti@linux.intel.com>,
        Wang Jianzheng <wangjianzheng@vivo.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
References: <20230608033446.18412-1-wangjianzheng@vivo.com>
 <ZIGhBvFlHwVmKJG4@ashyti-mobl2.lan>
Content-Language: en-US
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <ZIGhBvFlHwVmKJG4@ashyti-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
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

On 08/06/2023 11:36, Andi Shyti wrote:
> Hi Jianzheng,
> 
> On Thu, Jun 08, 2023 at 11:34:46AM +0800, Wang Jianzheng wrote:
>> Remove unneeded variable and directly return 0.
>>
>> Signed-off-by: Wang Jianzheng <wangjianzheng@vivo.com>
>> ---
>>  drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
>> index 102e1fc7ee38..fec0d014fd0e 100644
>> --- a/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
>> +++ b/drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
>> @@ -66,7 +66,6 @@ static void s6d7aa0_reset(struct s6d7aa0 *ctx)
>>  static int s6d7aa0_lock(struct s6d7aa0 *ctx, bool lock)
> 
> actually this function can completely made void.

It can't be made void, as the mipi_dsi_dcs_write_seq() macro calls
return with an int[1].

Best regards
Artur

[1] https://github.com/torvalds/linux/blob/v6.4-rc5/include/drm/drm_mipi_dsi.h#L319-L337

