Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11307612911
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 09:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJ3IVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 04:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiJ3IVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 04:21:34 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AA3C0A;
        Sun, 30 Oct 2022 01:21:32 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52D9768AA6; Sun, 30 Oct 2022 09:21:30 +0100 (CET)
Date:   Sun, 30 Oct 2022 09:21:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
        sagi@grimberg.me, bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 3/3] block: hide back blk_freeze_queue_start
 and export its blk-mq alias
Message-ID: <20221030082130.GA4930@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3f2b51cc7f5c21e49bfa089e594cb203a4015183.1667107410.git.nickyc975@zju.edu.cn> <20221030074010.GD4131@lst.de> <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2671e78e.152908.18427f9be8d.Coremail.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 04:19:49PM +0800, Jinlong Chen wrote:
> I agree that the freezing stuff (maybe also the quiescing stuff) should
> move out of the mq namespace. If now is not the proper time, I'll leave
> them alone. I'll resend patch 1 alone without the comment.

The quiesce actually is entirely blk-mq specific, which just have some
careless callers.
