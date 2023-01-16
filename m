Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E0666CF66
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 20:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjAPTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjAPTOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 14:14:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1BD25E01;
        Mon, 16 Jan 2023 11:14:00 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673896437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KP+ZeJKhuV/1h9DZDudWe7VjOB3jLOne6JPka+DBq8M=;
        b=C9PO+ig6Jpks3ETupv65OF37rXjMN7bOzL0sYy8VrGSm2FO+XAi1rICQvmYq/G+JvdRWSk
        3qFt9mOpx4RjU2yOKGl1iWr4xB0J0LtxTfufdQqHuSlUodFjzQsPYO9sa4MiU8632mQ4uS
        0X73peZulLRpU7Ifp/BcFp5JDw8gd7cqYqQ2OZV2YFJNkJgFZiY801QUP6iH02sOBZWZQ+
        DwqSQRofZaz/apD4BI2OZ4D+rE06Xr2X9HvAH44KeKUorBUEL7XcyGTVjqlaMlK5bsl1Dg
        +Yqd4PCiEGZ0xtesirs2tgQxzKfrS9ridYo4OPyAFftYjDDNzcJJxc71iyAs3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673896437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KP+ZeJKhuV/1h9DZDudWe7VjOB3jLOne6JPka+DBq8M=;
        b=3oRThO1aWKtOAMPVzSZ3Jvsam7g7zi1gCi4gRsaFMrwChAFsoIiJfa6GiQlYmpvLx72fcR
        irBTjH1BIZvxg0Cg==
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH V4 0/6] genirq/affinity: Abstract APIs from managed irq
 affinity spread
In-Reply-To: <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
References: <20221227022905.352674-1-ming.lei@redhat.com>
 <Y74cXN4SP7FNtSl3@T590> <ca08f6b8-a491-3a7e-f576-833acdf2135b@kernel.dk>
Date:   Mon, 16 Jan 2023 20:13:56 +0100
Message-ID: <87k01mmgwb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens!

On Wed, Jan 11 2023 at 12:04, Jens Axboe wrote:
> On 1/10/23 7:18=E2=80=AFPM, Ming Lei wrote:
>> Hello Thomas, Jens and guys,
>
> I took a look and it looks good to me, no immediate issues spotted.

Want me to take the blk-mq change through tip too or do you prefer to
merge that into your tree?

If this goes through tip, I'd appreciate an Ack. If you want it through
block, then I give you a tag with the irq parts for you to pull.

Thanks,

        tglx
