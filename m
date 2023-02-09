Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0438168FE0A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbjBIDi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbjBIDit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:38:49 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7A0233D5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:38:42 -0800 (PST)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3191nKHF017135;
        Thu, 9 Feb 2023 03:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=8Vitq4pMctTb4jOhl4pCj/KuYr8g6FTn8c8hc59Rqeo=;
 b=gYhnmMMGgn56M8oN8k+fxHbgtZ7p4gEhJtgkWfQRaPdeYAE8azqhxC67XZ3vxVGZEQKW
 XKm5vYn5jzaMEXbrYkaGmNhD3xNdBvWqJ2hF00hr8kiN16nUO6JAmGWx7baxihxzA7y2
 ZlU1z7bo8cH+FG7P2M/vfctJ6Twc29b2jETILyutXqqB7YCY4Znsewv0Gcye2KBbZjWW
 y+bagxMG/oqrqMB9EvPrFbN+QxHKCGu22Z6/M2U1HRqOwdOViSlI6Zv6nVCRY/Xxpmdv
 icIcn4pNNdCKayqutngmzRE5fzdo2XeRc3EwkoymPx6uSp7V6XVsP4rKNyFs2ZOH3ER8 qA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nmqgjrmnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 03:38:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 4EC3613195;
        Thu,  9 Feb 2023 03:38:19 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 07992800220;
        Thu,  9 Feb 2023 03:38:14 +0000 (UTC)
Date:   Thu, 9 Feb 2023 11:38:12 +0800
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de,
        christophe.jaillet@wanadoo.fr, gustavoars@kernel.org,
        nishadkamdar@gmail.com, torvalds@linux-foundation.org,
        dhaval.experiance@gmail.com, viro@zeniv.linux.org.uk,
        arvind.yadav.cs@gmail.com, standby24x7@gmail.com,
        wfp5p@virginia.edu, jslaby@suse.cz, prarit@redhat.com,
        tj@kernel.org, adobriyan@gmail.com, aahit.gaba@hpe.com
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3TLSON/7XRG5BiN@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: mjnP0Y_qiBW1vl7cilGuwEZrNcoujISv
X-Proofpoint-ORIG-GUID: mjnP0Y_qiBW1vl7cilGuwEZrNcoujISv
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_11,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 mlxlogscore=737 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090030
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > From: Matt Hsiao <matt.hsiao@hpe.com>
> > 
> > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on HPE
> > servers with BMC (HPE iLO) functionality, a dual MIT/GPL license is needed
> > for porting the hpilo driver to OpenBSD.
> > 
> > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > ---
> > 
> > Hello contributors in the CC list,
> > 
> > Thanks for your contributions to the hpilo driver. Please kindly review
> > the license change and hopefully you would agree and approve it. Thanks!
> > 
> > Patch v2:
> > ---------
> > - Change MODULE_LICENSE to Dual MIT/GPL too
> 
> As I asked for on the v1 version (delayed email on my side), I need a
> lawyer from HPE to sign off on this change as well.
> 
> thanks,
> 
> greg k-h

Add HPE attorney Aahit Gaba to sign off.
