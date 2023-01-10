Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86609663A60
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 09:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjAJIEY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 03:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238012AbjAJID3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 03:03:29 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9286D2F7BF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 00:03:24 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BAF5C60719A6;
        Tue, 10 Jan 2023 09:03:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ZH3MRa_nO2Mu; Tue, 10 Jan 2023 09:03:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7E4A2609D2C4;
        Tue, 10 Jan 2023 09:03:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SOKTC41ONl-h; Tue, 10 Jan 2023 09:03:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5F907607401A;
        Tue, 10 Jan 2023 09:03:21 +0100 (CET)
Date:   Tue, 10 Jan 2023 09:03:21 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <sha@pengutronix.de>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1093159744.18217.1673337801329.JavaMail.zimbra@nod.at>
In-Reply-To: <20230106121815.GA20604@pengutronix.de>
References: <20180704140230.5606-1-richard@nod.at> <20230106121815.GA20604@pengutronix.de>
Subject: Re: [PATCH] ubifs: Handle LPT corruption better in
 ubifs_garbage_collect_leb()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Handle LPT corruption better in ubifs_garbage_collect_leb()
Thread-Index: b7na40JorsG4+CUCL+f2TJDtyvMYEg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sascha,

----- Ursprüngliche Mail -----
> What happened to this patch? It never made it anywhere. I just stumbled
> over this issue and found this patch afterwards.

I have withdrawn this patch because it cures only a symptom and not
the root cause. The root cause is a LPT corruption.
IIRC I saw the problem while investigating into another problem which
caused UBIFS corruptions.

Thanks,
//richard
