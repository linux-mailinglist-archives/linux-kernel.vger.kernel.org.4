Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED95B5D10
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 17:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiILPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 11:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiILPYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 11:24:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A661F2C3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 08:24:12 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CFCrln017366;
        Mon, 12 Sep 2022 15:23:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=boeV+lBleRKRmAPehZpnIIEs0nTPF83CYwRvWwi2Di8=;
 b=ZqqOOJvKtaw9oecxyZtgMeGWMV2++1aPOC9JbngqQn/UBoRBtw3ALv6LI9V9RrVxwywo
 LSg5dccuKChWhzuxDItpaSNkZHlAY7uq4en0DQwiKHcUfzjycN6LmdsA12ZqS+upVX0G
 Xo3iAiBrbkuDJrbyRK/bg6NvSvUO09jU173VU1+9E9eMwVLVVgDgarFfVWk6HjPGStTP
 pikN4BZJ6JUbKIwc9XdwyvjGxXtij8g4cNRxsgbluZo/2cr3Afu+r1cFfkc9k5pIOYtA
 wgiNV0KNn3JzSWHX9Tcjf/oPp8I/Z5/ZinRh1yA+P/QCQrbJvihW3DslvjiJCGCdi2cP 2Q== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3jj77483gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Sep 2022 15:23:50 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CD181D246;
        Mon, 12 Sep 2022 15:23:48 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 69B3C803DB3;
        Mon, 12 Sep 2022 15:23:46 +0000 (UTC)
Date:   Mon, 12 Sep 2022 10:23:44 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     robinmholt@gmail.com, steve.wahl@hpe.com, mike.travis@hpe.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, hch@lst.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/misc/sgi-xp: remove unused declarations in xp.h
Message-ID: <Yx9PAHL/6ptF5MDF@swahl-home.5wahls.com>
References: <20220911093212.3220496-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911093212.3220496-1-cuigaosheng1@huawei.com>
X-Proofpoint-ORIG-GUID: NuBdJIe9OI-tkbDbOItfVN8u28FsDZsp
X-Proofpoint-GUID: NuBdJIe9OI-tkbDbOItfVN8u28FsDZsp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 mlxlogscore=897 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 suspectscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209120052
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't xp_nofault_PIOR be removed also, for the exact same reasons?

On Sun, Sep 11, 2022 at 05:32:12PM +0800, Gaosheng Cui wrote:
> xp_nofault_PIOR_target and xp_error_PIOR have been removed since
> commit 9726bfcdb977 ("misc/sgi-xp: remove SGI SN2 support"),
> so remove them.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  drivers/misc/sgi-xp/xp.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/misc/sgi-xp/xp.h b/drivers/misc/sgi-xp/xp.h
> index 9f9af77f8d2e..cf073304b714 100644
> --- a/drivers/misc/sgi-xp/xp.h
> +++ b/drivers/misc/sgi-xp/xp.h
> @@ -334,9 +334,7 @@ extern int (*xp_cpu_to_nasid) (int);
>  extern enum xp_retval (*xp_expand_memprotect) (unsigned long, unsigned long);
>  extern enum xp_retval (*xp_restrict_memprotect) (unsigned long, unsigned long);
>  
> -extern u64 xp_nofault_PIOR_target;
>  extern int xp_nofault_PIOR(void *);
> -extern int xp_error_PIOR(void);
>  
>  extern struct device *xp;
>  extern enum xp_retval xp_init_uv(void);
> -- 
> 2.25.1
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
