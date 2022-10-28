Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55DA61143E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiJ1OOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiJ1OOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:14:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E70033435
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:14:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SBNet6011135;
        Fri, 28 Oct 2022 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=vx0pMU2qpSc9MrQ5iTRRnaq/17RgQaNHKZzUkCpX3Ng=;
 b=ux89waA9wWisE7rOa6+cwZoqV/NT5wzpRuAuPvcZ4kq1V67M/QcTAomGz4ePkVAU/Tna
 WloZGant+3PEKUJDD+fm+emwA5vLDLkYeBMkOAGKgjTaqfnHekfv56eXQ85Vbm9CsEJv
 ELAVleQpww6WQEDKIWhDDGNsLXfKN1EVwGjVlLtp+IQ7FI0C47hwi2o8ofi9MI2CYNM3
 +LKotoDB/MXXYfpaMIZE8qyhjqhn0jJLX4FgXfF17zO8TThc+adSEG9W0O0JByWI5dX4
 LtIUMSfGYBt47Ve/qxPAwx26z6puW6HVSFN4W7yHNwyPGYl74Dh4yUmUCwixme6IgTrA Ag== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahedekk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:14:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SDQF2a011647;
        Fri, 28 Oct 2022 14:14:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfags4m8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 14:14:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDE5HyJL9Lh4vmK1m8diaHNXRJtju7yszUrwoX6comoOjYr2brPupRMYA9F6wNz3S+rthrM09B8Z+kQh4MOJh1njbp4VPtCZWJ3xQH+FrulGcpFwvAGjM4cp4AfyzTCo8AS5BX/BorIpHMirWfN3HBldiEXcWLk+e0d17499OEkS7frJhLejidWJlQgNFwk6L4tpMJjL/OrjUm6JIpLs1aBBdta4YNgPKh92GAXdKWq2kvC8P9lXeCiWZNQWadyPAFgRjUtFaAetQSqOpkUhfb9GWgqQ5kQgot6GxejhYbTGmnJ3xP9gPH6ZXqIiyboHRU/rckRyYg2/K0EOw6pY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx0pMU2qpSc9MrQ5iTRRnaq/17RgQaNHKZzUkCpX3Ng=;
 b=FRCZtIppdQr9JGyq/1TZUhmHTI/WgRJN9u/pvm5MITO8TAGT78e13UcNl+nFF7ih6CnqaFN7cXGjgaCPFflYDwgZeXSCKiaXYQnVrhw4EIt+4DXhaFWIax8RRD4O9WrePJH9/v+Ddggr5zno/OQm/3kklEQ7IES0Ovhn/b10REggTH8kCNGSCleH7yHg4CBL0pzYv2cTpms94SrFpS8G2yA1aMgklxfwUS9KuDqbHOrQcCEwnAxAWrqetLI/DoI8sfno3SMUByWjGeTJqSNcn+x+SryTPGxI8O4YBJyYrTl31vDYeS6TS2QLSrGvxNnR9kuf3ptHzpnP+gL2OIZlHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx0pMU2qpSc9MrQ5iTRRnaq/17RgQaNHKZzUkCpX3Ng=;
 b=T9aJ5e0oD6ySyMjgp58ZFu/NyxqtocQ56MLizX6VLjO8jvTEaqNN12IZ5fvR66pDbG1ZfjLhAn1SNoJ1LsTuLFNQNjYrhS4UwduHVH0cb1nIbsM+ZGhxVbZ3WZZMQUe57pZu4aPTcKGczcAGvJWL70Jv86TV0RXJvrlN1tPpWdA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 14:14:21 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3809:e335:4589:331e%7]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 14:14:21 +0000
Date:   Fri, 28 Oct 2022 17:14:09 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: Use flexible-array for one /
 zero-length arrays
Message-ID: <Y1vjsTMsvVFuMIYb@kadam>
References: <Y1vNNSSWK1EkcohT@ubunlion>
 <Y1vaR0olLH9+bJbk@kadam>
 <Y1vb7OoJqVK3C5bc@ubunlion>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1vb7OoJqVK3C5bc@ubunlion>
