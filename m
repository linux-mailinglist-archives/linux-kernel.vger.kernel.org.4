Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED47060BF28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiJYAAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiJYAAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:00:18 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23AF309E10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:15:08 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id n73so8874502iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6vua4Dyda0yEvNLZR0r5GnBK0oOLnVu43JFNVctrL0=;
        b=JMAVY4yEPNKXqRpMvAj2Z5XXaddcr3sui1yLCm77hsyJyRHKJOTfx1vxVzi8RGZJM4
         Z1MwJKPfFkHQrnGMeg0ZJ8zl290QuCfNSBDJpSg0M0N8T8PeMtv69qvfOq0OquUmsnZ5
         qVqxBdK5bVvoj3HDwCU7eD5g+OjFVGa0L46FGvviBpU/hcVQVehrTenHvKPD7T5LuHfT
         q3UgCblQKy0vuuQcHGi/waniCyqxlj+MViSgVmni8DbhNiY3THogwibqCz2FsnoxA/ol
         CU/GdzRfqQNCMVGhPaiJk6q4YzIfA73i8AtW7mqwqi10ofVP/vHKIivCoCdJw2EBXSE7
         FBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h6vua4Dyda0yEvNLZR0r5GnBK0oOLnVu43JFNVctrL0=;
        b=JNjAQ9TzXKzOCMbPtC9LxqX3MQgDdZBnYwp5tshe+2dms7N7p0vgbhTyH7SFO0zyDh
         jaXJilRfpWG5vUwF/nS4qk3g10WI1HNdylOBNP7VukfqxAAdIVjuZvY9mNCaduO/c2w8
         ak+LT2mGsbjQb6FBij3A+fAQ5crFRUvJnGAbcYo9sB+j/2ksn4nAtNoX2OJUgnK55XXT
         nacahrABoi4z9tfhxYG+kYJ8eDGzmM0CSDsI4qWXegKiVLZCYMcm+aanrP5VsQAutrS0
         IdB7tH5Id8wCBFlFvMnyK+SeHf7CQXDwWt/C7zt8hsGnZYCTsw5XcrByJxc9R36/lc9S
         Z7kA==
X-Gm-Message-State: ACrzQf0HguZ4oqJ71xfL7AgGX6CnvRbTdeWqsCBeo+vI7sbcdzwGtPZC
        yvqw8ZjEWRmA9gUUlTBjtlg+lbyu56LLGEVoQibJCA==
X-Google-Smtp-Source: AMsMyM6KLbOdRtdnqqasj6uf/KvNNi26YuJ8uJwYogOKbtCN2OaIs1Boa0viHFPJjZPGe3zFvUwEyrB66Fq89CUxc8o=
X-Received: by 2002:a05:6638:379f:b0:363:cd63:1954 with SMTP id
 w31-20020a056638379f00b00363cd631954mr22919914jal.103.1666649706202; Mon, 24
 Oct 2022 15:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221021041526.3696483-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 24 Oct 2022 16:14:55 -0600
Message-ID: <CANLsYkyEonDyqCuOi+vHGBC6ZnyWu61k5Vr1iTX40mzL4nFKnA@mail.gmail.com>
Subject: Re: [PATCH V8 0/7] remoteproc: imx_rproc: support i.MX8QM/QXP
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     bjorn.andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have applied this set.

Thanks,
Mathieu

