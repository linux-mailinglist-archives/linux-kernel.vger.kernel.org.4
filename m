Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954DA60566D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJTEkk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 Oct 2022 00:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJTEkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:40:37 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C6714FD19
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:40:36 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id 224901A036F;
        Thu, 20 Oct 2022 04:40:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 64F6E1A;
        Thu, 20 Oct 2022 04:40:18 +0000 (UTC)
Message-ID: <c3c211c1c99cd19f86fb801576c55b2ae2216c6f.camel@perches.com>
Subject: Re: [PATCH] staging: rts5208: Replace instances of udelay by
 usleep_range
From:   Joe Perches <joe@perches.com>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Date:   Wed, 19 Oct 2022 21:40:31 -0700
In-Reply-To: <Y06yiBaluz6X0C4G@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
References: <Y06yiBaluz6X0C4G@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: usmgqx4pixopy5egm85zxz4z9qnn1kia
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 64F6E1A
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18nOiWvhA8sshLgAaiSMN3kHKN/Czo5MVc=
X-HE-Tag: 1666240818-841376
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-18 at 14:04 +0000, Tanjuate Brunostar wrote:
> Replace the use of udelay by usleep_range as suggested by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay; see Documentation/timers/timers-howto.rst
> +               udelay(30);
[]
> diff --git a/drivers/staging/rts5208/ms.c b/drivers/staging/rts5208/ms.c
[]
> @@ -3235,7 +3235,7 @@ static int ms_write_multiple_pages(struct rtsx_chip *chip, u16 old_blk,
>  			return STATUS_FAIL;
>  		}
>  
> -		udelay(30);
> +		usleep_range(30, 30);

This isn't useful.  Please read the Documentation/timers.

