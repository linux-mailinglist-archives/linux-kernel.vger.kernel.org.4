Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F926128DC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 08:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJ3Hit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiJ3Hiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 03:38:46 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901CD2C7;
        Sun, 30 Oct 2022 00:38:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F36F268AFE; Sun, 30 Oct 2022 08:38:42 +0100 (CET)
Date:   Sun, 30 Oct 2022 08:38:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 2/3] blk-mq: remove blk_freeze_queue
Message-ID: <20221030073842.GC4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <e21821b72fe9df4f187c1321dd38587138cd1aaa.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e21821b72fe9df4f187c1321dd38587138cd1aaa.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 01:26:45PM +0800, Jinlong Chen wrote:
> Nobody is calling blk_freeze_queue except its alias, so remove it.

So while we really do not need both names - the queue freezing is also
used for non-mq drivers, so the naming without the mq is actually the
slightly more correct one.  But for that it should also move out of
blk-mq.c, so I'm not really sure touching this right now is all that
helpful.
