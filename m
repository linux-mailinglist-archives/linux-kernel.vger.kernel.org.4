Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B9971540F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjE3Cxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3Cxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:53:39 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2EA8;
        Mon, 29 May 2023 19:53:37 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b03d3e41fcso57195241fa.0;
        Mon, 29 May 2023 19:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685415216; x=1688007216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abv0F38Kb+H1iq841VQW7GAB7tr+6RM1I7/gkXbGhvM=;
        b=GBZoAIJldvjvXxQlv3aSpuDSzWykHF7NTzRVvsiSnG2TBH6OoMl8xV0belYMoYUd0r
         B4jzbszYhWlMUjx0lyvh4R5Iddor6Okxf8OCze1QtBWbS2vc6UxK+tE1jmEFFgBCNJ5Z
         hRQlPCn6EWLHIncYKZAeAsE3IJ0QEFAFC3BjgkUuB+0RcsLl7ssaIsEA0qdPXFPvVvAx
         1uDlh7jZEDRpraLHxhC81lZsy7+PpX9jdmP+rsqVOLb1N2xguubUDovqeca+aYT0ZkJB
         +x6F5betYYURb4w8IgsIooMvjDgE0JrqnHPmDEOKMsu/nerSZjL+SwVhDfcZu4Hy3Zhb
         HG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685415216; x=1688007216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abv0F38Kb+H1iq841VQW7GAB7tr+6RM1I7/gkXbGhvM=;
        b=By/lns75K8LmA5Uh/Sujpi3tgb5LbNbUxNIRQ/PRtPET2LcUBTkUBNXR5NT9FHpMnr
         YDtgKh1EzuPom0OfVERh5i6SQIyhzjpS79BueXNnUEtNJL0aI+QQQbBpLmtYEsMo5/0/
         T6gGExX1nk6MdKuZsVqhpyEAvZqBU6hNT/e/IV4rjYb883m27C04geGx+BuTdBNF19bz
         vjLKhCQ7drnNLcFQLt0g77BB0PdTW6+GWwxYrWyj4Y4Mncmlh61xlBB0x3mGCm6+FrUH
         3I8v1/NNcPXycjYHLf/9LHAd20IhE63aa/TD5w0pIysuyVLYSbPryoCfl8WMkuAcipLH
         ylgA==
X-Gm-Message-State: AC+VfDzjAbZsRZrcNy8qe/QsaKQwL8TkC163mbypuAUHIHYboAuHKvWp
        aIfjpgAGIwjE4X2EIBwCTf/73+s+ztNzmOxtkikrn4/vtw==
X-Google-Smtp-Source: ACHHUZ77y0PA2RlEEvFIe5qH2zMe2mxNW2B+qocVvwjH5POSpPgz9W6FNC2AhueN6zpdzHPKkZU4WNJvPyEw4+B4Rd0=
X-Received: by 2002:a2e:b5dc:0:b0:2a9:d4f0:6 with SMTP id g28-20020a2eb5dc000000b002a9d4f00006mr3800615ljn.17.1685415215746;
 Mon, 29 May 2023 19:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230530023227.16653-1-powen.kao@mediatek.com>
In-Reply-To: <20230530023227.16653-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Tue, 30 May 2023 10:53:24 +0800
Message-ID: <CAGaU9a9q2j8jSPjufa__vTCoW_beQFL9VjSzm5uQqqAsVLr+Hw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add MCQ support for MTK platform
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po-Wen,

On Tue, May 30, 2023 at 10:44=E2=80=AFAM Po-Wen Kao <powen.kao@mediatek.com=
> wrote:
>
> v1 -> v2
> - Introduce MCQ SQ to CQ mapping vops and provide MTK implementation.
> - Update export symbol patch
>
> v1
> - Separated from topic "[PATCH v4 0/5] Several UFS MCQ Code Changes".
>   Here are some changes since last upload
>   - Store irq in per host array
>   - Symbol rename
>   - Use ufshcd_mcq_poll_cqe_lock() instead of ufshcd_mcq_poll_cqe_nolock(=
)
>   - Handle invalid irq dts property
>   - Remove ufshcd_disable_intr(hba, MCQ_CQ_EVENT_STATUS) in MCQ mode.
>     This will become host quirk later.
>
> Peter Wang (1):
>   scsi: ufs: core: Introduce mcq ops to config cqid
>
> Po-Wen Kao (2):
>   scsi: ufs: core: Export symbols for MTK driver module
>   scsi: ufs: ufs-mediatek: Add MCQ support for MTK platform
>
>  drivers/ufs/core/ufs-mcq.c      |   6 +-
>  drivers/ufs/core/ufshcd-priv.h  |  10 +-
>  drivers/ufs/core/ufshcd.c       |  11 ++
>  drivers/ufs/host/ufs-mediatek.c | 188 +++++++++++++++++++++++++++++++-
>  drivers/ufs/host/ufs-mediatek.h |  33 ++++++
>  include/ufs/ufshcd.h            |   8 ++
>  6 files changed, 251 insertions(+), 5 deletions(-)
>
> --
> 2.18.0
>

For this series, feel free to add

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
