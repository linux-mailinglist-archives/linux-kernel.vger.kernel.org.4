Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793DC69EE43
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbjBVFTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjBVFTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:19:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9F93432C;
        Tue, 21 Feb 2023 21:19:32 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s22so8442625lfi.9;
        Tue, 21 Feb 2023 21:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vFxknHf70WyN5xkLwsDT8RicelViEW38jmkvWXuqBJA=;
        b=iEznKgBx4zmxsixB3cukUeKcLMmzha2ioHvXLPjXhdVAluc3blsAN+phD+2zx4KBjP
         yivA0RZDHtAQGaIMSUbWN7U6feuo5u41gKnuWI0QXa4XHwcz1lP0ziC/5nGZRbx/o+fC
         BGUdnFA50Scid2W/BSKUWaBtbsQK4f+nIXMgMYYPpCwtC8HrpulkfnlKV/s0cYlcc1N8
         Ts0Nmyaz3peH1PAp+HSP8qhOr8IEoX/v8l52A+51VZ3XahDmWQN2aDVc4IMWY1++7fb/
         yiYbsDX9JmLYypv0kW8oPuBP4ptRbzQCpHyBnhnKTY55pFFplgk33tgYsQqoF6AjmMxY
         yqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFxknHf70WyN5xkLwsDT8RicelViEW38jmkvWXuqBJA=;
        b=gSPx9+bt7ml1JgUIfbhAEX1spcAWRLZxN8wtOmWFkoGcChRxgpmIBgbNwuplfiUMOZ
         9Q0AWxrY7XPHC3LRrfQ2jBBhqQjpqgEwXOLXiu5tENPjgWePXzPsHdM/5qBc495lgqoQ
         EcL6/3eM/RBP9KZ4lkC9DrdYDMax48vJW5BwI9JbdRTIbYXkKKqQAqJm8f25VYzlj6L1
         I8wDjHIiE0wth+nC54ey2aMNa8hYNh/A38CeWzhYAElO2jzbT/b1bRwBikQqgIImSOuF
         UCmhzVo/r5enMDtkOXT9GqZtNOD6Tz2Lde2NIvAR0VS0Dx+nisQ2hJ3wC2qRuFutFakv
         ajJg==
X-Gm-Message-State: AO0yUKXIVncO94CX8NojBX061NoIDzlrqqH5QEf3vlNjf8cMp4l7Dgv0
        mOxBEhguNNBmzi4vmqSQmsFR9VhFrbbwKp6KcA==
X-Google-Smtp-Source: AK7set8jBro1k9Sk+DR5U/YO1Vnv7b3fghO75BG6pfX4GC3RTuomOlkgyicjF2eLx51xwgEJMAwpGRSKsRy1wVEEyGw=
X-Received: by 2002:ac2:568a:0:b0:4db:3901:3fdf with SMTP id
 10-20020ac2568a000000b004db39013fdfmr2503653lfr.0.1677043170253; Tue, 21 Feb
 2023 21:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20230222030427.957-1-powen.kao@mediatek.com> <20230222030427.957-7-powen.kao@mediatek.com>
In-Reply-To: <20230222030427.957-7-powen.kao@mediatek.com>
From:   Stanley Chu <chu.stanley@gmail.com>
Date:   Wed, 22 Feb 2023 13:19:18 +0800
Message-ID: <CAGaU9a9gcVA8Sz1F8TqZt2q2_P3XxuJ4E437CFGP6kA95ApRqg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] scsi: ufs: core: Export symbols for MTK driver module
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
        wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
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

