Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D88635120
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbiKWHfs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Nov 2022 02:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiKWHfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:35:45 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7488F72C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:35:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 72E6663E5148;
        Wed, 23 Nov 2022 08:35:40 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9EFN1IRcMIeV; Wed, 23 Nov 2022 08:35:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E37EF63E515B;
        Wed, 23 Nov 2022 08:35:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nBXtOD2zi7y0; Wed, 23 Nov 2022 08:35:39 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C3C0163E5148;
        Wed, 23 Nov 2022 08:35:39 +0100 (CET)
Date:   Wed, 23 Nov 2022 08:35:39 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Lihua <hucool.lihua@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        yusongping <yusongping@huawei.com>
Message-ID: <1427885394.268278.1669188939670.JavaMail.zimbra@nod.at>
In-Reply-To: <ad8ff736-bbce-2ec3-301f-691401a80bd1@huawei.com>
References: <20221121111847.71648-1-hucool.lihua@huawei.com> <ad8ff736-bbce-2ec3-301f-691401a80bd1@huawei.com>
Subject: Re: [PATCH v2] ubifs: Fix build errors as symbol undefined
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix build errors as symbol undefined
Thread-Index: Syve/GRFazr/6Fr3vH7Qg++v1/6ndA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Lihua" <hucool.lihua@huawei.com>
> An: "richard" <richard@nod.at>, "Sascha Hauer" <s.hauer@pengutronix.de>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "Wei Yongjun"
> <weiyongjun1@huawei.com>, "yusongping" <yusongping@huawei.com>
> Gesendet: Mittwoch, 23. November 2022 04:29:04
> Betreff: Re: [PATCH v2] ubifs: Fix build errors as symbol undefined

> ping

While I'm perfectly fine with pinging, because I'm more busy than I want to,
pinging after less than 48 hours is a little aggressive.

Thanks,
//richard
