Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690066CCF86
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 03:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjC2BcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 21:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2BcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:32:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104A310E5;
        Tue, 28 Mar 2023 18:32:17 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q16so18160372lfe.10;
        Tue, 28 Mar 2023 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680053535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZHGglGdWPxmLZqzE9Llvceqs/qTUTBeEQL05IjQ1GM=;
        b=XcsoEJJxl1+QHxMh2z9moGG+r4jo5wA6j2Pz55DBO+Ag1Gm0mr3PXkC8s3EPqYcBC/
         +7VY6+B9iLi3TAsuSyKqTitSZeF7f3qh0bm3BzVhu/doEiY+KH0QGKoV2O0gpflRjw6X
         jPayASahJ8WBBausFNZG+70PPanU2EHHjcFjo6ZP9nOQOnA0jZyGccK2eWS7wYWg35B8
         wFmIZFrk7uge/DMV/JintYkGIxM6158Ot5rcv0u6JMSYv3Tfv2fdmvRHsGcF6UcWRYTf
         FD6t54ZhJsmXouT8lYKsA1+tJdEQhQ4BEBq/fRInizySNx+s+3pAD8V5wUuCkMyVGzcz
         /sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680053535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZHGglGdWPxmLZqzE9Llvceqs/qTUTBeEQL05IjQ1GM=;
        b=yBjvg+ukkR1mXz1XEmA4VEb1OVwlOBDWaEybpWXCtm72yGu307Wv0JiVqwt2ahtetm
         hRoVHASVz6DBwEr/KxkzYHW+xOPrwVtomldr5bgm9HwtfCXLK4U21AIzZQzxSkdNBLVn
         6mqLwbXcbBLqSf4bEmJ30RBMYvliwHXwZGdFI4IaT3nAYRmHWLKqNvW+4OaLlb0/Y9lI
         YoJlvtbn2xrcInyP+Ios9PjFpw1zUneZCC4l+MbkSJGatRMDBbSIYKNw0FqQvsXFvmSV
         t9cA20NnwBGZhiOingtuBkM8lSZNFEgHcq9Tul0V/tUqAxIBbh0LGXKNWVwatP/UcFFX
         1J/A==
X-Gm-Message-State: AAQBX9e4hWLtMMH+w1k6oheLEjJ3/DidLueHfoS3UVWi50t9citonAg5
        Vks1ftfIAP7ZvJEYcpdrgl08Um42osgKnJiJLw==
X-Google-Smtp-Source: AKy350ZJB6a7OQPoK0lwOGpL2K/wAnPDQc3srlgvjR3MpcfWsa2UceRHwbzl4Nrp2RSgJYQpa/EAliAkUvNWxBzIoIM=
X-Received: by 2002:ac2:4473:0:b0:4eb:eaf:aa00 with SMTP id
 y19-20020ac24473000000b004eb0eafaa00mr2977003lfl.4.1680053535096; Tue, 28 Mar
 2023 18:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328103801.11198-1-powen.kao@mediatek.com>
In-Reply-To: <20230328103801.11198-1-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 29 Mar 2023 09:32:03 +0800
Message-ID: <CAGaU9a_dCZA3A_1TP=ijGgXTfiNZffvBe875xXXCKmoN8bQPxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] scsi: ufs: core: Add host quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR
To:     Po-Wen Kao <powen.kao@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Po-Wen,

On Tue, Mar 28, 2023 at 6:42=E2=80=AFPM Po-Wen Kao <powen.kao@mediatek.com>=
 wrote:
>
> Quirk UFSHCD_QUIRK_MCQ_BROKEN_INTR is introduced for plaforms that
> implement different interrupt topology from UFSHCI 4.0 spec.
> Some platform raise per hw queue interrupt in addition to
> CQES (traditional) when ESI is disabled.
>
> Enable this quirk will disable CQES and use only per hw queue
> interrupt.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
>  drivers/ufs/core/ufshcd.c | 8 ++++++--
>  include/ufs/ufshcd.h      | 7 +++++++
>  2 files changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
