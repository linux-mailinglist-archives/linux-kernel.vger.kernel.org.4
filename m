Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5B76A27B6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 08:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBYH3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 02:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBYH3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 02:29:03 -0500
Received: from h7.fbrelay.privateemail.com (h7.fbrelay.privateemail.com [162.0.218.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3835418B0B;
        Fri, 24 Feb 2023 23:29:02 -0800 (PST)
Received: from MTA-08-3.privateemail.com (unknown [198.54.122.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by h7.fbrelay.privateemail.com (Postfix) with ESMTPS id 51728601CB;
        Sat, 25 Feb 2023 02:29:00 -0500 (EST)
Received: from mta-08.privateemail.com (localhost [127.0.0.1])
        by mta-08.privateemail.com (Postfix) with ESMTP id 1477518000A2;
        Sat, 25 Feb 2023 02:28:58 -0500 (EST)
Received: from localhost.localdomain (cpe-66-66-66-125.rochester.res.rr.com [66.66.66.125])
        by mta-08.privateemail.com (Postfix) with ESMTPA id B8BE418000A0;
        Sat, 25 Feb 2023 02:28:46 -0500 (EST)
From:   Dylan Le <self@dylanle.dev>
To:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Dylan Le <self@dylanle.dev>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 0/1] Documentation: gpu: add acceleration node section
Date:   Sat, 25 Feb 2023 07:28:33 +0000
Message-Id: <cover.1677308797.git.self@dylanle.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

There is a missing section of GPU documentation on Acceleration Nodes.
This patch adds a stubbed section to be filled in. I was able to render
the new section as a PDF.

make SPHINXDIRS="gpu/" pdfdocs

Changes since v1:
- Comments from Bagas. Change from note admonition to generic admonition

Dylan Le (1):
  Documentation: gpu: add acceleration node section

 Documentation/gpu/drm-uapi.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

Thanks.
-- 
2.30.2

