Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBB466CED4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 19:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjAPS3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 13:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234951AbjAPS2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 13:28:35 -0500
Received: from smtp.tiscali.it (michael-notr.mail.tiscali.it [213.205.33.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4922E41B63
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 10:14:46 -0800 (PST)
Received: from [192.168.178.50] ([79.40.78.92])
        by michael.mail.tiscali.it with 
        id 9WEh2900t1zVZtK01WEhD8; Mon, 16 Jan 2023 18:14:44 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: fantonifabio@tiscali.it
Message-ID: <62a18c7d-93d9-657e-48fd-1af06d6d1d9e@tiscali.it>
Date:   Mon, 16 Jan 2023 19:14:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: fantonifabio@tiscali.it
Subject: Re: [PATCH v2] documentation: fix Generic Block Device Capability
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergei Shtepa <sergei.shtepa@veeam.com>
References: <20230110132104.12499-1-fantonifabio@tiscali.it>
 <Y8WPFMFxpfdZKs5a@infradead.org>
From:   Fabio Fantoni <fantonifabio@tiscali.it>
In-Reply-To: <Y8WPFMFxpfdZKs5a@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Avast (VPS 230116-4, 16/1/2023), Outbound message
X-Antivirus-Status: Clean
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1673892884; bh=3U/UMDrt1ERP+4W8WcGd8ghmP5Kf8zFnC0ua/Movv7Y=;
        h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To;
        b=GXjGttE24bptT6Mg2kDVcWMNAS76gup0cyC7Zno3Cvyvsqc9YjaPFpJnVt0NHaxCO
         1SFRI/l3BW06lufYD9cNbvRrCflFMqvhAgrMtoewpkyL16okj5dOmRH8rHnMfm+pvF
         8DALWSyCTRrlzIw1VrSuh0Yt9g7RyA/9N0ckuGS0=
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_SORBS_WEB,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/01/2023 18:53, Christoph Hellwig ha scritto:
> On Tue, Jan 10, 2023 at 02:21:04PM +0100, Fabio Fantoni wrote:
>> - * ``GENHD_FL_REMOVABLE``: indicates that the block device gives access to
>> + * ``GENHD_FL_REMOVABLE`` (0x01): indicates that the block device gives access to
> The numberic values really do not belong into the documentation.  They
> are just implementation details.
>
Thanks for reply, if values are not into the documentation see from 
/sys/block/<disk>/capability output what flags are enabled will require 
look to source code of include/linux/blkdev.h and 
Documentation/block/capability.rst will be less useful, or I'm wrong?

