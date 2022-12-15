Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654364E4D7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiLOX4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiLOX4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:56:12 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C636D5E0BD;
        Thu, 15 Dec 2022 15:56:06 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0AA65E0EDD;
        Fri, 16 Dec 2022 02:56:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-type:content-type:date
        :from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=post; bh=DdS1VBmXCCXBX8TinHnW
        D3eIoJeeunNj3INyqaAgzmM=; b=pqk36VHArTcUIKGkiilo7EAfp5TR3QEqbh81
        IWTLBkhqDfBbbixagCo2eH4XKaDtlTH9euHoaBcaj8zN6rmT5Eu40KOS6etsULx1
        JWm06gxzjlekdk1gSVSz/QI1Na92LLhPKqSB1mOix0CzAWP8OXj92dMpE5zcniHS
        jGW1XPA=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id B14B2E0E6B;
        Fri, 16 Dec 2022 02:56:04 +0300 (MSK)
Received: from mobilestation (10.8.30.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 16 Dec 2022 02:56:04 +0300
Date:   Fri, 16 Dec 2022 02:56:03 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Thierry Reding <treding@nvidia.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the pci tree with the arm-soc tree
Message-ID: <20221215235603.pwbgwarxutjq2cq7@mobilestation>
References: <20221213195313.GA200257@bhelgaas>
 <20221213200733.GA201693@bhelgaas>
 <20221213233649.zmmiskezdponleuc@mobilestation>
 <Y5nfr+AXofk9Ch2m@orome>
 <20221214220735.5fv6agbkwamvfmbv@mobilestation>
 <Y5sNxY1ibaSK5lND@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y5sNxY1ibaSK5lND@orome>
X-Originating-IP: [10.8.30.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 01:06:29PM +0100, Thierry Reding wrote:
> On Thu, Dec 15, 2022 at 01:07:35AM +0300, Serge Semin wrote:
> > On Wed, Dec 14, 2022 at 03:37:35PM +0100, Thierry Reding wrote:
> > > On Wed, Dec 14, 2022 at 02:36:49AM +0300, Serge Semin wrote:
> > > > On Tue, Dec 13, 2022 at 02:07:33PM -0600, Bjorn Helgaas wrote:
> > > > > On Tue, Dec 13, 2022 at 01:53:13PM -0600, Bjorn Helgaas wrote:
> > > > > > On Tue, Dec 13, 2022 at 10:03:10PM +0300, Serge Semin wrote:
> > > > > > > On Tue, Dec 13, 2022 at 05:48:53PM +0100, Thierry Reding wrote:
> > > > > > > > On Tue, Dec 13, 2022 at 10:21:03AM -0600, Bjorn Helgaas wrote:
> > > > > > > > > On Mon, Dec 05, 2022 at 09:57:38AM +1100, Stephen Rothwell wrote:
> > > > > > > > > > Hi all,
> > > > > > > > > > 
> > > > > > > > > > Today's linux-next merge of the pci tree got a conflict in:
> > > > > > > > > > 
> > > > > > > > > >   Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
> > > > > > > > > > 
> > > > > > > > > > between commit:
> > > > > > > > > > 
> > > > > > > > > >   5c3741492d2e ("dt-bindings: PCI: tegra234: Add ECAM support")
> > > > > > > > > > 
> > > > > > > > > > from the arm-soc tree and commit:
> > > > > > > > > > 
> > > > > > > > > >   4cc13eedb892 ("dt-bindings: PCI: dwc: Add reg/reg-names common properties")
> > > > > > > > > > 
> > > > > > > > > > from the pci tree.
> > > > > > > > > > 
> > > > > > > > > > I didn't know how to fix this up, so I just used the latter (and so lost
> > > > > > > > > > the addition of "ecam").
> > > > > > > > > 
> > > > > > > > > Did I miss a suggested resolution for this?
> > > > > > > 
> > > > > > > > We had a brief discussion about this in another thread. So basically
> > > > > > > > Stephen's resolution is fine here and the plan is to instead add the
> > > > > > > > ECAM bits that the Tegra patch does in a separate patch on top of
> > > > > > > > Serge's patch. I should get around to sending that patch tomorrow.
> > > > > > > 
> > > > > > > Actually the discussion still goes. I haven't got a respond to my
> > > > > > > last suggestion which seems to me more reasonable than extending the
> > > > > > > DT-bindings with another vendor-specific reg-name. @Bjorn, please join
> > > > > > > the discussion here:
> > > > > > > https://lore.kernel.org/linux-pci/20221114155333.234496-2-jonathanh@nvidia.com/
> > > > > > 
> > > > 
> > > > > > Sorry, it's really too late for discussion.  I need to send the v6.2
> > > > > > pull request today or at the very latest, tomorrow, so the only thing
> > > > > > to decide is how to resolve the merge conflict in the simplest
> > > > > > possible way.  Unless there's a very compelling reason to resolve it
> > > > > > differently than Stephen did, that's going to be the answer.
> > > > 
> > > > Sigh... One more redundant vendor-specific name. I wish I was in the
> > > > Cc-list of the original series.
> > > > 
> > > > > 
> > > > > To be more specific, the current answer is this (which is the same as
> > > > > what's in next-20221213):
> > > > > 
> > > > >   https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml?id=f64171fdd171
> > > > 
> > > > Thanks. I've got it from the @Stephen message. @Thierry will submit a
> > > > new patch with the same 'ecam'-names change rebased on top of the
> > > > updated DT-schema.
> > > 
> > 
> > > If Rob doesn't mind this being broken in linux-next for a few more days,
> > > I can discuss this internally with our PCI and UEFI teams and find out
> > > if your proposal could be made to work.
> > 
> > That would be awesome if you managed to work with the already defined
> > 'config' reg-name so the DT-schema would look a bit cleaner. Thanks
> > in advance.
> 

> Looks like Linus has now pulled this in and resolved the conflict
> himself. I think there is some benefit in "ecam" being more specific
> than "config" and with ECAM being a PCIe standard mapping, it doesn't
> seem like it's worth overcomplicating things by overloading the meaning
> of "config".

It's vise versa actually. Adding the new name overcomplicates the
DT-interface for no reason. Using the 'config' name for mapping both
the unrolled and single-sided cfg-spaces would look much cleaner.

-Serge(y)

> 
> Thierry



