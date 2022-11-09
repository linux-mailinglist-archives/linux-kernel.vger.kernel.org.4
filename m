Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459AC6230DC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiKIRAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKIQ7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:59:44 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC6B2FFCD;
        Wed,  9 Nov 2022 08:56:28 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A9GhxHu009605;
        Wed, 9 Nov 2022 16:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=TBrkBY6oTcdeMiHZ2OVdDGY1fEdvEW9ai/PFOMZM3LI=;
 b=hnuy+fgFFk35D26gQC2ofAPQlFAQFfFIsFwtoC73UViYv6WiTSlacuj4wA8JT6AB5Jg5
 ZkAAJyGStSg2phChrsoSLemCjVpDyaCNRqQpJL3lZj71jIxcd813Y7kt7rNEgA1suqtR
 5czm0G0vHIzDGnXK3gHdNogNmCQcFMs88zNQyvSmOMBtca8wN30B/LmsNt2IeDsNtbLj
 S0OhXIrMB6YEmJrRP8rnSegWAbwPP82swwhVEa6K+o5iC2Yad7rGaq3Z1rP4lyEPPuZW
 dQx5UC1ET0sjEt+tDVcE5Df11n58+hwHCoVLxz6GwTEjvzRyhwX/CPGT8SxP9mCM7M2g +g== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3krfyw84h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Nov 2022 16:55:56 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 43B55806B64;
        Wed,  9 Nov 2022 16:55:55 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Nov 2022 04:55:47 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 9 Nov 2022 04:55:47 -1200
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 9 Nov 2022 04:55:47 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbkUQl7QDSET46nojFF3D4hGzACb/sMqS68yq6r6BEZ9P8fQdw6+kjn9X9Trtt5qwR5YRiT2s3UjNd8eUGFfFPzQ1PPMJr9p8cdswOG93cuKzfvikEITBHiozeOMlc7nl9TWvbTUS6rm7nJRm5wsp6Q/A6l3ajViCiDDY8lAQMMGGeN03Vwf0zIBL1zJaiYjiI/ND7by+RvDWWdPmryfCxBt1pCFdG28e8N5jn/v/JYa+gu8nserXoYf8Ywltiwlz3LUaMMRy+TXSgG4HpXQe9DBkX6mr9i7Ej/KBvfLxbYtF8oodTQVTZenB0zZxlx2ngNhP6Ej3OWt3crTYZLYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBrkBY6oTcdeMiHZ2OVdDGY1fEdvEW9ai/PFOMZM3LI=;
 b=Uki0ALs0xQlUbT0cRP97PNlNQH6lh8JfcikrIkQyI/Vi5xDbgeirq2rlOsmRkrb3ZTsWiMPOj7g6vkt6rcmyStesWDLllMsVu5PpMnXh/KE2rxGl6sKqzmXOrz9QZzDBWI4q4wTUiFAy+5x001TCnL1mvCm3aH6TdJav81PfWjlhc2BFCqpvdi8zlne34tfH0YWZywInKcYvhKnn5lld5jjm/DtNPDchIf7SAVdolIUDcJH3go198oxmskrVfLRCDEGYXA8cf7Ro+45FmTHBvsIvOuoG+7wweivQVH/izrdDCz7qAqonTG1tfrjR6O4JJao9PxBTM9vIU8wWnoTASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by SJ0PR84MB1578.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:430::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 16:55:45 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 16:55:45 +0000
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
Subject: RE: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v6 1/2] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY9B8WepNC0ic5WUOW0S7L17lcwq42zGXg
Date:   Wed, 9 Nov 2022 16:55:45 +0000
Message-ID: <MW5PR84MB18423CA291ABCD3DCCE3D416AB3E9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221109093739.187-1-thunder.leizhen@huawei.com>
 <20221109093739.187-2-thunder.leizhen@huawei.com>
