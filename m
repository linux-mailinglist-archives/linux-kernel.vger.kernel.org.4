Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D707380CF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjFUK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjFUK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:28:00 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD56A3;
        Wed, 21 Jun 2023 03:27:57 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-460eb67244eso2013721e0c.1;
        Wed, 21 Jun 2023 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687343276; x=1689935276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtjYH+2P+QYg94YakrCegFEQ872mnB10+dWRjipMnUo=;
        b=qoDafpm0f2q8nhGgg/vwpPkaiPg3Pt/0GB1d6QIAhWy9KwD/C/tWUe3WcthP3Nc7ay
         svcAODK6N7W6HBEU1msi2/fYZWnW1PoAZGEspVFvF8J8YmslPDP/2zSXS0X6H69HaC+V
         LRaY5RdJfLhL/zq4f1f5Cm0YBEwcKb7jlvLTqXq3DkKmmsEseVeJS9LZ1YL85RBhdCas
         J3hT9gHC53YMKpkcx3b+9PTUmQrrphRnGsCrfYN2ZH/ZNJ1ObGy3HNiHbBUMhFIqzjA2
         90PDRnWTsPiO0z9ddpAdrMmGOUnJ/WwPMlt95OISZQjFvChsSeclaqELe26g3K9up/0z
         lKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687343276; x=1689935276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtjYH+2P+QYg94YakrCegFEQ872mnB10+dWRjipMnUo=;
        b=CDd2t6xIYVT2I9POsZijFFUoMNoLCRWPUWRWEaDJSZyioaYM3xk9Pw2XBSQsgolR1k
         BPXJPtm1PJmjTJwrbnWgtgrCtnnLytODiaMx5xTJPhGr9c5wFHv907T0qbimzWn3h5iX
         cwXwF/piWofawC2zNgI6ZY71CDw7mUT1xi73BHWXrsNQlFshPIFRkw2VcwWmLfOwlAwI
         hwMiMftt8C/WEdEpN0IPgKEybil6Ylz/8GVLiTWXbklMeduatLFzJbhgwLfKZCvSfPOy
         XDWayou77DPDKbq6ViY8UkAncageQkSAw+sqTEEg71pc9hrE3ShaXZNdfQV3PEcrkpwW
         N8Ow==
X-Gm-Message-State: AC+VfDyRBG0n5t5HGH7XUkobxWp2ieE7YgMzditSwNl8hbRsZ4EHSQ8a
        Q1KPw6lJswdcnHK1C3pyDNNe8PgTxVFyhTD0g0min0oWunI=
X-Google-Smtp-Source: ACHHUZ4t0OkCUEzBZiIOm5uLT/k8Ml9vU5e/kEkKc1ssbMCEN9jmm/1rExDbigXPoW37bFR8EJ5dxCFT9Q+j+hip74w=
X-Received: by 2002:a1f:bfd7:0:b0:471:6b1d:3796 with SMTP id
 p206-20020a1fbfd7000000b004716b1d3796mr5743444vkf.1.1687343276289; Wed, 21
 Jun 2023 03:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230331105546.13607-1-victor.shih@genesyslogic.com.tw>
 <20230331105546.13607-8-victor.shih@genesyslogic.com.tw> <20bd15db-9483-59b8-a5e5-6f047b215bb8@intel.com>
In-Reply-To: <20bd15db-9483-59b8-a5e5-6f047b215bb8@intel.com>
From:   Victor Shih <victorshihgli@gmail.com>
Date:   Wed, 21 Jun 2023 18:27:44 +0800
Message-ID: <CAK00qKDDZfM=Hsd25nUm5yvvqgpN4K7DSgdOHk4D5QDvaOV9uQ@mail.gmail.com>
Subject: Re: [PATCH V7 07/23] mmc: sdhci: add UHS-II related definitions in headers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, ulf.hansson@linaro.org,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        takahiro.akashi@linaro.org, dlunev@chromium.org,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Adrian

