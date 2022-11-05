Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880B961A6C9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 03:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKEB7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKEB7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:59:08 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB026AF8;
        Fri,  4 Nov 2022 18:59:07 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A51M8I5006550;
        Sat, 5 Nov 2022 01:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=YL8blbs3TZOkLbo/xAyIxfu/eh6M4xvycjS7bwtjcYw=;
 b=S4/rFhPdv5os1kC7B6CYu3KQ3msMH6B6dWnPjTBFW5FoKFxc6SjzaCw5qWG5lAisJlO0
 T7M+eRikeODlbAYB1oW+N1QvnX2OL8KRBlH149Juf7H4k1LvMUn7HaLC8hJZa0N8FL9Z
 TxXEkvYNMi7VPd02iJ4VDbT+IXBPVleYiBUaYsqR3MXekP9Q4DSuacZk6Lx0GpPyeYbl
 ICCFLx34rM8RZq2tdNr62fythEdNdjzW5NoIZfkbS7QS79EVwkJJZE42rDGnfkWDZ73S
 D6Qdy5TdgHoXTjKFNC6r6vWLR+Vpy4NkPVgLFgo3KzGbtD5u52tcMDBCMWa1SdYp5xAb Iw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kn8auj7m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Nov 2022 01:58:38 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 2B4D8295A2;
        Sat,  5 Nov 2022 01:58:36 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 4 Nov 2022 13:58:30 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 4 Nov 2022 13:58:30 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sat, 5 Nov 2022 01:58:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3C2hr9NaoFgizQxVmen0zDjPdpTmkwfMGK64wLrNTpTJ1iv+A5DfxrpnJWu9a0oB8VuW8XKx8X6M06b84uOPjZspoQExhPi26i+T+cRoBum21j4r7fh77JHJRDag0lhw7QNr/4v6EHhwC/ivcnXyLgheLfJwKkwoD7NTZeLwLkmcrj7YB/0IlFjHt5EotmgtMIWnAABkVEZLetoVNlCc/Uqb4nsK3Hg7TGDOp4+vSd1mH2p72TWJHmV1kK6v3YkDJeJotoPrWyFLOgADKY375hJzV9mB6TdLvrtLQiil8HCwt5FeU5KiNKaA/Gjgh5DZc5DpjacJ0CUl/zCMdyi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YL8blbs3TZOkLbo/xAyIxfu/eh6M4xvycjS7bwtjcYw=;
 b=lxq84hgCl5X2i7iC+qAf5MB+bwdQtS9HpPawRHKTxsynFZNP8kSM6J4TP++FigPc/XRzmJvC/vSgp8fsfZJYRIfd60cjJFQQ2ozS/BKaKnM0gGnk8iTBcEtTPqyhamnq4lsUUGfNncg58ne/dpiC+D/9tpkvgsCqWGbSQydPy0BzNryo8eNqi8+InVxqspYO77REWVEoKhbiEEkm4gEx0WFJWIJ2fLB8npV/6Db+owrIGLXPknZNuKPMsTpvwKd3tF1uJbQ/mcdJqSMWEMDO/4Pc/QmpndP9SZvpOU2Vuaa6ZA+CeC67cfPLi8lLRfDZS539XBG5S/oxG4jlIadhYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1784.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Sat, 5 Nov
 2022 01:58:28 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5791.022; Sat, 5 Nov 2022
 01:58:28 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Neeraj Upadhyay" <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODw
