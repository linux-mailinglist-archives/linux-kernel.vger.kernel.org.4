Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A196428A0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbiLEMjh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Dec 2022 07:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiLEMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:39:30 -0500
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0F91B9C6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:39:22 -0800 (PST)
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id 8E91C407AE;
        Mon,  5 Dec 2022 12:39:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id 3FCF32000E;
        Mon,  5 Dec 2022 12:39:19 +0000 (UTC)
Message-ID: <b0194f880b217e905a9ce571e5b86b974beaef0b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Add the backport commit format check
From:   Joe Perches <joe@perches.com>
To:     korantwork@gmail.com, apw@canonical.com, dwaipayanray1@gmail.com,
        lukas.bulwahn@gmail.com
Cc:     alexs@kernel.org, linux-kernel@vger.kernel.org,
        Xinghui Li <korantli@tencent.com>
Date:   Mon, 05 Dec 2022 04:39:18 -0800
In-Reply-To: <20221205094826.44844-1-korantwork@gmail.com>
References: <20221205094826.44844-1-korantwork@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3FCF32000E
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Rspamd-Server: rspamout07
X-Stat-Signature: zbkwwnnyjwb3oukthes7wu98i51kqhph
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/M7+oG2JkfReSLyAmweKq7tz3+LP5Aykg=
X-HE-Tag: 1670243959-42702
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-12-05 at 17:48 +0800, korantwork@gmail.com wrote:
> From: Xinghui Li <korantli@tencent.com>
> 
> The backport commit has been  used to be misreported as Error
> by checkpatch.pl like this:
> 
> 'ERROR: Please use git commit description style
> 'commit <12+ chars of sha1> ("<title line>")' - ie:......
> commit <sha1> upstream.
> 
> total: 1 errors, 0 warnings, 8 lines checked
> '
> So, add the backport commit format check to avoid the above mistake.

nak.

I don't believe this should be an accepted style.

and

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
>  				ERROR("GIT_COMMIT_ID",
> -				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
> +				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\nor check the backport commit description format\n" . $herectx);

Output messages are only single line not multiple lines.