On Wed, Apr 12, 2023 at 9:09=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 31/03/23 13:55, Victor Shih wrote:
> > Add UHS-II related definitions in shdci.h and sdhci-uhs2.h.
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Here and other patches:
>
> From:/Signed-off-by: email address mismatch: 'From: Victor Shih <victorsh=
ihgli@gmail.com>' !=3D 'Signed-off-by: Victor Shih <victor.shih@genesyslogi=
c.com.tw>'
>

I will fix it in the V8 version.

> > ---
> >  drivers/mmc/host/sdhci-uhs2.h | 178 ++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.h      |  62 +++++++++++-
> >  2 files changed, 239 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/mmc/host/sdhci-uhs2.h
> >
> > diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs=
2.h
>
> It is nice and neat which is great, but tabs would have been
> better than spaces.
>
> > new file mode 100644
> > index 000000000000..c47debb7497e
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-uhs2.h
> > @@ -0,0 +1,178 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controll=
er
> > + *  Interface driver
> > + *
> > + * Header file for Host Controller UHS2 related registers.
> > + *
> > + *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
> > + */
> > +#ifndef __SDHCI_UHS2_H
> > +#define __SDHCI_UHS2_H
> > +
> > +#include <linux/bits.h>
> > +
> > +/* SDHCI Category C registers : UHS2 usage */
> > +
> > +#define  SDHCI_UHS2_CM_TRAN_RESP                0x10
> > +#define  SDHCI_UHS2_SD_TRAN_RESP                0x18
> > +#define  SDHCI_UHS2_SD_TRAN_RESP_1              0x1C
> > +
> > +/* SDHCI Category B registers : UHS2 only */
> > +
> > +#define SDHCI_UHS2_BLOCK_SIZE                   0x80
> > +#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz)      ((((dma) & 0x7) << 12)=
 | ((blksz) & 0xFFF))
