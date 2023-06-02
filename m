Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22D720ADF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbjFBVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjFBVME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:12:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52819D;
        Fri,  2 Jun 2023 14:12:02 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352FVcl7006336;
        Fri, 2 Jun 2023 21:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : in-reply-to : message-id : references : content-type :
 mime-version; s=pps0720; bh=GgxkIc8AuetCQyYW/hjX1OEHhwPNHxjn0k1YrWEvyGY=;
 b=GCYEkAQhr716X/DUgoBF8qOW3pw7ifCBMyEXmU5uytL9KqPENxs//mwFyhPdA2mMDdTj
 HcGDZzudyqWVtqk7CNZqO+IWnQ7zSUFMJqsmkKtOEX3rN9CP954VlUw4Bzid7YZYiRzi
 k9ouWTEy1x7yJzYP6bidtn91BZlGtFXDikmV+v6f8LRSefsbrzLJkRBKZL/Zbpuy2lg7
 95yj0CSPqfOR0L7V0QqLXJg8vLQgDyyVzGzM4vpXTtw2zYSQlIS1HzKRkmsdwHNlFuMo
 FRcjLpScnVtYYYBRHHDzNdlvAikgh6wcmzsx2t7RLYycJfcD2xdk6lNQ9wNv8Fk/huct jg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qyh9ruu0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 21:11:49 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 22852804DED;
        Fri,  2 Jun 2023 21:11:48 +0000 (UTC)
Received: from p1wg14924.americas.hpqcorp.net (10.119.18.113) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 09:11:42 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 2 Jun 2023 09:11:42 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 09:11:41 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEHo8AA9IChTk7zhJNn2HdbeXn+ubH4zRZfkHpE8zC9fXTjbpIVcrVSHeVXovjHTvsyz1rOiasszG6WTdEfRhZ58JLN7jNCQ5qgMEUSGRb4bCHfkOOg2zHzJJNCnbnTk3mS/GAe6LNzdbOmJNrzBLK86rsSAUfnMpMsatYQm3NET+SmzVUopT2npTqnfZw3BtKej+7z2/tdw6Cwnh1fUk5saO6kJeLWqbt9sFHAXn/qVUdMsJQfm30SPbk6Tud8GOs4vbOJoFelVDeyxTbuHjiWuyraOFforfUwaC5VD/cxZLA7Snx6narr5lU3x9ATNJpAnXOylsRW1CHzmtd56Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgxkIc8AuetCQyYW/hjX1OEHhwPNHxjn0k1YrWEvyGY=;
 b=S7XLufTZe2QbFIwLhFCL2/n0AXiOFtF88WM2/sx9x8sWOK4HkhG52dH9B2NpK7aDza1RcBaJ50+EfOeVZaeuPOnx4zQUq2b9XQpyta03+oSOUThRCPyX+oy9INixcU59MiAEbwydFy9Oak/F1ReQOQqW8O26heBcJtTibe5PhIHdvZBKASdXu2Bcjlbtu7D0O/lctG7Qb67TeLeQbt5gz8qskNxPErjoVeTh/2RT4ZzWCt8OH0qTcnmPVQp5iZ7VQONmtN6Sv1qHpLBhm1LRjTZmzeYZVNRla24UGjlaEQIR0UIuw3mEvzmQiJJvj1iTigz/+sm3DDnddkrQYR25lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:12f::16)
 by PH7PR84MB1485.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:150::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 21:11:40 +0000
Received: from PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e410:63db:c8f3:39ef]) by PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e410:63db:c8f3:39ef%5]) with mapi id 15.20.6455.027; Fri, 2 Jun 2023
 21:11:40 +0000
Date:   Fri, 2 Jun 2023 14:11:36 -0700 (PDT)
From:   Paul Cassella <cassella@hpe.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     <dan.j.williams@intel.com>,
        Yongqiang Liu <liuyongqiang13@huawei.com>,
        <linux-kernel@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <vishal.l.verma@intel.com>, <dave.jiang@intel.com>,
        <akpm@linux-foundation.org>, <joao.m.martins@oracle.com>,
        <zhangxiaoxu5@huawei.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] dax/hmem: Fix refcount leak in dax_hmem_probe()
