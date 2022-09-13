Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32735B78AE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiIMRrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbiIMRqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:46:35 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9111559A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 09:43:30 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DEZPjG013261;
        Tue, 13 Sep 2022 15:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=trk/472N42UIul6YU9xO8D93yFXG6mBH2ftLmiR9+dE=;
 b=lmjR8COBLq/g2VxVJ5XWXv76qgPWWOmvhn+DljCnxQCk4LreaHmmMOqOpvVU+ozG3rh6
 kV17dqyvFqQI8Min2KhfbwoVtOyAdyCdpTKlZwSUdyT9Id6xjVI+R/lRuq6opd5Kjvrb
 YrW15M8BMGw1FsFbBiPnbrLVKiM7dD9HQWq9eHn1aH9DQiyvJAcPpZq/tjrx3oQdiXOy
 I2acKACPUiW0YnnAladp4zg0IQG/53hY1ZVscy8f1UHszSiu8llf8cmmUX+31XPeJ9yp
 GwvGLNoToeKEIIH4vGpSSF8XkG/cX/rDSG7gs1y9ZuONayp7Bz2acKJl2sdp3JfU6Eg6 oA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jjqv82gyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 15:01:44 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 7427287;
        Tue, 13 Sep 2022 15:01:43 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 077F98040B6;
        Tue, 13 Sep 2022 15:01:41 +0000 (UTC)
Date:   Tue, 13 Sep 2022 10:01:40 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     robinmholt@gmail.com, steve.wahl@hpe.com, mike.travis@hpe.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, tony.luck@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/misc/sgi-xp: Remove orphan declarations from
 drivers/misc/sgi-xp/xp.h
Message-ID: <YyCbVNDYURxOu7iK@swahl-home.5wahls.com>
References: <20220913110356.764711-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913110356.764711-1-cuigaosheng1@huawei.com>
X-Proofpoint-GUID: ir-nN6Qu9Dl3JVw-vcr6Sc45FY4gVOlU
X-Proofpoint-ORIG-GUID: ir-nN6Qu9Dl3JVw-vcr6Sc45FY4gVOlU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_07,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=882
 phishscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Tue, Sep 13, 2022 at 07:03:56PM +0800, Gaosheng Cui wrote:
> Remove the following orphan declarations from drivers/misc/sgi-xp/xp.h:
> 1. xp_nofault_PIOR_target
> 2. xp_error_PIOR
> 3. xp_nofault_PIOR
> 
> They have been removed since commit 9726bfcdb977 ("misc/sgi-xp:
> remove SGI SN2 support"), so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
> v2:
> - Remove unused xp_nofault_PIOR declaration.
> - Format the commit messages for the patch, thanks!
>  drivers/misc/sgi-xp/xp.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
> index 9f9af77f8d2e..f1336f43d3bd 100644
> --- a/drivers/misc/sgi-xp/xp.h
> +++ b/drivers/misc/sgi-xp/xp.h
> @@ -334,10 +334,6 @@ extern int (*xp_cpu_to_nasid) (int);
>  extern enum xp_retval (*xp_expand_memprotect) (unsigned long, unsigned long);
>  extern enum xp_retval (*xp_restrict_memprotect) (unsigned long, unsigned long);
>  
> -extern u64 xp_nofault_PIOR_target;
> -extern int xp_nofault_PIOR(void *);
> -extern int xp_error_PIOR(void);
> -
>  extern struct device *xp;
>  extern enum xp_retval xp_init_uv(void);
>  extern void xp_exit_uv(void);
> -- 
> 2.25.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
