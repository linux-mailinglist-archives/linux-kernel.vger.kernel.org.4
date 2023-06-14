Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CCC72CBB8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235757AbjFLQlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjFLQla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:41:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278A6183;
        Mon, 12 Jun 2023 09:41:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f629ccb8ebso5357433e87.1;
        Mon, 12 Jun 2023 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686588087; x=1689180087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jx6/wV4m4BBpnfz/K5lj00yNBxCoPS4eqrXhFxrqWNY=;
        b=SYrCV3aYzPE5UdqR48D73VeNJ/VqJo6v5Qkeuszdrd5uNDEGfUy2cLpthevFBT/cf7
         ox+xx+EoTqsMM+aWfDt4p4+GWrFdM+SbYC5YxovFbF7zFD+ysokg3HphzqcwXw9/LpyU
         ZHS7NhMc4c5OF3T1Rhi0ZcoO7Vwdh+zZbLjyATFnvJeUDb0oIhQ0AxT+TEAaqKlEhtII
         URuCCMRfHHWOgegCD2fQ/0/FRRwNyYgKRMftGh8rPrlOp80OtkUfU8TbkCyMLXz17uL9
         6jTDcr6frDAz4Io4PJnOcamrWMFRhZY4XwBrawDGs/3iJsuAoeQkB1DPusmcl5igVe4I
         /NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686588087; x=1689180087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jx6/wV4m4BBpnfz/K5lj00yNBxCoPS4eqrXhFxrqWNY=;
        b=j+FwKKoz2O/SJ/6OeZnB1BkcmVWdY+oX3daVKmkaxO52j5pXf3SBWwOThj5A/USEEZ
         PyU9f4XvCijOhlZ1fXWP0DfxLMRgdpx2D1pU2G8dQSKZKkRQerQaO2GlZRhRsTsA2Qq3
         vi/jmvqIw7uxBvmhGL2WFlNuQk6YKuiH6ZcbWYKuedt6Oan3Lo/rU+ZscqJJ56p8JqH9
         WSt8L0xLdSQ74n2RuqkLjb+wVxwW0FA5lerBUCvl6TemocYJYBqXX1d+AdGUiDYwH7+d
         8AaLp7Fzl+IcbFDs0zb/Z9s6ST5lCS9Dy7zXh3CVgPK/htUKAdZqGd3IXjAxxnnx6LVV
         aYNg==
X-Gm-Message-State: AC+VfDxpG4w1MO0X3woR7oy5AtcQTREbmCU8JfHQ1O15KtwSO3lqqA/v
        VH9DnwKEo6LCkSCHXL3Jojw=
X-Google-Smtp-Source: ACHHUZ4+45STAcne9lCis07zMOF5bck38Vv7+pgogTLaVpEafMv6mzap6UfthmFcrWZVoy65CoQtAw==
X-Received: by 2002:a05:6512:329c:b0:4f6:3c67:ddfc with SMTP id p28-20020a056512329c00b004f63c67ddfcmr4410805lfe.23.1686588087054;
        Mon, 12 Jun 2023 09:41:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id m16-20020ac24250000000b004f1383d57ecsm1490154lfl.202.2023.06.12.09.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 09:41:25 -0700 (PDT)
Date:   Mon, 12 Jun 2023 19:41:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v7 00/11] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230612164124.ytqn5lfeaxds6ywq@mobilestation>
References: <20230611192005.25636-1-Sergey.Semin@baikalelectronics.ru>
 <20230612154127.GA1335023@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612154127.GA1335023@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:41:27AM -0500, Bjorn Helgaas wrote:
> On Sun, Jun 11, 2023 at 10:19:54PM +0300, Serge Semin wrote:
> > It turns out the recent DW PCIe-related patchset was merged in with
> > several relatively trivial issues left unsettled (noted by Bjorn and
> > Manivannan). All of these lefovers have been fixed in this patchset.
> > Namely the series starts with two bug-fixes. The first one concerns the
> > improper link-mode initialization in case if the CDM-check is enabled. The
> > second unfortunate mistake I made in the IP-core version type helper. In
> > particular instead of testing the IP-core version type the macro function
> > referred to the just IP-core version which obviously wasn't what I
> > intended.
> > ...
> 

> I am unable to do anything with this series.
> 
> Google's legal team is reviewing this matter under applicable laws and
> regulations.

I don't get it, how come Google gets to decide anything about what to
do with this patchset? Even the driver copyright doesn't belong to
Google Inc, not to mentioned the GPL v2 license under which the driver
is released. Could you clarify since when Google (but not the driver
and subsystem maintainers) has been reviewing the patches submitted to
the kernel? And how come it is able to block even the subsystem
maintainers work?

-Serge(y)

> 
> Bjorn
