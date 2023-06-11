Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395C372B3AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 21:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjFKT2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFKT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:28:17 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Jun 2023 12:28:16 PDT
Received: from mail.turbocat.net (turbocat.net [88.99.82.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F4CA0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 12:28:16 -0700 (PDT)
Received: from [10.36.2.145] (unknown [46.212.121.255])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by mail.turbocat.net (Postfix) with ESMTPSA id 548DF26053E
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 21:22:43 +0200 (CEST)
Message-ID: <9675e28b-4f74-84c0-6717-fe33e5a0ead0@selasky.org>
Date:   Sun, 11 Jun 2023 21:22:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   Hans Petter Selasky <hps@selasky.org>
Subject: [FYI] Issue about whiteout characters being used in file-systems
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To those who it may concern:
https://bugzilla.kernel.org/show_bug.cgi?id=217541

--HPS
