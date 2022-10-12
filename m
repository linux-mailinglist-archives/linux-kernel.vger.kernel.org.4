Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69B55FCB55
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiJLTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiJLTMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:12:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEFA8CD5CE
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 12:12:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A24FB81BAC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 19:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0259AC433C1;
        Wed, 12 Oct 2022 19:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665601923;
        bh=842rEsxNEoTTXm2YSLeKRUjCxxnVJCWE23SS6zP6ItI=;
        h=Date:From:To:Cc:Subject:From;
        b=oj2DomY0VF7qd0WD4i4U+TQaRxqKp3ikw78T/ICeIi8No3Uww29OjVZ6b1iDXGAiR
         uc8aeMU1G26i8j9PTcQmFC4kjngi1gfQAYRblSa0F9JjRcOv2J7f8fdhD057Shr6mq
         NJA6+H8YWQsMeyV8++Qc7RkW7ALd2RoY5pf+IypVHwrtBTHv84k35P41y9KcWpahyR
         fwubYeJSVr6RXypCkBuduZrPpCL9QPGEAy8/z8cTF4zBVFVbkgdVMsfG8DoWnfuSmH
         qf8/Q5p45wR1ZBDigfNopYxrpvF71durOHk6iv7ywyHxAlVxAi0CyA9tGEJ46LmZJG
         0+RFFdHGk2G0w==
Date:   Wed, 12 Oct 2022 14:12:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-parport@lists.infradead.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport-owner@lists.infradead.org,
        linux-kernel@vger.kernel.org, helpdesk@kernel.org
Subject: Add linux-parport archives to lore.kernel.org?
Message-ID: <20221012191201.GA3107702@bhelgaas>
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

The linux-parport@lists.infradead.org mailing list is listed in
MAINTAINERS.  There's not much current activity [1], but I suspect
there's some useful history that we might want to preserve.

Should we add linux-parport to the lore.kernel.org archives?

https://korg.docs.kernel.org/lore.html says pipermail archives like
infradead has are not ideal, but I don't have any archives at all, and
I don't know how to get even pipermail archives out of infradead.

Bjorn

[1] https://lists.infradead.org/pipermail/linux-parport/
