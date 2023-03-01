Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0620E6A65B2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 03:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjCACme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 21:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCACmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 21:42:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55ECC37554;
        Tue, 28 Feb 2023 18:42:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id x34so11928297pjj.0;
        Tue, 28 Feb 2023 18:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677638552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TtEI17+g3+FYNmzjZog7TObGaEISKv33yP7XaUgcMpw=;
        b=C2awFZi3UZK1zN88aASBwpbUmIyVjmgoYglFuONN/+0apTYd5IWDuLiOz1c1VN8upZ
         6mlskXUv1yXAzEH8dxRsozpV2xWpBd80NAmpQGfUmvJrKEuXhVvb/V6prcMvsaRZiCo+
         iXCFzMv9fj9v6B/f7hkrooQoUAGi4cO0UN3c8UHZpBrPIC1gOPBU49wHROJNBocEHvmp
         tb3cm050fGMauVRXy7ifSfX1VzGGFhZ3tAEBXlF+mQg8FsIVHkeT8V5zrFCozrWvuK8Q
         9rrdYm6eG1V39BS+g40xVcIy99Q0FgF6YWINYxQvQWe/rGwLsUCHKm73ixthff5BDTcM
         E7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677638552;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtEI17+g3+FYNmzjZog7TObGaEISKv33yP7XaUgcMpw=;
        b=shAOjRrwhDaOjkrBWbNlyVKXK37YWagk0WL05oh4d7Ab7zlfE95wjt/zLE/NIsyZGY
         yPDI49te2tA+KuwM2sLT5ctGUndGfbHcyWfYelo6sWuSvdrbnKTMYkRnWn8weoCtmmQ4
         bw3NrjPYwnP7ij+mrmHtLx3UUm6rnhPP+Air4/ZqndhbWK322QMJ8Wvq0LFJQDiKa+VG
         X6l1X1B02el+56Fn9s1hYS4PlK99piK8oJBAHkWaW58UUMn2MoU12g/au8GBsNeRv99H
         oJgxtvEpxUqae/686qheDvZ0fPe0uKdE9JmZTC02+nHeRcpp6qbLOPdOKQsTgqR2z7mk
         YAIA==
X-Gm-Message-State: AO0yUKXPhb9c6m3X0pENlO3U3Y/sjoXbQeNIZ+qINuIlUDdjrcc98X+S
        KfO72sfapmL2jF0WgjX2ieA=
X-Google-Smtp-Source: AK7set/i/rEne9Miy3soqJWFleyHZluwc5UHR+jsPgrNaLUUlsoxf8qLJ7q2HYdNV1zs/GO9IiWdsQ==
X-Received: by 2002:a17:902:d54d:b0:19e:2298:c53d with SMTP id z13-20020a170902d54d00b0019e2298c53dmr4379817plf.10.1677638551793;
        Tue, 28 Feb 2023 18:42:31 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id ju4-20020a170903428400b0019a7563ff15sm7198090plb.115.2023.02.28.18.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 18:42:31 -0800 (PST)
Message-ID: <7aaf6ed9-3da2-0535-f269-fc5c35e7aadc@gmail.com>
Date:   Wed, 1 Mar 2023 09:42:14 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 00/15] dma-fence: Deadline awareness
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Simon Ser <contact@emersion.fr>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        intel-gfx@lists.freedesktop.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        Vinod Polimera <quic_vpolimer@quicinc.com>
References: <20230227193535.2822389-1-robdclark@gmail.com>
 <Y/320d96QmbLe1J8@debian.me>
 <CAF6AEGuqHDDQS22qcp8sk+5bj16XFiBarCLvpX=qNc2r2euMUw@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAF6AEGuqHDDQS22qcp8sk+5bj16XFiBarCLvpX=qNc2r2euMUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 22:44, Rob Clark wrote:
> You can find my branch here:
> 
> https://gitlab.freedesktop.org/robclark/msm/-/commits/dma-fence/deadline
> 

Pulled, thanks!

-- 
An old man doll... just what I always wanted! - Clara

