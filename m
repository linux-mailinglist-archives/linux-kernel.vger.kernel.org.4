Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3108C6EC461
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 06:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDXE2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 00:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDXE2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 00:28:35 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800B51FE3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 21:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tJU2CtdhD0rKbJxzeTBLXgpl5/T7iCzugrtH5fv9K+s=; b=sxGBPhUe1MgrApjcL+h9TALhxu
        RbOMMyaJQPRVHZZaic74JQ6CKiqFLjASJOj9lMRKPr1M+z0YV64ig6wVgzGapz7kfq4//cS8r450v
        0rNKeqTDYkmfBR1kQJJkXxZd6Dc6vlCzP1Lr9AE85vqa8LF/s1+dIPFh72TLnoEP7EVW9WihgHi64
        Qai8sPG2X8m98RkJ2PdEru2fG099fQ4I0xLUTVMYq5Ap8EWGrB9/OF7xC1YupxNXCSzEPJfUKA+8v
        CLAdWFYuq094Nco+YS6sQrFokR1769H5uSXo3/o2gVYm/kof0u+UhbukyT0kt+H+O40GReyuurDCA
        hPOqXsLQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pqnoX-00C0KD-0I;
        Mon, 24 Apr 2023 04:28:33 +0000
Date:   Mon, 24 Apr 2023 05:28:33 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] trivial nios2 cleanup
Message-ID: <20230424042833.GL3390869@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-nios2

for you to fetch changes up to eb2317b13b1884b07db23d986988620941b2f075:

  nios2: _TIF_ALLWORK_MASK is unused (2023-03-05 20:21:04 -0500)

----------------------------------------------------------------
nios2 minor cleanup

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
Al Viro (1):
      nios2: _TIF_ALLWORK_MASK is unused

 arch/nios2/include/asm/thread_info.h | 3 ---
 1 file changed, 3 deletions(-)