In-Reply-To: <647a384743e5d_c35b294af@iweiny-mobl.notmuch>
Message-ID: <3cf0890b-4eb0-e70e-cd9c-2ecc3d496263@hpe.com>
References: <20221203095858.612027-1-liuyongqiang13@huawei.com> <Y4u2TK4yPU9dfiDr@iweiny-mobl> <d0819e2a-f584-3287-61ba-88ea78a9885b@hpe.com> <647a384743e5d_c35b294af@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:12f::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR84MB1389:EE_|PH7PR84MB1485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bdc0f1b-e2e3-48e8-cc65-08db63adf523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfhWN4Auv1CfaIP6T6PAKtG609oOYNfI/4kM4E/motqWK59tE5cblN7fnKhXgYM4YvetuSxJGqyTUM9c+NPGuExxf9rtULduDjXfb8EmU+2z1GyppdcKpYN2rKLoeFyABk/lRlRagML7nFMVRNt9/ZXY1L0oVA8UrxmIhlkJc8nqIliVffdfTvO/f31Rt4BNlY2cDjlgAZQgjZsUl8/dAP8XZpdh3psV/adomeZPDUjX2okcMOXJyAQLWg9LwO5WtyWLTstyUWO0XdBkT7RMwIjTWmvaVSqLIj//fkmNXmCwzzpkOTvXph6DLL+KqIEnwk6T5XcyV3EfK4XttiZBC3/Pq3tP33dqyNr80TmbqvpH8FTebxByHEVSHhpgp78BPZftj7viN1Z5KfZjCyDeanvbEC1fTibzd824GGmZiQ3cxZ6PwusENZUWJ8J4rZvTdNX6PRjnel30CX8UI65WgufoIVD46rxhJafwPD4eLM3WvFEfkBzqJMmNdyGfjDEa+IXAX2fGtloxCqJfkFrfsNwJlfc4RTctvXbfyzRcXFrJ2tDwYbHBP4WmMlWWye34AXPxMh1ooMRgxvUdvMk1gEn1NkI9Mu8LfJT7gNarAzRQ3HGMnunREg6OzbJFBfFx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(38100700002)(7416002)(5660300002)(8936002)(8676002)(6486002)(478600001)(316002)(6666004)(41300700001)(66556008)(66946007)(6916009)(4326008)(186003)(82960400001)(83380400001)(36756003)(66476007)(31686004)(2616005)(31696002)(6512007)(53546011)(26005)(6506007)(2906002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MoeSU70lZDtrWYv7d/siZC2U0IsjGtb8m9xmVKzqcV4nER/1xBh8oU1MS8ln?=
 =?us-ascii?Q?k3eGosrvm5LqDBEROxCiufoU9gNrRqo8InDyEJOe/ZkAHK9Xs0jZpDkKZVJ4?=
 =?us-ascii?Q?sScpAeW8LoVM1seslSx1DgTBWj4x6XR0IxKha83uaeY4fMvqNXR2AwIIcZv3?=
 =?us-ascii?Q?iTUxaxDtBoOOtlKb9027tiMTaeaZDXeVFrknG6ndPhyCsNUhKYLiYyNho9HP?=
 =?us-ascii?Q?0L028ew+p732Uh16hOfyIKTg7LNwdqOLleCy9a/I4+P26wbPRx7YGgVqKRcT?=
 =?us-ascii?Q?SPmHbgi9bb18mkg5+lsHpdaNC7IpNSPzs1I7juAkE+gOaGrmqUKlGy6CqKrv?=
 =?us-ascii?Q?JeYIQFhsxqWMoxsPTscJRiT9h4KfbDu0vou612upwMWsVvSAbkU6EcIZxK3+?=
 =?us-ascii?Q?ukWJhM0ULAbvqVbKGfGrzfp4Q0vF/GGiZK6MKuivBTlhLaHrgS9TjGKFavuu?=
 =?us-ascii?Q?4riz1QS7EzKRwaap2Sc3jnlnN///JWzX94EmP6SM005VZBqhR1EvRReoyy+x?=
 =?us-ascii?Q?w8OwHnsD29Q3TMIcZvWdoPuX8sWnQIWqDb6gCc1d8sgBew1oUMgREEtD81sQ?=
 =?us-ascii?Q?Z+VXoc8IZqj7RHsBxLtWhfZqhvEFcIIhug5+Lwq3c2F9J94WpzNa/AB906Tg?=
 =?us-ascii?Q?hvxbocEQiqeMTRHaZMW1gDqqCwa8dUm0Ksuik9MXLCKWENzAb5iDFeJ0p0BF?=
 =?us-ascii?Q?2kGxhkqQMmbJxQUKKm/1XAshZAzb91iLiUn7P6+MWgKjQZNwi/jDhy0fhT4f?=
 =?us-ascii?Q?NnGykewmXuunvOYwG9wci1co55kP9jpluPieD96UTNqPomne1+j+meuHf/0o?=
 =?us-ascii?Q?mLaoda1XdLrD80c4XUwmsZW3rxE8yOjJ+duFNIpno0xOmU4iDkoZF6Rky1Fk?=
 =?us-ascii?Q?zBABUOQ1ij+x8JMSwnODz46yW42xHfmg7cDJqYqAaDszn1cY4E2nG3jisa+d?=
 =?us-ascii?Q?6Y4LqufdFz1tuHlv/mBZVIkhM8MqDbjk7KA4qtRXuYA0p7+v1IvK46IAY+K6?=
 =?us-ascii?Q?x+kCT5Ts3t2SN1ABTYTivIKkT2VAiPNvW69H3NheyDjYEqE+ZgeJBP4xA9i/?=
 =?us-ascii?Q?LXLIQR572TlO4WUqga8Sl5hkcLzuf17RDfMYk6HViqeaWwvtEH4zFw1mLXt2?=
 =?us-ascii?Q?9w526h1XpPp6wKJssDW7UQOjjyDnUuxBqYP3VHzoB9qoD0oeZuYa1/CFLGak?=
 =?us-ascii?Q?HVJGXSytcyfl6WEHTXTgbRm0V3xzJ8hx7+iGfRPLQIg8dqmE3dAQS+6xBXfU?=
 =?us-ascii?Q?gGEF6IUopK5tjERxNK8yu87iPYJgXfb574SXYu8zUaBC8xDlkuNl27TKYmzi?=
 =?us-ascii?Q?nCQVhXBJDUlG5f98gP3ogbC7aELnLniqz3pWHNSF+AteRsooXseCPZZiDkLp?=
 =?us-ascii?Q?TWW47jUasa0/s9tYVbL8d5cCvqFtFLjYuIo25nOk7trj9NI+LYqK5movkX80?=
 =?us-ascii?Q?qYNviDdCPd/7w+Ss91cVnkvkEGuz93GlaBTJhotgJpgqkuh4aQt5goRSZOoM?=
 =?us-ascii?Q?YPgsx+R7+Znp1q3e4HtH2enPb1r4AJl8ACJUEcw/bb7dqIoy0EOLeVmHGdl1?=
 =?us-ascii?Q?QyM3KZ2ms3bZg3Voqj0kczOJ7CG5eKb1jQJvshyI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bdc0f1b-e2e3-48e8-cc65-08db63adf523
