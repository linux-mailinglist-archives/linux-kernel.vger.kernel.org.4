Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608A85F49C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiJDThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJDThu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:37:50 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A001EC46
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:37:49 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id j16so10947388wrh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=MUpueCuE/J7qezizADjX0kvdp/nyg8DWaUkjf19MNLU=;
        b=ZYsOO/XBzug7ZFE7K1ekR/9QH1t2PQq4MJPJEJWLjyztdkfEcn1oI/RhhD2TLwS+s6
         0L3wQLZqIvKHZaKzmP26LYD+5a/rx3AzoEEU1UQj/GIvyJVb1d7GNC97aZ7uAavSvqs5
         P/I4+gVLZNyhHfsQJ736Z+XEXf+HoR2eILsmEZRkOqOo8ioYjMNc0VJQL608PSTL9Ddo
         fHH7AoYBZeb7h0dFbGi8wd6sa4fvyC56rnEEwBOPUL8uo2HrjXmwLeWCmoBLMxnVo7FP
         /dKIs9RI0lOh/gjyxsZ4SmZ35edbv3ijG2iKMEAfK9uqj+z7yZ5uAWpr1Q/FTGyAkZ79
         WGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=MUpueCuE/J7qezizADjX0kvdp/nyg8DWaUkjf19MNLU=;
        b=fEB95MQYIHiR86vZxPN5BUfLFpGSWCkjOOv6THKKCymLWe4aOKdwfIzQsPiLT9zJlu
         3LrWoBlYMPLcg/GKaeaMSyAg8r9jrI+pK5a3kIB87ci5YAkY32JR/1WO6RCIfiHa2SV2
         gzkSm6G7+R80nrnLi7gejLHTqSGcerx4brUwIebl8C7bOPfiYl0J5wTDvtp1KKNB3BPZ
         6txqjaJzplKwyqC3OorqESZ2XZdhAzoHru/2ufZkfw06YTrw8xSdW1yu17UNNOePR/n9
         hc9AinU9cTN8XW7pGoCRXczSaF4ycuzwWs/77ll8+450a9JSmSsTz3YV/gNROsz5SFhd
         UiFg==
X-Gm-Message-State: ACrzQf3hk1Upzcgo+n3TSAk32pY8UNweMTAS3lpwPokNSSoODfG+uDNu
        8OYZdd7/lruAB4BvDypWrN0=
X-Google-Smtp-Source: AMsMyM4ZCX8JHJ711T3ZAlwg2yQbxxAWfZxJ6KbKZgUkP3PKZXZYXDYw+zZVW03tlpgqPM68inPjsg==
X-Received: by 2002:a05:6000:16c5:b0:22c:bdbd:e06b with SMTP id h5-20020a05600016c500b0022cbdbde06bmr17795355wrf.53.1664912268394;
        Tue, 04 Oct 2022 12:37:48 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id bj3-20020a0560001e0300b00226dfac0149sm7268735wrb.114.2022.10.04.12.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 12:37:47 -0700 (PDT)
Message-ID: <e5992130-ce33-9377-e3f3-9bfdb240f9b8@gmail.com>
Date:   Tue, 4 Oct 2022 20:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: re: irqchip: Add IMX MU MSI controller driver
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Static analysis with clang scan-build detected an issue with the 
following commit in linux-next:

commit 70afdab904d2d1e68bffe75fe08e7e48e0b0ff8e
Author: Frank Li <Frank.Li@nxp.com>
Date:   Thu Sep 22 11:12:43 2022 -0500

     irqchip: Add IMX MU MSI controller driver

The issue is as follows in source drivers/irqchip/irq-imx-mu-msi.c :


static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
         .type   = IMX_MU_V2,
         .xTR    = 0x200,
         .xRR    = 0x280,
         .xSR    = {
                         [IMX_MU_SR]  = 0xC,
                         [IMX_MU_GSR] = 0x118,
                         [IMX_MU_GSR] = 0x124,    /* <--- issue here */
                         [IMX_MU_RSR] = 0x12C,
                   },
         .xCR    = {
                         [IMX_MU_GIER] = 0x110,
                         [IMX_MU_GCR]  = 0x114,
                         [IMX_MU_TCR]  = 0x120,
                         [IMX_MU_RCR]  = 0x128
                   },
};

The .xSR object with index  IMX_MU_GSR is being set twice, once with 
0x118 and again with 0x128. I believe the first one should be IMX_MU_TSR 
but w/o the datasheet I don't want to make any assumptions.



Colin
