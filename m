Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E105563750B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiKXJWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiKXJWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:22:44 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A055413E12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:22:42 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO7sBjC004512;
        Thu, 24 Nov 2022 03:22:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=wsQRThLlbccZrJZvbPoJQTj1QE08PMaYf1MzGwUSMRs=;
 b=i5gjlt74FrlTQbWhuAAPG3dJqgx3eK04h7TQlp/bjl8NA4f1QKJ8Ykj2IuygpBH7WJ2r
 sapLXTgMk6fy2e3/bo55WcuUyPf/04Yit3K8coqNyAWRAqqCruxMvkTYIguPW9fcxJDU
 QzhjkjRs+lw5/dfmcOO6Kwqdg/oLR24aHU6H6GoNk8vBIbT6q4FlTmGzzS4k3QmlTR8P
 6yae4ieGttCq7NphI5bG1IaMjJhuUr+GhDN20OBNKXBSkkf4BivUzPObd/A048U4EAjK
 gaIo0p0t7uZqYAdThtKDwFsyhTQxQ+OWJ2bwwKDIB5HAVeiVv4czWpxYJaF5hGVd8WJN qQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3kxwe6wygd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Nov 2022 03:22:33 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 24 Nov
 2022 03:22:31 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Thu, 24 Nov 2022 03:22:31 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A87282BA;
        Thu, 24 Nov 2022 09:22:31 +0000 (UTC)
Date:   Thu, 24 Nov 2022 09:22:31 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <yung-chuan.liao@linux.intel.com>,
        <pierre-louis.bossart@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>
Subject: Re: [PATCH v3 2/4] soundwire: Provide build stubs for common
 functions
Message-ID: <20221124092231.GD105268@ediswmail.ad.cirrus.com>
References: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
 <20221121141406.3840561-3-ckeepax@opensource.cirrus.com>
 <Y374VPAQcX6MkG22@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y374VPAQcX6MkG22@matsya>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: iKGQYZSxFjDxzItSCcsTmehsj3BpSXOI
X-Proofpoint-GUID: iKGQYZSxFjDxzItSCcsTmehsj3BpSXOI
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 10:21:32AM +0530, Vinod Koul wrote:
> On 21-11-22, 14:14, Charles Keepax wrote:
> > Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> > that are quite likely to be used from common code on devices supporting
> > multiple control buses.
> > 
> > Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> > +static inline int sdw_stream_add_slave(struct sdw_slave *slave,
> > +				       struct sdw_stream_config *stream_config,
> > +				       struct sdw_port_config *port_config,
> > +				       unsigned int num_ports,
> > +				       struct sdw_stream_runtime *stream)
> > +{
> > +	return 0;
> 
> Should this and other here not return error...? Indicating sdw is not
> available..? Silently ignoring may not be very helpful in debugging
> 

Yeah I was a little unsure which way to go on that, in the end I
opted for returning zero as it was more likely code would get
optimised out. But I am happy to switch to returning an error, it
would as you say making debugging misconfigurations easier.
-ENOSYS seems kinda reasonable I think.

Thanks,
Charles