In-Reply-To: <20221109093739.187-2-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|SJ0PR84MB1578:EE_
x-ms-office365-filtering-correlation-id: 6fc19540-c7ef-4912-1f60-08dac2733ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 587u6sr6Bya1QtYX6+rrkn2RyqpDTKj/bYu9U/r3/2hstDg4Is14FQesVN+1s1ENgPLoiB5CVVTGTb81hg6cyfaaXYeBfoIm7lwti/+PpM0Hqzrm2Gajy0fEBcFwuSdc6XzKLLeTstnGrd9XNnVNs6ongNosvNAWQrte/NJEow2kalvFL20BGuxctoJlhYZAvxHaPEIWnevViOZSV9n3XhWQoVvEzpjL1QuXzuFsXQidBCZjPROgqy4qrAsSjgjECcPKePJ0zjqdGlH4MAvG3mqZP8OI7XXQRBbfZy+P+3b671XF5D5V4UZ/Kz1ADZ/y1AmSvay2s1H/knwmYKscVCU1jrCwAafOCyVFZNoCeCWpToj1V4h/u7gVrp6+UGpTNvY7lNgiHcZu6V+BjJqCNvfM/stoCX6tonzWUfoi3ZAT9yWEU+ITDJA2bzYsxPkh/yGemoUXfKzVw9uXEkSikCTHheEovbL2b/Ku1LlgYDY2NvDIfn1cQJ0fEGbmcEQz/XRX6Z7w5UAtIAnilcNlDUyepaG3WoyRrwn59Y2XWgMk3oyXutcmL7S1sbHNIAm6UlTtfdiZHuKyCkXqnS54J+o9OH/xmIIbMLA8388vh7AVQ36d3FTul82Wuovjh9AuuHc0GBBkvjVh13r7r0OrSWlgdYVtuCfZyjLz2NihwTKGEaF2y9Dw9Aq+XdWxmEYWuWyj1xiB+qtyj4/6nozbVM//VhIABq94fXjxyynxTiX8b1rjaeYi7aUOplrlsfV6qyNfilaAarVOmkas1UPnYGCKLLV6YxM9hzBQyfdwsBE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199015)(66574015)(76116006)(66556008)(9686003)(64756008)(8676002)(66476007)(66446008)(41300700001)(26005)(86362001)(5660300002)(66946007)(52536014)(38070700005)(2906002)(83380400001)(33656002)(478600001)(82960400001)(316002)(122000001)(55016003)(38100700002)(186003)(71200400001)(6506007)(921005)(8936002)(45080400002)(7416002)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?09Hb/4SrmG3ep3VeqwGcrKO5iB3Uorhi2CJimf0GmnPTjXOdPERYA2+bcCqD?=
 =?us-ascii?Q?2yKp8DAQaWYRze1jsPTIXWBYNWHGA9QJflmBWN2xoXBSvza0Su0KrRih2ugk?=
 =?us-ascii?Q?8w/gTfHqzpVIVTO01E+Gir5yrEc27TdozPW6IVdhoyRt8bHub9PKY1M9Y5WH?=
 =?us-ascii?Q?rVEHbQw4pb9XpDBrd8LXyLePChl9qyXtcGaoi2Bh1AUq4P9hj3ypDHTYG6/v?=
 =?us-ascii?Q?NKDCsX8MJF2b8uzx9VXX6CfIU5jK1hEckybJdOdgSycMByTiG4w6sfSV5o7+?=
 =?us-ascii?Q?Mk44w58dcw/0sNS5TNLgLHsUnxFceVaxk0Nagw/U0dIV5Zm0Sw/l3X/CBMLc?=
 =?us-ascii?Q?soDUEtYJcUZSmnRfHhcRCUYZ8OtgJOsc0WUMw4kPvI+rLtnZVUyu8jcngtTJ?=
 =?us-ascii?Q?81MJW6Hueu7teYoncjd1us3uR42zoYQbBBochpQQjtHfcMMLPQyc3hBKWWVj?=
 =?us-ascii?Q?NLrrClSZaLr5IcqmqeJyCyHjXA9OE1TK5b9DoVZ3RSCZr3pJ+PycxIZc6q74?=
 =?us-ascii?Q?cQ6NhndHItJax2RKF38ze3ZuDIDIXK+HjlFepMiCAbFKOHl5JYiZbifFp888?=
 =?us-ascii?Q?yMNIKudmoAGeB49HNuaTS3B8psacM2HrRtBceqJ+XpYpaI5XMNFncbq2GlI5?=
 =?us-ascii?Q?N7PbVO30Lsxs8eKpeJqEBqL+NZYg0GTcogSHRAIr9QfR3au5zN/Cp/XrdCLx?=
 =?us-ascii?Q?4Zy8VUYRwmJH6TGxf03W6qo4qCIw7XVC+53JGC7XmNzgwv7suED/n6JbmnNa?=
 =?us-ascii?Q?O2NYBYYu7g15oDqKkrRL/KYSRtVI5p3RF212quVXmd9B3F7u8/gPvFgyhOgP?=
 =?us-ascii?Q?A29muGmPumY2o8Us8QKzFXmIUdqFHVyQLjZESxw4pZp/sAmUjOdorAonbNdA?=
 =?us-ascii?Q?DpQpTNhBRE+SDNmYsNoQG6scu3nwXrrrouBTiXYrzusNqztQq713Xn/oj4/R?=
 =?us-ascii?Q?ggHu8OYjDSR9GZj6Kgrs0mSFgqsxmqn4dbk0u/4A9oWEgi90FZNsooNjYPtY?=
 =?us-ascii?Q?4sHCQNvon9Bu0CrCngw6PyeNb096Q3newl1S7sTSyOLQ84JdWi8R3WRIUp5s?=
 =?us-ascii?Q?rK3Dt4fFNL4b/etT6KK4HR0bkp7dt9cU9GjDpA96TdWomoVqx5D6/PzDk99q?=
 =?us-ascii?Q?JsVFB1qwLdbbltvG0DwSfMC4VgWPoM0IcLEaP7UN1mHEoxMz7idGM1zM923I?=
 =?us-ascii?Q?nNzolyW2gZ3C0jQTMQeUzIUUkkFYJzuLlvn57yBx/k7qovz0OfjZ7Erce2ho?=
 =?us-ascii?Q?goJnYBxepM2A6RjqM48kTEq/IoygQSW3nZfBD0X76sRbAT3GVDwmOnhni6yC?=
 =?us-ascii?Q?wZ7VEwl5Q3A3ef/I3PSrQ92DgriVqM5y0jHZ+mDMgDSDLXxnFSfmyWNyUdDf?=
 =?us-ascii?Q?gEeHj9ZL9M09Y4bilc5EPFMeG92GozV52g0sf8Q3e1VveK8RCJzTSaQomZal?=
 =?us-ascii?Q?S1NQjGwVDr80zc2ATG/BV3Uy6ZZAm9m0NN1llVBnRhS14TEYnNFMEbRD/sll?=
 =?us-ascii?Q?c9WI6fAa9f3citNwuyB2hKlmLl3U5r/z/nx/vloUrHsWQZHE8+Me3emV2hCl?=
 =?us-ascii?Q?PzmFKW/tIXrjjBA/uek=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc19540-c7ef-4912-1f60-08dac2733ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 16:55:45.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SM5bBlMlUVbTHQCpLEYm/jftMLo87iM2X5WoYPZMV/pysX7TYvolxPJyRuagNvAg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1578
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: z_tCc3DipiwOie03yKXrOf-wUF8Wxe1K
X-Proofpoint-GUID: z_tCc3DipiwOie03yKXrOf-wUF8Wxe1K
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-09_06,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211090128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> b/Documentation/admin-guide/kernel-parameters.txt
> index a465d5242774af8..2729f3ad11d108b 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5082,6 +5082,12 @@
>  			rcupdate.rcu_cpu_stall_timeout to be used (after
>  			conversion from seconds to milliseconds).
>=20
> +	rcupdate.rcu_cpu_stall_cputime=3D [KNL]
> +			Provide statistics on the cputime and count of
> +			interrupts and tasks during the sampling period. For
> +			multiple continuous RCU stalls, all sampling periods
> +			begin at half of the first RCU stall timeout.

