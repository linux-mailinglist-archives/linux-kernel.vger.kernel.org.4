Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C362A316
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiKOUhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiKOUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:37:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA24BB3;
        Tue, 15 Nov 2022 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qy+DZuwA4M5WDugo0KAEoxGF9d6DWwiaweGeOENwlAA=; b=eeLAhDPOVheILTNUaMZAeCutI7
        G+ckJYCpaI5UJ0GTgnAyOgw5lDsvQf25ULwX2jnRAbd09KnVHR5+ud+TBakN4h+hr8qpAxvRT8lJK
        +Gvv9XYmLmOxBCJYsNA5rJk4UjlN3ftUxD79rmtSrMe9YChraW4hNwyL3XggoNw73bL/6dGBMIIcX
        b1kfOIN6xYBe3v2+rK5VMOdqzrQqhNUn0VbXIvWcq5OIy81P4z7/4EeZJWOl+Ymw5NFrCYVMrwnmy
        VpzQxiFQDxD9ql6QAsqmNUJbLGBvVHDP0ElX7u0DGvrpNZ/eAMaw11zGWcFqlAnTv6XBfMInpJ2XH
        xI/iYEaw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov2ft-00EcX0-LD; Tue, 15 Nov 2022 20:36:53 +0000
Date:   Tue, 15 Nov 2022 12:36:53 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>,
        masahiroy@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map
 symbols to built-in modules
Message-ID: <Y3P4ZXF97b88nVh5@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-5-nick.alcock@oracle.com>
 <Y3BhRvt53xO5A0iQ@bombadil.infradead.org>
 <87mt8tv554.fsf@esperi.org.uk>
 <76d7ba29-c7d2-d082-5928-599844112494@huawei.com>
 <87edu4uz7z.fsf@esperi.org.uk>
 <Y3PvavbJDZsQCiuQ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3PvavbJDZsQCiuQ@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 11:58:34AM -0800, Luis Chamberlain wrote:
> And then users.. we need users clearly documented, who the heck is
> using this or wants this / is going to use it and why.

What issues did existing users run into? Why is this an issue? If no
bugs have been reported why isn't this an issue then? Why does the
existing duplicate stuff not cause issues in-kernel for symbol
lookups?

Who is dying for this feature? What userspace tools / whatever has
support for this and can't wait to get their hands on this?

  Luis
