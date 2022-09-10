Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0935B43C9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 04:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiIJCwt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 22:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIJCwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 22:52:42 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28BE622B;
        Fri,  9 Sep 2022 19:52:37 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id E84DA1C6737;
        Sat, 10 Sep 2022 02:52:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 903D120027;
        Sat, 10 Sep 2022 02:52:33 +0000 (UTC)
Message-ID: <f1d9e2953551455bdee615dbe84ce55efead1c39.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: warn for non-standard fixes tag style
From:   Joe Perches <joe@perches.com>
To:     Niklas =?ISO-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@corigine.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     oss-drivers@corigine.com, Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Date:   Fri, 09 Sep 2022 19:52:31 -0700
In-Reply-To: <20220909202534.1857709-1-niklas.soderlund@corigine.com>
References: <20220909202534.1857709-1-niklas.soderlund@corigine.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 903D120027
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Stat-Signature: qwc566poa58ycpu4gq5ugbhxeycc3hto
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19n2zYvW1uGKh4qzeWX0sVWcp+JwB/gzjM=
X-HE-Tag: 1662778353-845646
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-09-09 at 22:25 +0200, Niklas Söderlund wrote:
> Add a warning for fixes tags that does not fall in line with the
> standards specified by the community.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3140,6 +3140,47 @@ sub process {
[]
> +			if ($ctitle ne $title || $tag_case || $tag_space ||
> +			    $id_length || $id_case || !$title_has_quotes) {
> +				WARN("BAD_FIXES_TAG",
> +				     "Please use correct Fixes: style 'Fixes: <12 chars of sha1> (\"<title line>\")' - ie: 'Fixes: $cid (\"$ctitle\")'\n" . $herecurr);

BTW: Might as well add a --fix for Fixes:

				if (WARN("...") &&
				    $fix) {
					$fixed[$fixlinenr] = "Fixes: $cid (\"$ctitle\")";
				}
