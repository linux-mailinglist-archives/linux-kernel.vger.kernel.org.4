Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252F8610116
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbiJ0TFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbiJ0TFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:05:13 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DCD213F96;
        Thu, 27 Oct 2022 12:05:12 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29REKeI6006133;
        Thu, 27 Oct 2022 19:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=lrV3Aoc1dwf7a4GMAKRHKYwgG2PLJ9jeiLbyYnRyg1Y=;
 b=G9JS0qe4nO4wXO5Pvz2YI2P+moAEzTleMvOk22UZrqZYPR+BB8vSh97uS2bkem9uofGw
 ivPaaPNk4n2i+wNARL6UJbGIJZHYetO09liTH8WBwgjwZBRv3xQaQhBpZHw6VxSqu/Ht
 AU3I0tnNLUe5+s1yoWt3cE4Qf8GxZgj5/lLPRSgCy0vqvI3MD/jt14sqRGrPo44A+ySb
 G87IkQpJ0aLtin0mSCgcShADKGK0SsvuCKEHB4QH2yvQLaxFGiVgCLfV9jl4LXnf4m8j
 cQdxUypFYwICkXt9bzjK/DAMZ7KNDCCuTqeqbnWBrZK+Yx6kNYIGaMA7RI5OlzpEiTVz zQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kfunptevy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 19:04:56 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 84B4F80470E;
        Thu, 27 Oct 2022 19:04:55 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 07:04:55 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 27 Oct 2022 07:04:55 -1200
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 27 Oct 2022 07:04:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxSBa+1sK2HDe/U5gvOVyA8TOqan6d4N5iU5cT7ezZvoY3/w4xGmP22+az/2p2X0ikZoSCO5uQdjNvHyydboOXOSc0/c7eFhXz4YdBZt1KEbHmUCO0GYUbu+E2ITxixoKlAlhhP47oqOdq150BtE/tQlX95HLObZyNAblhsDiLlGleFVhR/h/wepfu6KhPod7m3I8VXT2kikXUT7teRwqnJLkyHYmwVoHclv9T63+4XrhcG3e91HMTyf5P91LqHM4XCsv6Ggecqa/73mTd9Aag15HjOf+s0q4Eujo0cJkOd35AqwLe88mBk8GG7BuB4KEo0tlFxgjBYudKYSCwLmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrV3Aoc1dwf7a4GMAKRHKYwgG2PLJ9jeiLbyYnRyg1Y=;
 b=SEJK8SWr3JWK3AUnYMK5b8iFb+mj1AnrOO8PE+npx+Yb8qd5LelXlbMK6odt6gYm8NOvrUfMk+8abFRoLMU38Y79MvFn4WBmrOHoIX0WGSybKvB3XlotgA5gxJcMNz4bxldtLL/6pZXhluE/sJ3/hsmNiT5K4OurSSAbv+RNn9vfUV7rnXTwgzyBL7FifDxT+OPHQI5IxSPSjXK8EEQipFSiLjTCPnYisICGIffc4US8pbbwFmw7CZk1wpOEcTE/5u0c54qpYMJW0eF2X5LWKb18YYZa75OrWuEfwfHtu/JnFfeScAeqaMMIh93Du6ZsNj6oFrIfiiGhxMYcl1Rc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1782.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:04:53 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c023:cb9a:111f:a1b2%5]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 19:04:53 +0000
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
Subject: RE: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
Thread-Topic: [PATCH v2 1/3] sched: Add helper kstat_cpu_softirqs_sum()
Thread-Index: AQHY5hRPGohirfZ+NUCi6rPTBZAIq64imQUw
Date:   Thu, 27 Oct 2022 19:04:53 +0000
Message-ID: <MW5PR84MB18423C3F30D3F789EB48D0A5AB339@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221022124525.2080-1-thunder.leizhen@huawei.com>
 <20221022124525.2080-2-thunder.leizhen@huawei.com>
