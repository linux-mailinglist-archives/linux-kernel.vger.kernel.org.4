Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7B1655AA0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 16:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiLXPsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 10:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiLXPst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 10:48:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78B75FAE;
        Sat, 24 Dec 2022 07:48:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B183601D9;
        Sat, 24 Dec 2022 15:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E757C433D2;
        Sat, 24 Dec 2022 15:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671896925;
        bh=TbL10yENx03QutUshBo9CR+1cIeW10xWw1Krmir7kFw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHgOv6thr4+npEcodYXPAo7AUQ99xqL9LXWS5kbRn4CdfRgJ/Cj8u06lJuS1Ky2qB
         fw7Omg7o9drmoIRNw0vb+1bJNSzNvAfdCA7AbrgFMOkJqyurJKyPTAxivXqx60hOOz
         q3bb6JZssrmhwHonou+ouE86XIWBKebAC6OqYBaJgdemmi3zwCQTT3a7tWcXun/AbX
         mNeyTgbjwMvDohr+QxLnYEpl5ezuLTSd8TJMjL0dgiGIIre9sTiXcAKf8EaksbGTaL
         ViArgSSNXs8JrkaID17JKnAKZtru7AMhPaoaf5txCIUQs5BkI1s4SMIvWCSGEXf/pP
         Ld77n3kjnYfSQ==
Received: by pali.im (Postfix)
        id D8398720; Sat, 24 Dec 2022 16:48:42 +0100 (CET)
Date:   Sat, 24 Dec 2022 16:48:42 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224154842.o4ngrwmskduowttm@pali>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6cXRbGUsarzoJEw@zn.tnic>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2022 16:14:13 Borislav Petkov wrote:
> On Sat, Dec 24, 2022 at 02:34:25PM +0100, Pali Rohár wrote:
> > And asking question back is not the best way too.
> 
> Maybe I'm missing something here but is there a logic/rule somewhere
> which says to inform *you* when this driver gets removed?!

Do you think that it is fully illogical to never inform and ignore
userspace projects which are under active maintenance and are using
kernel APIs and kernel drivers which somebody decided to remove?

> I can't find one, ./scripts/get_maintainer.pl doesn't say so either.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
