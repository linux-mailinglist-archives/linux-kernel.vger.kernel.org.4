Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795E05FA16A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 17:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiJJPwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 11:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJJPwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 11:52:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAEB73939
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 08:52:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45B32221B5;
        Mon, 10 Oct 2022 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665417163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QxogDrSHEwlYmaDMlV9gILvjrrhXShq/wiqjWxtHiMQ=;
        b=E0JowWWULWQm+r6mNHUXsjBT0fWmgZTn7XFiTJ0ZacG8lAJIgAwMgFZUFDUVyfc1A/395s
        2Qtm/7bgvnAFKdrMhYDMW+R7u8narubvigeliQ8gOWLKAq0YZ67VLVSkU1+XGnJ/1GEC7F
        b+cXxOyZvQSO/t8Rj+9ytp1BMqt7lBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665417163;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QxogDrSHEwlYmaDMlV9gILvjrrhXShq/wiqjWxtHiMQ=;
        b=famPyZWpAsQAfN211DJW7MxH4UxiTWhQDlcsgjaK8DCH34L82xATI7zUGOXWIiP4c7Kbg7
        fS8g76nfw7LGZiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16C5B13ACA;
        Mon, 10 Oct 2022 15:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OYvhA8s/RGMmQwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 10 Oct 2022 15:52:43 +0000
Date:   Mon, 10 Oct 2022 17:52:41 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dmi update for v6.1
Message-ID: <20221010175241.06ad4168@endymion.delvare>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dmi subsystem updates for Linux v6.1 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-linus


 drivers/firmware/dmi_scan.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

---------------

Jean Delvare (1):
      firmware: dmi: Fortify entry point length checks

Thanks,
-- 
Jean Delvare
SUSE L3 Support
