Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94285EA974
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiIZPDG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbiIZPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:02:20 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51995637A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:34:36 -0700 (PDT)
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay03.hostedemail.com (Postfix) with ESMTP id 750B5A0C21;
        Mon, 26 Sep 2022 13:34:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf15.hostedemail.com (Postfix) with ESMTPA id 68F851B;
        Mon, 26 Sep 2022 13:34:28 +0000 (UTC)
Message-ID: <8cdad668f987bfc20d06628bd897accc6c7d3abb.camel@perches.com>
Subject: Re: checkpatch stops processing at an empty commit
From:   Joe Perches <joe@perches.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andy Whitcroft <apw@canonical.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 26 Sep 2022 06:34:32 -0700
In-Reply-To: <ff96be1b-b1d6-f170-d8f3-6199945500ef@ideasonboard.com>
References: <ff96be1b-b1d6-f170-d8f3-6199945500ef@ideasonboard.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 68F851B
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: irhghqc11ryknrj8r6ibwzuqnp8ukbuc
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19kVxaYY/9IGxmVYVrZOuQuhOQ7eDSEGqs=
X-HE-Tag: 1664199268-283903
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 13:41 +0300, Tomi Valkeinen wrote:
> Hi,

Hi back.

> I use empty commits as "banner" commits, and it seems that checkpatch stops
> processing commits when it encounters such an empty commit.

Well, honestly I don't much care.
This is not a use of checkpatch nor git in typical development.

If it bothers you, you could fix it.
Or perhaps pay someone to fix it for you.

cheers, Joe

