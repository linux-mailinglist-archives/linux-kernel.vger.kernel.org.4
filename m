Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D38270E041
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237344AbjEWPTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbjEWPTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:19:38 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897CC11A;
        Tue, 23 May 2023 08:19:36 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NCCZ6Q006179;
        Tue, 23 May 2023 15:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pps0720;
 bh=QbeCPkHPBUmVNkZKFmZrNQRg+5xggdUJo/uJga/GnxU=;
 b=pgwvsakbaoK0P7gjJt762OVYB3mLeBZZ5lVsrKn4Nmuq8FL7G6t9rhtxbsIEqCMz3osr
 JjTvnXrCbG9KoG/wrxqog8m4TfSoNh5Cr6XSixZbTTutiUVOm70dFkUlTkgbBMAD+yez
 kDVMqhM9ILcPVb/yGRSnmmRmMTdUpXzCrDm+KZC2h+tTgvRbc9c5mL9BAu75uIgxAMDU
 vWj38yE97zbjIfpSUH688jQHhqcX0g505iBF+qfm0FsLWmhKH9cQv7tp5gSHjvNaYwfn
 eYT/6i3dmW40uVsNULai5bgjlITQzEYuXN9j+3AFDYOGw9y+/ZKjdI8Vzv6LnfmWsxh5 SQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qrw9tsksf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 15:19:20 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 483DA80021E;
        Tue, 23 May 2023 15:19:20 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 7E87C8155A1;
        Tue, 23 May 2023 15:19:19 +0000 (UTC)
Date:   Tue, 23 May 2023 10:19:17 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: ISST: Remove 8 socket limit
Message-ID: <ZGzZddmPO2T24TjF@swahl-home.5wahls.com>
References: <20230519160420.2588475-1-steve.wahl@hpe.com>
 <bf9a2943-f4eb-eb24-e18b-1b1c1959fe31@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf9a2943-f4eb-eb24-e18b-1b1c1959fe31@linux.intel.com>
X-Proofpoint-GUID: AFldbljK1YISAcP3cZ_-xiDDduhwppvf
X-Proofpoint-ORIG-GUID: AFldbljK1YISAcP3cZ_-xiDDduhwppvf
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_10,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230119
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:27:08PM +0300, Ilpo Järvinen wrote:
> On Fri, 19 May 2023, Steve Wahl wrote:
> 
> > Stop restricting the PCI search to a range of PCI domains fed to
> > pci_get_domain_bus_and_slot().  Instead, use for_each_pci_dev() and
> > look at all PCI domains in one pass.
> > 
> > On systems with more than 8 sockets, this avoids error messages like
> > "Information: Invalid level, Can't get TDP control information at
> > specified levels on cpu 480" from the intel speed select utility.
> > 
> > Fixes: aa2ddd242572 ("platform/x86: ISST: Use numa node id for cpu pci dev mapping")
> > Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
> > ---
> >  .../x86/intel/speed_select_if/isst_if_common.c       | 12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > index e0572a29212e..02fe360a59c7 100644
> > --- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > +++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
> > @@ -304,14 +304,13 @@ struct isst_if_pkg_info {
> >  static struct isst_if_cpu_info *isst_cpu_info;
> >  static struct isst_if_pkg_info *isst_pkg_info;
> >  
> > -#define ISST_MAX_PCI_DOMAINS	8
> > -
> >  static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn)
> >  {
> >  	struct pci_dev *matched_pci_dev = NULL;
> >  	struct pci_dev *pci_dev = NULL;
> > +	struct pci_dev *_pci_dev = NULL;
> >  	int no_matches = 0, pkg_id;
> > -	int i, bus_number;
> > +	int bus_number;
> >  
> >  	if (bus_no < 0 || bus_no >= ISST_MAX_BUS_NUMBER || cpu < 0 ||
> >  	    cpu >= nr_cpu_ids || cpu >= num_possible_cpus())
> > @@ -323,12 +322,11 @@ static struct pci_dev *_isst_if_get_pci_dev(int cpu, int bus_no, int dev, int fn
> >  	if (bus_number < 0)
> >  		return NULL;
> >  
> > -	for (i = 0; i < ISST_MAX_PCI_DOMAINS; ++i) {
> > -		struct pci_dev *_pci_dev;
> > +	for_each_pci_dev(_pci_dev) {
> >  		int node;
> >  
> > -		_pci_dev = pci_get_domain_bus_and_slot(i, bus_number, PCI_DEVFN(dev, fn));
> > -		if (!_pci_dev)
> > +		if (_pci_dev->bus->number != bus_number ||
> > +		    _pci_dev->devfn != PCI_DEVFN(dev, fn))
> >  			continue;
> >  
> >  		++no_matches;
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> 
> With the note that _pci_dev is not a good variable name (but the rename 
> would make this fix larger than it needs to be).

I did look askance at that name for the briefest moment, but came to
the same conclusion.

Thank you for your time reviewing!

--> Steve

-- 
Steve Wahl, Hewlett Packard Enterprise