X-MS-Exchange-CrossTenant-AuthSource: PH7PR84MB1389.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:11:39.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjryhXIcLydq9/emUkyrZ/ocZdX5SzW14QkEYGa852EURNRZwHJo4JkdBxxRlwmb0c2RNBbsN00HIgcIn2uTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1485
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: LPRogKSbC63_zpXJiKJsXUMC8mqDrT5M
X-Proofpoint-GUID: LPRogKSbC63_zpXJiKJsXUMC8mqDrT5M
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_16,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020164
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2023, Ira Weiny wrote:
> Paul Cassella wrote:
> > On Sat, 3 Dec 2022, Ira Weiny wrote:
> > > On Sat, Dec 03, 2022 at 09:58:58AM +0000, Yongqiang Liu wrote:

> > > > We should always call dax_region_put() whenever devm_create_dev_dax()
> > > > succeed or fail to avoid refcount leak of dax_region. Move the return
> > > > value check after dax_region_put().

> > > I think dax_region_put is called from dax_region_unregister() automatically on
> > > tear down.

> > Note the reference dax_region_unregister() will be putting is the one 
> > devm_create_dev_dax() takes by kref_get(&dax_region->kref).   I think 
> > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > successful case.

> Looking at this again I'm inclined to agree that something is wrong.  But
> I'm not sure this patch fixes it. anything.

