Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A8164B97C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiLMQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiLMQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:21:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56ACD21832;
        Tue, 13 Dec 2022 08:21:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E93FB615D5;
        Tue, 13 Dec 2022 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF33AC433D2;
        Tue, 13 Dec 2022 16:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670948465;
        bh=vx8f5XR4baTM163oHf4/eakdYDybX0oqWobDFJ/wI3g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PwFu4Xs1dGbQByk5cjonAVIpHbsUBVXXaIyeZPKH83B/2ZK0yM0JRrFQBJad6iPQv
         Zztx7SvogOavIoidFov1eSrdAcNokBvFVsZmZXt1z0Frv4R33KnkOyVDqZAEdyyTAk
         JGUZDD7texANoARzyl4evjWR4IEiFcDbB+43OAacfChtid6uJs3vFFzOmDmi4OeIR0
         yMIekbOtUySC/oUtw3R/p1stEt3WmH7TnRzobZfQIGUAzO2vOFFvUof7X6Nm91CsNN
         xgGtFCDjRAjTAEu2Asw8tODss5ggXbv4EX5PSWiDNXA9I8jLlkBE6Kyni/Ls3Hvozq
         6gL1NB/vaf09A==
Date:   Tue, 13 Dec 2022 10:21:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Rob Herring <robh@kernel.org>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20221213162103.GA106222@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205095738.607b9551@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the pci tree got a conflict in:
> 
>   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> 
> between commit:
> 
>   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> 
> from the arm-soc tree and commit:
> 
>   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
> 
> from the pci tree.
> 
> I didn't know how to fix this up, so I just used the latter (and so lost
> the addition of "ecam").

Did I miss a suggested resolution for this?
