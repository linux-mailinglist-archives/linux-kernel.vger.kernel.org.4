Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E157214E5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 07:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjFDFpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 01:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDFpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 01:45:00 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDDD2
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 22:44:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A0865C0103;
        Sun,  4 Jun 2023 01:44:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 04 Jun 2023 01:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1685857496; x=1685943896; bh=mYfYawhR6/
        FwU6aA3Or07fkbdZ6eFN/9YA8MoLGiTOI=; b=nzbvAALfuKK8lO11gTvuhUocJ2
        qHT2Pvh9oKeKPUL0QwvzOQtP292DO/53pAimHHT09OcMDfWapT6EH35yBN3MFRxr
        va4xQe2DwCJXfTh/mFFE8eQGGySGh7gCqzdaCay3HjXxqfMzrJmoPbgBth7WRJEQ
        22Oq45p9IJ7dgVOpqAB/TIUo95fE7udI7bEyOGaFXVtscrWzKWCYgIst3b0GjgXy
        92Eb6V4rHSX4WxyqYnFCUkBk/XZJwfe5QurGkoRiHse00e+A4pWaT69wpbAjkmgX
        4hc099B9ik4lTy/XpRmXEnKAFk2RmbpT0Z8yGGDPO3uJGB/+3w62xHTTmp0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:date:feedback-id:feedback-id:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1685857496; x=1685943896; bh=mYfYawhR6/FwU6aA3Or07fkbdZ6e
        FN/9YA8MoLGiTOI=; b=vS/BRBm5+glxkXhS8cAZ2qCCRd6TEaOBtWeH54E1Fau9
        CBjAuQNGGeq3rEm/bboWVSmKSFdTmezYDjDlDHGmYLq0pWSHEPXyWyXoI2/nh/pB
        D3YkZ98bC8Ab9+i8t9Ccb0e2hwkadqXWZEgL9gvWnHTFP0Czc5FhS5kh32SHdYfX
        scgmupmeVcpXweVvxZ9cn7s+1iEMEK+s1dRRNbQa9Gs6xljzoNR05MCu3H0JM9pq
        nHoYLMdRYXiertr9RVsBWFBbfd2oLm4LirjvrW5lp2jyEGdEdrT/M05uH8voAtJc
        qVx0hDlCi5j52VGvLrHBJ62lPF0xSo/YBRLtIg21dQ==
X-ME-Sender: <xms:2CR8ZJQHTrWt9_ofO8bDRnqu-R1W51Xjfm4-Qtfmo6BFvQH52unNew>
    <xme:2CR8ZCxObukXaT1KG6xAJ189CAMGjvqb8_YC4jxLMsFuOb2ywbWYCF21uLb5a-OkI
    gEwfRXaj0Gh3nlOdiQ>
X-ME-Received: <xmr:2CR8ZO0oI65Vv_Y2kd_CP7ssCMJl87WTV-wgzzqCFFJx8-Qa6jUIKhrxZZqYm2grggpUuQB6BYGgw4GcI8Jt_hKK7-s2wY7xk8HV7Nt3bpU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeliedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpedujeetlefhtd
    dtkefgtdeuieelhffgteejjeehkeegveduvdevgeeiheeuueekjeenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghshhhisehsrg
    hkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:2CR8ZBDHHEFwR2fjgXrnmiFyEsKb77n_L61jcdxfdwKnGvWMUvbgvg>
    <xmx:2CR8ZCjmHDMR_7sK2nLWT-KBExKwkw4KswZ_DJ-FZcrPev5WgIhBzw>
    <xmx:2CR8ZFqL3Bd6NGiun2pZVmJhbWcGTbc6XwseERwWDlu4hXcJN0EQyA>
    <xmx:2CR8ZKKWgY5zghHvOGhqwuBsBeyS_nX0QYZua5k_XLV8KCnY8u2N7w>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jun 2023 01:44:55 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] firewire: ohci: adoption of device managed resource
Date:   Sun,  4 Jun 2023 14:44:42 +0900
Message-Id: <20230604054451.161076-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linux FireWire subsystem includes a driver (firewire-ohci) for 1394 OHCI
controller. The code of driver is mostly written at the time when device
managed resource (devres) was not widely used. Nowadays the usage of
devres is standard when writing drivers. The series is an adoption of
devres for firewire-ohci.

I note that MSI-related operation is left as is. The hardware vendors
forms their products of extension card with 1394 OHCI controller
connected to PCIe bus by several ways. If chip of 1394 OHCI controller has
PCIe interface (e.g. VIA VT6315, LSI FW643), it is just connected to PCIe
bus. If the chip has PCI interface only, it is connected to PCIe bus via
PCI/PCIe bridge chip (e.g. VIA VT6307 + asmedia ASM1083). There is some
chip of 1394 OHCI controller integrated with the bus bridge (e.g. TI
XIO2213, XIO2221). The MSI-related operation should cover the above
forms as well as module option, while it is still unclear that the
operation from pci device driver to the bus bridge.

Takashi Sakamoto (9):
  firewire: ohci: use devres for memory object of ohci structure
  firewire: ohci: use devres for PCI-related resources
  firewire: ohci: use devres for MMIO region mapping
  firewire: ohci: use devres for misc DMA buffer
  firewire: ohci: use devres for requested IRQ
  firewire: ohci: use devres for list of isochronous contexts
  firewire: ohci: use devres for IT, IR, AT/receive, and AT/request
    contexts
  firewire: ohci: use devres for content of configuration ROM
  firewire: ohci: release buffer for AR req/resp contexts when managed
    resource is released

 drivers/firewire/ohci.c | 174 +++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 111 deletions(-)

-- 
2.39.2

