Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3206051CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiJSVMv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Oct 2022 17:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiJSVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:12:48 -0400
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332F0183DA7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:12:47 -0700 (PDT)
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id A18DD1C5FA0;
        Wed, 19 Oct 2022 21:12:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf04.hostedemail.com (Postfix) with ESMTPA id 762A520030;
        Wed, 19 Oct 2022 21:12:05 +0000 (UTC)
Message-ID: <babe69207a0a301b270726cbead912345d9f015f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for non-lore mailing list URLs
From:   Joe Perches <joe@perches.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Date:   Wed, 19 Oct 2022 14:12:40 -0700
In-Reply-To: <20221019202843.40810-1-helgaas@kernel.org>
References: <20221019202843.40810-1-helgaas@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: 3mz9dr7rom18nz8cn576y5iyo87cor6k
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 762A520030
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Ay7ZXh7o5wGeykZBcEZdmcVy0QRsnMRo=
X-HE-Tag: 1666213925-546317
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-19 at 15:28 -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> The lkml.org, marc.info, spinics.net, etc archives are not quite as useful
> as lore.kernel.org because they use different styles, add advertising, and
> may disappear in the future.  The lore archives are more consistent and
> more likely to stick around, so prefer https://lore.kernel.org URLs when
> they exist.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Seems sensible, thanks.

> ---
> 
> Sample commits for testing with "checkpatch -g":
> 
>   bd82d4bd2188 www.spinics.net/lists/arm-kernel/msg716956.html
>   fdec2a9ef853 www.spinics.net/lists/kvm-arm
>   1cdca16c043a www.spinics.net/lists/linux-mmc
>   48ea02184a9d www.spinics.net/lists/linux-pci
>   f32ae8a5f131 www.spinics.net/lists/netdev
>   b7dca6dd1e59 lkml.org
>   265df32eae58 lkml.org/lkml/
>   4a9ceb7dbadf marc.info/?l=linux-kernel&m=155656897409107&w=2.
>   c03914b7aa31 marc.info/?l=linux-mm
>   f108c887d089 marc.info/?l=linux-netdev
>   7424edbb5590 marc.info/?t=156200975600004&r=1&w=2
>   dabac6e460ce https://marc.info/?l=linux-rdma&m=152296522708522&w=2
>   b02f6a2ef0a1 www.mail-archive.com/linux-kernel@vger.kernel.org
>   5e91bf5ce9b8 lists.infradead.org/pipermail/linux-snps-arc/2019-May
>   3cde818cd02b mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144761.html
>   a5448fdc469d http://lists.infradead.org/pipermail/linux-nvme/2019-June/024721.html
> 
> Previously posted:
>   https://lore.kernel.org/all/20201217235615.43328-1-helgaas@kernel.org/
>   https://lore.kernel.org/all/20220401201417.126664-1-helgaas@kernel.org/
> ---
>  scripts/checkpatch.pl | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1e5e66ae5a52..4e187202e77a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -702,6 +702,17 @@ sub find_standard_signature {
>  	return "";
>  }
>  
> +our $obsolete_archives = qr{(?xi:
> +	\Qfreedesktop.org/archives/dri-devel\E |
> +	\Qlists.infradead.org\E |
> +	\Qlkml.org\E |
> +	\Qmail-archive.com\E |
> +	\Qmailman.alsa-project.org/pipermail\E |
> +	\Qmarc.info\E |
> +	\Qozlabs.org/pipermail\E |
> +	\Qspinics.net\E
> +)};
> +
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
>  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -3324,6 +3335,12 @@ sub process {
>  			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
>  		}
>  
> +# Check for mailing list archives other than lore.kernel.org
> +		if ($rawline =~ m{\b$obsolete_archives}) {
> +			WARN("PREFER_LORE_ARCHIVE",
> +			     "Use lore.kernel.org archive links when possible - see https://lore.kernel.org/lists.html\n" . $herecurr);
> +		}
> +
>  # Check for added, moved or deleted files
>  		if (!$reported_maintainer_file && !$in_commit_log &&
>  		    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||