On Thu, 20 Oct 2022 at 22:14, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V8:
>  patch 2/7: Per Krzysztof, keep alphabetical order for compatible string
>  Patch 6/7: Add comments to explain the tx_ch/rx_ch check in imx_rproc_xtr_mbox_init,
>             to address comment: https://lore.kernel.org/all/20221017173335.GA121862@p14s/
>
> V7:
>  patch 3/7: use dev_err, and R-b from Mathieu
>  patch 4/7: Add comment when "num_pd <= 1", add R-b from Mathieu
>  patch 5/7: Typo has->have, add R-b from Mathieu
>  patch 6/7: add detach hook to free the mbox. As wrote in the patch commit log,
>           imx_rproc_xtr_mbox_init is called both in probe and attach hook to resolve
>           mbox defer probe, so there is check in imx_rproc_xtr_mbox_init.
>             Moved imx_rproc_free_mbox out from parition notify to detach hook
>  patch 7/7: since detach hook moved to patch 6/7, so only enable recovery feature.
>
>  https://lore.kernel.org/all/20221014031037.1070424-1-peng.fan@oss.nxp.com/
>
> V6:
>  Two changes are made:
> 1.
>  In V5, patch 3 has a wrong logic in imx_rproc_put_scu, see [1], however
>  patch 4 fixed the wrong logic, as below:
>
> -       if (!imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> -               return;
> +       if (imx_sc_rm_is_resource_owned(priv->ipc_handle, priv->rsrc_id))
> +               return imx_rproc_detach_pd(rproc);
>
>  In V6, patch 3 fixed the wrong logic, drop the fix in patch 4. And patch 4
>  changed as below, because put scu not has return value.
>                 imx_rproc_detach_pd(rproc);
>                 return;
>
> 2. Include patch 7/7 to enable attach recovery, because the attach recovery
>  feature has been supported in remoteproc core.
>
> [1] https://lore.kernel.org/linux-remoteproc/DU0PR04MB941763C3EBF8AE9A9CD69445884C9@DU0PR04MB9417.eurprd04.prod.outlook.com/T/#m87e2864260d0a1c431b577068ba79e1d64c595f1
>
> V5:
>  The patchset could not apply on latest remoteproc for-next branch,
>  so rebased. Only patch 6 has a minor conflict, other patches are not
>  changed.
>
> V4:
>  https://lore.kernel.org/all/20220701104725.557314-1-peng.fan@oss.nxp.com/
>  Add R-b from DT maintainer
>  Fix probe failure and driver remove path in patch 3, 4
>  Add comments about i.MX8QM entries filter in patch 5
>
> V3:
>  Drop the dependency in V2.
>  Tested on i.MX8QM/8MM
>  Use 'fsl,resource-id' and 'fsl,entry-address' Per dt maintainer
>  Drop 'reg' property Per remoteproc maintainer
>  Drop mcore self recovery, until we land in common framework support.
>  https://patchwork.kernel.org/project/linux-remoteproc/cover/20220517064937.4033441-1-peng.fan@oss.nxp.com/
>
> V2:
>  https://patchwork.kernel.org/project/linux-remoteproc/cover/20220309102118.8131-1-peng.fan@oss.nxp.com/
>  Depends on https://patchwork.kernel.org/project/linux-remoteproc/list/?series=621311
>  Tested on i.MX8QXP/QM/8MP
>  Addressed Mathieu's comments
>  Drop V1 patch 5/9, patch 3/9 is replaced with upper dependency patchset
>  Move V1 patch 4/9 out to https://patchwork.kernel.org/project/linux-remoteproc/patch/20220308065754.3355-1-peng.fan@oss.nxp.com/
>  Update commit log
>  Drop magic number to get entry address from device tree in patch 4/6
>
> The V1 patchset:
> https://patchwork.kernel.org/project/linux-remoteproc/patch/20220111033333.403448-4-peng.fan@oss.nxp.com/
>
> Peng Fan (7):
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QXP
>   dt-bindings: remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: support attaching to i.MX8QXP M4
>   remoteproc: imx_rproc: support kicking Mcore from Linux for i.MX8QXP
>   remoteproc: imx_rproc: support i.MX8QM
>   remoteproc: imx_rproc: request mbox channel later
>   remoteproc: imx_rproc: Enable attach recovery for i.MX8QM/QXP
>
>  .../bindings/remoteproc/fsl,imx-rproc.yaml    |  16 +
>  drivers/remoteproc/imx_rproc.c                | 294 +++++++++++++++++-
>  2 files changed, 304 insertions(+), 6 deletions(-)
>
> --
> 2.37.1
>
