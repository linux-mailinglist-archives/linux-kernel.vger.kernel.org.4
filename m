Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A3E62439E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKJNvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiKJNvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:51:01 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41815CE0;
        Thu, 10 Nov 2022 05:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668088250;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L6wvDDhXKUzII32ywi5QeK1Fitev1Yi4DtJi2jmWynw=;
    b=hDDgMl/9pDYuVxCZO9yeomuGvAHvl3zMfAYDx5fB+1GHAQdkO0LiQEq76OqnTIjEmP
    Rejwuap91u2H1z9n4QQ+QGf9FurC8QJYtRbqzQSxkDVLyWK3n13aJiDDpcNVdY+lplnJ
    QkJw80tZO7IAXLhKXhB/JaIoaISQ7oFmtYKpSSID21kjgrA47vRnnD9tNbjvUaT08hoj
    5f+bRRvlnNsIH5cf7/sP8SlflhXw0pMJqbm+2QAOVgZoprqm9Ff3oDdcmsPWX68NSXe6
    KpMZMgEEEidPeOCg9y0ZGI4RmQr1kGnmYMyk2SJcEOHRt7Swd4EozU2Y1Wp4FfweqLYO
    xVfQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAADolxCp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Nov 2022 14:50:47 +0100 (CET)
Message-ID: <95651ffcf1d00f54b72eca006355cc6591787068.camel@iokpp.de>
Subject: Re: [RFC PATCH v1 0/2] UFS Advanced RPMB
From:   Bean Huo <beanhuo@iokpp.de>
To:     Avri Altman <Avri.Altman@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "quic_richardp@quicinc.com" <quic_richardp@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "hare@suse.de" <hare@suse.de>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 10 Nov 2022 14:50:47 +0100
In-Reply-To: <DM6PR04MB6575F12BAAB0883DA91EFC5DFC3E9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <DM6PR04MB6575F12BAAB0883DA91EFC5DFC3E9@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Avri, 

Thanks for your suggetions and review

On Wed, 2022-11-09 at 08:18 +0000, Avri Altman wrote:
> > In UFS 4.0, it introduced advanced RPMB, which can significantly
> > improve
> > RPMB's command performance, enhancing its atomic operation. We
> > don't
> > know which implementation will please everyone, mark this advanced
> > RPMB
> > patch as RFC. Any suggestions to make the patch a master patch are
> > welcome.
> > Based on suggestions and feedback from Hannes Reinecke and Bart, we
> > can
> > use job_bsg->request and job_bsg->reply to pass EHS packets without
> > changing
> > the BSG V4 structure and BSG core. So we push RFC patch just to
> > start
> > Advanced RPMB mainlining
> 
> I concur with this approach.
> 
> The current limitations that the new spec imposes,
> 
> e.g. putting confidential data in a construct that lives in the ufs-
> driver,
> 
> practically gives no other alternative but ufs-bsg.
> 
> 
> 
> If no one else object, maybe you can leave out the rfc from the next
> version.
> 
> 

I will prepare next version, and address your all questions in the next
version. thanks.

Kind regards,
Bean 


