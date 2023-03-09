Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF25F6B203A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjCIJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCIJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:37:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC34E1CA2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:37:01 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 83D2968BEB; Thu,  9 Mar 2023 10:36:57 +0100 (CET)
Date:   Thu, 9 Mar 2023 10:36:57 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, elvis.angelaccio@kde.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: Add a module parameter for users to force
 simple suspend
Message-ID: <20230309093657.GA24373@lst.de>
References: <20230301203302.28889-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301203302.28889-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 02:33:01PM -0600, Mario Limonciello wrote:
> Elvis Angelaccio reports that his HP laptop that has two SSDs takes
> a long time to resume from suspend to idle and has low hardware sleep
> residency.  In analyzing the logs and acpidump from the BIOS it's clear
> that BIOS does set the StorageD3Enable _DSD property but it's only
> set on one of the SSDs.

Please quirk the platform in the PCIe core instead of requiring the
user to override manually in the nvme drivers that is not relevant.

And as a representative for a CPU/platform vendor that is all behind
this stupid crap please work with Microsoft and Intel to sort it out
properly the firmware level.  It's a never ending pain caused on us
that you guys caused for absolutely no reason.
