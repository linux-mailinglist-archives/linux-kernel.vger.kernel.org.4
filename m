Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0437E6E4BB3
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDQOjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 10:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjDQOjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4D86BE;
        Mon, 17 Apr 2023 07:39:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FE856262D;
        Mon, 17 Apr 2023 14:39:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B522C433D2;
        Mon, 17 Apr 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681742367;
        bh=LTTln81pU3tbmAEDXucfOA7gxmfn0aHgrBX7aTXJ72k=;
        h=From:To:Cc:Subject:Date:From;
        b=KWw03S2bX6ty62CMEBwRHiWNsa7WKHIf2dy9Mw+vo8zKfKnII4QYxPRTdNZn3OSys
         o7KvJ6G+0sKRoqv1OG3hbzQ5yz4YrG0QQ1CrYw0bazhg0hnHvQPrkAxeNUkelhlPQz
         XCcWPDMN1/xh/s4dqbenWCvuvFAOkULifUJciYX0CJEzwQyvobwSLkD2Gt4974OwWv
         K5XNhOs2zzPePJyeY9WsB6xSKGEXzOjd/OH2Yr6MM82vhuiexQHEIZblE9MQ8QeQHK
         zvfhqQlLpQQVqJX5J7RriLijAFzrq1bCmKp35/9x41Fq0JUtyfVBeL7Z0Y7pgewKt4
         ZYLZZIUWAkbYQ==
From:   broonie@kernel.org
To:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes tree
Date:   Mon, 17 Apr 2023 15:39:23 +0100
Message-Id: <20230417143923.2136597-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/display/intel_dp_aux.c

between commit:

  e1c71f8f91804 ("drm/i915: Fix fast wake AUX sync len")

from the drm-intel-fixes tree and commit:

  605f7c7313334 ("drm/i915: Fix fast wake AUX sync len")

from the drm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/gpu/drm/i915/display/intel_dp_aux.c
index 30c98810e28bb,705915d505652..0000000000000
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