> > +
> > +#define SDHCI_UHS2_BLOCK_COUNT                  0x84
> > +
> > +#define SDHCI_UHS2_CMD_PACKET                   0x88
> > +#define  SDHCI_UHS2_CMD_PACK_MAX_LEN            20
> > +
> > +#define SDHCI_UHS2_TRANS_MODE                   0x9C
> > +#define  SDHCI_UHS2_TRNS_DMA                    BIT(0)
> > +#define  SDHCI_UHS2_TRNS_BLK_CNT_EN             BIT(1)
> > +#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT          BIT(4)
> > +#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE          BIT(5)
> > +#define  SDHCI_UHS2_TRNS_RES_R5                 BIT(6)
> > +#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN       BIT(7)
> > +#define  SDHCI_UHS2_TRNS_RES_INT_DIS            BIT(8)
> > +#define  SDHCI_UHS2_TRNS_WAIT_EBSY              BIT(14)
> > +#define  SDHCI_UHS2_TRNS_2L_HD                  BIT(15)
> > +
> > +#define SDHCI_UHS2_CMD                          0x9E
> > +#define  SDHCI_UHS2_CMD_SUB_CMD                 BIT(2)
> > +#define  SDHCI_UHS2_CMD_DATA                    BIT(5)
> > +#define  SDHCI_UHS2_CMD_TRNS_ABORT              BIT(6)
> > +#define  SDHCI_UHS2_CMD_CMD12                   BIT(7)
> > +#define  SDHCI_UHS2_CMD_DORMANT                 GENMASK(7, 6)
> > +#define  SDHCI_UHS2_CMD_PACK_LEN_MASK           GENMASK(12, 8)
> > +
> > +#define SDHCI_UHS2_RESPONSE                     0xA0
> > +#define  SDHCI_UHS2_RESPONSE_MAX_LEN            20
> > +
> > +#define SDHCI_UHS2_MSG_SELECT                   0xB4
> > +#define SDHCI_UHS2_MSG_SELECT_CURR              0x0
> > +#define SDHCI_UHS2_MSG_SELECT_ONE               0x1
> > +#define SDHCI_UHS2_MSG_SELECT_TWO               0x2
> > +#define SDHCI_UHS2_MSG_SELECT_THREE             0x3
> > +
> > +#define SDHCI_UHS2_MSG                          0xB8
> > +
> > +#define SDHCI_UHS2_DEV_INT_STATUS               0xBC
> > +
> > +#define SDHCI_UHS2_DEV_SELECT                   0xBE
> > +#define SDHCI_UHS2_DEV_SEL_MASK                 GENMASK(3, 0)
> > +#define SDHCI_UHS2_DEV_SEL_INT_MSG_EN           BIT(7)
> > +
> > +#define SDHCI_UHS2_DEV_INT_CODE                 0xBF
> > +
> > +#define SDHCI_UHS2_SW_RESET                     0xC0
> > +#define SDHCI_UHS2_SW_RESET_FULL                BIT(0)
> > +#define SDHCI_UHS2_SW_RESET_SD                  BIT(1)
> > +
> > +#define SDHCI_UHS2_TIMER_CTRL                   0xC2
> > +#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK     GENMASK(7, 4)
> > +
> > +#define SDHCI_UHS2_INT_STATUS                   0xC4
> > +#define SDHCI_UHS2_INT_STATUS_ENABLE            0xC8
> > +#define SDHCI_UHS2_INT_SIGNAL_ENABLE            0xCC
> > +#define SDHCI_UHS2_INT_HEADER_ERR               BIT(0)
> > +#define SDHCI_UHS2_INT_RES_ERR                  BIT(1)
> > +#define SDHCI_UHS2_INT_RETRY_EXP                BIT(2)
> > +#define SDHCI_UHS2_INT_CRC                      BIT(3)
> > +#define SDHCI_UHS2_INT_FRAME_ERR                BIT(4)
> > +#define SDHCI_UHS2_INT_TID_ERR                  BIT(5)
> > +#define SDHCI_UHS2_INT_UNRECOVER                BIT(7)
> > +#define SDHCI_UHS2_INT_EBUSY_ERR                BIT(8)
> > +#define SDHCI_UHS2_INT_ADMA_ERROR               BIT(15)
> > +#define SDHCI_UHS2_INT_CMD_TIMEOUT              BIT(16)
> > +#define SDHCI_UHS2_INT_DEADLOCK_TIMEOUT         BIT(17)
> > +#define SDHCI_UHS2_INT_VENDOR_ERR               BIT(27)
> > +#define SDHCI_UHS2_INT_ERROR_MASK            ( \
> > +            SDHCI_UHS2_INT_HEADER_ERR      | \
> > +            SDHCI_UHS2_INT_RES_ERR         | \
> > +            SDHCI_UHS2_INT_RETRY_EXP       | \
> > +            SDHCI_UHS2_INT_CRC             | \
> > +            SDHCI_UHS2_INT_FRAME_ERR       | \
> > +            SDHCI_UHS2_INT_TID_ERR         | \
> > +            SDHCI_UHS2_INT_UNRECOVER       | \
> > +            SDHCI_UHS2_INT_EBUSY_ERR       | \
> > +            SDHCI_UHS2_INT_ADMA_ERROR      | \
> > +            SDHCI_UHS2_INT_CMD_TIMEOUT     | \
> > +            SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
> > +#define SDHCI_UHS2_INT_CMD_ERR_MASK     ( \
> > +            SDHCI_UHS2_INT_HEADER_ERR | \
> > +            SDHCI_UHS2_INT_RES_ERR    | \
> > +            SDHCI_UHS2_INT_FRAME_ERR  | \
> > +            SDHCI_UHS2_INT_TID_ERR    | \
> > +            SDHCI_UHS2_INT_CMD_TIMEOUT)
> > +/* CRC Error occurs during a packet receiving */
> > +#define SDHCI_UHS2_INT_DATA_ERR_MASK         ( \
> > +            SDHCI_UHS2_INT_RETRY_EXP       | \
> > +            SDHCI_UHS2_INT_CRC             | \
> > +            SDHCI_UHS2_INT_UNRECOVER       | \
> > +            SDHCI_UHS2_INT_EBUSY_ERR       | \
> > +            SDHCI_UHS2_INT_ADMA_ERROR      | \
> > +            SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
> > +
> > +#define SDHCI_UHS2_SETTINGS_PTR                 0xE0
> > +#define   SDHCI_UHS2_GEN_SETTINGS_POWER_LOW     BIT(0)
> > +#define   SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK  GENMASK(11, 8)
> > +#define   SDHCI_UHS2_FD_OR_2L_HD                0x0 /* 2 lanes */
> > +#define   SDHCI_UHS2_2D1U_FD                    0x2 /* 3 lanes, 2 down=
, 1 up, full duplex */
> > +#define   SDHCI_UHS2_1D2U_FD                    0x3 /* 3 lanes, 1 down=
, 2 up, full duplex */
> > +#define   SDHCI_UHS2_2D2U_FD                    0x4 /* 4 lanes, 2 down=
, 2 up, full duplex */
> > +
> > +#define   SDHCI_UHS2_PHY_SET_SPEED_B            BIT(6)
> > +#define   SDHCI_UHS2_PHY_HIBERNATE_EN           BIT(12)
> > +#define   SDHCI_UHS2_PHY_N_LSS_SYN_MASK         GENMASK(19, 16)
> > +#define   SDHCI_UHS2_PHY_N_LSS_DIR_MASK         GENMASK(23, 20)
> > +
> > +#define   SDHCI_UHS2_TRAN_N_FCU_MASK            GENMASK(15, 8)
> > +#define   SDHCI_UHS2_TRAN_RETRY_CNT_MASK        GENMASK(17, 16)
> > +#define   SDHCI_UHS2_TRAN_1_N_DAT_GAP_MASK      GENMASK(7, 0)
> > +
> > +#define SDHCI_UHS2_CAPS_PTR                     0xE2
> > +#define  SDHCI_UHS2_CAPS_OFFSET                 0
> > +#define   SDHCI_UHS2_CAPS_DAP_MASK              GENMASK(3, 0)
> > +#define   SDHCI_UHS2_CAPS_GAP_MASK              GENMASK(7, 4)
> > +#define   SDHCI_UHS2_CAPS_GAP(gap)              ((gap) * 360)
> > +#define   SDHCI_UHS2_CAPS_LANE_MASK             GENMASK(13, 8)
> > +#define    SDHCI_UHS2_CAPS_2L_HD_FD             1
> > +#define    SDHCI_UHS2_CAPS_2D1U_FD              2
> > +#define    SDHCI_UHS2_CAPS_1D2U_FD              4
> > +#define    SDHCI_UHS2_CAPS_2D2U_FD              8
> > +#define   SDHCI_UHS2_CAPS_ADDR_64               BIT(14)
> > +#define   SDHCI_UHS2_CAPS_BOOT                  BIT(15)
> > +#define   SDHCI_UHS2_CAPS_DEV_TYPE_MASK         GENMASK(17, 16)
> > +#define    SDHCI_UHS2_CAPS_DEV_TYPE_RMV         0
> > +#define    SDHCI_UHS2_CAPS_DEV_TYPE_EMB         1
> > +#define    SDHCI_UHS2_CAPS_DEV_TYPE_EMB_RMV     2
> > +#define   SDHCI_UHS2_CAPS_NUM_DEV_MASK          GENMASK(21, 18)
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_MASK         GENMASK(23, 22)
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_SHIFT        22
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_P2P          0
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_RING         1
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB          2
> > +#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB_RING     3
> > +
> > +#define  SDHCI_UHS2_CAPS_PHY_OFFSET             4
> > +#define   SDHCI_UHS2_CAPS_PHY_REV_MASK          GENMASK(5, 0)
> > +#define   SDHCI_UHS2_CAPS_PHY_RANGE_MASK        GENMASK(7, 6)
> > +#define   SDHCI_UHS2_CAPS_PHY_RANGE_A           0
> > +#define   SDHCI_UHS2_CAPS_PHY_RANGE_B           1
> > +#define   SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK    GENMASK(19, 16)
> > +#define   SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK    GENMASK(23, 20)
> > +#define  SDHCI_UHS2_CAPS_TRAN_OFFSET            8
> > +#define   SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK    GENMASK(5, 0)
> > +#define   SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK       GENMASK(15, 8)
> > +#define   SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK   GENMASK(18, 16)
> > +#define   SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK     GENMASK(31, 20)
> > +
> > +#define  SDHCI_UHS2_CAPS_TRAN_1_OFFSET          12
> > +#define  SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK GENMASK(7, 0)
> > +
> > +#define SDHCI_UHS2_EMBED_CTRL_PTR               0xE6
> > +#define SDHCI_UHS2_VENDOR_PTR                   0xE8
> > +
> > +#endif /* __SDHCI_UHS2_H */
> > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > index f4f2085c274c..2c7ab4453248 100644
> > --- a/drivers/mmc/host/sdhci.h
> > +++ b/drivers/mmc/host/sdhci.h
> > @@ -43,8 +43,23 @@
> >  #define  SDHCI_TRNS_READ     0x10
> >  #define  SDHCI_TRNS_MULTI    0x20
> >
> > +/*
> > + * Defined in Host Version 4.0.
> > + */
> > +#define  SDHCI_TRNS_RES_TYPE         0x40
> > +#define  SDHCI_TRNS_RES_ERR_CHECK    0x80
> > +#define  SDHCI_TRNS_RES_INT_DIS              0x0100
> > +
> >  #define SDHCI_COMMAND                0x0E
> >  #define  SDHCI_CMD_RESP_MASK 0x03
> > +
> > +/*
> > + * Host Version 4.10 adds this bit to distinguish a main command or
> > + * sub command.
> > + * For example with SDIO, CMD52 (sub command) issued during CMD53 (mai=
n command).
> > + */
> > +#define  SDHCI_CMD_SUB_CMD   0x04
> > +
> >  #define  SDHCI_CMD_CRC               0x08
> >  #define  SDHCI_CMD_INDEX     0x10
> >  #define  SDHCI_CMD_DATA              0x20
> > @@ -65,6 +80,9 @@
> >  #define SDHCI_PRESENT_STATE  0x24
> >  #define  SDHCI_CMD_INHIBIT   0x00000001
> >  #define  SDHCI_DATA_INHIBIT  0x00000002
> > +
> > +#define  SDHCI_DAT_4_TO_7_LVL_MASK   0x000000F0
> > +
> >  #define  SDHCI_DOING_WRITE   0x00000100
> >  #define  SDHCI_DOING_READ    0x00000200
> >  #define  SDHCI_SPACE_AVAILABLE       0x00000400
> > @@ -80,6 +98,15 @@
> >  #define   SDHCI_DATA_0_LVL_MASK      0x00100000
> >  #define  SDHCI_CMD_LVL               0x01000000
> >
> > +/* Host Version 4.10 */
> > +
> > +#define  SDHCI_HOST_REGULATOR_STABLE 0x02000000
> > +#define  SDHCI_CMD_NOT_ISSUED_ERR    0x08000000
> > +#define  SDHCI_SUB_CMD_STATUS                0x10000000
> > +#define  SDHCI_UHS2_IN_DORMANT_STATE 0x20000000
> > +#define  SDHCI_UHS2_LANE_SYNC                0x40000000
> > +#define  SDHCI_UHS2_IF_DETECT                0x80000000
> > +
> >  #define SDHCI_HOST_CONTROL   0x28
> >  #define  SDHCI_CTRL_LED              0x01
> >  #define  SDHCI_CTRL_4BITBUS  0x02
> > @@ -100,6 +127,14 @@
> >  #define  SDHCI_POWER_300     0x0C
> >  #define  SDHCI_POWER_330     0x0E
> >
> > +/*
> > + * VDD2 - UHS2
> > + * VDD2 power on/off and voltage select (UHS2)
> > + */
> > +#define  SDHCI_VDD2_POWER_ON         0x10
> > +#define  SDHCI_VDD2_POWER_120                0x80
> > +#define  SDHCI_VDD2_POWER_180                0xA0
> > +
> >  #define SDHCI_BLOCK_GAP_CONTROL      0x2A
> >
> >  #define SDHCI_WAKE_UP_CONTROL        0x2B
> > @@ -110,7 +145,7 @@
> >  #define SDHCI_CLOCK_CONTROL  0x2C
> >  #define  SDHCI_DIVIDER_SHIFT 8
> >  #define  SDHCI_DIVIDER_HI_SHIFT      6
> > -#define  SDHCI_DIV_MASK      0xFF
> > +#define  SDHCI_DIV_MASK              0xFF
> >  #define  SDHCI_DIV_MASK_LEN  8
> >  #define  SDHCI_DIV_HI_MASK   0x300
> >  #define  SDHCI_PROG_CLOCK_MODE       0x0020
> > @@ -139,6 +174,10 @@
> >  #define  SDHCI_INT_CARD_REMOVE       0x00000080
> >  #define  SDHCI_INT_CARD_INT  0x00000100
> >  #define  SDHCI_INT_RETUNE    0x00001000
> > +
> > +/* Host Version 4.10 */
> > +#define  SDHCI_INT_FX_EVENT  0x00002000
> > +
> >  #define  SDHCI_INT_CQE               0x00004000
> >  #define  SDHCI_INT_ERROR     0x00008000
> >  #define  SDHCI_INT_TIMEOUT   0x00010000
> > @@ -152,6 +191,9 @@
> >  #define  SDHCI_INT_AUTO_CMD_ERR      0x01000000
> >  #define  SDHCI_INT_ADMA_ERROR        0x02000000
> >
> > +/* Host Version 4.0 */
> > +#define  SDHCI_INT_RESP_ERR  0x08000000
> > +
> >  #define  SDHCI_INT_NORMAL_MASK       0x00007FFF
> >  #define  SDHCI_INT_ERROR_MASK        0xFFFF8000
> >
> > @@ -178,6 +220,9 @@
> >  #define  SDHCI_AUTO_CMD_END_BIT      0x00000008
> >  #define  SDHCI_AUTO_CMD_INDEX        0x00000010
> >
> > +/* Host Version 4.10 */
> > +#define  SDHCI_AUTO_CMD_RESP_ERR     0x0020
> > +
> >  #define SDHCI_HOST_CONTROL2          0x3E
> >  #define  SDHCI_CTRL_UHS_MASK         0x0007
> >  #define   SDHCI_CTRL_UHS_SDR12               0x0000
> > @@ -186,6 +231,7 @@
> >  #define   SDHCI_CTRL_UHS_SDR104              0x0003
> >  #define   SDHCI_CTRL_UHS_DDR50               0x0004
> >  #define   SDHCI_CTRL_HS400           0x0005 /* Non-standard */
> > +#define   SDHCI_CTRL_UHS2            0x0007
> >  #define  SDHCI_CTRL_VDD_180          0x0008
> >  #define  SDHCI_CTRL_DRV_TYPE_MASK    0x0030
> >  #define   SDHCI_CTRL_DRV_TYPE_B              0x0000
> > @@ -194,9 +240,12 @@
> >  #define   SDHCI_CTRL_DRV_TYPE_D              0x0030
> >  #define  SDHCI_CTRL_EXEC_TUNING              0x0040
> >  #define  SDHCI_CTRL_TUNED_CLK                0x0080
> > +#define  SDHCI_CTRL_UHS2_ENABLE              0x0100
> > +#define  SDHCI_CTRL_ADMA2_LEN_MODE   0x0400
> >  #define  SDHCI_CMD23_ENABLE          0x0800
> >  #define  SDHCI_CTRL_V4_MODE          0x1000
> >  #define  SDHCI_CTRL_64BIT_ADDR               0x2000
> > +#define  SDHCI_CTRL_ASYNC_INT_ENABLE 0x4000
> >  #define  SDHCI_CTRL_PRESET_VAL_ENABLE        0x8000
> >
> >  #define SDHCI_CAPABILITIES   0x40
> > @@ -219,11 +268,13 @@
> >  #define  SDHCI_CAN_VDD_180   0x04000000
> >  #define  SDHCI_CAN_64BIT_V4  0x08000000
> >  #define  SDHCI_CAN_64BIT     0x10000000
> > +#define  SDHCI_CAN_ASYNC_INT 0x20000000
> >
> >  #define SDHCI_CAPABILITIES_1 0x44
> >  #define  SDHCI_SUPPORT_SDR50 0x00000001
> >  #define  SDHCI_SUPPORT_SDR104        0x00000002
> >  #define  SDHCI_SUPPORT_DDR50 0x00000004
> > +#define  SDHCI_SUPPORT_UHS2  0x00000008
> >  #define  SDHCI_DRIVER_TYPE_A 0x00000010
> >  #define  SDHCI_DRIVER_TYPE_C 0x00000020
> >  #define  SDHCI_DRIVER_TYPE_D 0x00000040
> > @@ -232,6 +283,7 @@
> >  #define  SDHCI_RETUNING_MODE_MASK            GENMASK(15, 14)
> >  #define  SDHCI_CLOCK_MUL_MASK                        GENMASK(23, 16)
> >  #define  SDHCI_CAN_DO_ADMA3  0x08000000
> > +#define  SDHCI_CAN_VDD2_180  0x10000000 /* UHS-2 1.8V VDD2 */
> >  #define  SDHCI_SUPPORT_HS400 0x80000000 /* Non-standard */
> >
> >  #define SDHCI_MAX_CURRENT            0x48
> > @@ -239,11 +291,14 @@
> >  #define  SDHCI_MAX_CURRENT_330_MASK  GENMASK(7, 0)
> >  #define  SDHCI_MAX_CURRENT_300_MASK  GENMASK(15, 8)
> >  #define  SDHCI_MAX_CURRENT_180_MASK  GENMASK(23, 16)
> > +#define SDHCI_MAX_CURRENT_1          0x4C
> > +#define  SDHCI_MAX_CURRENT_VDD2_180_MASK     GENMASK(7, 0) /* UHS2 */
> >  #define   SDHCI_MAX_CURRENT_MULTIPLIER       4
> >
> >  /* 4C-4F reserved for more max current */
> >
> >  #define SDHCI_SET_ACMD12_ERROR       0x50
> > +/* Host Version 4.10 */
> >  #define SDHCI_SET_INT_ERROR  0x52
> >
> >  #define SDHCI_ADMA_ERROR     0x54
> > @@ -262,10 +317,15 @@
> >  #define SDHCI_PRESET_FOR_SDR104        0x6C
> >  #define SDHCI_PRESET_FOR_DDR50 0x6E
> >  #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
> > +
> > +/* UHS2 */
> > +#define SDHCI_PRESET_FOR_UHS2  0x74
> >  #define SDHCI_PRESET_DRV_MASK                GENMASK(15, 14)
> >  #define SDHCI_PRESET_CLKGEN_SEL              BIT(10)
> >  #define SDHCI_PRESET_SDCLK_FREQ_MASK GENMASK(9, 0)
> >
> > +#define SDHCI_ADMA3_ADDRESS  0x78
> > +
> >  #define SDHCI_SLOT_INT_STATUS        0xFC
> >
> >  #define SDHCI_HOST_VERSION   0xFE
>

Thanks, Victor Shih
