Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59895FCAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbiJLSbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJLSbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 14:31:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567321AD94
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:31:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z20so17002684plb.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5tAqUnu5h8rAVMtbB+FKyxeFkhIJL7VzFEtUmPpmJDA=;
        b=mXjb+QXRlYo0akoSv3PaoWZ4NSgieFYMaHywaeMtJHKO2vY4zcNG1zl0Ox9HEh9uf7
         9ITp+MI7Xd+rl5IrO/HGwjtCsbF3fs1diciltjVQTGrGemRVCl0W3bkbCGaW1Y4pP0yq
         C+2Gc3R/j5LrXvvQ8aLtLF5LRyV9Em9QvfmsU4Mk/80jrdxDCu/wZLrU2Tq3IskMdgpZ
         YwMiVw66u9oM0DbjxBYdNZ8S9WqtAnaUHo3DqFoM46g8lLTzWfhhGUtoUAoVhPUXyATj
         bDBYAA3tSh6mh73MuMR12u/Mwt37tiFenzPQ6c2pDqUlgyeSddEp8mMbh0h4cOzHa8dM
         ipWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tAqUnu5h8rAVMtbB+FKyxeFkhIJL7VzFEtUmPpmJDA=;
        b=8Pq88oeSCqB2a+ssD+T2yjMmuh/D9df0GxvliaYlxhB0CSZJ6FCTYGXr0zFRmfvZvq
         fdATMWlejxN1brWF5I2QDzh1j6e75Qx4nZMU2Uf1W1DcybnkMu4D5LH9t0eP4PZNVmnr
         guFa79J1IzLe1OV/umWtAkxVf/HkyGEC59O3gAE6cyWG3oxl+VcYpqH4GVuvD/s6Wcz5
         1g3OINyS8rvhDKgl1I0YqBXrdllozezHhq+PuNpHAd4VUKi6N4CudzPKofSXC0Qp6co0
         19//2mNm0gnsxWF8t/SIQO4Jj44f+m42gr1OA2xRlPksJ8pystWsHoN4xHLCMnVPKWQE
         e7Xg==
X-Gm-Message-State: ACrzQf3BOFPU7Uovk+QvbP2sxH+uxkyFVrDt3ina6TlCEirDxrv3x0zb
        97IvUURuK1Rv2lxWcML6o3SatDEAOoiI4uFWt8Xyeg==
X-Google-Smtp-Source: AMsMyM6/I3x+f8jFzDA32M6v16hPvWIjQfqtnawjwThjPMRgAzjQ3h3WLO0YhkwAZ/q9coLz7eayocqj9uw5QftREgE=
X-Received: by 2002:a17:90a:4607:b0:202:e22d:4892 with SMTP id
 w7-20020a17090a460700b00202e22d4892mr6402905pjg.220.1665599480880; Wed, 12
 Oct 2022 11:31:20 -0700 (PDT)
MIME-Version: 1.0
References: <1665387971-17114-1-git-send-email-hongxing.zhu@nxp.com>
In-Reply-To: <1665387971-17114-1-git-send-email-hongxing.zhu@nxp.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 12 Oct 2022 11:31:08 -0700
Message-ID: <CAJ+vNU2G_zVcFBmS6cR-HQk0XKgx_KaXvwSNmCHRgDy69=J_4g@mail.gmail.com>
Subject: Re: [PATCH v12 0/4] Add the iMX8MP PCIe support
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     vkoul@kernel.org, a.fatoum@pengutronix.de, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, shawnguo@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 1:07 AM Richard Zhu <hongxing.zhu@nxp.com> wrote:
>
> Based on the 6.0-rc1 of the pci/next branch.
> This series adds the i.MX8MP PCIe support and tested on i.MX8MP
> EVK board when one PCIe NVME device is used.
>

Richard,

This no longer applies to pci/next (pci-v6.1-changes) and needs to be
rebased. It does apply on top of 6.0-rc1 but then the patches to
pci-imx6.c and imx8mp.dtsi are missing so I'm not sure where to try to
base this off of.

Do you have a repo for testing and have you been able to test a Gen3
link with A1 silicon yet?

Best Regards,

Tim
