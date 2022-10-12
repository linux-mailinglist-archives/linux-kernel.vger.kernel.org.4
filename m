Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A265FCB54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiJLTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiJLTLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:11:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A496CD5EE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:11:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1688615B9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:11:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03272C433D6;
        Wed, 12 Oct 2022 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665601904;
        bh=Ga6EodlgETpMCD6v9Enbmq6fA9jv2ptq4OEgHx1YD5M=;
        h=Date:From:To:Cc:Subject:From;
        b=u9mPsy+yTLyQCT/E+KVRSIxdyfEH8RUNlzkjJtY473k/2sJaomFCql/pJBaoeesYk
         wiB4jvXQGM7CQ1D3oTFlJvMQvtbDkDmKz+6pFEijlxYREYnYxtgoZm4w6Mw7J7n43J
         YqdfG9C3yPJutaq2wsi4U/9v7eCnG6NhO8TZ+ctLbctiGCkhV6n7OOPcnha7krgnwp
         e4EQeU1AUCZ9d4eMa2nUnBmZQkWiWZHN0eWrbzWbcasVTu6iZn7azwdtUBBWG05Is+
         QsqFj/zDNadU3kgq1wiSEAl/BDr5WWpe/qAVWu5eSSH2tlbiNhdE2V+4AlVHZ+wF9V
         5o5O+i8qgubsA==
Date:   Wed, 12 Oct 2022 14:11:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-um@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um-owner@lists.infradead.org, linux-kernel@vger.kernel.org,
        helpdesk@kernel.org
Subject: Add linux-um archives to lore.kernel.org?
Message-ID: <20221012191142.GA3109265@bhelgaas>
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

The linux-um@lists.infradead.org mailing list is listed in MAINTAINERS
and is quite active [1].  Once in a while a commit links to the
infradead pipermail archive [2] (the link in that commit appears
broken).

I propose that we add linux-um to the lore.kernel.org archives so
future commits can use lore.kernel.org links that don't depend on
infradead.

https://korg.docs.kernel.org/lore.html says pipermail archives like
infradead has are not ideal, but I don't have any archives at all, and
I don't know how to get even pipermail archives out of infradead.

Bjorn

[1] http://lists.infradead.org/pipermail/linux-um/
[2] https://git.kernel.org/linus/3b0b42527937
