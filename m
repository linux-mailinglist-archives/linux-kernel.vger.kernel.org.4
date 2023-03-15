Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504016BABF7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjCOJUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCOJUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:20:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C33B7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:20:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so8070772pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678872040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJSYyhC9hw2dM6xrk1Ayhxfkc3nPZHyNZyP2FXIazVU=;
        b=ky5l3UhZ7WgUz6YMH4LuMgKZCEVAcOjKSBr9EJrY2B3CeDfo7K4aCSqHokbXYIi9SJ
         +q31aveABnlxmPsT5IBlI8H1LqCgVHVjfG9Xn/6ukXMwlMWm/LnD1k4NTNYqzZ4wYfvm
         8h7hdYNqgwgdIuBrbMK9rQ49sYp6uBRPqtHcvlntGVKqeIlHT6uPxsLEx+KOS15Z8pt5
         0LrRMQebiwbNAb/sVB3jKq1isuyFuYdSu8NYsOSOgvSwfcITKmpT1BFyvd1gjb0tAMn/
         /gh6vpaoloJKLY0O6ekrVUqszxenc9p3I1NGkS5Og2ctN5XIzGHqeI+SQunPdTQodAG5
         JWHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678872040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJSYyhC9hw2dM6xrk1Ayhxfkc3nPZHyNZyP2FXIazVU=;
        b=KGY1BWJbmkxKdzlGwl/z5B+m1JiQPRmoo1Ur9JmZ59Xu71mhv1/xYCEr8OAHF2iWXt
         s1w4q4KSxKdNx0D9Dnk2E54b9P9iys8ySo1JAOezR24+q6JM+t6IO/V0sSC9ra4OaNGf
         iKj2hQJplNIbITWXVK14Fke6mRk+72kS6jXyGCLt2V59LBUFpZPiKLYOrneR4DVQrSYe
         n7w8Xzsy7JCpbc1MrFGUAjIWsyXN78hwyNMiXjooMR/8rXg6UR6oVH4QUfCDSvI32lJQ
         +Nj9m4my4wI+ltd467f6W1edtIiNzNWLGwN4iBeU+AQsrvOaAf78GubhaQxvFMClEoXn
         oD0g==
X-Gm-Message-State: AO0yUKUFqVCwLh6K9vrMeo2gk8UCdlLRRk8XqBIlM4nQFHd6p5pe50Ya
        Gs2W4v0l/9fvqhCa/P0iqCHTnygFKo5y3hKp0wc=
X-Google-Smtp-Source: AK7set9NwX+IDLekPulTlC0yQn9MFkdfj2xwZm68xeREZLv/VQMzM9y68XR+wgxY1EUz6Kl/DiJR4FPbxTCKb3N4ZN8=
X-Received: by 2002:a17:903:130a:b0:1a0:52f1:8ea7 with SMTP id
 iy10-20020a170903130a00b001a052f18ea7mr848781plb.12.1678872040256; Wed, 15
 Mar 2023 02:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230308173433.2788833-1-zyytlz.wz@163.com> <d1eee7a0-8942-5f76-a3f0-74dcfddb95b5@linaro.org>
In-Reply-To: <d1eee7a0-8942-5f76-a3f0-74dcfddb95b5@linaro.org>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 15 Mar 2023 17:20:28 +0800
Message-ID: <CAJedcCwWWet3--mvSks=Dz10jEBNqYKadwGY1ijT9-Q=ponCYQ@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: adv7511: fix race condition bug in
 adv7511_remove due to unfinished work
To:     neil.armstrong@linaro.org
Cc:     Zheng Wang <zyytlz.wz@163.com>, dri-devel@lists.freedesktop.org,
        andrzej.hajda@intel.com, jonas@kwiboo.se, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        1395428693sheep@gmail.com, alex000young@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<neil.armstrong@linaro.org> =E4=BA=8E2023=E5=B9=B43=E6=9C=8815=E6=97=A5=E5=
=91=A8=E4=B8=89 17:08=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 08/03/2023 18:34, Zheng Wang wrote:
> > In adv7511_probe, adv7511->hpd_work is bound with adv7511_hpd_work.
> > If we call adv7511_remove with a unfinished work. There may be a
> > race condition where bridge->hpd_mutex was destroyed by
> > drm_bridge_remove and used in adv7511_hpd_work in drm_bridge_hpd_notify=
.
> >
> > Fix it by canceling the work before cleanup in adv7511_remove.
> >
>
> Can you add the relevant Fixes tag ?
>

Hi Neil,

Thanks for your reply and kind reminder. Sorry for my mistake. I'll
append more messages in the next version of patch.

Best regards,
Zheng

> Thanks,
> Neil
>
> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > ---
> >   drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index ddceafa7b637..9bf72dd6c1d3 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -1349,6 +1349,7 @@ static void adv7511_remove(struct i2c_client *i2c=
)
> >   {
> >       struct adv7511 *adv7511 =3D i2c_get_clientdata(i2c);
> >
> > +     cancel_work_sync(&adv7511->hpd_work);
> >       adv7511_uninit_regulators(adv7511);
> >
> >       drm_bridge_remove(&adv7511->bridge);
>
