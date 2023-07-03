Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E6A74589E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjGCJok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjGCJoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:44:37 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id D599E12E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:44:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id F3D7360A24DE6;
        Mon,  3 Jul 2023 17:44:27 +0800 (CST)
X-MD-Sfrom: dengxiang@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   dengxiang <dengxiang@nfschina.com>
To:     tiwai@suse.com, yangyingliang@huawei.com, perex@perex.cz
Cc:     linux-kernel@vger.kernel.org, dengxiang@nfschina.com
Subject: Re: [PATCH v5] ALSA: hda/realtek: Add quirks for Unis H3C Desktop B760 & Q760
Date:   Mon,  3 Jul 2023 17:43:31 +0800
Message-Id: <20230703094331.3021471-1-dengxiang@nfschina.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87bkgt77b7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Applied now, but I had to edit manually to move this Signed-off-by
> line. As mentioned in the previous post, the Signed-off-by line must
> be *before* the line "---"; git-am truncates the lines after "---",
> so Signed-off-by tag will be missing otherwise. Please put at the
> right position at the next time.

Ok, i got it. Thanks for your help. I will notice it at the next time. Thank you very much.
