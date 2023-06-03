Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBF972111E
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjFCQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:07:34 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8202DBD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 09:07:30 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 353G6xE1005188;
        Sat, 3 Jun 2023 18:06:59 +0200
Date:   Sat, 3 Jun 2023 18:06:59 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>,
        Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
Message-ID: <20230603160659.GA5182@1wt.eu>
References: <20230603151447.29288-1-james@equiv.tech>
 <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Sat, Jun 03, 2023 at 08:55:39AM -0700, Randy Dunlap wrote:
> It sounds to me like we should just prohibit (not allow) emails that
> don't have a To: recipient in them.

Also those without subjects, which seem to become increasingly frequent
and which used to exclusively be used by spam years ago.

> > To reduce ambiguity and eliminate this class of potential (albeit
> > tangential) issues, prescribe sending patches 'To' maintainers and
> > 'Cc' lists. While we're at it, strengthen the recommendation to use
> > scripts/get_maintainer.pl to find patch recipients, and move Andrew
> > Morton's callout as the maintainer of last resort to the next
> > paragraph for better flow.
> > 
> 
> I think that is going overboard (too far). As long as a maintainer
> is a direct recipient of the email (patch), that should be sufficient.

Or it could be simplified, saying that all those who are expected to
play a role on the patchset (review, test, merge etc) should be in the
'To' field while those who might possibly be interested in having a
look are in 'Cc' (lists, other people having expressed interest in the
patchset, single-time contributors to the file being changed etc). It
could be hinted that usually people read mails sent to them faster than
those they're CCed. This implies that maintainers have to be in To and
lists in Cc.

regards,
Willy