This description should start with:
    "In kernels built with CONFIG_RCU_CPU_STALL_TIME=3Dy, "

Also, that parameter name seems like it contains a time value, but
it's really just treated as zero vs. anything else. Consider renaming
it to rcu_cpu_stall_cputime_en or describing the values in the
description ("0 disables, all other values enable").

> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> +struct rcu_snap_record {
> +	unsigned long	gp_seq;		/* Track rdp->gp_seq counter */
> +	u64		cputime_irq;	/* Accumulated cputime of hard irqs */
> +	u64		cputime_softirq;/* Accumulated cputime of soft irqs */
> +	u64		cputime_system; /* Accumulated cputime of kernel tasks
> */
> +	unsigned long	nr_hardirqs;	/* Accumulated number of hard irqs */
> +	unsigned int	nr_softirqs;	/* Accumulated number of soft irqs */

That should be "unsigned long" to match the other patch


> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> +static void print_cpu_stat_info(int cpu)
> +{
...
> +	pr_err("         hardirqs   softirqs   csw/system\n");
> +	pr_err(" number: %8ld %10d %12lld\n",
> +		kstat_cpu_irqs_sum(cpu) - rsrp->nr_hardirqs,
> +		kstat_cpu_softirqs_sum(cpu) - rsrp->nr_softirqs,
> +		nr_context_switches_cpu(cpu) - rsrp->nr_csw);
> +	pr_err("cputime: %8lld %10lld %12lld   =3D=3D> %lld(ms)\n",

Those should all start with "\t" to match other related prints.


