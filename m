Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D606E674747
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjASXhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 18:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjASXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 18:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B179373B;
        Thu, 19 Jan 2023 15:37:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C80A61DA8;
        Thu, 19 Jan 2023 23:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7FBC433EF;
        Thu, 19 Jan 2023 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674171452;
        bh=+gEU+eMFHL3lKHPOqi8dNs9YPbbilMd5M394ShMlU0s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tsVRjb5H2Y8GJdYdo7iWksxQ27oNtdSCdudLDnNMadigmH93vpYyU65+jDWIih9X6
         WLnx25JUtoTkL2Cq/vqDNGtqx6TArZ/G3l077U+qR7nlID5JOKgloEpSgpn8IUVXGS
         5KeN4aUynTwn+Vo/DiKGF6afuwdCzZGWKpXnvLCddiq7I2f/j7tp3vrkdwgy9NAbx+
         QXPtFtbT/v4fuuhs0V0PfNmbUvm0BFTkSFtrKux4eN8ANyStXRn8mNDlp4TD6bMzZM
         CqCo1mSBZ3iouzj50sO8Z/lPMny6ZGLjQiOr9f8IInOmFh6xPwWsGg6NzlntcHIBAb
         qibaj7C/5FGLA==
Date:   Fri, 20 Jan 2023 08:37:28 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Sai Prakash Ranjan" <quic_saipraka@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V0 1/1] bootconfig: Increase max size of bootconfig from
 32 KB to 256 KB for DCC support
Message-Id: <20230120083728.d685ee9140d71e7f245f4440@kernel.org>
In-Reply-To: <ea3e6838-a656-9a20-8240-b312dd54f285@quicinc.com>
References: <cover.1673261071.git.quic_schowdhu@quicinc.com>
        <654357bcbfd3974072a558c494a51edafaa73e1a.1673261071.git.quic_schowdhu@quicinc.com>
        <20230110001820.5ca81344286f614ed4ccec77@kernel.org>
        <e2ac0fa4-28f0-f4d8-e02a-b2a5d6131a48@quicinc.com>
        <20230110234643.7bbd340ece99c28f25fe7ad7@kernel.org>
        <9545ca51-ccda-64f0-bdd4-3b53e06785ad@quicinc.com>
        <20230112160128.600f9e7257d67aa63a5fbcb9@kernel.org>
        <ea3e6838-a656-9a20-8240-b312dd54f285@quicinc.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 22:21:27 +0530
Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:

> 
> 
> On 1/12/2023 12:31 PM, Masami Hiramatsu (Google) wrote:
> > On Tue, 10 Jan 2023 20:38:54 +0530
> > Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> > 
> >>
> >>
> >> On 1/10/2023 8:16 PM, Masami Hiramatsu (Google) wrote:
> >>> On Tue, 10 Jan 2023 17:26:07 +0530
> >>> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> >>>
> >>>>
> >>>>
> >>>> On 1/9/2023 8:48 PM, Masami Hiramatsu (Google) wrote:
> >>>>> On Mon, 9 Jan 2023 20:01:05 +0530
> >>>>> Souradeep Chowdhury <quic_schowdhu@quicinc.com> wrote:
> >>>>>
> >>>>>> Increasing the memory size of bootconfig to be able to handle a max number of
> >>>>>> 8192 nodes to be fitted in memory size of 256KB.
> >>>>>
> >>>>> Sorry, but you missed the 'xbc_node::data' stores the index of the data and
> >>>>> that is uint16_t. So the XBC_DATA_MAX is fixed limitation.
> >>>>>
> >>>>> The number of nodes (XBC_NODE_MAX) can be expanded because I just decided it
> >>>>> to keep the pre-compiled array size ~8KB. Maybe expanding it to 64KB just
> >>>>> increase the size of kernel on init memory (and freed after boot).
> >>>>>
> >>>>> Could you tell me why you need such a big data for your DCC?
> >>>>>
> >>>>> Thank you,
> >>>>
> >>>> DCC is a debugging tool used in qcom which is needed to debug crashes
> >>>> that can happen at boot-time. For debugging purposes a large number of
> >>>> registers need to be configured in DCC driver which is to be fed via the
> >>>> bootconfig file. For that we need to expand the nodes as well as memory
> >>>> for using bootconfig.
> >>>
> >>> Hmm, how many registers does DCC usually use? And how big the bootconfig
> >>> file is usually? I have no idea about that.
> >>
> >> So a typical bootconfig file for consumption of DCC looks like as follows
> >>
> >> dcc_config {
> >>           link_list_0 {
> >>                   qcom-curr-link-list = 6
> >>                   qcom-link-list = R_0x1781005c_1_apb,
> >>                                    R_0x1782005c_1_apb
> >>           }
> >>           link_list_1 {
> >>                   qcom-curr-link-list = 5
> >>                   qcom-link-list = R_0x1784005c_1_apb
> >>           }
> >> }
> >>
> >> The "qcom-link-list" field can have 1000s of register , based on that
> >> max nodes is increased to 8192.
> > 
> > OK, then the number of fields can be larger than 1000. I got it.
> > 
> >>
> >>>
> >>>> Can you let us know the changes that you suggest for doing the same? Is
> >>>> it fine to just increase the XBC_NODE_MAX, do we also need to
> >>>> change the uint16_t to u32 for proper storing of index values?
> >>>
> >>> Expanding the number of max nodes is easy, just increase the XBC_NODE_MAX
> >>> (must be less than 64k). That will also increase the memory consumption
> >>> during the boot time even if the bootconfig is small. Anyway, it will be
> >>> freed after boot, so it maybe OK.
> >>
> >> So since the limit is 64K, 8192 is a valid value for max nodes.
> > 
> > Yes. Expanding the number of node is OK to me.
> > 
> >>
> >>>
> >>> But expanding the size of max bootconfig needs to change the type of
> >>> the 'data' field to uint32_t (since that will be used for building
> >>> bootconfig tool) and you also must confirm that `tools/bootconfig/bootconfig`
> >>> can be built and pass the test-bootconfig.sh.
> >>> Hmm, comparing with expanding the max number of XBC node, changing the
> >>> 'data' type to uint32_t may not have much impact on memory consumption point
> >>> of view, because it may increase only 20% of memory, but expanding the
> >>> MAX_XBC_NODE always increases more than double.
> >>>
> >>> Thus, if we can accept increasing the number of node, it should be OK to
> >>> change the 'data' type.
> >>
> >> That means from DCC point of view only increasing the max nodes is
> >> enough as increasing the data size is unrelated to increasing the max nodes?
> > 
> > Yes, if it is less than 32KB, you just need to increase the XBC_NODE_MAX.
> > But if you think the size of bootconfig, we have to change the type of
> > xbc_node::data field.
> > 
> > Can you check the DCC also need to expand the size of bootconfig limitation?
> > 
> > Thank you!
> 
> Yes, I don't think the index needs to be increased from u16 to u32 for 
> dcc. Will be sending out the next version accordingly.

OK, thanks for the confirmation!



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
