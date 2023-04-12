Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994FF6DFFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 22:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDLU0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 16:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDLU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 16:26:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204FB1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 13:26:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 200446301E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:26:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545DDC433D2;
        Wed, 12 Apr 2023 20:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681331181;
        bh=R7AwwTXtPuvKs3PHaUsx71XVPUNjECs+6UtErpcbNJM=;
        h=From:To:Cc:Subject:Date:From;
        b=LtqsFByrXEOGIA4oYlz6qG7/vrrSaigIBk3OiutIp92WDzJ9dAjqdkTuWnOI5spk/
         zGX8TiWdFUfmU+lkPZ9csoRzO11vo7MSDZ+FODEWTTpC5Avm7MaAOpp77Vq9YVKia8
         HwwyjixZ8ZTu6V1F3lllJhtuIcj+WqX+d5bIS3Kaa3tchXo/ZJR1WPGrUY9QWMPt9V
         TbY5BRbrajxHFKf7otGmh4/LP5zgoy5dNlL4O1ZG8PGG5Wy2VzHjjVkrFbZZSbEtxV
         rDhUXQGXpb++m2+Y9qYOQnH/m7+1MkP8PLY4neOVoww857Rvn1dtGk9nNrNqAfg8kS
         A0p7HWnGceNTg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 0/3] objtool: Generate ORC data for __pfx code
Date:   Wed, 12 Apr 2023 13:26:12 -0700
Message-Id: <cover.1681331135.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf (3):
  objtool: Separate prefix code from stack validation code
  x86/linkage: Fix padding for typed functions
  objtool: Generate ORC data for __pfx code

 arch/x86/include/asm/linkage.h |   2 +-
 tools/objtool/check.c          | 102 +++++++++++++++++++++------------
 2 files changed, 65 insertions(+), 39 deletions(-)

-- 
2.39.2

