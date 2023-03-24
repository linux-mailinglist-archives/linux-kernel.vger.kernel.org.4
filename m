Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871BE6C7ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbjCXNcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXNcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:32:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D03168BF;
        Fri, 24 Mar 2023 06:31:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52E05B82433;
        Fri, 24 Mar 2023 13:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B532FC433EF;
        Fri, 24 Mar 2023 13:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679664715;
        bh=95kYkVDx7ZQFLluye1hn4V3c1u/gdhLYfeTG4puFTrE=;
        h=From:To:Cc:Subject:Date:From;
        b=mIa9ooLsuCH4SBwC+/wEe9e3W5ORy1LmwpUame0lKHNTPWBql1KzTeeWcurtPfBrn
         sv/2ONMCWlHHvZwMfUmENcXTud88/R55s8C0rLF3fMUnjwD7Q8S9cc2CRrTFcHn/PA
         ujaDUx8UqUCe9YiMxXCNSngTjgj0wTr0gMJDWvJHz9nZA8ukHO8joCunlnppdATuXk
         xCdqy9przQNUyOxF6Bh4nNetXpxMxwGtW0rqgBIDQI8mRxZnFlFLHnQ3yk88zeuCAY
         qAJ6quCb2wLOT016iVVkpHyXLqBX0gm2NAQc8Y9+Z/yK8Btp6qwFbfUKYdriBLR2IE
         tjUFeBqzNUqnw==
From:   Roger Quadros <rogerq@kernel.org>
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/2] arm64: dts: ti: k3-am625-sk: Enable Type-C dual-role
Date:   Fri, 24 Mar 2023 15:31:48 +0200
Message-Id: <20230324133150.43224-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables Type-C port on USB0.

cheers,
-roger

Dhruva Gole (1):
  arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

Roger Quadros (1):
  arm64: dts: ti: k3-am625-sk: Enable Type-C port for USB0

 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 41 ++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

-- 
2.34.1

