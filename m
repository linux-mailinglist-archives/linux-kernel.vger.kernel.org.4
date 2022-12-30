Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F726596E9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbiL3Jm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbiL3JmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:42:24 -0500
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378AD1A807
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:42:23 -0800 (PST)
Received: by air.basealt.ru (Postfix, from userid 490)
        id B8C182F20236; Fri, 30 Dec 2022 09:35:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from nickel-ws.ipa.basealt.ru (unknown [85.140.7.15])
        by air.basealt.ru (Postfix) with ESMTPSA id D082C2F20226;
        Fri, 30 Dec 2022 09:35:48 +0000 (UTC)
From:   nickel@altlinux.org
To:     linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        regressions@lists.linux.dev
Subject: [PATCH 0/1] Revert patch to fix sound sudden dissapearance
Date:   Fri, 30 Dec 2022 12:30:52 +0300
Message-Id: <20221230093454.468857-1-nickel@altlinux.org>
X-Mailer: git-send-email 2.33.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update to 5.10.157 causes sudden sound dissapearance regression for some laptops

[PATCH 1/1] Revert "ASoC: soc-pcm: Don't zero TDM masks in
