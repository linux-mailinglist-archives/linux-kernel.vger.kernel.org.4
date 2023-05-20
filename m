Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F1670A8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 17:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjETPeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjETPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 11:34:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF17A10F
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 08:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 449B460B18
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 15:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D24C433EF;
        Sat, 20 May 2023 15:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684596840;
        bh=RCrb0iZRu61dtcKTYh2CYMyznwZ1y+qR8D0PCr7gzbo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qsRaUbHcuW9ezMKsABRval6gFER4vT2tHfAI8xuNgCjzttMGNTTRzEXabUKx8Mawe
         lylPCQgLoTDfVFwZ+ODWPVMGwl3nnuaMTCs7iwNh5NFq8RAiaFF2iYp4k5yGeQmP89
         Lr9WX2pixkcLqXlj/aVTTIqG3BidAPMTVyAhcancneJyzXFeHafhu7NGehRijeMC8/
         hYv5pshjQEJr9l5E6r4VrUcNnkz+yztCwmsqngGUA6evGm3gn5IjoomnFn4FUvDXbe
         eC7umLdF0Q55M5enMl5xFQE5dQPI9bg+cqzsSmvimB/AuaUR0ckHsusdzv7mjfvTUb
         1dAePjL6TOZAA==
Date:   Sat, 20 May 2023 08:33:58 -0700
From:   Chris Li <chrisl@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH -next v9 0/3] Delay the initialization of zswap
Message-ID: <ZGjoZogPALPvHKOo@google.com>
References: <20230411093632.822290-1-liushixin2@huawei.com>
 <ZFL4Tvm8KKrCfjRr@google.com>
 <9b2b6dac-9a3d-efcb-9706-44f6df1fe2bf@huawei.com>
 <ZFPG3swMcHW/qxID@google.com>
 <6ed055cb-e705-3993-6285-3a30bba15c0d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ed055cb-e705-3993-6285-3a30bba15c0d@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shixin,

On Mon, May 08, 2023 at 09:37:23AM +0800, Liu Shixin wrote:
> > I am guilty of giving this feedback late. If you come up with a V10, I will be glad
> > to review it. Or, if you prefer, I can come up with the smaller patch for you
> > to review as well. What do you say?
> You can add a pre-patch to modify it before your patch. Thanks.

Will do. I notice your patch has already been merged, that is the
only way to move forward anyway.

I will CC you for review when I send the patch out.

Chris
