Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699036678C6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbjALPN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjALPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:13:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E241D129
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:02:44 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id m6so28807978lfj.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YHPdJqIq38+J4n8CN1cX0dFtD8Rvs4CgnEIDyi8KGdM=;
        b=Woe1qwgtFH7Jk41E81KSelxmDXOGMuHmgXn6VZV+usKWWZERy9NlA4O/8t7+hHGGfa
         OlkZmuSpKm0A+6UXmZ1n0aiH6yjGj0LhtVz+oEAbiGv1yqqIbsxD3VFJNPasbGrOv4p7
         dsZY2XqG+A5CDFFXfTx6enU6kcSjJxBuOLlv0Ct9+SCRrdkyZ5atqzmyZKv1xi/FfVTN
         uYfwCqASIh+xwjWvNiOU7vLc2yVt5yAgbt3kGH8DMmyfOniD5Shex3KPg9xbX6cV67pg
         WFqxIhzd2Ef6CB1DWOBq2aVPUq3P/NO9D0KVsn+bZY0a7wGfVOCsu8M8BomQd5KUSBM4
         dl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHPdJqIq38+J4n8CN1cX0dFtD8Rvs4CgnEIDyi8KGdM=;
        b=Sx+dE52ayeUSzvKVfcCv08Pl5PuiqBx/QeF7CVQEvVLvHB+YLgb2VKEt1SghIQn3Wd
         n8gBpLmsmtiNHzKkCXpblk6Hk5glSpCtoEnbIakHT5734KDjzoL/PDhPfrkW8+LgguF5
         75uKqovHRmS8yA5IYIEnfNlHZfZu6aHZdRqzENW3dK7P1srz5tFpvuw49tILn77deLre
         FwhGbASi+D9R+/Ll+c5dmTAVBrXb8Vz3vBO3X+oCK5G9qEnkvr3nLeshsZ3oKtg/mWwO
         A8GWSaFEbQqik1zcJupQ/k9mlcY7zsKzQ/lsleFtDTiL8iw2iwpZNw6tXl/vjsUMBX2O
         +Jtg==
X-Gm-Message-State: AFqh2kqk2CKyH2AhEKj279ikCgvXf688eEuhTU8SscLdJfP1wZU4Gvxi
        Xr+6dFrYEdJYce9Qxc+riMQjPYuqgqIS66I3UdgsZA==
X-Google-Smtp-Source: AMrXdXvR1l36/qUwB1P+1UgWfgsNtjVZ4KPZcRod+KwbmrmOF3n+QPkLuOVKH18qwF4Pv5w3YUxBKrLQn+R8ZCn2uSg=
X-Received: by 2002:a05:6512:33cd:b0:4cb:3df9:b25f with SMTP id
 d13-20020a05651233cd00b004cb3df9b25fmr1748078lfg.653.1673535762952; Thu, 12
 Jan 2023 07:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com> <20230101-patch-series-v2-6-2-rc1-v2-5-fa1897efac14@collabora.com>
In-Reply-To: <20230101-patch-series-v2-6-2-rc1-v2-5-fa1897efac14@collabora.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 12 Jan 2023 12:02:31 -0300
Message-ID: <CAAEAJfDqXJf-UovhGnmN7FDY-skSu-x5Rgz+K2WVQP+PKUVbsQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] staging: media: rkvdec: Add SPS structure to
 internal context
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
<sebastian.fricke@collabora.com> wrote:
>
> Prepare storing the SPS structure for HEVC & H264 in the internal
> context of the rkvdec instance. This structure is used to figure out
> which capture queue format is appropriate for decoding.
>
> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> ---
>  drivers/staging/media/rkvdec/rkvdec.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/staging/media/rkvdec/rkvdec.h b/drivers/staging/media/rkvdec/rkvdec.h
> index 633335ebb9c4..332126e7b812 100644
> --- a/drivers/staging/media/rkvdec/rkvdec.h
> +++ b/drivers/staging/media/rkvdec/rkvdec.h
> @@ -105,6 +105,7 @@ struct rkvdec_ctx {
>         struct v4l2_ctrl_handler ctrl_hdl;
>         struct rkvdec_dev *dev;
>         void *priv;
> +       void *sps;

I don't really like re-caching the SPS in the context,
since all the controls are already stored in the context,
via the ctrl_handler.

See hantro_get_ctrl().

Duplicating state can lead to problems and even if we get it
right this time, will be hard to maintain.

Thanks,
Ezequiel

>  };
>
>  static inline struct rkvdec_ctx *fh_to_rkvdec_ctx(struct v4l2_fh *fh)
>
> --
> 2.25.1
