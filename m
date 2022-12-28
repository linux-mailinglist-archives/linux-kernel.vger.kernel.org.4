Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C79658740
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 23:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiL1WNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 17:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1WNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 17:13:38 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673A6D9B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 14:13:37 -0800 (PST)
Received: from letrec.thunk.org (capios.firout.com [104.224.87.177] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2BSMDDj7012798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 17:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1672265599; bh=ul/NZsCm1LN681rwuJVRjc6Rre5uxmh36nv6gaDD6Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bQ0sELAf0MkyDpX2YfhSPyZu7PNw0tyhKvYxrPslvfzsXpjtfbX+toZKJBF/k7E/Q
         0q+oMGtUtbvHyugU9FhY7p7SRFCf3Vy6HAn9MnSQFM/SHnMCIcTmm4h331Hb4ge+kq
         bT2B3J6rSoAt0+kyeXca4w/NmbDn3PkgsvtYApIJ0lFlw3seQNcY9Ho12tTRQS+pIt
         UaW9ITffzg3CAtRn1OKZhdWYtMB6+siNCskG9+wAiSTpUlW8yTumfYzNwxVs+BVqyG
         2KFH2FQ4XaDPM86p6mWMAR5qAFxiPUaBP6Im0tj+4hw8zB7v8Ki9kaI3j84eHTfiwp
         AWYK/fgfJL1Vg==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id 9EA5B8C08FD; Wed, 28 Dec 2022 17:14:42 -0500 (EST)
Date:   Wed, 28 Dec 2022 17:14:42 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     oss-security@lists.openwall.com,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: [oss-security] [patch] proc.5: tell how to parse /proc/*/stat
 correctly
Message-ID: <Y6y/0uzFlTpkw/VT@mit.edu>
References: <Y6SJDbKBk471KE4k@p183>
 <Y6TUJcr/IHrsTE0W@codewreck.org>
 <1a1963aa1036ba07@orthanc.ca>
 <20221228152458.6xyksrxunukjrtzx@mutt-hbsd>
 <Y6xzIR9P+a6uaaEx@itl-email>
 <20221228172517.l7h3m7wjfpxr3dzw@mutt-hbsd>
 <Y6yEv+6iYQQNaqi9@itl-email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6yEv+6iYQQNaqi9@itl-email>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,MAY_BE_FORGED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 01:02:35PM -0500, Demi Marie Obenour wrote:
> > I think the argument I'm trying to make is to be flexible in
> > implementation, allowing for future needs and wants--that is "future
> > proofing".
> 
> Linux should not have an XML, JSON, or YAML serializer.  Linux already
> does way too much; let’s not add one more thing to the list.

There's always Protobufs[1]!  :-)  And all of these are better than
ASN.1, for which Google already has a limited parser (for x.509
certificates).   :-)   :-)   :-)

						- Ted
