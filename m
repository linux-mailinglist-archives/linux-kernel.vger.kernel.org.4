Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEF55F2836
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 07:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJCFjH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Oct 2022 01:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiJCFjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 01:39:04 -0400
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36CE326FF;
        Sun,  2 Oct 2022 22:39:03 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay05.hostedemail.com (Postfix) with ESMTP id DCB1E409F8;
        Mon,  3 Oct 2022 05:39:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id A95C060009;
        Mon,  3 Oct 2022 05:38:52 +0000 (UTC)
Message-ID: <04ade5f54bd3dc658cb8606c98b0b1fe34a97383.camel@perches.com>
Subject: Re: new checkpatch flexible array test ?  (was Re: [PATCH v4 12/14]
 gunyah: rsc_mgr: Add RPC for console services)
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
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
Date:   Sun, 02 Oct 2022 22:38:51 -0700
In-Reply-To: <YzpzVfwA7NMCIyIp@kroah.com>
References: <20220928195633.2348848-1-quic_eberman@quicinc.com>
         <20220928195633.2348848-13-quic_eberman@quicinc.com>
         <YzbfaCj9jvSUDfUg@kroah.com>
         <c7e45416cc911290efb5ad669f4a45bdc5678f69.camel@perches.com>
         <YzpzVfwA7NMCIyIp@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Stat-Signature: any5n6dxybnur6i78t7xb6k1yayxcqqa
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A95C060009
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/g7GhkL1qx20CJKVVk/r/b4D3cncpPwyQ=
X-HE-Tag: 1664775532-285486
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-03 at 07:29 +0200, Greg Kroah-Hartman wrote:
> On Sun, Oct 02, 2022 at 06:46:30PM -0700, Joe Perches wrote:
> > On Fri, 2022-09-30 at 14:22 +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 28, 2022 at 12:56:31PM -0700, Elliot Berman wrote:
> > > > Gunyah resource manager defines a simple API for virtual machine log
> > > > sharing with the console service.
> > []
> > > > diff --git a/include/linux/gunyah_rsc_mgr.h b/include/linux/gunyah_rsc_mgr.h
> > []
> > > > +struct gh_rm_notif_vm_console_chars {
> > > > +	u16 vmid;
> > > > +	u16 num_bytes;
> > > > +	u8 bytes[0];
> > > 
> > > Please do not use [0] for new structures, otherwise we will just have to
> > > fix them up again as we are trying to get rid of all of these from the
> > > kernel. Just use "bytes[];" instead.
> > 
> > Maybe a checkpatch addition like:
> > ---
[]
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3948,6 +3948,17 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for zero length array declarations in likely structs
> > +		if ($line =~ /^\+\t($Declare\s*$Ident)\s*\[\s*0\s*\]\s*;\s*$/ &&
> > +		    defined $lines[$linenr] &&
> > +		    $lines[$linenr] =~ /^[\+ ]\}\s*(?:__\w+\s*(?:$balanced_parens)?)\s*;\s*$/) {

This should actually be:

		    $lines[$linenr] =~ /^[\+ ]\}(?:\s*__\w+\s*(?:$balanced_parens)?)*\s*;\s*$/) {

as it was missing a * for uses like

	int foo[0];
} __packed __aligned(4);

and uses without any attribute at all

> > +			if (WARN("FLEXIBLE_ARRAY_ZERO",
> > +				 "Prefer flexible length array declarations with [] over [0]\n" . $herecurr) &&
> > +			    $fix) {
> > +				$fixed[$fixlinenr] =~ s/\[\s*0\s*\]/[]/;
> > +			}
> > +		}
> > +
> >  # check for multiple consecutive blank lines
> >  		if ($prevline =~ /^[\+ ]\s*$/ &&
> >  		    $line =~ /^\+\s*$/ &&
> 
> This is a question for Gustavo, who did all the work here.  Gustavo,
> does the above checkpatch change look good to you?


