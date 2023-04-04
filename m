Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796BD6D6858
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbjDDQGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjDDQGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 12:06:53 -0400
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [95.215.58.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D83AB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 09:06:52 -0700 (PDT)
Date:   Tue, 4 Apr 2023 12:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680624410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iW8EWSoTFtp5xBF6TezwF5Hnaz1uauxqPercJ/2f6tQ=;
        b=ab1021gupMK5rvMkPNefXvjtl1+Fv5lfQqqrMPanoZzkvBFey+fWlReH9nHMNXVooGgGIB
        YsIvHT+I8jlHJGMHn9aI3d0924xHjpC81n0IKfZw8sg1AK2B4fmDvJvb5871nj8cMT11XT
        eyZOCqNxEJhAocH/elctZdg3GJ8TZEQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 0/2] bio iter improvements
Message-ID: <ZCxLGLdcN5wYnxfr@moria.home.lan>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <ZCIVLQ6Klrps6k1g@infradead.org>
 <ZCNN2GE3WBjMkLkH@moria.home.lan>
 <ZCrsbv+zKGf4jvUm@infradead.org>
 <ZCsAhDpsiNWpiAxS@moria.home.lan>
 <ZCxAIR8pxOfSE6OR@infradead.org>
 <ZCxGdj3JKl2RPUJW@moria.home.lan>
 <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bbdb38b-a3ac-5127-23c0-56badd113538@kernel.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 10:01:58AM -0600, Jens Axboe wrote:
> >> Starting to get personal instead tends to not help to convince your
> >> reviewers that it's really useful in general.
> > 
> > I know you and others like to talk a lot about what you want as
> > maintainers and reviewers - but I find that the people who are the
> > loudest and the most authoritarian in that respect tend not to be the
> > people who drive discussions forward in productive ways.
> 
> One issue is certainly that nobody wants to engage with people that
> instantly try and make this personal, or just uncomfortable in general.

Yeah, you like to respond to technical discussion with a *plonk*.

*eyeroll*

Christoph can handle himself, he doesn't need you defending him.
