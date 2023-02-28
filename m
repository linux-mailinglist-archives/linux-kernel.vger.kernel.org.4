Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A661B6A5FDB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjB1TmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjB1TmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:42:22 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEECE32E73
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:18 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t14so11499940ljd.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 11:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677613337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IMgz+8i9lDRHkxwEIJDwxwFLj+KDr4M+MCf3M/7tTJM=;
        b=fnVIH66A+T4loHjEJBk1eiwVsFWwySA0EjMRv4mNph/d634x+vZzQ1t1ZXX13PZK+A
         lleZg6r6viA8nRna6Mky0+OOpu/CZbfDb5FukQBWRhQ7h2r2QCkW2PaXPrpBnMtmVp6p
         MO2O2n0KmmOBAIGwNoOv7yDQ3GMdGfYW5ZOUuSnO475AnuGBTOgSPoDFmbRHiY3igDxV
         C+6DWEYACQ4h3cx/Y43Gial10PkcLiH2ghVSsaFHZVidKovbKEh5Fne9vwBaAGhG47WS
         AeeWx4qwR+cXNGXv78VuUfpYPsViDVz515M8Bfk4OaJ+wiYovt31AIVDEs7yABO767jA
         iOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677613337;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IMgz+8i9lDRHkxwEIJDwxwFLj+KDr4M+MCf3M/7tTJM=;
        b=DsM6piQodgsCZTpCXl1w7E2MFbn+BMl4BqfNfaMJPkKi2E4nc/fqh9wylxVgcOAXCA
         gqfT4P9uFDkrIgGGBGkdCFGNG/qHN5E0KDxxe4y1mB11fazkhcJm47QWEhovK+WpPgFB
         nd4gnEBzouTWfMyaNwqRIHDD/JvQGEvY36rQMuWo8Dyo6gLrMqtrrhQ4htY+eWrdgk9N
         XIdUsQUzIERvR8WLUMvID7BqNwVLpBYcZZOJ+T+OdLe9iUWzQZOF/noENE+80ZjXUOdg
         Q8T3M7kgXDA53GDXs+BsvBEHIGMu5yWTIC32t1LgBvM/t/bM4qMaJDwpLR03oN+ZEwdT
         OvZw==
X-Gm-Message-State: AO0yUKVl2iKSciXw+4RSCnm6Jql9k/+Tca2zGjMBon3A1OsrIre3XrmL
        28VOaRI43kVoL9nZUc+TkPGQNQ==
X-Google-Smtp-Source: AK7set/YlENBCLqy77hHQCs4r1R/UVJNkdC2/9KL96Gc9ETxmc68JgoSYc5bsjJctCMiQPe+e97TMg==
X-Received: by 2002:a2e:3510:0:b0:295:a391:7b48 with SMTP id z16-20020a2e3510000000b00295a3917b48mr1149818ljz.26.1677613336957;
        Tue, 28 Feb 2023 11:42:16 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id p5-20020a2ea405000000b00295a2d07558sm1328602ljn.112.2023.02.28.11.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 11:42:16 -0800 (PST)
Message-ID: <b280c6a5-04dc-8a4f-459c-4703e567fa1d@linaro.org>
Date:   Tue, 28 Feb 2023 20:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V5 0/3] rpmsg signaling/flowcontrol patches
Content-Language: en-US
To:     Sarannya S <quic_sarannya@quicinc.com>, quic_bjorande@quicinc.com,
        arnaud.pouliquen@foss.st.com, swboyd@chromium.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1676995418-19358-1-git-send-email-quic_sarannya@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2023 17:03, Sarannya S wrote:
> Added two new RPMSG IOCTLs for rpmsg_char- RPMSG_GET_SIGNAL_IOCTRL and
> RPMSG_SET_SIGNAL_IOCTRL, to set/get the flow.
> Addressed review comments for changing variable names/ desciptions.
> 
Hi, your changes mostly don't apply on -next-20230228, please rebase
them. Not sure if I didn't miss anything, but I did it locally to test
this [1]. My Wi-Fi chip on SM6375 seems to send quite some signals calls
and applying this series got rid of "unhandled rx cmd: 15" and the
corresponding timeouts.

Also, please consider using b4 [2] for sending patches, you only sent
them to a couple of people and it didn't even reach patchwork..

Konrad

[1] https://github.com/SoMainline/linux/commits/signals_rebase
[2] https://b4.docs.kernel.org/en/latest/contributor/overview.html
> Sarannya S (3):
>   rpmsg: core: Add signal API support
>   rpmsg: glink: Add support to handle signals command
>   rpmsg: char: Add RPMSG GET/SET SIGNAL IOCTL support
> 
>  drivers/rpmsg/qcom_glink_native.c | 63 +++++++++++++++++++++++++++++++++++++++
>  drivers/rpmsg/rpmsg_char.c        | 58 ++++++++++++++++++++++++++++++-----
>  drivers/rpmsg/rpmsg_core.c        | 20 +++++++++++++
>  drivers/rpmsg/rpmsg_internal.h    |  2 ++
>  include/linux/rpmsg.h             | 15 ++++++++++
>  include/uapi/linux/rpmsg.h        | 12 +++++++-
>  6 files changed, 162 insertions(+), 8 deletions(-)
> 
