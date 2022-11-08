Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667F362117D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234260AbiKHMxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233807AbiKHMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:53:53 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E938A8;
        Tue,  8 Nov 2022 04:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1667912024;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=mwuCtf46ub32CEXDD98AZtFTBfsD2naQfEfKZCzYN/8=;
    b=c4G/PekBC2yWjnDUfLCyxfaaDr+/OgrVZGYYbzSMOhHxDJ8T/Bnvw/WDkRp1ytIQVV
    rsdvHD/wX+iOQtiDokSHNCQYTo+ODq1XH6Q9PHzp8bkcNmitZizetBrDcYE39SPxeL49
    bJ8kH5AEm7Rv0Rt1XyLwU4Ywk9kF2tpE+u9Zeeug+YBgt92O9rUygkd6V+PH1l6qxjuX
    87R2sJz7CdIdjI9KpqSca0e0fxtitkSVnkNietcsyxnh95Asn4CsqaYLjm0bavWcwGS+
    8svL2HSD9/xY7N+ZN1HRiQwfgeRNimi1RY4fPyLTaGG99w0x5+bACv5pfRLDGB7Z2GTJ
    93lw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
X-RZG-CLASS-ID: mo00
Received: from blinux
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyA8Crgnvn
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Nov 2022 13:53:42 +0100 (CET)
Message-ID: <3ac98bc73cc953f6d1b989eb58bb03257bb5399c.camel@iokpp.de>
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
Date:   Tue, 08 Nov 2022 13:53:41 +0100
In-Reply-To: <DM6PR04MB6575D9DA640DE6BD0313758DFC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20221107131038.201724-1-beanhuo@iokpp.de>
         <DM6PR04MB6575D9DA640DE6BD0313758DFC3F9@DM6PR04MB6575.namprd04.prod.outlook.com>
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

On Tue, 2022-11-08 at 12:37 +0000, Avri Altman wrote:
> Hi,
> 
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
> > the BSG V4 structure and BSG core.
> 
> Can you share the reference to this mail thread, or was it a privet
> discussion?
> 
> 
> 
> Thanks,
> 
> Avri

Avri,

Yes, this is a private discussion during this year's Storage Summit wit
h Hannes Reinecke on the first two proposals below, and a private
discussion with Bart on the following three proposals 


1. Use current BSG v4, and transmit EHS in sense_buffer, which is rejected.

2. The optional suggestion is to use ufs_bsg, which is the patch.

3. New RPMB framework, but we should enable UFS/eMMC RPMB driver as
well in ufs/emmc core, also, the command will be passed to kernel over
ioctl(). interested in this one, But Bart suggested using io_uing
framework. Since RPMB operation is atomic required, we found it is not
safe to use io_uring now, this need passthorugh support SCSI layer as
well.


Kind regards,
Bean



