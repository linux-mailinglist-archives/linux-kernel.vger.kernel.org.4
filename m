Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A235FCB53
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJLTLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJLTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:11:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064FCD5CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:11:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FB9BB810C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:11:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98957C433C1;
        Wed, 12 Oct 2022 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665601889;
        bh=jtgX9tuBjxNWkKNaOxFaW7LtLZ+1wLafzykmke4nVeI=;
        h=Date:From:To:Cc:Subject:From;
        b=f9fQQkqnm4KqyAYkojcywc/2J5YxFqgkKUAUVlEN80QBnBpyeD/QSCxC8Wh1h9vUd
         bQ5VxxiULR/7CKdjUxVq9gTGBuf86B+YrvTuNgMHWJHcnut0TLU2Jdjmr7z1wd+cij
         D5NkngCgKgabxhpIflyvV+WWMUDqvyTnXY5bD+KqB8500kQC2HJESD3xWL5AWADevK
         LuAEDjJwhSXHuPW51UtTFC82kxjEaGCUvAFEA4NsuGq+A3Ncuez0pRUu5Q0C4nLEFH
         p7SXwWRt70wwvjlSS1ssN3I/iu2nYhIUB3kX0x4lig+pxHbTkbRYKFLNquxeAXkEZu
         CTuOr3yGy9D3w==
Date:   Wed, 12 Oct 2022 14:11:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-rpi-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Add linux-rpi-kernel archives to lore.kernel.org?
Message-ID: <20221012191128.GA3108607@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux-rpi-kernel@lists.infradead.org mailing list is listed in
MAINTAINERS and is quite active [1].  Once in a while a commit links
to the infradead pipermail archive [2] (the link in that commit
appears broken).

I propose that we add linux-rpi-kernel to the lore.kernel.org archives
so future commits can use lore.kernel.org links that don't depend on
infradead.

https://korg.docs.kernel.org/lore.html says pipermail archives like
infradead has are not ideal, but I don't have any archives at all, and
I don't know how to get even pipermail archives out of infradead.

Bjorn

[1] https://lists.infradead.org/pipermail/linux-rpi-kernel/
[2] https://git.kernel.org/linus/f147384774a7
