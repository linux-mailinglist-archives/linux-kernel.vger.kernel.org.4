Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72F56E5D77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 11:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbjDRJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 05:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjDRJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 05:33:46 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1365FEC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:33:42 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2a8bdcf87f4so15629231fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 02:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681810421; x=1684402421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L5WXOPB3Y4MTTwsxf9PWuOZ+BaBJ0YphlGsakZvJs+w=;
        b=piROnxjik+2/8Dv62cOus3n34UMiSOvIvZIPF9eI7/ArQzcwp1nxufhHkwzt+FRGI2
         IPzl1e5Gb4zQMqV0EAGwCWRirvfvzG3+pk29rhByc6tDVmi85gF1LPsglMQNF2ELFvp2
         3+xeWPl5d44dyiCVqBafSn8m0Z5NT9YZyhx+XYARcd27up8nO0VU1Fnq+cwjutZwF042
         yCyd9WJtVEM4sBHZvNIIiPuthDLI5jBjC9LSrrMSh0ll/q3jA04OzjXUs8puGbEboSQ4
         Tu4c1VbEjk5j2xtTavHalPvjWr9pQGn0XQ2hIhYwVWQN/UpQfIJjux/G7HI3F73/2jQu
         kTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681810421; x=1684402421;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L5WXOPB3Y4MTTwsxf9PWuOZ+BaBJ0YphlGsakZvJs+w=;
        b=LLSBPDBMfBnhh/LaKjR0ODkT/y0+dWFxJJGQ86D/4pJo5sT0VnzefL0/3xC0atxo+Z
         JW0LMPhcsasjYR+PTaG8fjJekCv5FejIh2VSANv1KRPqF66npMtpuX2vA+bCLV3Elz+6
         ZGQLIFy53qnKAbEayxiznHwmf0YP+4i6FtAnkm6ETOOtxn2srk71Pc7bcROvbRwqWBk1
         S6d5lKytJsm2sgNieECuJnCIvMw+Ge5QT0PCfiOwuDAFfsccaOms6IpGUPFehEXF3CNh
         OfWnuncjpopZmWVfiJw+xHiMTpULpbIKQgDLHbTwZpC0ShOvIG6rpcCb84X/1gcoDNfu
         Inpw==
X-Gm-Message-State: AAQBX9ft8ix/gzrZC/BlhXzSpdrPiKvp96fL5Rre63pidvyILzyDO5Qa
        9EIi60Yuf/qtWGmEd/V4OaFVPA==
X-Google-Smtp-Source: AKy350YfDnqx0ekmnOPKbiqhXQUmmKOiIzrPgd/oF+uGgWd9KFMGoFe5h5owEJ0XYWkDm/hdL7V4iw==
X-Received: by 2002:ac2:51b3:0:b0:4ec:a18e:f985 with SMTP id f19-20020ac251b3000000b004eca18ef985mr2854150lfk.13.1681810420962;
        Tue, 18 Apr 2023 02:33:40 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id f15-20020ac251af000000b004dc4becfcd6sm2319201lfk.54.2023.04.18.02.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 02:33:40 -0700 (PDT)
Message-ID: <a0518750-367d-5ec9-f49f-77e90d51cbf5@linaro.org>
Date:   Tue, 18 Apr 2023 11:33:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC 0/3] drm: Add comm/cmdline fdinfo fields
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org
Cc:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Rob Clark <robdclark@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>
References: <20230417201215.448099-1-robdclark@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230417201215.448099-1-robdclark@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like the 'PATCH' part of your subject was cut off!

Konrad

On 17.04.2023 22:12, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> When many of the things using the GPU are processes in a VM guest, the
> actual client process is just a proxy.  The msm driver has a way to let
> the proxy tell the kernel the actual VM client process's executable name
> and command-line, which has until now been used simply for GPU crash
> devcore dumps.  Lets also expose this via fdinfo so that tools can
> expose who the actual user of the GPU is.
> 
> Rob Clark (3):
>   drm/doc: Relax fdinfo string constraints
>   drm/msm: Rework get_comm_cmdline() helper
>   drm/msm: Add comm/cmdline fields
> 
>  Documentation/gpu/drm-usage-stats.rst   | 37 +++++++++++++++----------
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  4 +--
>  drivers/gpu/drm/msm/msm_drv.c           |  2 ++
>  drivers/gpu/drm/msm/msm_gpu.c           | 27 +++++++++++++-----
>  drivers/gpu/drm/msm/msm_gpu.h           | 12 ++++++--
>  drivers/gpu/drm/msm/msm_submitqueue.c   |  1 +
>  6 files changed, 58 insertions(+), 25 deletions(-)
> 
