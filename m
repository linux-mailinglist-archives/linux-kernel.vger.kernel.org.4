Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C9E672A93
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjARVe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjARVeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:34:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BA764D96;
        Wed, 18 Jan 2023 13:34:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25F1EB81D76;
        Wed, 18 Jan 2023 21:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA71C433AC;
        Wed, 18 Jan 2023 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674077645;
        bh=jWbrU7pchPyN+vMJqFsmIY+ydoP2dmCmAa+uZAeJf5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lWvjrevFldoy94U7FaJD8kl+TcA6wgZWjKaFJFPU0vM4QcZyVdGXzzQfWuc/jRiZ0
         YTchAaV6JhMeHo/B8wiP7vxVeNe9M6yUiYxHKl5WEN9UKLkxNuV/MB/StNAmWUtR3g
         SQ3OyVxVJraQw+OL5djSIGuO9nXXXSH0l9Y+6wLDyP+zKYF9w1N3H2Z8MvRWwh7kdH
         yBTZKpiCdscKI/WsBlJrumpPE80wCqDl5sxDqkyhd8RLbo9GwW98DPLHTHsvmc3cpv
         L+D+8i6u4ySbMRWyYt1dHc8S3FrHcmvV6Rga9iN3sq2nMSzThV1KfZL5Xe2Ar+HH2V
         NG5icWbi0jvvw==
Date:   Wed, 18 Jan 2023 15:34:03 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the pci tree
Message-ID: <20230118213403.GA261370@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116095325.01f715ee@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:53:25AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/pci/switch/switchtec.c: In function 'switchtec_dev_read':
> drivers/pci/switch/switchtec.c:623:1: error: label 'out' defined but not used [-Werror=unused-label]
>   623 | out:
>       | ^~~
> 
> Caused by commit
> 
>   fbc855bce49e ("PCI: switchtec: Return -EFAULT for copy_to_user() errors")
> 
> I have used the pci tree from next-20230113 for today.

Should be fixed.

Lorenzo, just FYI, I cherry-picked the commits from your pci/switchtec
branch into a local pci/switchtec branch to fix this.

Bjorn
