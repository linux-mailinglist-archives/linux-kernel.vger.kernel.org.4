Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E9624DC4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKJWqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbiKJWqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:46:11 -0500
X-Greylist: delayed 802 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 14:46:02 PST
Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE845EF81
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:46:01 -0800 (PST)
Received: from localhost (ip-109-42-177-67.web.vodafone.de [109.42.177.67])
        (authenticated bits=0)
        by mx10.gouders.net (8.17.1.9/8.16.1) with ESMTPSA id 2AAMWBE3010382
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 10 Nov 2022 23:32:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1668119533; bh=pvAaXHnemLPfU3cWSQzyvFq87pRKB1n9qZDJfuuWpcM=;
        h=From:To:Cc:Subject:Date;
        b=Xkb/qoTd6Li9XtBGFxalz0oOISeEi5pyAUVC1zrJLHsqM0yQLLzX5Eph/PenmfpGw
         CVvO8Gq/fDCmjT9/1pDR6+uWeihg/XtNNzk+EPq/4cgOH1Wd2VmCN+ARIh1BhQgsWI
         5qL9aclLyQr7OUSYDYsp7ICvFgx+pETe32GkeMdE=
From:   Dirk Gouders <dirk@gouders.net>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Wayne Lin <Wayne.Lin@amd.com>,
        Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <sean@poorly.run>
Subject: Regression bisected: drm/display/dp_mst: Move all payload info into
 the atomic state
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Thu, 10 Nov 2022 23:32:05 +0100
Message-ID: <ghwn827862.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_SBL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I noticed a regression with Linus' current tree and bisected it to
4d07b0bc403403 (drm/display/dp_mst: Move all payload info into the atomic state):

I have two monitors connected to my laptop's USB-C port and since this
patch, one of the monitors remains dark.

Please let me know if I can provide additional information that could help
to investigate this problem.

Dirk
