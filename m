Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02C56FC92B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235918AbjEIOhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbjEIOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:37:49 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93808109;
        Tue,  9 May 2023 07:37:45 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349Dx17f018202;
        Tue, 9 May 2023 07:37:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pfpt0220; bh=+mfLhJmVBJOGTMDQi+ADShaWubb8Mn6G8qmNPyPioBc=;
 b=BZP5xQ6BhDY/X02Sr1zT9v4YP7vRgChmsdPGbdJxgCKh2HqVbywmbxRkUtQwo81UWswm
 /G/Y2AyZQHUE3XxGS7/thOtMTdvyXf8NpGJ7ZaSGjh4pwLybXNZqDx1IT85RdGycOFTb
 LOSzyVCK6zGEYrnZ7jQFx/to27LbewnP+qVKoJaWMGmH6QiatUexTTWoaHtnulc7HKCa
 pVlTqndt30zZODp6V5Pk2ajXh+aaY8nxmiSaN296hCkMFrbAoxdLj76H6RDfwb2LcmWz
 cKdvTNcbs2LUfcqWGT/B/K6ZzvsL5+LjuqGWvel4Ml7dlHK/+z0VsD0MsC4XvvIjPYpW /Q== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3qf77s2tu5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 07:37:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 9 May
 2023 07:37:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 9 May 2023 07:37:21 -0700
Received: from Dell2s-9 (unknown [10.110.150.250])
        by maili.marvell.com (Postfix) with ESMTP id 822C63F7087;
        Tue,  9 May 2023 07:37:21 -0700 (PDT)
Date:   Tue, 9 May 2023 07:37:21 -0700
From:   Piyush Malgujar <pmalgujar@marvell.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Message-ID: <20230509143721.GA10616@Dell2s-9>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: qFnYkAutu_djET8H85p-1jwg8Z89UJjp
X-Proofpoint-GUID: qFnYkAutu_djET8H85p-1jwg8Z89UJjp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Thanks for the review comments.

On Thu, May 04, 2023 at 09:00:51PM +0000, Luck, Tony wrote:
> > +An error injection example::
> > +
> > +  # cd /sys/kernel/debug/apei/einj
> > +  # cat available_error_type         # See which errors can be injected
> > +  0x00000001 EINJV2 Processor Error
> > +  0x00000002 EINJV2 Memory Error
> > +  0x00000004 EINJV2 PCI Express Error
> > +  # echo 0x2 > error_type
> > +  # echo 0x5 > flags
> > +  # echo 0x12345000 > param1
> > +  # echo 0x2 > param5
> > +  # echo 1 > error_inject
> >
> > Is the expectation that platforms that implement EINJV2 will not include legacy
> > EINJ support?
> 
> I spoke to some BIOS folks here. They said that the ACPI 6.5 change is an
> extension to the action table with new opcodes for GET/SET when EINJV2
> is supported. The legacy actions are not deprecated. So platform firmware could
> support both old and new injection formats.
> 
> So I'm going to double down on this:
> 
> > Maybe it would be better to change the top-level directory to:
> >
> >	/sys/kernel/debug/apei/einjv2
> 
> and say this isn't a "maybe". The EINJV2 interface files should go
> in a new directory. The old files should continue to work (assuming
> firmware still enumerates the old available types).
> 
> Simplifying the interface for EINJV2 in the new directory is an option.
> I think we should take it ... the "paramN" files that mean different
> things for different injection types were an evolution rather than a design.
> 
> -Tony
> 
> 
> 
> 
If a platform supports einj v2, then the einj directory wont be needed, as per spec,
if a non-zero Error Type value is set by EINJV2_SET_ERROR_TYPE, then any Error Type
value set by (einj case) SET_ERROR_TYPE_WITH_ADDRESS and/or SET_ERROR_TYPE will be
ignored. So based on einjv2 is supported or not, we can have either einjv2 or einj 
directory with the related params files in it respectively. 
Kindly let us know your thoughts.

Thanks,
Piyush 
