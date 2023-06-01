Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2071A350
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbjFAPyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjFAPyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:54:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C45AE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:54:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED5EC646EE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 15:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4EEDC433EF;
        Thu,  1 Jun 2023 15:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685634843;
        bh=xeSn3E1qJvyf4etDPi5a+zgCrfqeEF4F7L6zPoddoHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g9WVNsUWn6yFnQvSiyKbqL8LE4DBDYs8lSq7I2Ur7WdD1MPG2aDCb9M9vJ6Nz/e2f
         OHCNlQ1LzoOsAoM6sMHAewiNiQGaTuJErLaAngEBiNjQrclwutSJ/EyJgscMIvpF16
         F4FHdZJe+b9LYNdvMMBOzI8+lr+IC/vNrwNypoXo+pkMvWYPDiKOZjIQTO2DIRyVlW
         yLZBGiatu02MU9HAdoNTNnv6i8jwo6SjQEeHWjiwiV9E1DC1jE2aEXH2tBH5RFwmSI
         6ppcjAn4FjD2STyp0VCwE3QP6nUQq1LLtXHcafnNvJfkzWg89QY+4WqeqEIoxpQV7K
         2MVgjCzTGxk3A==
Date:   Thu, 1 Jun 2023 08:54:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        davthompson@nvidia.com, asmaa@nvidia.com, mkl@pengutronix.de,
        limings@nvidia.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mlxbf_gige: Add missing check for platform_get_irq
Message-ID: <20230601085402.01c2a385@kernel.org>
In-Reply-To: <20230601065808.1137-1-jiasheng@iscas.ac.cn>
References: <20230601065808.1137-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  1 Jun 2023 14:58:08 +0800 Jiasheng Jiang wrote:
> According to the documentation of submitting patches
> (Link: https://docs.kernel.org/process/submitting-patches.html),
> I used "scripts/get_maintainer.pl" to gain the appropriate recipients
> for my patch.
> However, the "limings@nvidia.com" is not contained in the following list.

And I told you already to run the script on the _patch_ not on the file
path.

$ ./scripts/get_maintainer.pl 0001-mlxbf_gige-Add-missing-check-for-platform_get_irq.patch
"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING DRIVERS,blamed_fixes:1/1=100%)
Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING DRIVERS)
Jakub Kicinski <kuba@kernel.org> (maintainer:NETWORKING DRIVERS,commit_signer:5/6=83%,authored:1/6=17%,removed_lines:1/20=5%)
Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING DRIVERS)
Asmaa Mnebhi <asmaa@nvidia.com> (commit_signer:4/6=67%,blamed_fixes:1/1=100%)
David Thompson <davthompson@nvidia.com> (commit_signer:4/6=67%,authored:4/6=67%,added_lines:94/99=95%,removed_lines:19/20=95%,blamed_fixes:1/1=100%)
Marc Kleine-Budde <mkl@pengutronix.de> (commit_signer:1/6=17%)
Jiasheng Jiang <jiasheng@iscas.ac.cn> (commit_signer:1/6=17%,authored:1/6=17%)
vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
Liming Sun <limings@nvidia.com> (blamed_fixes:1/1=100%)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
linux-kernel@vger.kernel.org (open list)
