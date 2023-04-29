Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A420A6F270B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 00:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjD2Wvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 18:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjD2Wvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 18:51:43 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E8310C0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 15:51:42 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 923EB41A2A;
        Sun, 30 Apr 2023 00:44:00 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1682808237; x=1684622638; bh=iXgn+FR+QNAUf/Tz
        7822tb2VMKqrhdcpTMXVYYNDlsU=; b=kjTJJpcZoHVdB13I9kqZ5A7+AdXHx5Tt
        ce1IoJI5JFd3Pg7UV8TlZK32m/o8x7zurWY/utO9+v38HyFS6dlnNigiaHna7mxN
        G2K6c80xPFZdcJ2TBZ4tVoFjJ0BKdzARzZdNshZGVd10pWN8iStAUweagm9GrXoX
        DBUJYu4Vk+M9hf+IthG8nORh1crXg2qagHlfMmo0XIXESRVGIcNxP3Qk240clVQG
        2jQRjPKj/C8HE6wljNtz20BkRDaKkZqSeQ45RjyHaxVxFuxS/CiypGal1R+fyo9j
        xtchKpXRiJXfJj/lYRPEaTOh4lacwfSwH+Zuc6dNrRIFVCg40eob5nTxX+F4NsqX
        asSiUciNjleGpD4JmZC/XyJBt0NgYpyNU+20ejI1TXY3m0/dFCd6YYpO2/ZPsSUo
        OnvssobsB4ZymDuWVX5YLgYQXO5UyoAR4W/HpfSMTInb05NIMGs5ilpI9ag6AvdL
        X33q+liYZiekptqWY2FMR0lvC5YMBAypiLix/Vqn/AKQe9HQ7AlejHioD7X2SoYq
        atQomZC6hNPqzsYm+Sx1Vx/s+J8ewTOj7z44lYcOm/8gcwad+VKStW0eVZ9EwVh9
        7GzYMQoKnsKo7t4lnm76L2if10cqaxw9S2MZLooPMxJAIEUilT8sYYYhp9IbLSxt
        flpnmM8nXZg=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wg3lPB6SLRDX; Sun, 30 Apr 2023 00:43:57 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by mx.kolabnow.com (Postfix) with ESMTPS id 9A869418CF;
        Sun, 30 Apr 2023 00:43:56 +0200 (CEST)
Received: from ext-subm001.mykolab.com (unknown [10.9.6.1])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id 165675C77;
        Sun, 30 Apr 2023 00:43:56 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech
Subject: [PATCH 0/2] support config of U-Blox Zed-F9P GNSS
Date:   Sat, 29 Apr 2023 15:43:47 -0700
Message-Id: <20230429224349.1935029-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <achaiken@aurora.tech>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22, only on a U-Blox Zed-F9P GNSS.

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 198 +++++++++++++++++-
 2 files changed, 197 insertions(+), 2 deletions(-)

-- 
2.39.2

