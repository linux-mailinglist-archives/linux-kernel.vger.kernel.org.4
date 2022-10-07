Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11B25F81A2
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 02:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiJHAla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 20:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJHAlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 20:41:23 -0400
Received: from stravinsky.debian.org (stravinsky.debian.org [IPv6:2001:41b8:202:deb::311:108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F248C442
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 17:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
        s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rtVotppB6kFKwVvzfltZSDQOGa+vbjejr8EWFsl/4pU=; b=MtSNegbNVT2LwhiI2OCO8MtX4g
        SKRzGTChiwU9S2GmcnKymjidO1+9aOxz4m0ogOzTeBCWq2lzU2C+7iUHrBdVCS/Ui2SdUsjS05JY6
        LzPVW0Lor7/n9YjC/6Uo8XMFc9Y9/iiOiLWIIvIoiDN0FAa4xIU9cZPbRgzn0EE9WkbUyEzgdPfo2
        Zal4LfOxRSzDYCu50TqFEOueKjU8366qv+MXlB4AlsUy3zpb6MVLbCo/JyxDINpnuL6BCXLYDjlRp
        OVp6+FrUm9G+7H3GstGaoSDjwpaZzzB4K9bcsmbqNfW8t+fQ8tyvkvIvt7jPz1nSvNccbqEtAAwOB
        u8qOKddw==;
Received: from authenticated user
        by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <bage@debian.org>)
        id 1ogx3J-000AIf-OY; Fri, 07 Oct 2022 23:46:48 +0000
From:   Bastian Germann <bage@debian.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Bastian Germann <bage@debian.org>
Subject: [PATCH 0/1] 
Date:   Sat,  8 Oct 2022 01:45:52 +0200
Message-Id: <20221007234553.12328-1-bage@debian.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: bage
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,SUBJ_ALL_CAPS,UNPARSEABLE_RELAY
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pinebook uses RTL8723CS for WiFi and bluetooth. Enable it in the device tree.
This was part of a patch series adding RTL8723CS Bluetooth support to btrtl.

Vasily Khoruzhick (1):
  arm64: allwinner: a64: enable Bluetooth on Pinebook

 .../boot/dts/allwinner/sun50i-a64-pinebook.dts      | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.37.2

