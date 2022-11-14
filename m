Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B886280FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbiKNNNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbiKNNM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:12:59 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1234028E3B;
        Mon, 14 Nov 2022 05:12:54 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AE9XhTu007380;
        Mon, 14 Nov 2022 14:12:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hbffMJzz+D/Of/1FLXDm6mYFbbw4YsWQLicJfJxuiDk=;
 b=LkFnIMTnOo8zdx7Th17lovNc7GntRC53jHryNYtyefqdEfrCrj5KnKoY6hGRhT7nkOQJ
 4/CXx/kC+d8MbNEL7jQJVf6+BirkayjJCqr/8YR1ZsS9WwlorX5v2Sru+k+KUCEZ3NMs
 Yh9sSFeQqDt8aZO+07LjvgNg3SDaNg5rbY/gXay0Oj4vGgH123n+81lnXfwPj7SFPxvm
 tHHCZ0HJtDfUZzI4pBqeos9HGKnx6c3/0O1iIjd3AdWDVRoTr+2vowt73tEWAn34/dy6
 /O1BlwRm+b9shrIQ5jElHiK+S0pJe6hV5HCOFTfa611ji3cVP1gexGujYPcWKEFXT/Eg fQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ktq2yfgdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Nov 2022 14:12:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 207EE10002A;
        Mon, 14 Nov 2022 14:12:16 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4CB4622A6EF;
        Mon, 14 Nov 2022 14:12:16 +0100 (CET)
Received: from [10.129.167.233] (10.129.167.233) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Mon, 14 Nov
 2022 14:12:15 +0100
Message-ID: <ad2009b0-01be-76d9-ba02-e38a9ba87894@foss.st.com>
Date:   Mon, 14 Nov 2022 14:12:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Coverity: vgxy61_tx_from_ep(): Memory - corruptions
To:     coverity-bot <keescook@chromium.org>
CC:     <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        Shawn Tu <shawnx.tu@intel.com>, <linux-media@vger.kernel.org>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <linux-next@vger.kernel.org>, <linux-hardening@vger.kernel.org>
References: <202211100827.8A08F58A@keescook>
Content-Language: en-US
From:   Benjamin MUGNIER <benjamin.mugnier@foss.st.com>
In-Reply-To: <202211100827.8A08F58A@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.167.233]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thank you for your report.

On 11/10/22 17:27, coverity-bot wrote:
> Hello!
> 
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221110 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
> 
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
> 
>   Thu Oct 27 14:37:38 2022 +0300
>     153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")
> 
> Coverity reported the following:
> 
> *** CID 1527258:  Memory - corruptions  (OVERRUN)
> drivers/media/i2c/st-vgxy61.c:1528 in vgxy61_tx_from_ep()
> 1522     	 * valid for hardware stuff.
> 1523     	 */
> 1524     	for (p = 0; p < VGXY61_NB_POLARITIES; p++) {
> 1525     		if (phy2log[p] != ~0)
> 1526     			continue;
> 1527     		phy2log[p] = l;
> vvv     CID 1527258:  Memory - corruptions  (OVERRUN)
> vvv     Overrunning array "log2phy" of 5 4-byte elements at element index 5 (byte offset 23) using index "l" (which evaluates to 5).
> 1528     		log2phy[l] = p;
> 1529     		l++;
> 1530     	}
> 1531     	for (l = 0; l < l_nb + 1; l++)
> 1532     		polarities[l] = ep.bus.mipi_csi2.lane_polarities[l];
> 1533
> 
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527258 ("Memory - corruptions")
> Fixes: 153e4ad44d60 ("media: i2c: Add driver for ST VGXY61 camera sensor")
> 
> Note that l starts at 1, 2, or 4, so line 1529 could push it to 5, which
> is out of bounds, etc...

This 'for' loop is tied with the previous one.
The first loop fills log2phy with provided data, and the second one
fills slots that were not provided with hardware valid data. You can see
in the second loop:
  if (phy2log[p] != ~0)
    continue;
which prevents this loop from filling slots that were already filled,
and at the same time prevents 'l' to be incremented when this is the case.
As 'l' was incremented for each provided data by the first loop, and
incremented for each not provided data by the second loop. At the end of
the second loop l == VGXY61_NB_POLARITIES == 5 (because of the last
'l++'), but will never be used as an index for 'log2phy' because the
loop will end right after.


So if I'm not mistaken, and while hard to catch by tools this could be
understood as a false positive.

I could guard it with to make the checker happy with:
  if (p != VGXY61_NB_POLARITIES - 1) l++;
and it would be exactly the same, but I find this kind of unnecessary.


Any thoughts?

Thank you.

> 
> Thanks for your attention!
> 

-- 
Regards,

Benjamin
