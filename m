Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048A4652CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 07:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLUGR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 01:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLUGRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 01:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EA51EC69
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 22:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671603420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aDEoXmqhctOv+Hupg8C4n9G1Rcn/w3EHQMMbJRdV8Pg=;
        b=ADGwb7kHHBdhq3BYt1PWTM8V+bwk6nvjm3Cik4GscqFBiju6IquI8UXeYWfOYavdZJ7WrL
        38cfDHKLt5CmqtbBQEyMrozIm/epYUnJ24g4QuAvc0TLVL8m0k3TwoAIrD4yL9p7/UCdpu
        rzeBHkDbN6F/0h3U9gH3B6U7C7hcjKU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-Agf0H1tTO_u9URi2zIESJQ-1; Wed, 21 Dec 2022 01:16:58 -0500
X-MC-Unique: Agf0H1tTO_u9URi2zIESJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6571C3C3C164;
        Wed, 21 Dec 2022 06:16:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-236.pek2.redhat.com [10.72.13.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B49892166B26;
        Wed, 21 Dec 2022 06:16:55 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     sgarzare@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Vendor stats support in vdpasim_net
Date:   Wed, 21 Dec 2022 14:16:48 +0800
Message-Id: <20221221061652.15202-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:

This series implements vendor stats in vdpasim_net. Please review.

Thanks

Jason Wang (4):
  vdpa_sim: switch to use __vdpa_alloc_device()
  vdpasim: customize allocation size
  vdpa_sim: support vendor satistics
  vdpa_sim_net: vendor satistics

 drivers/vdpa/vdpa_sim/vdpa_sim.c     |  34 ++++-
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |   4 +
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 214 ++++++++++++++++++++++++++-
 4 files changed, 242 insertions(+), 11 deletions(-)

-- 
2.25.1

