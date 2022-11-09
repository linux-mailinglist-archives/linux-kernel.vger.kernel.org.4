Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE7162215D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 02:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiKIBaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 20:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiKIBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 20:30:08 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1800161749;
        Tue,  8 Nov 2022 17:30:07 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 130so2530747pgc.5;
        Tue, 08 Nov 2022 17:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3N404XwUgTy0PrRfb6253/OsDITUBh8vwB0xePuTtwU=;
        b=mr+CAXTFhVONLtU0kR0l4utue8cMN3bgrveICwM770SB2o17suBZQOrM3lcp7Iyngz
         cOQNS93ebjlGkq8fri6BOwJDHMVsK6CU2jo3PbwT+3NpH5IgeQhVIAEGhKBchky62qBS
         dMgKnAKb2UYT6Fl+y8K03yqOI1WClTRiDCGkVxd3pMyFkseWLGktydMdGRXsvCqSU3vK
         53M77ogd/++Ydba4m0DKm0iJ0OucCBBMlSTZIw1xYXrVn7+VZoJdpP2uq3OY5l8oXB1m
         xZr+Ct5km4J2vbGZZd48vocRYtgGFtG/MFV6tobf6cZUzbJuPBzaKQA26D9Eu3635taZ
         DPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3N404XwUgTy0PrRfb6253/OsDITUBh8vwB0xePuTtwU=;
        b=D6yxBArQ/sH8/YSvQ3AcJlACQL/D+ko6sT6FpRChVUce8nS+WZaVq6q0ZtR8H6Y6ua
         TLY83STwD0tBwa157498Ws0N39k/blfwJDCUZ0ukzM823o1IjY+wOKvGZtPWY9Io/5YW
         InOHhzOVMZi/FzTfzUannwaFbQzR7OmRQZMubxvTT6K5Rz9vOuX94dbSH5HgGmmgCPE5
         c4ppn3lxhBqx4XmVDnLiQgcgV7inlKw4QnOxUx1mJLldiZ7kPRLnLL0DcUKOzdBEMBu2
         mpVgeFh1f0EiGm6BrjnsRL6A/wBbLF39sHPmQSCLehvckYV3ETjV2xv3PqQZ1n0GKGFV
         dzUg==
X-Gm-Message-State: ACrzQf3KqrIie7AA5skglOZCKnF/iBvxcraJzng/ltx0VKqb2+2shz//
        U9BT6rlgrQkx7XFPcsjFX0kknOASP2G9sQdL3aw=
X-Google-Smtp-Source: AMsMyM5dn/qopXh5MXQyDKeHSuuy/S7lMPRtUmwpiKQBKmiO3ZHqUmPH7v22FdbTgEABCsF2BvM+TzFIu5ZLS68TsKk=
X-Received: by 2002:a05:6a00:3249:b0:565:fc2c:ad79 with SMTP id
 bn9-20020a056a00324900b00565fc2cad79mr57915724pfb.72.1667957406569; Tue, 08
 Nov 2022 17:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20221027130859.1444412-1-shenwei.wang@nxp.com> <20221027130859.1444412-2-shenwei.wang@nxp.com>
In-Reply-To: <20221027130859.1444412-2-shenwei.wang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 8 Nov 2022 22:29:53 -0300
Message-ID: <CAOMZO5Cy3h50QmjnTBDNweQS3JZN6HEx6A549860hUg5opuftQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] arm64: dts: imx8dxl-ss-lsio: add gpio-ranges property
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
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

Hi Shenwei,

On Thu, Oct 27, 2022 at 10:09 AM Shenwei Wang <shenwei.wang@nxp.com> wrote:
>
> add gpio-ranges property for imx8dxl soc.

The commit log could be improved by stating the reason for adding gpio-ranges.

Thanks
