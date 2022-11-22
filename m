Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B763437A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiKVSSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbiKVSSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:18:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B86663D8;
        Tue, 22 Nov 2022 10:18:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6B0617FF;
        Tue, 22 Nov 2022 18:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309B2C433C1;
        Tue, 22 Nov 2022 18:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669141088;
        bh=F1/X157RhwBLjXeukxzZ/EjlXBHlWPcogIzzZCy6LME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvx7G+72oARxGs+OMs8B7BFpfsX4VYx3H9aarElGAq1yMRZ5mDN/8mV4kug2hxwKl
         VF6NU9CNl9eIhJI7rGsaMxtxs5MXPZSYbQuDYL7YWLV51xT4UzTozL5KK7rtDhXIiS
         VYlFeAoQCEC98/+uyobCwqVUW7WsMXZxZZO4U/ftCiIZTFGpiK5f3/CyrvPf6y5nLV
         EX60obLR/HS8n8S+c6z21Y7nLwp5U8zgwXUnjfcs4BGQa2R//69vdyxm6m2SAPBHL5
         jsZKuuAtevtiGn6rfOzL84zGDIkvc8kxv1UGr+mewSJMigLWuAXLv4aCpVphM1PCHc
         uWw57AWiKTIUQ==
Date:   Tue, 22 Nov 2022 18:18:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     John Keeping <john@metanate.com>
Cc:     linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 0/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Message-ID: <Y30SWm+bhv8srJC2@google.com>
References: <20221122123523.3068034-1-john@metanate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122123523.3068034-1-john@metanate.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, John Keeping wrote:

> This series arises from the recent thread [1] on lifetime issues.
> 
> The main point is the first patch, with the second being an unrelated
> fix for an issue spotted while working on this.  Both of these have
> Fixes: tags for backporting to stable.
> 
> The final patch tidies up some error handling to hopefully avoid patch 2
> issues in the future.
> 
> [1] https://lore.kernel.org/r/20221117120813.1257583-1-lee@kernel.org
> 
> John Keeping (3):
>   usb: gadget: f_hid: fix f_hidg lifetime vs cdev
>   usb: gadget: f_hid: fix refcount leak on error path
>   usb: gadget: f_hid: tidy error handling in hidg_alloc
> 
>  drivers/usb/gadget/function/f_hid.c | 60 ++++++++++++++++-------------
>  1 file changed, 33 insertions(+), 27 deletions(-)

For the set:

Reviewed-by: Lee Jones <lee@kernel.org>
Tested-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