In-Reply-To: <20221022124525.2080-2-thunder.leizhen@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1782:EE_
x-ms-office365-filtering-correlation-id: 5589bc8c-b604-49b9-257b-08dab84e2189
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skoPz/RAQjowq/vJOikFci7O4+stwogjF4G65CnZCFeJSAsvi6LtAVKUdoDcCRKcovu69c3DTgDKsb/eOH91SAeiJHChNS9BBlNoR+M+9nh3Vlar4+q4WLDTLcZ9tpCGGTehnIixtWT3QhK8tz7JldAb3ZvOZY1H6O3DZVZpMt3Whn+Wf1a5TlYwezfBvia3Aq+J8fZCLJ3EFx7+xc1bKq9hdAEhk2nHvU6HEDgwYNA7KJdUR7lXBKr47ZgY3waTPC6pK6WGseGEu7xfNGB3hM1L18AP2DUjy1jFI7eFK+5FaOh+NwxF6WmfubDAKoCCOakLZbWeNjm9gNzormNQQyo9P5kAeb7p0uj9vVNjezohqKS6+237rnjYInDA/juQdHYKq/TM/yxJZCz+otgTjIiB+SrWk0R+hgGrZoHBMkEBNRshn4CfZbAenFd9gyVyhpBDJlWr7cMjsq+V8CdULoegoSVhhglmqXlMfUdp6wMOEz2Cf4UxCsnhLN9KvT14WQiHVGc8tYQa0H0QaXpKaMwQTYV6LumiWBYlcQVu+Ea6BBRCjbSTYh7tO2QsaH9maE59TPZEz817lnSKIaH9XVoQS+9d/TrtfFie5WTH7xPWZ1T9SympXd3MyXov8X+zVdnB8KX7hYkJgf3dCWee+XWvHexNm8W+Cb9AQkMwTksXe1oHLkYXCYgdyFjHmRtoL4lhJNWESX8xN+PRU02QSOY2nzoBBIpc73Z5X/wGKEP1Lr4IkTXkI0o069IeZoo67J2+ouB4VLwYvYVM3Kn2M3kczewKpyKnlXUZXDkLjME=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199015)(71200400001)(7416002)(186003)(478600001)(38070700005)(316002)(110136005)(82960400001)(8676002)(33656002)(7696005)(5660300002)(6506007)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(52536014)(26005)(55016003)(8936002)(9686003)(86362001)(2906002)(122000001)(41300700001)(38100700002)(921005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kZNNfs0LZBFm6myslkVDvuLJ0QHVvE7UFv8Aka9/gYCaQfGlwETgFLE1Ut4G?=
 =?us-ascii?Q?ssngPmXEsA6NwmW2b6Ibj6213Uh6czcascxnEqqlmkQfhFgcqWwRsbPC+9UP?=
 =?us-ascii?Q?BCaTGSZGOVykSINeobuZIHICZNQNGzPaZ51dNMyYf5G4ZL9DYKd3dN2MieMJ?=
 =?us-ascii?Q?BwYzNwPPtekZ6UD2zMaWIu+KdFirAzTMjbLRFUpq0jh8Hg5X1ZMIIOucYKNc?=
 =?us-ascii?Q?KigdTKGySuHakkc9ZirTiIt9/LUQHYQBBdYO2/n4QTP+vPruAUmEQ5vuOwKv?=
 =?us-ascii?Q?HFsNUxfNQbVsAo05F97nF10fejrK03KAaTwofwFFrduNnM2S4HCpVEyVxiQ4?=
 =?us-ascii?Q?nGlGa5mK/FwIjUZV8o7uqH3ZJvqMwmHOoICZF33rG72rDpbCavzQC5+kn3zN?=
 =?us-ascii?Q?W9/s7NCehQARK2u98wBrytKSzHLmk5nDYyMHvEiiZ+lOHe7Z8guGmWqYql0q?=
 =?us-ascii?Q?sxolubTj7j9EqMsPYeO/HW87ng1F87tgJkUsKngzu1YvY2K2TK3rrzX8aAOl?=
 =?us-ascii?Q?/L+qEheWDzsSAm+q7reRgcuyFDybQJCGfFXT1O7H3/xx0/QkfPxV98GAJqeH?=
 =?us-ascii?Q?l7MLNqIID/KLe10vXiuSttpYKlky1bXR7Vlt8D5RQULexMXaaOKk0iYRh+Ig?=
 =?us-ascii?Q?GbNVolrddO0LzK8R/RhjefBECYuldabEhVrYy7Xiz7oXFnb02zUelDkfPefL?=
 =?us-ascii?Q?+T529wO0qKgr7bb5WXclYFu0YbHItP8LivG0sq898WSxvq5mSDNZEBIcjmCH?=
 =?us-ascii?Q?qrFjh76audishWelZg2Y1yvbNXH+srl44dzLFdvCeEW5Zz7A7hNkA1+CLBp4?=
 =?us-ascii?Q?IZrHULHdvnnI6U6XA/JQth3jQeANOBmfuaMVDaEqaIIjXZ0ikLUmQuU1Qly7?=
 =?us-ascii?Q?3TFOGEfdNb0Kzea2HdRI3Wd/r1wme+EOcPK0PsJ09o7tbeomfc6YrF5v3prm?=
 =?us-ascii?Q?9IyTR/8ZQz8Piq+YeTccCSQMyzvFMW98zbebXGaSSZX6Azz+ZIneZjtnSXVb?=
 =?us-ascii?Q?z0NLYNMhhp2qFXsaeHIsIIssW1bhF7S2bZPA4E2XxhB8Dp5uLAIyk2fKMbr0?=
 =?us-ascii?Q?6X4y6cstQBdgJW8aqgXEyACOsoW0I9q4TCh6RWRoZjK4IMM5nM9SZ8QqynCn?=
 =?us-ascii?Q?PNtyAugJz03nf4NQ02/mFJ7DblgA9FTCHB8F46Lmk/wfflf3UERutiG7VjYY?=
 =?us-ascii?Q?i+3of9HjV5bAbOd+AovWlckKmxbEDYcFUxEgS4F4LJB6F2z49qihwGWPRUde?=
 =?us-ascii?Q?bSpX4UJN0OH7rcovhRyBXtbUBdrKqSvrhM1JYCv1yZya5YPpz90NIxdElHfl?=
 =?us-ascii?Q?ubiKGCzx6pXNHlWWYLtuBm0vk75InBS8Zen7jT9xi0nb48mBSD4qkpQaXslW?=
 =?us-ascii?Q?4pAHV1ob2R1YIyFedkpMxl5oCFiRI31fv4wZJw5VsIZIF+S2ZzzG1ujTejt/?=
 =?us-ascii?Q?m7zAm+n9+oPoAlr4RLS6lEUzMIDXUmY47MJAZbT9yZci0xVGudjYpKlhhO7a?=
 =?us-ascii?Q?lkVVU8pCpFSribyybu3oGSGxmoFwvmx81ipf9Lx0AEIjWKrQ2MTk9v/qbEtt?=
 =?us-ascii?Q?IOnLpPPfw/WCMN0onFs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5589bc8c-b604-49b9-257b-08dab84e2189
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 19:04:53.5473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qVHiTpPZKuYaupkRjnrsKcQfr/JesDnWSaGBt4sc9of8KHzZOMJ7jeKdLkB9tBZ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1782
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: xQz7ykjYaBPxWWw3ZXBmCAwmTA8tn1P6
X-Proofpoint-ORIG-GUID: xQz7ykjYaBPxWWw3ZXBmCAwmTA8tn1P6
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 clxscore=1011 mlxlogscore=710 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270108
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Similar to kstat_cpu_irqs_sum(), it counts the sum of all software
> interrupts on a specified CPU.
>=20
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> @@ -67,6 +67,17 @@ static inline unsigned int kstat_softirqs_cpu(unsigned=
 int irq, int cpu)
>         return kstat_cpu(cpu).softirqs[irq];
>  }
>=20
> +static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
> +{
> +	int i;
> +	unsigned int sum =3D 0;
> +
> +	for (i =3D 0; i < NR_SOFTIRQS; i++)
> +		sum +=3D kstat_softirqs_cpu(i, cpu);
> +
> +	return sum;
> +}

In the function upon which this is based:

irqs_sumstruct kernel_stat {
        unsigned long irqs_sum;
        unsigned int softirqs[NR_SOFTIRQS];
};

static inline unsigned int kstat_cpu_irqs_sum(unsigned int cpu)
{
        return kstat_cpu(cpu).irqs_sum;
}

kstat_cpu_irqs_sum returns an unsigned long as an unsigned int, which
could cause large values to be truncated. Should that return
unsigned long? The only existing caller is fs/proc/stat.c which
puts it into a u64:
        u64 sum =3D 0;
        ...
        sum             +=3D kstat_cpu_irqs_sum(i);

The softirqs field is an unsigned int, so the new function doesn't have
this inconsistency.

