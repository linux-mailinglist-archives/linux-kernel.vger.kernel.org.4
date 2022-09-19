Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030D95BCD14
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiISNZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiISNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406A0CE2D;
        Mon, 19 Sep 2022 06:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81A93B81BE3;
        Mon, 19 Sep 2022 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B00C433D7;
        Mon, 19 Sep 2022 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593926;
        bh=4bEUd19yquFy95j1oi43w3aV8cwe4vvx50yTbe2Sue0=;
        h=From:To:Cc:Subject:Date:From;
        b=bs/Tea3wekFPv1dUppYj0DLcTw9lZvncBNDZrtZkPcsgxxxcl1Uyjg1QGub3rzW7q
         b5MHfXfm/fiRta6QdX0dBKXZvv5pbRxZwcocuXkhFdGVUhEJZ125ZGE07g6kpLdVGe
         mcFCb6R/9yJlB7no5/pixgNVUx5Law8q0ihR/LMMWJNb/kmjuvO6G3ZiLdaXAnPQen
         jfb7SL0Y4KuTFdTOOFgUOJuqxCfJNZV/qSCQvrbGjzir7FudVnJUPiv5dI1JHnc/LR
         PfU/Om7dcRThG6H9iscDN6Uqj4b6n47xTg1+iG/gx5Flf24m4vAtPjErpvWfGNVLgV
         2w2ZsMb7m2gfA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaGmA-0005R3-Uo; Mon, 19 Sep 2022 15:25:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] USB: serial: ftdi_sio: misc clean ups
Date:   Mon, 19 Sep 2022 15:24:53 +0200
Message-Id: <20220919132456.20851-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some clean ups on top of the recent dev_groups attribute
conversion.

Johan

Johan Hovold (3):
  USB: serial: ftdi_sio: clean up attribute visibility logic
  USB: serial: ftdi_sio: move driver structure
  USB: serial: ftdi_sio: clean up driver prefix

 drivers/usb/serial/ftdi_sio.c | 144 +++++++++++++---------------------
 1 file changed, 54 insertions(+), 90 deletions(-)

-- 
2.35.1

