Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E892B6B43E1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjCJOT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbjCJOTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:19:06 -0500
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [IPv6:2620:100:9001:583::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9CB11BB0A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:17:35 -0800 (PST)
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.17.1.19/8.17.1.19) with ESMTP id 32AAG6AP028235;
        Fri, 10 Mar 2023 14:15:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=jan2016.eng;
 bh=a1Tdrh1E0sqCNPCvXDdc0TRelX2Ah/cezVnHkMNv/UY=;
 b=eefwoN0TjGvXBQC04slfoKfvhTTLolPovjJL/gylN5k54KLZVvCutn11IhdJ8clf4Ye/
 MI8mkpoq1Ejyow/8cX/lOFAzKcrOgjtavucrIYFmGdZUi5URzWNWuwwPJKaU17YB76ZW
 EoIONZAHadXf/jIzvkJlufH0Y3I1v8w/mSp9cCZIkrSoyFHPHFO/+4Rmx6EtsSzO1jo5
 hvB+qBJ9dumpSkyXcLNg4tr8X9rdUCJeLoadWa3PCc1pH3qDvqKn6VEmfYRdB6MzTb8g
 TeuUjSRmzTh2gakZAlRHyNRruS5Ky0/+wokG0SOCOMffK6b0TFAAR7+HahClun5XhlVE iA== 
Received: from prod-mail-ppoint3 (a72-247-45-31.deploy.static.akamaitechnologies.com [72.247.45.31] (may be forged))
        by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 3p6fhe8fp9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 14:15:56 +0000
Received: from pps.filterd (prod-mail-ppoint3.akamai.com [127.0.0.1])
        by prod-mail-ppoint3.akamai.com (8.17.1.19/8.17.1.19) with ESMTP id 32AAPe6m025465;
        Fri, 10 Mar 2023 09:15:55 -0500
Received: from prod-mail-relay19.dfw02.corp.akamai.com ([172.27.165.173])
        by prod-mail-ppoint3.akamai.com (PPS) with ESMTP id 3p6ffv0jgy-1;
        Fri, 10 Mar 2023 09:15:55 -0500
Received: from [172.19.47.124] (bos-lpa4700a.bos01.corp.akamai.com [172.19.47.124])
        by prod-mail-relay19.dfw02.corp.akamai.com (Postfix) with ESMTP id C68FF600FA;
        Fri, 10 Mar 2023 14:15:54 +0000 (GMT)
Message-ID: <bfa92c1d-11ea-eaad-2dd0-546ec1b4b0d3@akamai.com>
Date:   Fri, 10 Mar 2023 09:15:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ARM: dyndbg: allow including dyndbg.h in decompressor
To:     Arnd Bergmann <arnd@kernel.org>,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310140133.291594-1-arnd@kernel.org>
Content-Language: en-US
From:   Jason Baron <jbaron@akamai.com>
In-Reply-To: <20230310140133.291594-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100113
X-Proofpoint-GUID: ZqomsXiNACum6iYNz7RRMp-vffyiTo6d
X-Proofpoint-ORIG-GUID: ZqomsXiNACum6iYNz7RRMp-vffyiTo6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_06,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1011 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100115
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 9:01 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After a change to linux/module.h, dyndbg.h is now included
> indirectly from the decompressor for lz4 support, which in turn
> causes a build failure on 32-bit Arm:
> 
> In file included from include/linux/module.h:30,
>                   from arch/arm/boot/compressed/../../../../lib/lz4/lz4_decompress.c:39,
>                   from arch/arm/boot/compressed/../../../../lib/decompress_unlz4.c:10,
>                   from arch/arm/boot/compressed/decompress.c:59:
> include/linux/dynamic_debug.h: In function 'ddebug_dyndbg_module_param_cb':
> include/linux/dynamic_debug.h:307:14: error: implicit declaration of function 'strcmp' [-Werror=implicit-function-declaration]
>    307 |         if (!strcmp(param, "dyndbg")) {
>        |              ^~~~~~
> include/linux/dynamic_debug.h:1:1: note: 'strcmp' is defined in header '<string.h>'; did you forget to '#include <string.h>'?
>    +++ |+#include <string.h>
> 
> The decompressor has its own replacement for the linux/string.h contents,
> so the normal declaration is not visible here. Since the function is
> not actually called, it is sufficient to add a declaration, and this
> is in fact the correct one as it matches the definition in
> arch/arm/boot/compressed/string.c.
> 
> Fixes: 7deabd674988 ("dyndbg: use the module notifier callbacks")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> The patch that caused the problem is in linux-next, maybe fold
> the fix into that patch if possible
> ---
>   arch/arm/boot/compressed/decompress.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/compressed/decompress.c b/arch/arm/boot/compressed/decompress.c
> index 74255e819831..0669851394f0 100644
> --- a/arch/arm/boot/compressed/decompress.c
> +++ b/arch/arm/boot/compressed/decompress.c
> @@ -31,6 +31,7 @@
>   /* Not needed, but used in some headers pulled in by decompressors */
>   extern char * strstr(const char * s1, const char *s2);
>   extern size_t strlen(const char *s);
> +extern int strcmp(const char *cs, const char *ct);
>   extern int memcmp(const void *cs, const void *ct, size_t count);
>   extern char * strchrnul(const char *, int);
>   


Hi Arnd,

Thank you for the fix up, I was about to look into this...

Acked-by: Jason Baron <jbaron@akamai.com>

Thanks,

-Jason