X-ClientProxiedBy: JNXP275CA0003.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dae39c4-416a-423a-022a-08dab8eeb534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ftq1zUp5uXdtjKDkVPOmvFiHKrELGZe05GNHEgAldSUR8kDwpvNQEw0h3ORVsPeFMdeqaPrIdxS9x3jiy20rXswTK9CECEhg1KjkDHEpIatKfgN/G0F96lmyuHeBlY2HvhWr3VQarNCsQnDeriwc62KHJUjRkZpgaFZ1b3vEpcBuDk27XA1Eypz69XfMw16LRpOM4HazFkcUADxCISC03/hm/FQ679V4sns0qiR0oL+YiZkq/USErB9zqsuFs5aY+S7ti2oZkX5Kob1MHzLU4PBy/xaKDtc9ik3sdSwANJ+E0vJFQo042fzkjwc38B4lIxobFTmNJmnwJ5bKL59RSafXSRjUyh9iMIAZVUKytPMCBay5PQcQ/n5sAKc4/b7wcQIUhGqjZmmzYqEjl4VrXjq33qmZHu9P5rycylDyPgN7ily7a8KKNTGJzmAuGaBg8B62vkAxFmIaFZdGgl0/uX1jgNwhbc7iJyQk8qZZbVJ6D5Pl7geLjtGi+Yqrsq2nREoTW4zjICEzgS7tEk3/LskXAMMvdXeOuB26ZK9c86bkNwSNWGdchCvvm5I6KPLNZPZF549YXxHHGY9Yw794v647A8rIPjczIk6cc+mKykc58DIpZGPK4wR4tRLUyeYpXajgDiffIVdvPaPDGA6qVatmFNZB4MaECi9elylieV8aCb6RJnIKx2oakHPTHOrJ/Ie3SatxBJ6UGAYs1x91flpsCCU2UoMw2MR9BbtNDbEBNhEPCAcCgIVfBrAOW9bI6P5USvUIyGKQpG0ONecebw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199015)(44832011)(316002)(6916009)(66946007)(66476007)(66556008)(6666004)(86362001)(8936002)(2906002)(41300700001)(5660300002)(8676002)(6486002)(4326008)(478600001)(966005)(38100700002)(26005)(9686003)(6512007)(33716001)(6506007)(186003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BejKef9w58XvUloXAbxwIe2WSA+1/F0XA+WQ9BP8Y/VrvpiIJ5hgt44UW4yG?=
 =?us-ascii?Q?8tfHsUBuRVITSzrdyescWLg5GrpJIllfooNUwmLujHgd7E/XlZ74385Ip9e0?=
 =?us-ascii?Q?v9Je9Q79OJ7m0Aaw+iF7lXiNlL9JwujpoLXyDukemTIwePVpxyFOjJm7NkZ9?=
 =?us-ascii?Q?ymsQxo3w0LJpm8N97X/Pn22RV6M+L+4Qigqi9pApuSA5TzImDaq3i4Erp5ht?=
 =?us-ascii?Q?RwGFmU5gOw9Bq5O+26YtSAGyw5iXm+1MaL/YDCkNKnDSuumN9GEwpUGKGSO+?=
 =?us-ascii?Q?PmGd0uVfb+M0C3FV+iE25THTiSa77KR182x0NG0ILpZ/Odc+RsqYn7wCKTvP?=
 =?us-ascii?Q?AlkVuuc86wPGda4SNh05iGNLKufI/lue34beu7Zp2uXYNlMxUO/WTzG8SKIF?=
 =?us-ascii?Q?Gp3/h47FNDvlQqzG4/+1h9WmZH/mdJ7VSUfNYXP98DOqBeSKAHYOGhVxo5EL?=
 =?us-ascii?Q?dJxRnsxeUVT20ohDujxyx79gYJn3ZqAjo+cXYKIcOLGE11nheiH63tSSdQgS?=
 =?us-ascii?Q?8lcv4Dxkbn1/OeUxiwlC09wAFg/OaSDhEQOTNMKOAdIuy6dzWV+okAMvhtM0?=
 =?us-ascii?Q?UYaCrXMI0kdqSVEfiRCkAPyC/RtPjOQ9phfeslbVRow1JC16XuD2J0IwC1yS?=
 =?us-ascii?Q?HiwKlfcaf2qELXAIwSx5r5+ABTb+FaTf/qDLdTI3dbz8/rE6o5CEY8NVVFVS?=
 =?us-ascii?Q?WDyI4jWbr9soi9zKDorffzR819IE+NFEqE+fRKl7h2/aPtYmlEq5YZMQGx1O?=
 =?us-ascii?Q?DWK2AmKJhOomK5px4OinRFQj3W80cEXp4cFPBmN84N/FuWdQACgKCQ50+Cg8?=
 =?us-ascii?Q?/u1mUiwrY6Yle3IngWNCuX8SvwyXf9DJ6iLvRBPckqPEssyvx+C9yAU8tnRr?=
 =?us-ascii?Q?UaVR+BlbBAhrR77CQOGJu9U/fScSRO5c/jrfcT9Tglk9h5Z3DExfWLpWjASN?=
 =?us-ascii?Q?HrY5rrK0W0dG1cYs0hO+BPeG2qBw+UOgDoZkSoaVfPCm0vmY6AqV95U0pmGU?=
 =?us-ascii?Q?q7rZWgXO26w84D5a1IQJ/UBP9HOFbxuA9XOfckLrqAkVZeAv+mO7EL41bsP/?=
 =?us-ascii?Q?XU8abXECfgEJPvu25zxayLQPs6JBpFgoIoCGlihcYscmwiFev1vjhgOBazEg?=
 =?us-ascii?Q?FF5ahNbFJCv/9OAOdkaNpmlE5PeJS9UV8HtGGU7y1fWFdhry8Bs48BrXoOJp?=
 =?us-ascii?Q?XnNS8Z37yAwQt2K/UaB17fiyJQi9KzqNt8Cp5rdmlGsRTkZ1cl8i5ihu3usz?=
 =?us-ascii?Q?BaAP/mwwxddSnB4IluPMHhmWbPQces8C1SM+j1fw+CuvMal2oT38fnn86s7M?=
 =?us-ascii?Q?RfuKaReRyhYfntXi7/1qawtV3isD07NG59XTqk0fAzo8Okolj2hrK1xYhq/x?=
 =?us-ascii?Q?7FTMowqnH9gpU07MQyoqXvOCH2NHlZjUBrNxYc6U1RDCUu4zCyMJBfSZkeA5?=
 =?us-ascii?Q?rApRU9kjoXEeDCcEd8VKukFnrTcsdmWqkcKzRCWSokHRAEIluMyGJ8mPDKim?=
 =?us-ascii?Q?dskVjEfml1NRZlG/Osx6R/sWxKfW9ggDpU3W2JYww4AZCzGlenw3RRQDT9Lv?=
 =?us-ascii?Q?Y78PTnphpI3Xa/L2nYDZMaZkk3t/hAgmVA0orsaLJwAGIozYUE7K+SbxaWtE?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dae39c4-416a-423a-022a-08dab8eeb534
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 14:14:21.2532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyTCPkui3fd/AG/6VTBomwNgrmpeTx+DKOUgUWkYjGOGzymXjORVr4fL35QXRK6JSi2g8cRKm/Ygw/CYLKcpSz+aFV4tPTuqJUHNH5UaNTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280089
X-Proofpoint-GUID: j_soVNKX_JQnaomauyBdI9dHXUAuBz1E
X-Proofpoint-ORIG-GUID: j_soVNKX_JQnaomauyBdI9dHXUAuBz1E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:11:00PM +0530, Deepak R Varma wrote:
> On Fri, Oct 28, 2022 at 04:33:59PM +0300, Dan Carpenter wrote:
> > On Fri, Oct 28, 2022 at 06:08:13PM +0530, Deepak R Varma wrote:
> > > Flexible-array member should be used instead of one or zero member to
> > > meet the need for having a dynamically sized trailing elements in a
> > > structure. Refer to links [1] and [2] for detailed guidance on this
> > > suggestion.
> > >
> > > [1] https://en.wikipedia.org/wiki/Flexible_array_member  
> > > [2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays  
> > >
> > > Issue identified using coccicheck.
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >  drivers/staging/wlan-ng/p80211mgmt.h  | 8 ++++----
> > >  drivers/staging/wlan-ng/p80211types.h | 2 +-
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/staging/wlan-ng/p80211mgmt.h b/drivers/staging/wlan-ng/p80211mgmt.h
> > > index 1ef30d3f3159..d6fe52de2c8f 100644
> > > --- a/drivers/staging/wlan-ng/p80211mgmt.h
> > > +++ b/drivers/staging/wlan-ng/p80211mgmt.h
> > > @@ -229,14 +229,14 @@ struct wlan_ie {
> > >  struct wlan_ie_ssid {
> > >  	u8 eid;
> > >  	u8 len;
> > > -	u8 ssid[1];		/* may be zero, ptrs may overlap */
> > > +	u8 ssid[];		/* may be zero, ptrs may overlap */
> >
> > How have you ensured that changing this from a 1 byte array to a zero
> > byte array does not break anything?  It's not uncommon for a people
> > to do math like "size - 1 + length".  The "- 1" would be to take the
> > 1 element into consideration.
> 
> Hi Dan,
> I did a code review to understand how this structure member is used and did not
> find any computations you mentioned. I would certainly like to receive your feedback
> as well.
> 

That would be useful information for the commit message.  Even if it
goes under the --- cut off.

---
Compile tested only.  I audited all fourty two uses of the wlan_ie_ssid
struct and nothing checks sizeof(struct wlan_ie_ssid) and changing this
from 1 to 0 will not break anything.

> >
> > I was trying to read through this code to check your work, but then
> > you sent a second patch which also does not explain how you are auditing
> > your changes.  Can you go a bit slower?
> 
> My apologies for rushing patches in. I will hold on for feedback on these
> patches before turning in any new patch involving similar change. I hope it is
> okay to send a different type of patch though. Please correct if I am wrong.

I'm not saying you have to wait for days for reviewers to get through
your patches...  I guess what I'm really trying to say is please group
your patches together.  Pavel Skripkin's review comments seem reasonable
so if the patches are grouped then he only has to reply once but now
someone has to reply to every email.

Also if you write 10 patches maybe you will notice or think of something
part way through and which forces you to re-write the earlier patches.

When you send patches every ten minutes then everyone can see you have
not tested it at all.  I don't really expect people to test their
staging patches, but let's not make it obvious.  Wait overnight so
people think "Ah, maybe they were tested".  It gives people (false)
confidence that this is quality work.

regards,
dan carpenter

