Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EFE6CA3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjC0MWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbjC0MWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:22:19 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF55582
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:20:46 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 7898E240197
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 14:20:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1679919614; bh=FeXOoQUc6PRSMgFlkyS7zSZ95m6sTHjTayMcbvKNQxo=;
        h=Subject:From:To:Cc:Date:From;
        b=KuCf1QAUEh8gntcDJpxSKNjQtAtEwBaMhDZnR6dq0accQ/UDK5hsRkBQOKf519gQ9
         L0s8lQhop1SvBr62847sTQPiMQJAo+45j5JpIw/l4+l1V8ufZxmb7opaqXtGa4bAae
         W2RRgXnixWZ4LQnvVuRuLToBJJZKJdKROmu9lCUukZlTYZdIFlEH0+O6qGWThwQekG
         T7/1l6qGqhFTN2oGSnRw9f/JgyIv5S6fp9fjSLMEuWFCYRrctsbpn/ZDguSIv1qcsJ
         dbs1f3fZRrwcfdiU0YaMQiwL4lhWpoxw0kE80saTFf/QaMud4EBM5f45wL8W9s70l7
         9KxZYl1taVwnw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PlX2P523Rz9rxV;
        Mon, 27 Mar 2023 14:20:13 +0200 (CEST)
Message-ID: <d6e483b15911a9be1e6c1d38200e50b5789738b2.camel@posteo.de>
Subject: Re: [PATCH v3] media: hi846: Fix memleak in hi846_init_controls()
From:   Martin Kepplinger <martink@posteo.de>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 27 Mar 2023 12:20:13 +0000
In-Reply-To: <20230327115809.297633-1-harperchen1110@gmail.com>
References: <20230327115809.297633-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, dem 27.03.2023 um 11:58 +0000 schrieb Wei Chen:
> hi846_init_controls doesn't clean the allocated ctrl_hdlr
> in case there is a failure, which causes memleak. Add
> v4l2_ctrl_handler_free to free the resource properly.
> 
> Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846
> 8M pixel camera")
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>

just for the future: you don't need to send a new revision for tags-
addition only. That's usually something that maintainers can do when
applying, also (semi-)automated.

But *if* you send a new revision (due to other changes), you *should*
add all appropriate tags. So for this new revision you forgot this:

Reviewed-by: Martin Kepplinger <martin.kepplinger@puri.sm>

but, as you now know, you should not create a new revision for this
alone.

thanks,

                            martin


