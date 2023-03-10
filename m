Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65826B4DD4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCJQ7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjCJQ6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:58:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A228120E80
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:57:27 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bw19so5634860wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678467445;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gFpyIz5IDkAlMCD4jLAXbROu3buVoZLKweW3KUNtWJ0=;
        b=DMwdjpYHDqyh3WZntB5Q+unbDUcqJsH4jeMh7Wwz66hLFXLimqrFd3j6+sP/aanXU2
         SjPgGzGGZTocbPEnS6G5BXoObcYFBsBglbmYokkdTuI66i4czHd3KwY8fl7bC8U9bsxs
         rebf9FU4ptW+u+CK8UWJJgHwI3xW9WHYZXxBMqYqA/NzlMxVqeBIJEej6U6Jyc6PqjWi
         P0jbNBEo0EEzAJfRQtjQefuJSs4pqHSToCG+vvOCOsoAEb+KeX6Bq/jgOnoZY8OnDKEa
         H1a93t7fMJJyhjEKoRa3gjKWyRN5OrsLOJPpsUNtH1hL2jkRUHDsyff/v0i6tlMfLTWl
         n27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467445;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gFpyIz5IDkAlMCD4jLAXbROu3buVoZLKweW3KUNtWJ0=;
        b=wsHguHTd8hGZ3ELE3YzLwAbqDLojrKVhPtlLIejw9YSQQPNAPm8pDghxxU1Ni3pRJS
         +YzU9aaVBR6Z5yvAoq3luCYV203k3CdLfvceri+w7YeccL8zF40ZKe3lqn2ueCHlGN7K
         2QPUhA+JEa2QA6eM86AqD6y3/mpGsts7EhJncybbVGNlaDgEXmhDW5hrLPSgk0XOPGD8
         I3tdaAIrG63MhYYc1ZtHp4XD2i1Ntfb4WTsVNdiuSiPbZId907+DTzlJkxq2foDfdAzl
         jDl85O5PakBDIeMs2v0AbwwSl6jLfy3kxkkx6PUHC7CnAt3nL8XIGjSlAYagTteHYOaK
         +XRA==
X-Gm-Message-State: AO0yUKWmgUezhDlLmJRMeLvxONZIK5GU0UNJ1iQpvXTdIcdYAnnWC6wP
        6hqqtXZwU98aMiZhR4CKIaMeGA==
X-Google-Smtp-Source: AK7set/k2jvzdpZ+x1/a+riehOzhZniJXHH01TqXAOPGR1MT6PQL+VWojbn/xqNddc5P1TIkEsH+Zw==
X-Received: by 2002:adf:efc3:0:b0:2c7:ffd:f483 with SMTP id i3-20020adfefc3000000b002c70ffdf483mr17423986wrp.41.1678467445393;
        Fri, 10 Mar 2023 08:57:25 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:566:5b64:c228:1137? ([2a01:e0a:982:cbb0:566:5b64:c228:1137])
        by smtp.gmail.com with ESMTPSA id c14-20020adffb0e000000b002c8ed82c56csm224763wrr.116.2023.03.10.08.57.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:57:25 -0800 (PST)
Message-ID: <26e7dd52-215b-ce55-394d-b0730d5015b4@linaro.org>
Date:   Fri, 10 Mar 2023 17:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v4 2/2] drm/panel: Add driver for Novatek NT36523
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230310132144.2241-1-lujianhua000@gmail.com>
 <20230310132144.2241-2-lujianhua000@gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <20230310132144.2241-2-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/03/2023 14:21, Jianhua Lu wrote:
> Add a driver for panels using the Novatek NT36523 display driver IC.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---
> Changes in v4:
>    - add multiple modes support
>    - use dev_err_probe helper
>    - fix dsi_info type string
>    - reimplement mipi_dsi_dual_dcs_write_seq() macro
> 
> Changes in v3:
>    - Refactor source code
> 
> Changes in v2:
>    - Refactor and clean up source code
> 
>   MAINTAINERS                                   |   7 +
>   drivers/gpu/drm/panel/Kconfig                 |  10 +
>   drivers/gpu/drm/panel/Makefile                |   1 +
>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 771 ++++++++++++++++++
>   4 files changed, 789 insertions(+)
>   create mode 100644 drivers/gpu/drm/panel/panel-novatek-nt36523.c
> 

<snip>

It looks great now, Konrad do you have some comments on this revision ?

Neil
