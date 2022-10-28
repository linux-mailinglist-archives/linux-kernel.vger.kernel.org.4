Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1990E610E37
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiJ1KPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiJ1KPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:15:33 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A1F1B94C6;
        Fri, 28 Oct 2022 03:15:26 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id C5D261863FB9;
        Fri, 28 Oct 2022 13:05:49 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MwiZZI5VNg5o; Fri, 28 Oct 2022 13:05:49 +0300 (MSK)
Received: from localhost (localhost [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 76F3E1863F7D;
        Fri, 28 Oct 2022 13:05:49 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NhTW9b_4Lqs3; Fri, 28 Oct 2022 13:05:49 +0300 (MSK)
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.20])
        by mail.astralinux.ru (Postfix) with ESMTPSA id C06461863FB9;
        Fri, 28 Oct 2022 13:05:48 +0300 (MSK)
From:   Anastasia Belova <abelova@astralinux.ru>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Anastasia Belova <abelova@astralinux.ru>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [PATCH 5.10 0/1] vdec_vp9_if: add check for NULL for vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Date:   Fri, 28 Oct 2022 13:05:38 +0300
Message-Id: <20221028100539.30925-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Null-pointer dereference was found with static analysis tools=20
in version 5.10. Seems this file doesn't exist since 5.18.
This file was moved to=20
    /drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c.
Maybe it is necessary to create another patch for these updates.
