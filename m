Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B3771858F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjEaPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbjEaPEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:04:25 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31B513D;
        Wed, 31 May 2023 08:04:14 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34V7r8na020051;
        Wed, 31 May 2023 08:03:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=bSDcykJRkrXkmn/QYqWDJXxxnH+v2s6cN4XdNOmXSjQ=;
 b=Ki0pkaHXZDahOCs1OGU6RIl8cOn41eQ/dwx/AI/Ah4hs42gI8wEk7+LwjvecnTor71GZ
 fyTHZBbDuS8jR7eabwkHQNRpI59eYJSBLlqGwfU/sr2fO9AkLH7nj5WI4zo1YFRsA9bV
 WNynDIMuCfeezQkj/ZHrrb4AIt7r5Dq97sWSj8NZlpjJya7LTUPTVpAdnApL5mgtHs4N
 ZUOS5Q5YfXb/sbo7I5ZNc0EDeyk5S0Zwu+npdDbXZ/SM6nP1ByiJd4EGCgh8x8dVDqZ0
 MCkEjERTDGGbvg98g2aaqgZyskn6sz6hjPiY6fVSWCB69UTGX0DxY3ER4h0hQCCVfQJK PA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3qwsb8upfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 08:03:44 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 31 May
 2023 08:03:42 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 31 May 2023 08:03:42 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 691DF3F7052;
        Wed, 31 May 2023 08:03:42 -0700 (PDT)
Date:   Wed, 31 May 2023 08:03:42 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Message-ID: <20230531150342.GA13601@Dell2s-9>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230509143721.GA10616@Dell2s-9>
 <SJ1PR11MB60831FCB30F2A642B95C9D9FFC769@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <4376a7ba-2f85-6160-b7d4-d5c08b5b3429@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4376a7ba-2f85-6160-b7d4-d5c08b5b3429@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: OWjFgdkdcHRHkbmVCwoOpbS5GVFJDTRL
X-Proofpoint-GUID: OWjFgdkdcHRHkbmVCwoOpbS5GVFJDTRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_10,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 06:05:48PM +0200, Wilczynski, Michal wrote:
> 
> 
> On 5/9/2023 8:35 PM, Luck, Tony wrote:
> >> If a platform supports einj v2, then the einj directory wont be needed, as per spec,
> >> if a non-zero Error Type value is set by EINJV2_SET_ERROR_TYPE, then any Error Type
> >> value set by (einj case) SET_ERROR_TYPE_WITH_ADDRESS and/or SET_ERROR_TYPE will be
> >> ignored. So based on einjv2 is supported or not, we can have either einjv2 or einj 
> >> directory with the related params files in it respectively. 
> >> Kindly let us know your thoughts.
> > Piyush,
> >
> > There are a lot of validation tests built on top of the EINJ v1 Linux interface and interest
> > in keeping them working rather than forcing a giant "change everything" when the first
> > EINJ V2 system arrives.
> >
> > BIOS team here thinks that the EINJ V2 spec change is (or can be) incremental.
> > Platform firmware can choose to continue supporting EINJ V1 while also providing
> > EINJ V2 actions.
> >
> > So Linux should be prepared to handle:
> >
> > 1) Legacy systems with just the V1 interface.
> >
> > 2) Incremental systems that have both V1 and V2 interfaces.
> >
> > 3) Future looking systems that only have the V2 interface.
> >
> > -Tony
> 
> Hi all,
> 
> It seems to me like backwards compatibility has been a big priority historically for Linux.
> I guess with debugfs we get more leeway to change things, however this interface seems
> to be present for a very long time and seems to be entrenched enough to keep backwards
> compatibility.
> 
> 
> Piyush,
> Did you make any progress on the solution ? I can offer some help if you don't have BW to work
> on this.
> 
> 
> Good video on the topic :)
> Link: https://www.youtube.com/watch?v=Nn-SGblUhi4&ab_channel=FelipeContreras
> 
> >
> >
>

Hi Michal, Tony,

Thanks for your reply.

I get that we have to support v1 and v2 for backward compatibility, but for the point no.2
made by Tony - 
"2) Incremental systems that have both V1 and V2 interfaces.",
just wanted to understand if we expect any use case where if EINJ V2 is supported, both v1
and v2 interfaces shall be required at the same time for error injection, as from the spec,
if V2 is supported, EINJV2_SET_ERROR_TYPE takes precedence.

This seems to be similar with V1 action types - whether to go with SET_ERROR_TYPE_WITH_ADDRESS or
SET_ERROR_TYPE, is based on the action entry in the EINJ table where "SET_ERROR_TYPE_WITH_ADDRESS"
gets precedence.

Please share your inputs.

Thanks,
Piyush
