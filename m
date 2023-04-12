Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CF36DF12D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDLJzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDLJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:55:29 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05BB6A78;
        Wed, 12 Apr 2023 02:55:27 -0700 (PDT)
Received: (Authenticated sender: cyril@debamax.com)
        by mail.gandi.net (Postfix) with ESMTPA id BD0FD1C000D;
        Wed, 12 Apr 2023 09:55:23 +0000 (UTC)
From:   Cyril Brulebois <cyril@debamax.com>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>,
        Michal Suchanek <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Updating hardcoded "of-display" devices
Date:   Wed, 12 Apr 2023 11:55:07 +0200
Message-Id: <20230412095509.2196162-1-cyril@debamax.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We've spotted a regression with the Debian Installer on ppc64el, and
I've confirmed that the first patch fixes fbdev/offb as expected (or at
least works around the regression, see last part of the commit message):
 - [PATCH 1/2] fbdev/offb: Update expected device name

Since I've spotted that drm/ofdrm is affected as well, I'm submitting a
similar patch for it, but I can't really test it. I suppose Thomas who
introduced this new driver during the v6.2 release cycle will be able
to take it from there if needed:
 - [PATCH 2/2] drm/ofdrm: Update expected device name


Cheers,
-- 
Cyril Brulebois -- Debian Consultant @ DEBAMAX -- https://debamax.com/