On Wed, Feb 22, 2023 at 11:05 AM Po-Wen Kao <powen.kao@mediatek.com> wrote:
>
> Export
> - ufshcd_mcq_config_mac
> - ufshcd_mcq_make_queues_operational
> - ufshcd_mcq_read_cqis
> - ufshcd_disable_intr
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> ---
>  drivers/ufs/core/ufs-mcq.c     | 3 +++
>  drivers/ufs/core/ufshcd-priv.h | 2 --
>  drivers/ufs/core/ufshcd.c      | 3 ++-
>  include/ufs/ufshcd.h           | 6 ++++++
>  4 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index d1ff3ccd2085..ae67ab90bd29 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -98,6 +98,7 @@ void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds)
>         val |= FIELD_PREP(MCQ_CFG_MAC_MASK, max_active_cmds);
>         ufshcd_writel(hba, val, REG_UFS_MCQ_CFG);
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_config_mac);
>
>  /**
>   * ufshcd_mcq_req_to_hwq - find the hardware queue on which the
> @@ -271,6 +272,7 @@ u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
>  {
>         return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_read_cqis);
>
>  void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i)
>  {
> @@ -401,6 +403,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
>                               MCQ_CFG_n(REG_SQATTR, i));
>         }
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_mcq_make_queues_operational);
>
>  void ufshcd_mcq_enable_esi(struct ufs_hba *hba)
>  {
> diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
> index 13534a9a6d0a..1c83a6bc88b7 100644
> --- a/drivers/ufs/core/ufshcd-priv.h
> +++ b/drivers/ufs/core/ufshcd-priv.h
> @@ -75,8 +75,6 @@ int ufshcd_mcq_init(struct ufs_hba *hba);
>  int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
>  void ufshcd_mcq_print_hwqs(struct ufs_hba *hba, unsigned long bitmap);
>  int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
> -void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
> -void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
>  void ufshcd_mcq_select_mcq_mode(struct ufs_hba *hba);
>  u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
>  void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 21e3bf5d8f08..a0848a8e2e6f 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -2567,7 +2567,7 @@ static void ufshcd_enable_intr(struct ufs_hba *hba, u32 intrs)
>   * @hba: per adapter instance
>   * @intrs: interrupt bits
>   */
> -static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
> +void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
>  {
>         u32 set = ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
>
> @@ -2583,6 +2583,7 @@ static void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs)
>
>         ufshcd_writel(hba, set, REG_INTERRUPT_ENABLE);
>  }
> +EXPORT_SYMBOL_GPL(ufshcd_disable_intr);
>
>  /**
>   * ufshcd_prepare_req_desc_hdr - Fill UTP Transfer request descriptor header according to request
> diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
> index 8f79cca449e1..d4dc7bcec127 100644
> --- a/include/ufs/ufshcd.h
> +++ b/include/ufs/ufshcd.h
> @@ -1230,6 +1230,7 @@ static inline void ufshcd_rmwl(struct ufs_hba *hba, u32 mask, u32 val, u32 reg)
>
>  int ufshcd_alloc_host(struct device *, struct ufs_hba **);
>  void ufshcd_dealloc_host(struct ufs_hba *);
> +void ufshcd_disable_intr(struct ufs_hba *hba, u32 intrs);
>  int ufshcd_hba_enable(struct ufs_hba *hba);
>  int ufshcd_init(struct ufs_hba *, void __iomem *, unsigned int);
>  int ufshcd_link_recovery(struct ufs_hba *hba);
> @@ -1242,9 +1243,14 @@ void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk);
>  void ufshcd_update_evt_hist(struct ufs_hba *hba, u32 id, u32 val);
>  void ufshcd_hba_stop(struct ufs_hba *hba);
>  void ufshcd_schedule_eh_work(struct ufs_hba *hba);
> +
> +void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
> +u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i);
>  void ufshcd_mcq_write_cqis(struct ufs_hba *hba, u32 val, int i);
> +

Dummy empty line?

>  unsigned long ufshcd_mcq_poll_cqe_nolock(struct ufs_hba *hba,
>                                          struct ufs_hw_queue *hwq);
> +void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
>  void ufshcd_mcq_enable_esi(struct ufs_hba *hba);
>  void ufshcd_mcq_config_esi(struct ufs_hba *hba, struct msi_msg *msg);
>
> --
> 2.18.0
>

Except for the above nickpicking, others look good to me.

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