Date:   Sat, 5 Nov 2022 01:58:28 +0000
Message-ID: <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
In-Reply-To: <20221104021224.102-5-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1784:EE_
x-ms-office365-filtering-correlation-id: c7f1d84e-7b9d-476b-8237-08dabed13b6c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hGmuq+YO3j4UQn/H8GSSsXWD9HxvELowpkpkswEOp0ILXC6qFW2N5mj8rRcR/J6fJiL4m+XfwTk6vzPoFPOzYyZizif+aW/AC3Iew42Mp0XlsHEnNSfwKjDJTV33fnCRzOPS8Y9Q3v/50wlzHt6Urp5QKsGoRcBCBwl60+NdQ9OutHLJEkqdhUrBTs8J8dTbLa0egyi/2ueX6DwmA8j107CMEzhjVBl0DtDSdcPOVaZUkA6FkzWw7K+YJtWp6C5g6bEDOwo2D1ASq/heXO45EJcNdJ1szi4rmEY9kxONGKu0gt7lp7kk2BQq/Oc8dxSSj75HYjw5jzvwZz9tQJ8fWuQGG02DROmTX+Vt4zc+QdAgE0bWHDwRoFUdX+gjXaL7EqIyCIpJZiDzEJJ/2ZEU08tgzeZCEE4zJsk/W9LvsCDnGZZq+JBy8/ura3aNxP76FfmLw033Th0BJ8m3LiBF6sSdoJWxYWBNd/74yjxvpZkTZSXPS8+ISZsNN48z50P/v1QURmTEw4QkQxAO9h7JYBj+1l48FdYWtT2DHSOi1n4qYzxPoHhh1Pd7gRgv5Gldeh1Z+aJZQoT7T/M5QhFIfOnvrhIUa3IMndCj7J7MumVui+FjdpLW9w0p2eJeqMH32nYEEEbdpbJKw3I0A7pvRvgmlGJJ508YjBzZxJ/eUkU8LjrschjgmIZTt68AROGik34erCV/MM4rRs1BKgz39mFVqQIsHBxmwuv0x7+d11uopYDZTtAX5XpyZat9bUk/1qfGwW2emFBJXWK62yN7a23y+zxwV/lTDBf4Tdbu2H8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(346002)(136003)(366004)(451199015)(921005)(76116006)(82960400001)(38070700005)(86362001)(2906002)(66946007)(5660300002)(38100700002)(66446008)(7416002)(122000001)(52536014)(66556008)(66476007)(186003)(83380400001)(66899015)(64756008)(6506007)(478600001)(110136005)(26005)(7696005)(316002)(45080400002)(71200400001)(8676002)(8936002)(9686003)(41300700001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J3RIESkk4onSZnji1/vzYFDy5yw6l8FFTtYNLalT00GbwLPxuczOTFdTSPxI?=
 =?us-ascii?Q?ol+FTVKkgA0JmtkYSQxbDLrA1r7Jpd7E5yQpe4dPwiHx2PaiofwulgTj6WmN?=
 =?us-ascii?Q?5Cnksu/8aGOwSkJDWDUtFfRj/aS51OanAtk7MqMTk9ZQ0U4avXHdn63Ee6de?=
 =?us-ascii?Q?6RECpDRUM5ocWA/TKctkP7U12hUBYXjmVwO8nVN5ASbVXKV5Yi+hCmNbGZ9c?=
 =?us-ascii?Q?PbH9PP3uvI1Za8x95w9DRNpJnn09woC1T+7KK5S5pssdroC1JxmMGCJsOYph?=
 =?us-ascii?Q?sE0KH2bKtQttZxgD8VRxdYFYlOAoyaGxupvfDfKMDbygC/YgSiBTTwVlOOQX?=
 =?us-ascii?Q?kWGdQSTa8ehbfskDpEvKElejFCsLLPtxeNmYhD9ooY7FB78eRf4W6ayDvkW8?=
 =?us-ascii?Q?nCdI/c5QFy4D34J0K628VYlAIpPuTYzA+JaFdCyN4hKdY9AnZ5PIuPCxe5XP?=
 =?us-ascii?Q?OWciQbqJZrMjPiqo/ujUdt3WeFagr057IC63K9EAj4mqvg17KCVYZQmHs4wm?=
 =?us-ascii?Q?NaDO3N18pGXApdhwjUrBaztNQ7qgx/MNYc90BHNEbZp8x7cNB6b/65xJJl9E?=
 =?us-ascii?Q?ShWMcbmaW7ews+rC12kNVereFstEWL0pZ0VFRXFf2ji/qL962K8FRHfl1m/b?=
 =?us-ascii?Q?mZKHPQTa9gcvtImfIkulShNQI9akW1fcMqVpavh/1tXHElDSk1aYwqcMI2yL?=
 =?us-ascii?Q?lFoA4xoIviG4x9mSDcqnD3FYLma9FhGweRULmRueiG29hehqS6Xdz1UCDvZd?=
 =?us-ascii?Q?fP1DKXe9sw5fAnjMCnqEwbjvw8qu+HT9lC94t+PPofHRYO8c90JBdOpH6p4w?=
 =?us-ascii?Q?vWcxYPiRL6M6WTDOb0PFNx2vY/nyBvE+Fl4L/dJXaZvSIt619LLTTqU0X7DS?=
 =?us-ascii?Q?NTgJzaW9OlBvT/urJatSicMlO2WAdHr1FqLmZ7EcApnuxBWF5mPpKNRO4sf7?=
 =?us-ascii?Q?SYxMhuMAr7qG2smznfS39DCU3JHa3ZonJawlT9beG71j53ykqMuocPxa+RsK?=
 =?us-ascii?Q?C+HONYR8Ctb78jcXuR8qHQK8UJIkioH+6wBlOUD5TyTQ8eO17bRXsbYJ4h95?=
 =?us-ascii?Q?vyfhJN6OLywBGj9MFpNiZYOkgVZ+CyZmQkjTK1QJMeQP/MJ5oRbCB8ZWSaaw?=
 =?us-ascii?Q?a5DLYa2SSK8mNtEEOcNWIUq7XeSGqUkT3UWhlhkYnlh6DTnzsprVHxMdAIwR?=
 =?us-ascii?Q?EeHmoNcCti/moMYVqk44k+e9XQ71GcDS6X4lByaLMtCN6o8AQWl1tW5QORAh?=
 =?us-ascii?Q?0Q1b/5Gkn64VxsbUTzQz6I8n+7kY7QtUO6Mt4G4H1fk4cusdDFmrl1Rah6p3?=
 =?us-ascii?Q?r4BprwiREKA8knt3q8RQAqT0JM8buXKrtKMBTuxICTNjP/smVjC3R5fhsjB3?=
 =?us-ascii?Q?33mVu6WTBDi/4I3ojBkkVop/HHiiau/a51rOnBWYyVAHlUb0OZwy4qGAEQsx?=
 =?us-ascii?Q?kkIukvwxMY3S5Gwj3lfVxYr6tC7mu2ypo020brCbl6LE45xZc9TiCHR2LSyg?=
 =?us-ascii?Q?aypTbCf4ZKl0j/5RI1N7W36PoFMbvtJDv9aWjfwgTBhoa6fj8SrylxY1hPjo?=
 =?us-ascii?Q?zNkcKN6ImTX10VEqD6M=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f1d84e-7b9d-476b-8237-08dabed13b6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2022 01:58:28.0443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqc0B0VIIUiMLiAjR+FuR1K2Omcj4fMEclAA/uB5A0OKmHlqc9QvFGWZgypEGOti
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1784
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: aPqnrlSNGcVpyTZRvMP1f0aUWxOXHXNP
X-Proofpoint-ORIG-GUID: aPqnrlSNGcVpyTZRvMP1f0aUWxOXHXNP
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 mlxlogscore=836 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211050011
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> --- a/kernel/rcu/Kconfig.debug
> +++ b/kernel/rcu/Kconfig.debug
> @@ -95,6 +95,16 @@ config RCU_EXP_CPU_STALL_TIMEOUT
>  	  says to use the RCU_CPU_STALL_TIMEOUT value converted from
>  	  seconds to milliseconds.
>=20
> +config RCU_CPU_STALL_CPUTIME

Since the information might change and grow over time, consider
calling it "ADDITIONAL_INFO" rather than just "CPUTIME".

> +	bool "Provide additional rcu stall debug information"
> +	depends on RCU_STALL_COMMON
> +	default n
> +	help
> +	  Statistics during the period from RCU_CPU_STALL_TIMEOUT/2 to
> +	  RCU_CPU_STALL_TIMEOUT, such as the number of (hard interrupts,
> soft
> +	  interrupts, task switches) and the cputime of (hard interrupts,
> soft
> +	  interrupts, kerenl tasks) are added to the rcu stall report.

s/kerenl/kernel/

Those parenthetical words are not grammatically correct, and
nobody will remember to update Kconfig if they change the code.

Try making it is a little less precise:=20
"Collect statistics during the RCU stall timeout period
(e.g., counts and CPU time consumed by hard interrupts, soft
interrupts, task switches, and kernel tasks) and include
them in the RCU stall console error message."

...
> +
> +	pr_err("         hardirqs   softirqs   csw/system\n");
> +	pr_err(" number: %8ld %10d %12lld\n",

Everything after a %d is a "number". These are more specifically counts.

> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);

Two columns are plural and one is not.=20

Within a few lines, this is referred to as "context_switches", cws,=20
and "task switches." One term would be better. vmstat uses "cs",=20
pidstat uses "cswch", and /proc/<pid>/status uses "ctxt_switches,"
so there's not one ideal term for that column. Matching one
of those might be better than using another unique name.

Since no other variants are shown, the "/system" suffix is a bit
confusing.=20


> +	pr_err("cputime: %8lld %10lld %12lld   =3D=3D> %lld(ms)\n",
> +		div_u64(cpustat[CPUTIME_IRQ] - rsrp->cputime_irq, NSEC_PER_MSEC),
> +		div_u64(cpustat[CPUTIME_SOFTIRQ] - rsrp->cputime_softirq, NSEC_PER_MSE=
C),
> +		div_u64(cpustat[CPUTIME_SYSTEM] - rsrp->cputime_system, NSEC_PER_MSEC)=
,
> +		jiffies64_to_msecs(half_timeout));

There is no column header for that fourth number. "half_timeout"
might be good, dropping the "=3D=3D>".

The "(ms)" at the end is awkward. Try moving it to the left
as "cputime (ms): "

> +int rcu_cpu_stall_cputime __read_mostly =3D
> IS_ENABLED(CONFIG_RCU_CPU_STALL_CPUTIME);

As a config option and module parameter, adding some more
instrumentation overhead might be worthwhile for other
likely causes of rcu stalls.

For example, if enabled, have these functions (if available
on the architecture) maintain a per-CPU running count of
their invocations, which also cause the CPU to be unavailable
for rcu:=20
- kernel_fpu_begin() calls - FPU/SIMD context preservation,
  which also calls preempt_disable()
- preempt_disable() calls - scheduler context switches disabled
- local_irq_save() calls - interrupts disabled
- cond_resched() calls - lack of these is a problem

For kernel_fpu_begin and preempt_disable, knowing if it is
currently blocked for those reasons is probably the most
helpful.

