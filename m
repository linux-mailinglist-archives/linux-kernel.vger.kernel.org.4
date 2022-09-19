Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A345BD438
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 19:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiISRzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 13:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbiISRyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 13:54:46 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6BA645E;
        Mon, 19 Sep 2022 10:54:41 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28JG4xtC027934;
        Mon, 19 Sep 2022 10:54:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=1G3GJzV5y9auR1/NnhU8VG7NgQwc16taTs26xl1s1X8=;
 b=ifXyyMY25NrEnkWKtjRHnLpIc072YDEWw8/SXvkx7nujjdQTxkJranuO+afyppseKOye
 Lnso5zsb0CwIs9Wk9exYm9cuh/JkxX8KT4RZBrHhurmDSHr8M5/ssV3+uuAcJ6nbgui7
 kveV0E3oH4PAZhtJWqNtZxnTps8z/1NCoKba7kRlBn5EVefoY1bUC004SaxkP64pmH+K
 Tc9QKJs78FlxlF+Qb8AZbTVqg5pIjcRwS51mPGQgvIPHWyTvRY2wYHAg//2+GqMOVomM
 HKfGu1YwPYZo11Gnm5m67lJMXycSIq7kBgZFyBH40gzncAyQzXReyAvRLua3ecbi+OzT nw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3jnbkpqtd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 10:54:29 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 19 Sep
 2022 10:54:27 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 19 Sep 2022 10:54:27 -0700
Received: from mvluser05.qlc.com (unknown [10.112.10.135])
        by maili.marvell.com (Postfix) with ESMTP id 364C03F7040;
        Mon, 19 Sep 2022 10:54:27 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by mvluser05.qlc.com (8.14.4/8.14.4/Submit) with ESMTP id 28JHsOO1024270;
        Mon, 19 Sep 2022 10:54:25 -0700
X-Authentication-Warning: mvluser05.qlc.com: aeasi owned process doing -bs
Date:   Mon, 19 Sep 2022 10:54:24 -0700
From:   Arun Easi <aeasi@marvell.com>
To:     Ren Zhijie <renzhijie2@huawei.com>
CC:     <njavali@marvell.com>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <dwagner@suse.de>, <himanshu.madhani@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] [PATCH v2 -next] scsi: qla2xxx: Fix build error
 implicit-function-declaration
In-Reply-To: <20220919133404.85425-1-renzhijie2@huawei.com>
Message-ID: <dfc510ef-a181-3832-f16c-74f1d7fb5608@marvell.com>
References: <20220919133404.85425-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="1879738122-2001043555-1663610067=:26768"
X-Proofpoint-ORIG-GUID: gYWoiu4yJhH2R4zNL772aO8qpm0Yztoz
X-Proofpoint-GUID: gYWoiu4yJhH2R4zNL772aO8qpm0Yztoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1879738122-2001043555-1663610067=:26768
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT

NAK.

Please see these threads for a fix in "trace.h" to address this issue and 
a related discussion.

Most recent (v3) patch posting:
https://lore.kernel.org/linux-scsi/20220907233308.4153-2-aeasi@marvell.com/

Steve suggesting to take the patch via SCSI tree:
https://lore.kernel.org/linux-scsi/20220906174140.41b46a5f@gandalf.local.home/

Hoping this would get a nod soon and can get merged.

Regards,
-Arun

On Mon, 19 Sep 2022, 6:34am, Ren Zhijie wrote:

> External Email
> 
> ----------------------------------------------------------------------
> If CONFIG_TRACING is not set,
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-,
> will be failed, like this:
> 
> drivers/scsi/qla2xxx/qla_os.c: In function ‘qla_trace_init’:
> drivers/scsi/qla2xxx/qla_os.c:2854:18: error: implicit declaration of function ‘trace_array_get_by_name’; did you mean ‘trace_array_set_clr_event’? [-Werror=implicit-function-declaration]
>   qla_trc_array = trace_array_get_by_name("qla2xxx");
>                   ^~~~~~~~~~~~~~~~~~~~~~~
>                   trace_array_set_clr_event
> drivers/scsi/qla2xxx/qla_os.c:2854:16: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
>   qla_trc_array = trace_array_get_by_name("qla2xxx");
>                 ^
> drivers/scsi/qla2xxx/qla_os.c: In function ‘qla_trace_uninit’:
> drivers/scsi/qla2xxx/qla_os.c:2869:2: error: implicit declaration of function ‘trace_array_put’; did you mean ‘trace_seq_putc’? [-Werror=implicit-function-declaration]
>   trace_array_put(qla_trc_array);
>   ^~~~~~~~~~~~~~~
>   trace_seq_putc
> cc1: all warnings being treated as errors
> 
> To fix this error, wrap up all the relevant code with CONFIG_TRACING.
> 
> Fixes: 8bfc149ba24c ("scsi: qla2xxx: Enhance driver tracing with separate tunable and more")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
> Changes in v2:
>  - warp the definition statement of qla_trace_init() and qla_trace_uninit() with CONFIG_TRACING.
> ---
>  drivers/scsi/qla2xxx/qla_os.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 2c85f3cce726..f64063e56f3d 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -37,7 +37,9 @@ static int apidev_major;
>   */
>  struct kmem_cache *srb_cachep;
>  
> +#ifdef CONFIG_TRACING
>  static struct trace_array *qla_trc_array;
> +#endif
>  
>  int ql2xfulldump_on_mpifail;
>  module_param(ql2xfulldump_on_mpifail, int, S_IRUGO | S_IWUSR);
> @@ -2851,6 +2853,7 @@ static void qla2x00_iocb_work_fn(struct work_struct *work)
>  static void
>  qla_trace_init(void)
>  {
> +#ifdef CONFIG_TRACING
>  	qla_trc_array = trace_array_get_by_name("qla2xxx");
>  	if (!qla_trc_array) {
>  		ql_log(ql_log_fatal, NULL, 0x0001,
> @@ -2859,14 +2862,17 @@ qla_trace_init(void)
>  	}
>  
>  	QLA_TRACE_ENABLE(qla_trc_array);
> +#endif
>  }
>  
>  static void
>  qla_trace_uninit(void)
>  {
> +#ifdef CONFIG_TRACING
>  	if (!qla_trc_array)
>  		return;
>  	trace_array_put(qla_trc_array);
> +#endif
>  }
>  
>  /*
> 
--1879738122-2001043555-1663610067=:26768--
