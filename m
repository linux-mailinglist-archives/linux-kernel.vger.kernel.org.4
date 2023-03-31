Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4196D25B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjCaQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjCaQfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:35:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A165BBA;
        Fri, 31 Mar 2023 09:31:54 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-213-136.ewe-ip-backbone.de [91.248.213.136])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D6A26603196;
        Fri, 31 Mar 2023 17:31:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680280312;
        bh=ROyKFN5J9kFHYYM+jc7ULdBrZHEhNuSH4qms85Kx6Oo=;
        h=From:To:Cc:Subject:Date:From;
        b=eOkjxSvdqAlo/PMgxdsHKsmzTMCfsYnvhWw4eOde5o34LCqNkbUppzxLJyyIO0E1M
         TK4ThSj3c/HqW5lLciLDImVLg1bkoyYsws40mevkXcJcKttV3xzwHqNUG1eUbIgOeW
         HLcwGJXRqlMj428NN3yQOfUjOKgtkuFnyV7XErbAQ7cLp9KWgrvCSnBOrnQ11XDk7n
         Z66bAmQ9ShD1AOk0fKMfVSsY1BnTB5EYsGa7lp9Qx1gHSK5dZDPilSpNgtt1l30h8r
         tYvoK+sM3utVPdWYed5oKRbOdU8OC5m7qQtnMzweRXr+Enp1dGRLyF+h+fE0cU+uSj
         nLDiSpRGT4gYQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 63A4C4807E1; Fri, 31 Mar 2023 18:31:50 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCHv1 0/2] generic-ohci: increase allowed clocks
Date:   Fri, 31 Mar 2023 18:31:46 +0200
Message-Id: <20230331163148.5863-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This increases the max. allowed clocks for generic-ohci from 3 to 4.
On RK3588 a total of 4 clocks is required to access the OHCI registers.
Note, that EHCI already supports 4 clocks.

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: usb: generic-ohci: increase allowed clocks
  usb: host: ohci-platform: increase max clock number to 4

 Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
 drivers/usb/host/ohci-platform.c                        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.39.2

