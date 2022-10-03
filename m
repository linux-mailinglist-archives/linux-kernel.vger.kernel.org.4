Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5B35F282D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiJCF31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 01:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJCF3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:29:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188C92E6BB;
        Sun,  2 Oct 2022 22:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B0493B80DC8;
        Mon,  3 Oct 2022 05:29:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2464C433D6;
        Mon,  3 Oct 2022 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664774960;
        bh=joD1y2rfEII9cd3jqH3Jj7paIkXHLkM1SQfNeRd7EVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OpgvaA6IsJgmIJU3f0HB/azNohN8L3Y/rJJk3QT0Loo7iC6cy3pdXuX9nZ9GMl1I3
         0WlmzUkCwNi1wNsMEGDq/HJlrxsLswQ7g9xMXLP8mU4vgpaIVmFSVvw8aiwNA8OmQV
         p2NnBCKF+m4jSruAsiP1042QnY0qk+j889FbBgrQ=
Date:   Mon, 3 Oct 2022 07:29:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Joe Perches <joe@perches.com>
Cc:     Elliot Berman <quic_eberman@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: new checkpatch flexible array test ?  (was Re: [PATCH v4 12/14]
 gunyah: rsc_mgr: Add RPC for console services)
Message-ID: <YzpzVfwA7NMCIyIp@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
 <20220928195633.2348848-13-quic_eberman@quicinc.com>
 <YzbfaCj9jvSUDfUg@kroah.com>
 <c7e45416cc911290efb5ad669f4a45bdc5678f69.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e45416cc911290efb5ad669f4a45bdc5678f69.camel@perches.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 06:46:30PM -0700, Joe Perches wrote:
> On Fri, 2022-09-30 at 14:22 +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 28, 2022 at 12:56:31PM -0700, Elliot Berman wrote:
> > > Gunyah resource manager defines a simple API for virtual machine log
> > > sharing with the console service.
> []
> > > diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> []
> > > +struct gh_rm_notif_vm_console_chars {
> > > +	u16 vmid;
> > > +	u16 num_bytes;
> > > +	u8 bytes[0];
> > 
> > Please do not use [0] for new structures, otherwise we will just have to
> > fix them up again as we are trying to get rid of all of these from the
> > kernel. Just use "bytes[];" instead.
> 
> Maybe a checkpatch addition like:
> ---
>  scripts/checkpatch.pl | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2737e4ced5745..187ed84c1f80a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3948,6 +3948,17 @@ sub process {
>  			}
>  		}
>  
> +# check for zero length array declarations in likely structs
> +		if ($line =~ /^\+\t($Declare\s*$Ident)\s*\[\s*0\s*\]\s*;\s*$/ &&
> +		    defined $lines[$linenr] &&
> +		    $lines[$linenr] =~ /^[\+ ]\}\s*(?:__\w+\s*(?:$balanced_parens)?)\s*;\s*$/) {
> +			if (WARN("FLEXIBLE_ARRAY_ZERO",
> +				 "Prefer flexible length array declarations with [] over [0]\n" . $herecurr) &&
> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/\[\s*0\s*\]/[]/;
> +			}
> +		}
> +
>  # check for multiple consecutive blank lines
>  		if ($prevline =~ /^[\+ ]\s*$/ &&
>  		    $line =~ /^\+\s*$/ &&

This is a question for Gustavo, who did all the work here.  Gustavo,
does the above checkpatch change look good to you?

thanks,

greg k-h
