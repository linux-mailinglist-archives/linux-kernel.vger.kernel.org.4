Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03E75FC8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 17:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJLPzz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Oct 2022 11:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiJLPzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 11:55:53 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BCA13E81
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 08:55:51 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay08.hostedemail.com (Postfix) with ESMTP id BA264141358;
        Wed, 12 Oct 2022 15:55:50 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 94DE980013;
        Wed, 12 Oct 2022 15:55:48 +0000 (UTC)
Message-ID: <f7a89e4de994c351d3cb6f2e080d71d207c95f36.camel@perches.com>
Subject: Re: [PATCH] mailmap: update Dan Carpenter's email address
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 12 Oct 2022 08:55:47 -0700
In-Reply-To: <Y0a+6+5SHMdvUnpg@kili>
References: <Y0a+6+5SHMdvUnpg@kili>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: xyncceck48g5z9yz1xw6u3qtd671g5if
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 94DE980013
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19nsQFeGkp8mmjOTIafQftOK4vMoAT3Dcw=
X-HE-Tag: 1665590148-386166
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-12 at 16:19 +0300, Dan Carpenter wrote:
> My time at Oracle is ending at the end of the month.  Update my email
> address accordingly.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> It's sort of unfortunate that this changes the output of git log.  I
> wish there were a way to update get_maintainer.pl output without
> affecting the log.

There is a --no-mailmap command line option switch both for
git log and get_maintainer

