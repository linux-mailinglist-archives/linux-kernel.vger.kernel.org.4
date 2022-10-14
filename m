Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDF85FE62D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJNATk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJNATd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:19:33 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525471960A5;
        Thu, 13 Oct 2022 17:19:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id fy4so7300373ejc.5;
        Thu, 13 Oct 2022 17:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YLUuEPbeHwPmQyYJMc73Q6jKpll4zmH7qmymoNKBPY8=;
        b=MDuWDD6o8ZR9Bgi3eqLk6EOdwaCfN8Eq7bbHZRgmQPrK8zE+sqSPh22Ar0bmDxG0Rv
         LKUp0DPSaWOG4LDRwB00jA2xXWeuPJine//GuOKf5cBC1u84YoM+tPQhoVlBBPEpN0bz
         M5l6FSQZ/usN9GLAcTv+JpVtLFq/LbffMHnigGj4FrkveUAg2Vrr8Ttedkz32fzoduu7
         QM/WwTgA/pPqmM/+N2N6rlF43yLzkYq5bCWzKjjgm+f4fiEzY9in0WszAw8zGPbqMCZL
         0hCeNWv/07qBM18kl7HY1zBi8QqZseeV42GCgPxb4Xylq9Kx43mlLL4aG0rGuLDCiIn9
         eV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLUuEPbeHwPmQyYJMc73Q6jKpll4zmH7qmymoNKBPY8=;
        b=lVfb4/hnfrdBG7271gl4SYoxYXn6tfjl+lodkvKR9RfVc9+dtEDBgU0bSe9eQahT3v
         lph7/NxTB3yBEHQPZt8AoZuBIKtOBL1aXqdHnjOpRQI1LJigvlwSKcPHGYuWqfl/p0zn
         YcFG7OMcNdDDVKxpPXXjnewPzvCzD5w/5Yk5oKer0+qi6lHoMtbv6z/CqA7nB/55auia
         rvodiH9bleucT8PNca2Rs2uZGcQxQ5SuyZQ9bJGcebC9OS7p4PTd6LrC5yTZaVsmCBnW
         +J2vasfkR4htNk+juzfMx5l+JhEdemSeJkAhUInOgMQbP9l1FjTJJuMddxxS9Bu5IVh7
         WL4Q==
X-Gm-Message-State: ACrzQf2GHypIe7WSmhz/dgjXpbR2d3EgcY4xPmCfCH9nSVY7DqNutw7v
        rBVR18q0tFMrtOrWtn65tKIINJ5GWL8nxUDoovx9NumPZVw=
X-Google-Smtp-Source: AMsMyM4kPG7TtZnxn8Yo16eNXuFfUTOnLoHMOQilmDGRp4LO6S7BrxEk7p7tyizz3Ox6+tGDFEUmZku3Q0T8FO9NebU=
X-Received: by 2002:a17:907:a052:b0:78d:8531:92b with SMTP id
 gz18-20020a170907a05200b0078d8531092bmr1674708ejc.37.1665706769713; Thu, 13
 Oct 2022 17:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221013225520.371226-1-robdclark@gmail.com>
In-Reply-To: <20221013225520.371226-1-robdclark@gmail.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 13 Oct 2022 17:19:18 -0700
Message-ID: <CAPaKu7SE+Vh9rW6MVr8fCUdrJM6f7O1ZOfSPFdzRaw9TjpG-FA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 0/3] drm/msm/a6xx: devcore dump fixes
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Emma Anholt <emma@anholt.net>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <sean@poorly.run>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno@lists.freedesktop.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 3:55 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> First patch fixes a recently introduced memory corruption, the remaining
> two are cleanups.
Series is

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>

> Rob Clark (3):
>   drm/msm/a6xx: Fix kvzalloc vs state_kcalloc usage
>   drm/msm/a6xx: Skip snapshotting unused GMU buffers
>   drm/msm/a6xx: Remove state objects from list before freeing
>
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 18 ++++++++++++++++--
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c     |  7 ++++++-
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> --
> 2.37.3
>
