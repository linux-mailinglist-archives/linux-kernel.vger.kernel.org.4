Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD8270B16A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 00:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjEUWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjEUWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 18:21:45 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9464ADD
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 15:21:39 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id A84721608D7;
        Mon, 22 May 2023 00:21:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1684707696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cAPg9tGtbz2/1LCTEZRf8SwYspQRIvIHtWj1fyxBIkI=;
        b=U6M5UirtuFGAKzak1FCJzyShlQ8OWXFaQ08qrbUAm4PeIEHXpQpaDjeU+2LTPTwo0xFOmR
        keKBUBsJhKDf7xKglrO1eg0roGVY2DNEVsCVuYTAmSV0/BSPobYEob48fqBfhZVdd4hbhO
        THhnaIYuGSEu+DhUzndC8Ldfq1kptZs=
From:   David Heidelberg <david@ixit.cz>
To:     clabbe@baylibre.com
Cc:     gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v5 1/2] usb: serial: add support for CH348
Date:   Mon, 22 May 2023 00:21:31 +0200
Message-Id: <20230521222130.15906-1-david@ixit.cz>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230106135338.643951-2-clabbe@baylibre.com>
References: <20230106135338.643951-2-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver loads, ttyUSB[0-7] are available, connecting with picocom working.

Thank you!

Tested-by: David Heidelberg <david@ixit.cz>
