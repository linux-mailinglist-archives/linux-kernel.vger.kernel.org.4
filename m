Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4462E212
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240734AbiKQQgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240649AbiKQQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:35:29 -0500
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344765985B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:34:54 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:34:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668702892; x=1668962092;
        bh=UHkvVZhelkt87lb5NxW5b94WAvZpnGxgLmfBH+Voh+Y=;
        h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=UY5le6ovD5Vkg3CsEACZLWLOAuE49BC8J9Ovke8ohoGVAwS8Y7vUyqJqkeJx6y8wd
         BHga3UJwH+n8nNFJkqwm7TqAumQxl3lqsOqSmZd94Yl5JyYaUIRzTFElWzjdcPzGdx
         27wSjCj1MFgeViUvNHd59WfkpnT6ygjQ1wBW4jVlLuDpr9QGCHZCz2zIpqVA3G/zX3
         2qsRJf6vkMRkCmtGqZg04x+Bx3VsJEY3AQdbyM62yK0Z2/aI6iUB5GoKCasFVBP6ZJ
         ngonrYexlOYx/jfSmvD4Hd85EtmF3P7Is8gXEsCMBfWIC6VscqC4DCHzmSv20CILVW
         ioakJC10sWWIw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 0/3] Add supports for Imagis IST3038 and IST30XXB
Message-ID: <20221117163440.23394-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds supports for Imagis IST3038 and IST30XXB IC, which are
variants of Imagis IST3038 IC. They have a different register map
(labeled protocol b), but otherwise it seems to be the same IC.
It is also possible to support various other Imagis ICs using
protocol b, such as (but not limited to) IST3044B, IST3026, IST3032,
IST3026B, IST3032B. However, most of them (all except IST3044B)
use a different coordinate format, so extra effort would be needed
to support those.

Tested on Samsung Galaxy Core Prime and Grand Max.

