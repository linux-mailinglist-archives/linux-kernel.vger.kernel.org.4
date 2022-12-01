Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1497F63ECB1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiLAJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiLAJmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:42:19 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFF18EE66;
        Thu,  1 Dec 2022 01:42:18 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B19Rnnu005092;
        Thu, 1 Dec 2022 09:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=6sFECJHBh59XnXxMkp/AiV4JjbD3CHEwXLsKtJ4ruY4=;
 b=GbYtmFLoldsX7qbdZMSW9ZRp5Dnz74K+kIkQ4069/xrxxgWJ+YFomQQ+CclGqv9n9W7m
 UUoXslWVrLUjYZJaBiDZaZvcdqZqKkeV8gNNhdbj6DwFT+QCJCrwunTfHTUZHFOKJpVw
 OCxyhj4zzTxmIy42FOCfibl12NRaAfDeMHnk5XPkVTMguIqbjwlzYdVjiUadXwK1x6st
 PcLZnAjLYfDMTuT8FVNjkLDaM+r6rp/RvdAxp3rto5eeJyP1lk8GPi1BBnz3JsMJM0CG
 21upqB+LWOUbY68bxUCPp0s28WGbM5nlNFcdVWjR2ZF/yyAfHF6Pu9cpV8IVYj0qcnwn 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6snjgaeq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 09:41:54 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B19SfQo006657;
        Thu, 1 Dec 2022 09:41:54 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3m6snjgadw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 09:41:54 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B19ZtdY017033;
        Thu, 1 Dec 2022 09:41:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 3m3ae9557w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 09:41:52 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B19fnbo8258178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 1 Dec 2022 09:41:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CAC46A404D;
        Thu,  1 Dec 2022 09:41:49 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B5D9A4040;
        Thu,  1 Dec 2022 09:41:49 +0000 (GMT)
Received: from li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com (unknown [9.179.5.155])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  1 Dec 2022 09:41:48 +0000 (GMT)
Date:   Thu, 1 Dec 2022 10:41:47 +0100
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf build: Fixes for LIBTRACEEVENT_DYNAMIC
Message-ID: <Y4h227w4T5EWrwKm@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
References: <20221129192924.1580537-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129192924.1580537-1-irogers@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xGDwIzjJtTiZ7qfGGAgCByMWHH5hQsUf
X-Proofpoint-GUID: _xhELqXTuaG32yICiuanVsrdm2SwtUtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_04,2022-11-30_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212010066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 11:29:24AM -0800, Ian Rogers wrote:
> If LIBTRACEEVENT_DYNAMIC is enabled then avoid the install step for
> the plugins. If disabled correct DESTDIR so that the plugins are
> installed under <lib>/traceevent/plugins.
> 
> Fixes: ef019df01e20 ("perf build: Install libtraceevent locally when building")
> Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Makefile.perf | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a17a6ea85e81..f4cd946fe91a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -884,7 +884,7 @@ $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
>  
>  install-traceevent-plugins: libtraceevent_plugins
>  	$(Q)$(MAKE) -C $(LIBTRACEEVENT_PLUGINS_DIR) O=$(LIBTRACEEVENT_PLUGINS_OUTPUT) \
> -		DESTDIR=$(LIBTRACEEVENT_PLUGINS_DESTDIR) prefix= \
> +		DESTDIR=$(DESTDIR_SQ) prefix= \
>  		$(LIBTRACEEVENT_FLAGS) install
>  endif
>  
> @@ -1093,7 +1093,11 @@ install-tests: all install-gtk
>  		$(INSTALL) tests/shell/coresight/*.sh '$(DESTDIR_SQ)$(perfexec_instdir_SQ)/tests/shell/coresight'
>  	$(Q)$(MAKE) -C tests/shell/coresight install-tests
>  
> -install-bin: install-tools install-tests install-traceevent-plugins
> +install-bin: install-tools install-tests
> +
> +ifndef LIBTRACEEVENT_DYNAMIC
> +install-bin: install-traceevent-plugins
> +endif
>  
>  install: install-bin try-install-man
>  
> -- 
> 2.38.1.584.g0f3c55d4c2-goog

Tested-by: Alexander Gordeev <agordeev@linux.ibm.com>
