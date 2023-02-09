Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 148AD69021E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjBII0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjBII0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:26:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D649576;
        Thu,  9 Feb 2023 00:26:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 921F661932;
        Thu,  9 Feb 2023 08:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B93C433EF;
        Thu,  9 Feb 2023 08:26:19 +0000 (UTC)
Message-ID: <a524d4df-ea30-7823-fb2e-9f5b9ab7644e@xs4all.nl>
Date:   Thu, 9 Feb 2023 09:26:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230209075636.313e54e0@canb.auug.org.au>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230209075636.313e54e0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 21:56, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   fd24c6974a3a ("media: Revert "media: saa7146: deprecate hexium_gemini/orion, mxb and ttpci"")
>   a4ff09f5a690 ("media: Revert "media: av7110: move to staging/media/deprecated/saa7146"")
> 
> are missing a Signed-off-by from their author.
> 

Fixed. Thank you for reporting this.

Regards,

	Hans
