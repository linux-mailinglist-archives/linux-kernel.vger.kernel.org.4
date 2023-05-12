Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63070043B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 11:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbjELJs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 05:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240215AbjELJsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 05:48:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089BB4C1F
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 02:48:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9E085C0395;
        Fri, 12 May 2023 05:48:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 12 May 2023 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1683884900; x=1683971300; bh=WrqF6SH0WS
        I05AVERMo+UbmQ+uOMQVHk/uJCiB3xzsw=; b=HUkCCc5KHY57+EBwm0RxyoAOyO
        VLwM2N2c+HEMP94GRI/WQorfMTUwB9SpYD+FoKVsrL3Fa6RZuJ75lDcVkVZLq4J1
        to5haxc2W/yD0PCKVHW+g+CchcrJYQo7ayOPW83rChHlaNp2NiLEvG5RMH6gFdfK
        5vSvVB+PkLR6GVVOxC0euQ7elYKkoNG67wONQHfN8JX7u9mW1/cuCplTPKn+5tTE
        mJ8YwKdgxAlWEmEt2/68EWw8G5MqpVthmzyYfB1fZ3QeBhn+ywvbjcL4T9Flyq4U
        di3QVpiksh53ED20+3AAsMVfjLohX5HdivG9hk5drxQNvGz+JoqRBYqKe5mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1683884900; x=1683971300; bh=WrqF6SH0WSI05AVERMo+UbmQ+uOMQVHk/uJ
        CiB3xzsw=; b=v9Hh1FgU9k3WwI6Vr3AI1vizyYZ2PHUIvmUQEgMuk4FQL5X6nEM
        Tl9hSWE7CoRQB+5RguMdlKUgS5z9wL0bmWzxyd2BEfs4uf4Q2JEOSSfJavcbCfCa
        yrv70WXFSzafcmDpwsqdWSVmg5K0inBkFA7GNpnhabhMX5HpFE+67DHwgzdit/C5
        ACy0DXdcZ/35fPIXoVkzTiUVADl34SDXkcrxFPEBDhFiriQlbzZik8xSD3lNktBb
        Sr50V5HWKJ3QOGdeSoTeoLd3JrXRS4dy5z8bSWLQ8PZhtbrub7oNwuuNQS3jPb7H
        Ty/hkM6rZPgCGaUGpW0wlnqopRIiFuDtAkw==
X-ME-Sender: <xms:ZAteZJ7LpuR1s8msMjz-qaHOX-8zeggbhIExeNEOYbndRM-055yhKg>
    <xme:ZAteZG7CkjfkNx5-U-vQ9YK9b1VmNZsx9wIV3o7AT54M0174WF4b6n2mqKOUP6nAg
    yQp2v-YAY9wCfj4t7E>
X-ME-Received: <xmr:ZAteZAf18xxBdqtY1fsgrDpW_9ZgllyNgsz-PARYJy_a_CCUVwf9mlzhpGiscYocLwuOHZIJsZlKd3T0lFkPiFbWzL8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeehtddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehttdertd
    dttddvnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeetfeeiteefve
    egvdfggeffheetleejkeekleeugeffffdtgfdtteetkeevvddvgfenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:ZAteZCIKW7t-84n56mGacaGMiX0uPfvDnBsPFBR7W6SGNLF-Glo4xA>
    <xmx:ZAteZNKgeaApjATkxDCwCLuA4ypueXjBDhJ09FzB8CdJtVq8gwgxVw>
    <xmx:ZAteZLzBxHjyjthAgowL4SmZUPO_aZcf11sj7Ep7NWfgBpWxmtY_fg>
    <xmx:ZAteZEU2taO3MDM9xOiSm6BGMNdgvrNSC6LPThfsePx3crZi6mmsRQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 May 2023 05:48:19 -0400 (EDT)
Date:   Fri, 12 May 2023 18:48:17 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     torvalds@linux-foundation.org
Cc:     broonie@kernel.org, tiwai@suse.de, linux-kernel@vger.kernel.org
Subject: [GIT PULL] firewire fixes for 6.4-rc2
Message-ID: <20230512094817.GA904820@workstation>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        torvalds@linux-foundation.org, broonie@kernel.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some minor fix for FireWire subsystem.

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.4-rc2

for you to fetch changes up to f7dcc5e33c1e4b0d278a30f7d2f0c9a63d7b40ca:

  firewire: net: fix unexpected release of object for asynchronous request packet (2023-05-11 09:06:49 +0900)

----------------------------------------------------------------
firewire fixes for 6.4-rc2

The pull request includes one patch to fix the change added to 6.3 kernel.
The patch can be applied to 6.3 stable kernel as is.

----------------------------------------------------------------
Takashi Sakamoto (1):
      firewire: net: fix unexpected release of object for asynchronous request packet

 drivers/firewire/net.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)


Regards

Takashi Sakamoto
