Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961B655AAE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 17:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiLXQBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 11:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiLXQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 11:00:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0DE79;
        Sat, 24 Dec 2022 08:00:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 847C2601D9;
        Sat, 24 Dec 2022 16:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E71C433D2;
        Sat, 24 Dec 2022 16:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671897657;
        bh=tCIbJLGlKF/75werwPQ2M/iSeqjrp6+Cf8FBuisAnqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XqcO2jRBhXDwjVXe+ck1nZ04WSgx7+AddMEgfc3KCK+RWr+Ak6GCfCPUjJcA9ZHiG
         ievkFMpGJfEikvnda676sju7UJOQx72ce6wrJfwt6wEZx5H15uiMP8fgULecD0gTfj
         RH681xMP+ETldkC6sAXLuxdLrDbcYkW4v9i0fKJG75XJJ1vVT0d6kV0RLJtmjX6fxz
         +yukBy4RBqi/7ivMZhVsUWtWlBRiBC/SAlJpcE2K1P5LAxP7MugWYXHVfIqdE+9B7U
         P6TKv4Oz4C/rbmANcekm6jEbt6mcJvBbNHs19hu+yfpwFMqDqIA4hifB+IfefsgEe+
         zehkstKcXsvxA==
Received: by pali.im (Postfix)
        id 2A47F720; Sat, 24 Dec 2022 17:00:55 +0100 (CET)
Date:   Sat, 24 Dec 2022 17:00:55 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Maier <balagi@justmail.de>, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd: remove driver.
Message-ID: <20221224160055.ln3dbhx7dnut7dwi@pali>
References: <20221202182758.1339039-1-gregkh@linuxfoundation.org>
 <20221224095353.w32xhmyzlft6qi4v@pali>
 <Y6bObzIoHrJMotI3@kroah.com>
 <20221224101139.sgvhr2n3pbrs4agm@pali>
 <Y6bvh48kTTzbMX6M@kroah.com>
 <20221224133425.vlcxbaaynihiom4a@pali>
 <Y6cXRbGUsarzoJEw@zn.tnic>
 <20221224154842.o4ngrwmskduowttm@pali>
 <Y6chm9khdG4pmNhN@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6chm9khdG4pmNhN@zn.tnic>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 December 2022 16:58:19 Borislav Petkov wrote:
> On Sat, Dec 24, 2022 at 04:48:42PM +0100, Pali Rohár wrote:
> > Do you think that it is fully illogical to never inform and ignore
> > userspace projects which are under active maintenance and are using
> > kernel APIs and kernel drivers which somebody decided to remove?
> 
> How is one supposed to find those userspace projects?

Maybe it would be a wise to read a documentation which is in the kernel
source tree? Or at least read the deletion patch itself as it is linked
from there? Or what else could be easier than this?

> Lemme repeat my question: is there a logic/rule somewhere which says to
> inform *you* when this driver gets removed?!

Let me repeat my original question again: Why to remove this driver?