> When you say:
> 
> > ...   I think 
> > dax_hmem_probe() needs to put its reference in the error case, as in the 
> > successful case.
> 
> ... which kref_get() is dax_hmem_probe() letting go?

Isn't it letting go of the initial kref_init() reference from 
alloc_dax_region()?

Sorry, I had gone through the code a little carelessly yesterday.  Now I 
think that kref_init() reference is the one that dax_hmem_probe() is 
dropping in the success case, and which still needs to be dropped in the 
error case.

(If so, I think the alloc_dax_region() path that returns NULL on 
devm_add_action_or_reset() failure, releasing the kref_get reference, will 
leak the kref_init reference and the region.)



-- 
Paul Cassella


> Here is what I see with the current code.
> 
> dax_hmem_probe()
> 	alloc_dax_region()
> 		kref_get(&dax_region->kref)
> 		devm_add_action_or_reset(... dax_region_unregister, ...)
> 				... kref_put() later...
> 
> 	devm_create_dev_dax()
> 		...may return error...
> 		kref_get()
> 		[dev_dax_release() set to call kref_put() later]
> 		...may return error...
> 
> 	if not error
> 		dax_region_put() => kref_put()
> 
> I think this is an extra unneeded put???
> 
> Dan I see this pattern repeated in cxl and pmem.  Is the intent to remove
> the need for dax_region_unregister() to be called when the platform device
> unwinds because the platform device is not intended to own the dax_region
> after success?  If so it seems like the device managed call should be
> removed too.  Not just calling dax_region_put()?  :-/
> 
> But wouldn't that cause an issue with the sysfs entries created?
> 
> > 
> > Consider, devm_create_dev_dax() has error paths that return without 
> > involving dax_region_unregister(), prior to kref_get() and device_add().  
> > dax_hmem_probe() is clearly responsible for freeing the region in those 
> > cases.
> 
> No the devm_add_action_or_reset(... dax_region_unregister, ...) will cause
> dax_region_unregister() to release the reference when the platform device
> unwinds.
> 
> devm_create_dev_dax() configures a reference release through the
> dev_dax->type release.  So when the dev_dax device is put the dax_region
> will be released through dev_dax_release()->dax_region_put().
> 
> > 
> > 
> > dax_hmem_probe() drops its own reference in the successful case because 
> > (per the comment) "child dev_dax instances now own the lifetime of the 
> > dax_region".  That ownership is the reference that the error-case 
> > dax_region_unregister() is dropping.
> 
> No dax_region_unregister() is not just an error case flow.
> 
> >
> > dax_hmem_probe()'s initial reference 
> > also needs to be dropped in the error case, as in the successful case.
> > 
> 
> I don't follow this.  Doesn't this now result in an invalid reference
> release in dax_region_unregister() when the platform device is unwound?
> Furthermore, that reference is required I think for the sysfs entries.
> 
> > 
> > > > Fixes: c01044cc8191 ("ACPI: HMAT: refactor hmat_register_target_device to hmem_register_device")
> > > 
> > > I'm also not sure how this patch is related to this fix.
> > > 
> > > Ira
> > > 
> > > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > > ---
> > > >  drivers/dax/hmem/hmem.c | 5 ++---
> > > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> > > > index 1bf040dbc834..09f5cd7b6c8e 100644
> > > > --- a/drivers/dax/hmem/hmem.c
> > > > +++ b/drivers/dax/hmem/hmem.c
> > > > @@ -36,12 +36,11 @@ static int dax_hmem_probe(struct platform_device *pdev)
> > > >  		.size = region_idle ? 0 : resource_size(res),
> > > >  	};
> > > >  	dev_dax = devm_create_dev_dax(&data);
> > > > -	if (IS_ERR(dev_dax))
> > > > -		return PTR_ERR(dev_dax);
> > > >  
> > > >  	/* child dev_dax instances now own the lifetime of the dax_region */
> > 
> > This comment should probably be updated now.  :)
> > 
> 
> I think removed...
> 
> Dan what do you think of this patch?  Am I seriously off the rails here?
> I worry about this code being around for so long.  But since it is in tear
> down perhaps it is just a race which has never been lost.
> 
> Ira
> 
> ---- 8< ---------------------
> 
> From f63969c761b04fb5e646e7ba7df77a48bc26ba1c Mon Sep 17 00:00:00 2001
> From: Ira Weiny <ira.weiny@intel.com>
> Date: Fri, 2 Jun 2023 11:17:10 -0700
> Subject: [PATCH] dax: Avoid extra kref_put() of dax_regions
> 
> In alloc_dax_region() sysfs attribute groups are created against the
> parent object the dax_region is being created under.  A reference to the
> dax_region was thus obtained for the lifetime of the parent device via
> kobj_get() and released via dax_region_unregister().
> 
> The ownership of the dax_region was intended to be transferred to the
> device dax device but this transfer is not necessary and could be
> problematic if the sysfs entries are used after the dax device is
> unwound but before the parent device is.
> 
> For the dax device the dax_region reference taken during creation in
> devm_create_dev_dax() is sufficient to ensure the dax_region lifetime
> for both the parent device and the dax device.
> 
> Remove the extraneous dax_region_put() from all call paths with this
> pattern.
> 
> Not-Yet-Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/dax/cxl.c       | 3 ---
>  drivers/dax/hmem/hmem.c | 3 ---
>  drivers/dax/pmem.c      | 7 +------
>  3 files changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index ccdf8de85bd5..d3c3654842ba 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -31,9 +31,6 @@ static int cxl_dax_region_probe(struct device *dev)
>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
>  		return PTR_ERR(dev_dax);
> -
> -	/* child dev_dax instances now own the lifetime of the dax_region */
> -	dax_region_put(dax_region);
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
> index e5fe8b39fb94..d22d56964120 100644
> --- a/drivers/dax/hmem/hmem.c
> +++ b/drivers/dax/hmem/hmem.c
> @@ -41,9 +41,6 @@ static int dax_hmem_probe(struct platform_device *pdev)
>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
>  		return PTR_ERR(dev_dax);
> -
> -	/* child dev_dax instances now own the lifetime of the dax_region */
> -	dax_region_put(dax_region);
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
> index f050ea78bb83..efbdaac51e5f 100644
> --- a/drivers/dax/pmem.c
> +++ b/drivers/dax/pmem.c
> @@ -65,12 +65,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
>  		.pgmap = &pgmap,
>  		.size = range_len(&range),
>  	};
> -	dev_dax = devm_create_dev_dax(&data);
> -
> -	/* child dev_dax instances now own the lifetime of the dax_region */
> -	dax_region_put(dax_region);
> -
> -	return dev_dax;
> +	return devm_create_dev_dax(&data);
>  }
>  
>  static int dax_pmem_probe(struct device *dev)
> -- 
> 2.40.0
> 
> 
