Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73249718966
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjEaSbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjEaSbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:31:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77618198;
        Wed, 31 May 2023 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cFO0KTo2++Ng2RRXlpAW5yD45ZEX1X3u5XV/hZd9TdU=; b=c4AJJM/Id+jv4X4K73t+VCQuYj
        kQSg+zL8IMjg3dZ6L4TYvmWocLbG0FZoOu0L8QLgjzqDPja0iWanYrGvZgemVRbQiBuXUw9nzYHQ+
        HxA8ca7Z7d9pNnV5R+d19ZKa/HHIBMcuoeqIggGdLUZCpX8ereis1zz3siTJ7kWl1I1kIGXQH7jaV
        Tzkg9DVN+682ydWvlFBqTGfXGo53u876a8M234X8XM0kJqvcakeMa3aZdh0en5p/TWSIVTUa8M7OV
        kpoRkuWAOE9a64f1nmWq6mIkBZHAI5V0wWigLWzZdcAx6QtkqzRYOYDI36LOt90Nhb1GYx7B749rR
        CxYZA6uA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4Qay-007Vrh-CT; Wed, 31 May 2023 18:30:52 +0000
Date:   Wed, 31 May 2023 19:30:52 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, netdev@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>,
        Boris Pismenny <borisp@nvidia.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Ahern <dsahern@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/6] net: Block MSG_SENDPAGE_* from being
 passed to sendmsg() by userspace
Message-ID: <ZHeSXFdWuFjH+vVw@casper.infradead.org>
References: <ZHd9vCcBNtjkqeqg@corigine.com>
 <20230531124528.699123-1-dhowells@redhat.com>
 <20230531124528.699123-3-dhowells@redhat.com>
 <724855.1685556072@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <724855.1685556072@warthog.procyon.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 07:01:12PM +0100, David Howells wrote:
> Simon Horman <simon.horman@corigine.com> wrote:
> 
> > > sendpage is removed as a whole slew of pages will be passed in in one go by
> > 
> > on the off-chance that you need to respin for some other reason:
> > 
> > 	s/in in/in/
> 
> What I wrote is correct - there should be two ins.  I could write it as:
> 
> 	... passed in [as an argument] in one go...
> 
> For your amusement, consider:
> 
> 	All the faith he had had had had no effect on the outcome of his life.
> 
> 	https://ell.stackexchange.com/questions/285066/explanation-for-had-had-had-had-being-grammatically-correct

Let's not buffalo Buffalo buffalo ...
