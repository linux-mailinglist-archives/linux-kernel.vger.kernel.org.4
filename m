Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090E692B24
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBJX2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjBJX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:28:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425A36F22C;
        Fri, 10 Feb 2023 15:28:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D231661EAD;
        Fri, 10 Feb 2023 23:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9DFC433D2;
        Fri, 10 Feb 2023 23:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676071686;
        bh=z/fjSHEKkeZH0xl3gSAlWJUi78rSlqVpPRun+dizBq0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pw5OnvbI1SKNF56oxP1v1X7jyCtaiLalEYMdS1yb483R7PqMqLw7oEFUhiTSD5XQs
         DZnECnb58Tg2RY0Ei/iUsfNPc/aBDn3WLuGqOV8O9KBWetZf55graWvyHJJUjr8yaR
         YEMOYNnCNBzwozKNlhUYABWTqaT3clDhvsEFfzoGDHGGM0z23Zn+xQ51YUjRUKae4F
         erz7gkdyFqKHrxRbfRCKUHUv9G02rLTJIdIZDYkpr0kSrCltPr4zvZgEuF0j9lRVnL
         AqOCr9N3lclySASNGzM/IdVeQ0/XJTMnQyWSNm442+WPw/1R38pmgVHVnj0XV42P+J
         hE8En9X0Npjxw==
Date:   Fri, 10 Feb 2023 17:28:04 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20230210232804.GA2712855@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230210153834.0452f24d@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 03:38:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   da006a8c9352 ("dmaengine: dw-edma: Use non-atomic io-64 methods")
>   e3042508ac7c ("dmaengine: dw-edma: Fix readq_ch() return value truncation")
> 
> are missing a Signed-off-by from their committer.

Thanks, should be fixed now.

BTW, Stephen, can you add Krzysztof Wilczyński <kw@linux.com> to your
list of "people to notify about PCI tree issues"?

Thank you!
