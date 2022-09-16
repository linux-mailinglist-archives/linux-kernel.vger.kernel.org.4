Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5785BB3DF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIPVWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIPVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:22:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DBF95E40;
        Fri, 16 Sep 2022 14:22:38 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28GIA0a2019380;
        Fri, 16 Sep 2022 14:22:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=VYI6/00owk0O6G3XDM77cjPICoPf+pMVR+2coYAax/I=;
 b=JmByx+yO3nZYV+PpsyLXu3FRZbZxs+ckSMo3sJVsf+YWafhg3hV44WY3J5p0BvnB2rSh
 i8j/8bGxT0iJvbDk//PZimwckvklKyb4l58vY10n46i+L7pAyn8sxLS72ImJ69dvmpu4
 RmeL9+qkuBzv77NWz33VwwPpMaBN19FUDVpZi16eSEELCaodCHoyJXRYoAJncgvFXoaC
 soPeFKajmZaOVPNmxTcQHoEATLG+Ie6mgNqFOjArdmXJ9KEJpzYEw6wJRokwjejxi4Dk
 IeOmIWYoONq0ZzyJ+nLjkonN0E7QM5x/oF0U69/Bwjc+2xlvLWurRPBI6a7QizFKY5v0 rw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3jm8y758uk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 16 Sep 2022 14:22:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 16 Sep
 2022 14:22:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Fri, 16 Sep 2022 14:22:32 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 94C1A3F7044;
        Fri, 16 Sep 2022 14:22:32 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 28GLMTVi015156;
        Fri, 16 Sep 2022 14:22:29 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Fri, 16 Sep 2022 14:22:29 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Ingo Molnar <mingo@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Steven Rostedt <rostedt@goodmis.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        James Bottomley <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: Re: [EXT] Re: [PATCH v3 1/1] tracing: Fix compile error in trace_array
 calls when TRACING is disabled
In-Reply-To: <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
Message-ID: <77936835-03cf-fcc1-b563-da141d7ccbe0@marvell.com>
References: <20220907233308.4153-1-aeasi@marvell.com>
 <20220907233308.4153-2-aeasi@marvell.com>
 <yq15yho3y0s.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: RtYJ4Gf6Hhzj7uXicuut5eU3m_7yJf-z
X-Proofpoint-GUID: RtYJ4Gf6Hhzj7uXicuut5eU3m_7yJf-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-16_14,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Steve is travelling, trying Ingo, who is a co-maintainer of trace 
stuff.

Hi Ingo,

If you could review/approve the patch, that would be very helpful, as this 
is a build breaker fix.

Please see the link below for more context:

Most recent (v3) patch posting:
https://lore.kernel.org/linux-scsi/20220907233308.4153-2-aeasi@marvell.com/

Steve suggesting to take the patch via SCSI tree:
https://lore.kernel.org/linux-scsi/20220906174140.41b46a5f@gandalf.local.home/

Regards,
-Arun

On Thu, 15 Sep 2022, 6:32pm, Martin K. Petersen wrote:

> External Email
> 
> ----------------------------------------------------------------------
> 
> Steven,
> 
> Can you please review Arun's patch?
> 
> > Fix this compilation error seen when CONFIG_TRACING is not enabled:
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_init':
> > drivers/scsi/qla2xxx/qla_os.c:2854:25: error: implicit declaration of function
> > 'trace_array_get_by_name'; did you mean 'trace_array_set_clr_event'?
> > [-Werror=implicit-function-declaration]
> >  2854 |         qla_trc_array = trace_array_get_by_name("qla2xxx");
> >       |                         ^~~~~~~~~~~~~~~~~~~~~~~
> >       |                         trace_array_set_clr_event
> >
> > drivers/scsi/qla2xxx/qla_os.c: In function 'qla_trace_uninit':
> > drivers/scsi/qla2xxx/qla_os.c:2869:9: error: implicit declaration of function
> > 'trace_array_put' [-Werror=implicit-function-declaration]
> >  2869 |         trace_array_put(qla_trc_array);
> >       |         ^~~~~~~~~~~~~~~
> >
> 
> 
