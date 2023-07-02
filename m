Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA0744D17
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjGBJvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE0FDC;
        Sun,  2 Jul 2023 02:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 303A860C08;
        Sun,  2 Jul 2023 09:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97340C433C9;
        Sun,  2 Jul 2023 09:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688291462;
        bh=hA6GlV1UqjmkA56DuucUvDkCtcQNNv7bBEGovbx1Fk4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZpIl/0mG6g7ahPl4aF1WDSXW7RQg9KvEDECwPSFMQx37AzIMDwjuCHi389WTobdKX
         qbNVP3QmxSOHSpTJE1ZaHERJE3GJk5r2mlPiDnGMKzb9pcRFiqDBpyRvqSkMfzaHRo
         u2fQG5AUc5aBwq3R/Xn8EtCALrgOExsdYWAAjYqqtbeg9DdutKx1+tLAC2p/kgajQu
         8b1xKFNpAjOmKS9zyNHkIspK1RrD2aTI0kxrJLm1Cu9d66e3QwzVyOQDeJRmO9tgyX
         +DX+B0u9pUbtJhaVD84Uyw3dihGIyUnBUPM791RZYucOAkTlNtc2WJ3XCYKyQZZ9e4
         u/9Ta1MLQ+OvQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so4299480e87.0;
        Sun, 02 Jul 2023 02:51:01 -0700 (PDT)
X-Gm-Message-State: AC+VfDz4kLwAy0IRrgyPJqnSfAKaPAsFI8D7qVe9sXDxokJjCeTWoGRm
        hFFBtlffmN9upFunnRH9LyJ+xhvoi4Gf3NQUgw==
X-Google-Smtp-Source: ACHHUZ6L2kvXHzm79mMIeDZDgvuDYbbSjie/ZH4uVr+PSQ9kioutb93cROQeonW8J6th9h92WSPRzm6UmI0vRxIH6IE=
X-Received: by 2002:a05:6512:2828:b0:4f8:75d5:e14f with SMTP id
 cf40-20020a056512282800b004f875d5e14fmr3736142lfb.28.1688291459662; Sun, 02
 Jul 2023 02:50:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230630100321.1951138-1-jstephan@baylibre.com> <20230630100321.1951138-5-jstephan@baylibre.com>
In-Reply-To: <20230630100321.1951138-5-jstephan@baylibre.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 2 Jul 2023 17:50:47 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8z9YDrC6yJ80TUJQ6FmU6wQOdgGJ0eCN15gu0LYds0ig@mail.gmail.com>
Message-ID: <CAAOTY_8z9YDrC6yJ80TUJQ6FmU6wQOdgGJ0eCN15gu0LYds0ig@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Phi-bang Nguyen <pnguyen@baylibre.com>,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        devicetree@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
        Louis Kuo <louis.kuo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Julien:

Julien Stephan <jstephan@baylibre.com> =E6=96=BC 2023=E5=B9=B46=E6=9C=8830=
=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:06=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> From: Phi-bang Nguyen <pnguyen@baylibre.com>
>
> This driver provides a path to bypass the SoC ISP so that image data
> coming from the SENINF can go directly into memory without any image
> processing. This allows the use of an external ISP.
>
> Signed-off-by: Phi-bang Nguyen <pnguyen@baylibre.com>
> Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---

[snip]

> +
> +static irqreturn_t isp_irq_camsv30(int irq, void *data)
> +{
> +       struct mtk_cam_dev *cam_dev =3D (struct mtk_cam_dev *)data;
> +       struct mtk_cam_dev_buffer *buf;
> +       unsigned long flags =3D 0;
> +       unsigned int irq_status;
> +
> +       spin_lock_irqsave(&cam_dev->irqlock, flags);
> +
> +       irq_status =3D mtk_camsv30_read(cam_dev, CAMSV_INT_STATUS);
> +
> +       if (irq_status & INT_ST_MASK_CAMSV_ERR) {
> +               dev_err(cam_dev->dev, "irq error 0x%x\n",
> +                       (unsigned int)(irq_status & INT_ST_MASK_CAMSV_ERR=
));
> +       }
> +
> +       /* De-queue frame */
> +       if (irq_status & CAMSV_IRQ_PASS1_DON) {
> +               cam_dev->sequence++;
> +
> +               if (!cam_dev->is_dummy_used) {
> +                       buf =3D list_first_entry_or_null(&cam_dev->buf_li=
st,
> +                                                      struct mtk_cam_dev=
_buffer,
> +                                                      list);
> +                       if (buf) {
> +                               buf->v4l2_buf.sequence =3D cam_dev->seque=
nce;
> +                               buf->v4l2_buf.vb2_buf.timestamp =3D ktime=
_get_ns();
> +                               vb2_buffer_done(&buf->v4l2_buf.vb2_buf,
> +                                               VB2_BUF_STATE_DONE);
> +                               list_del(&buf->list);
> +                       }
> +               }
> +
> +               if (list_empty(&cam_dev->buf_list)) {
> +                       (*cam_dev->hw_functions->mtk_cam_update_buffers_a=
dd)
> +                                               (cam_dev, &cam_dev->dummy=
);

It's not necessary to use function pointer. Call
mtk_camsv30_update_buffers_add() directly.

Regards,
Chun-Kuang.

> +                       cam_dev->is_dummy_used =3D true;
> +               } else {
> +                       buf =3D list_first_entry_or_null(&cam_dev->buf_li=
st,
> +                                                      struct mtk_cam_dev=
_buffer,
> +                                                      list);
> +                       (*cam_dev->hw_functions->mtk_cam_update_buffers_a=
dd)
> +                                               (cam_dev, buf);
> +                       cam_dev->is_dummy_used =3D false;
> +               }
> +       }
> +
> +       spin_unlock_irqrestore(&cam_dev->irqlock, flags);
> +
> +       return IRQ_HANDLED;
> +}
> +
