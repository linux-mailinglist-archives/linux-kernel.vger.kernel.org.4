Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7441A68CC41
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjBGBoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbjBGBoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:44:24 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9F9367F0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:43:14 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id ch22so262924uab.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igel-co-jp.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slsYSnRG5tB09fuwlP7s4BX6R5bETrWg46OL4k8XjfA=;
        b=FIb1ZpizHlfoN7P6ayp4RRvAysVicTtpBF8SISJSMocofSSaEeNXiWDOkOk/ERjo2F
         nCl3fmX+2ft4CQd0usAWBuT+OtaI5bjNpWVwb04gbe3keaY/AnxlDtjBpc6GrqXj3WJn
         kuKrBCHf+SgG1h4ohgrlSox048Ka9Iy2htkG8/X4LCIfOEHFeOVQv5C8A8is+bh/ni+R
         5hS2haTeNeNBHCj1vCIYqbF3v2lFirAYbda00jqHTxTUZtDevJdrGkoSQq0vi4IzEmjt
         ZSOahb3cu3MhXriD28SUBqe82dQ1abDBSrmywldNO+08HTs3ZoNnc3PK3x5p3n5zX2sc
         WvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slsYSnRG5tB09fuwlP7s4BX6R5bETrWg46OL4k8XjfA=;
        b=Lu6QeCZHU/aIe3UKpChxf5jMMtNVXbfHD0osyE1bza5GUbnHzSfG6XyFyoQ5HwJ0gT
         BXORZQG9Tk9niQ3f0FPP+bTkhvWMkJ/DHbidr7DfLTWyhI2X1Vl7LB12Us8DWFgyxkdZ
         foSnLR01B3iMRCd5nflfQ8Uz9hrWqOZM9809MNsJNpLYuQXIBwUo11dqqs7p5taE+x90
         Vt7rdTK6YTpUrX/nJNU2BXUUNCT6jEdw681JoyNqMG+TrwH+IpPekrUFkIlmNAxFXGsq
         Tjv9eSe2BJHy4zHKn5ImLVxfBgI7PhHCdYZ+3zOGsUzGAhV7GCcqn8rnqScXDNSut8w+
         8cMw==
X-Gm-Message-State: AO0yUKUnkGzcYTfFnOvsZTfK5gJaovzcdY49rXXt77fFdfiwCkflZV3D
        TpCbQtuCsVHn9qUazBVxtswSOUVG2shSAHjmJej8INReIZp49ecJui4=
X-Google-Smtp-Source: AK7set+171qFNiP3BgyEC1MS/cg3RppIvueqeqqZzIW6EdlKC5IDXHn7wwlPVkgdwbOW5B+xl/8Ahe36nt0AaY6uYbA=
X-Received: by 2002:ab0:660f:0:b0:670:ff15:7f5f with SMTP id
 r15-20020ab0660f000000b00670ff157f5fmr287912uam.16.1675734190964; Mon, 06 Feb
 2023 17:43:10 -0800 (PST)
MIME-Version: 1.0
References: <20230203100418.2981144-1-mie@igel.co.jp> <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
In-Reply-To: <HE1PR0401MB2331582DC0401DFA4EB5540C88D79@HE1PR0401MB2331.eurprd04.prod.outlook.com>
From:   Shunsuke Mie <mie@igel.co.jp>
Date:   Tue, 7 Feb 2023 10:43:00 +0900
Message-ID: <CANXvt5pCnC=7DaPkFi4v1WUbzrgETVL03aAi=aq-uBFFxqhTyA@mail.gmail.com>
Subject: Re: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP function
To:     Frank Li <frank.li@nxp.com>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jon Mason <jdmason@kudzu.us>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Takanari Hayama <taki@igel.co.jp>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023=E5=B9=B42=E6=9C=884=E6=97=A5(=E5=9C=9F) 6:48 Frank Li <frank.li@nxp.co=
m>:
>
> > foundation.org
> > Subject: [EXT] [RFC PATCH 0/4] PCI: endpoint: Introduce a virtio-net EP
> > function
> >
>
> The dependent EDMA patch can't be applied at last linux-next.
> Can you provide a git link? So I can try directly.
Sorry, I've missed it. The embedded DMA's patchset is
https://lore.kernel.org/linux-pci/20230113171409.30470-1-Sergey.Semin@baika=
lelectronics.ru/
and, merged to a pci/dwc branch on kernel/git/lpieralisi/pci.git . The
link is here:
https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?=
h=3Dpci/dwc

I'll add the information to a cover letter from the next submission.
> Frank
>
> >
> > About this patchset has 4 patches. The first of two patch is little cha=
nges
> > to virtio. The third patch add APIs to easily access virtio data struct=
ure
> > on PCIe Host side memory. The last one introduce a virtio-net EP device
> > function. Details are in commit respectively.
> >
>
Best,
Shunsuke
