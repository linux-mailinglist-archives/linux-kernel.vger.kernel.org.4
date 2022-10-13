Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E425FCF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 02:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJMAFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 20:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJMAFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 20:05:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D19D8EC3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 17:05:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F8B6166E
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 00:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E58DC433D7;
        Thu, 13 Oct 2022 00:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665619550;
        bh=YvYXcOXGUUew1LRS4jWpVLBEaW0yYPl59TADZ8wHhu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QL6/XY/vt3YZNIKJ7oFIEcyv/LHaN15JwtPu1BCMEtJoUBgl21dbMwsqejhr//sBr
         lGZpKNVQUrZXzfOzfdUQj+6CWryE2Sm66tIvFxEWhxGfxjjlxdCgpooEizULzSseIE
         GgtqgfUcedUjaXqqmZQUWsMtscX36cyJTAKfCjmWrZX6rtiebFEr9peWkud+OaL9Xo
         g/RkWYVHmUXeaSNEiItUR7gEsBqAlptimdALaTGCe7F9uoMNa50IlGt4kmpzu1xaas
         va1HETefXg9goGMsDV9CSqTP5LZ2CiNyBCzszv2ezzkmIVZZlYVD/80PGI0GvqddRj
         1KODv/8HS0lyw==
Date:   Wed, 12 Oct 2022 17:05:48 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Sathvika Vasireddy <sv@linux.ibm.com>, jpoimboe@redhat.com,
        aik@ozlabs.ru, linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, rostedt@goodmis.org, npiggin@gmail.com,
        mbenes@suse.cz, chenzhongjin@huawei.com
Subject: Re: [PATCH v4 00/16] objtool: Enable and implement --mcount option
 on powerpc
Message-ID: <20221013000548.d2m65fozzdvdsj5u@treble>
References: <20221002104240.1316480-1-sv@linux.ibm.com>
 <1665401892.qmrp2qjj9t.naveen@linux.ibm.com>
 <notmuch-sha1-66fb111b87471c685a53b80a0502d959f90d07a7>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <notmuch-sha1-66fb111b87471c685a53b80a0502d959f90d07a7>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 01:20:02PM -0700, Josh Poimboeuf wrote:
> On Mon, Oct 10, 2022 at 05:19:02PM +0530, Naveen N. Rao wrote:
> > All the above changes are down to compiler optimizations and shuffling due
> > to CONFIG_OBJTOOL being enabled and changing annotate_unreachable().
> > 
> > As such, for this series:
> > Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > 
> > 
> > Josh,
> > Are you ok if this series is taken in through the powerpc tree?
> 
> Yes, it looks ok to me.  Let me run it through a round of testing.

The testing looked good, so:

  Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
