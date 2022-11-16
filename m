Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB362BB01
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbiKPLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbiKPLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:09:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7676027CC0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:55:32 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668596131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZWOK12bBQzfven+8ibegaaTe5lWvR5YpriVsQM/F1s=;
        b=qTTSe3UJ7rDg5M3QGrN8qRVEU9NdQBaNDQvmvU7MgngFQtN+ZVvtF/pwZ4WIJeAgCWg8cO
        cSayAsFNUNAIyUuyhjJ1m14iqKbPH+Taf9uEuTH7aiWMm+IZTh0KIWPsBvoagSpZswIOPR
        Va1StaUT1GL1pzUYN5oXOgSjPeXqIVoP1NjF6pTZDTshtYxNeonzDIxj5Kj4SxbUQ2JUkM
        rRffNZvr7dldZJZIw561wolDskS5DO9sjSm1/T03x/kWDytYhFN5sf3yY4z3g6szWCyxlG
        mD0T3f9VseB0/7l4Fur4rlOBo+XPbVDqE8j6lLNQGQbMxYywmxGOB76bDBM3pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668596131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XZWOK12bBQzfven+8ibegaaTe5lWvR5YpriVsQM/F1s=;
        b=9gL3tdw3nM0hizgP3YEjQeAW2d3RpgsnOoAPRAKm0nlKTZ0k0s90T59SOmFV8edilDW+35
        F8E7rflPR4pa9lBg==
To:     Angus Chen <angus.chen@jaguarmicro.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: RE: IRQ affinity problem from virtio_blk
In-Reply-To: <TY2PR06MB34241333364AA5843CD4BAA885079@TY2PR06MB3424.apcprd06.prod.outlook.com>
References: <TY2PR06MB3424CB11DB57CA1FAA16F10D85049@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <87v8nfrhbw.ffs@tglx> <20221115174152-mutt-send-email-mst@kernel.org>
 <87sfijrf9o.ffs@tglx> <87o7t7rec7.ffs@tglx>
 <20221115183339-mutt-send-email-mst@kernel.org>
 <TY2PR06MB34241333364AA5843CD4BAA885079@TY2PR06MB3424.apcprd06.prod.outlook.com>
Date:   Wed, 16 Nov 2022 11:55:30 +0100
Message-ID: <87fsejqicd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16 2022 at 01:02, Angus Chen wrote:
>> On Wed, Nov 16, 2022 at 12:24:24AM +0100, Thomas Gleixner wrote:
> Any other information I need to provide,pls tell me.

A sensible use case for 180+ virtio block devices in a single guest.

Thanks,

        tglx
