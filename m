Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B0A6D5044
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDCS1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjDCS1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:27:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEBE2690
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:26:57 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333DiDMQ012286;
        Mon, 3 Apr 2023 18:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=/z1U/UzawkAyr9ugfcX833kJctsQ13Xx9pI7Dkr7weg=;
 b=n+cPLO897pcd1qZSziYOcccJgjBNCpKNSs5Y64g9C+SexHM6TqhC4u89R0V6ou0mgo3D
 r9Mbh1bmjWt58S1FfL28CNCGO6abmXFmwYGQ02HHdGcYefTT1wO2+Mg9gzK8qmk77jky
 aJoMvlKwH2C6g/TCvPk/qOMkU85YA1PiWFO0p99TPqVuJK5/lQz6Ynt3soKOJ8VcHADg
 qChTlhzEAauu9dLA2Dn3PQnK9M+3S8q+rhDGaZqF2Yt2ymHGrYzGiBygQGm3FcQNQnQu
 2CsEN6TK9fT9I6hii+aRNk10Lqo9/3i6ZcoRH2frSkGMsmjtLfZor7rdDib9T/XJ2pv6 ZQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb71kxg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 18:26:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 333Gswne001463;
        Mon, 3 Apr 2023 18:26:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt3fwmnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 18:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYmjWLnvUScnU6sLS1X5eZTyNS8OFuPKLzS8wYw/WqYqDp6RNcnCmAbnVXmwuf80iXE/v6L1IwQaBUNOFTF6DmtwouDi0NQ51iZ/FjojtS2vKlF2dqmTrJ0M1vNcoDvI3tQzEVM58Sy6FHGo6vSqM27eBx9Rq5BNx01k7IaaVA93AABisZM4erXPit4XKiDRcy54lINekC2ynCdFwx00ZIZkHS1+sJOrTalKyR+meAyH4HqWZbpWrf056alqW6GCyt0A+HO8s6RJ6cHOY2gF/aPi7liTh8gc8UqzzqacmZ8eXU1KeJZad1f1YS8lkk2dm8tvM7VX6cJ2sMkJz/3TxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z1U/UzawkAyr9ugfcX833kJctsQ13Xx9pI7Dkr7weg=;
 b=MPLfBRA/r7fXXKZuxLsNmS95k3w/gElpVnWGCzQmp3LwF19ATmOGzqupJ1NGivP42W/9fTibWvB04JIV8ZCiYOTDqyhtfGkJFHZlKPxqOGqDGETpGvrkbNPS/BbOUua2ZYvKl3YstgvA9AIhXiT2RxenUg0zxWSypqY3jIj/MaPirXWsW+fJwnA50fUcqql2teX+BlvHjcnEVoIzz1mtuq65YGltIGICLV1yz+h7pHHqoiiCzxYXBQvjYLtPsvvK1tTi+DPU3//I91QBwHImo7HsrrgtW9K+r1KAzlhYJZNJ/HEKAP+2JXYjiaLS3bPIWm3OZ9EhF2h364SBdx4hvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/z1U/UzawkAyr9ugfcX833kJctsQ13Xx9pI7Dkr7weg=;
 b=a6GwKFfROxWgjiHNyhxGuQadhuOBGV+f7MpXztPRTeL3JNFfw0mdnY49P57pGnSJV24efrPtJRuR28yiAByVjIdHfp44rGEEk+Z+Ztj8g5doQ2sgceRSgRVNsXrpqcaDxEYUTkbdqLma5SiB7dIRYPhTGxgr7PwAEpemfPJAMkc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5881.namprd10.prod.outlook.com (2603:10b6:303:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Mon, 3 Apr
 2023 18:26:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6254.033; Mon, 3 Apr 2023
 18:26:47 +0000
Date:   Mon, 3 Apr 2023 14:26:44 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] regmap: Add maple tree based register cache
Message-ID: <20230403182644.uylyonu6w6l63oze@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Mark Brown <broonie@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230325-regcache-maple-v3-0-23e271f93dc7@kernel.org>
 <20230325-regcache-maple-v3-2-23e271f93dc7@kernel.org>
 <20230403154508.qia42tyasj4vhtm5@revolver>
 <6f49fdf0-c373-46f7-89bd-f30f0fb68c15@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f49fdf0-c373-46f7-89bd-f30f0fb68c15@sirena.org.uk>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT3PR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::26) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|MW4PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: f58e9814-f5f8-48bf-fd08-08db3470fc0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvVVLN3dvLwsmApZYqocxAJzUPP6kYLw+WLAu629rb/dPen+XJXKE956vsyMR/JSViRzUSU+vznNN9js5woWUL/I5TWPQykgKfwUdhclPFWedwyx2QwH8uKHSHJA5a1Bj4js0y8O1gm6Xa9dVAR/EGQRDLbdEaG5IRAIZih10y/r3LaGb/FYEoWDvRvM45a4yBb2RIYakr2m1ZYkdWWzRRpOkm3jZ58hr6XDrmav8J7XLUYi2/VGv5yPGUWrWGpPphI2fED8c1zw8bZKdTiYrD34DXMENvJxaSZbQIQQGGEmPkl4wSNOS5sbgFgIbaAWXHaAOCom1gTdfy4W/QaemtvY5DxT9I3YFT9iEX/uWAB19rCs/QvP6nAGeNHhLSfeZtBO0zKAHRGXha7Oaly0zFIY81TuZliZ2zmazOKqEqEtL39BSNjwazdAMzltoi0WnHSOxSFEfUIn3wLq5f0XEUBeAPU9A7ZHJytXJ9bAUQwBn55CBQjmdhu7P7jNVdnREMVKprpuPY+7WqwWfC/Kkz6CKGekvfm5QC9HIDMhedh7Kvqzthi6XYislfZDna9y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(451199021)(86362001)(33716001)(6486002)(38100700002)(6666004)(2906002)(478600001)(1076003)(6506007)(6512007)(26005)(9686003)(8936002)(5660300002)(316002)(83380400001)(41300700001)(186003)(4326008)(6916009)(66556008)(66476007)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1X9zlnLYD/hgP6abqEfvsORcxCQK7FSfWAnkil2wN4Rcpt6qNLN/Ui+rSEPH?=
 =?us-ascii?Q?D0wzmdT8qWh26UKFFIBNSghyAgmBp8E8Am98VjEIrfo7fBdZ6usZbAx88Mkq?=
 =?us-ascii?Q?uHO12DtfP22/k5snzDFA09PuBhitRH93PkISAcj92EFTup3wYDjkHljYf6xk?=
 =?us-ascii?Q?bXorqg0+mfr/3bidlpDcjr+cttkS9ElZttrdZqmHaXNB90o5S8wOhI4HDIXC?=
 =?us-ascii?Q?cwD6aSm3gHhdwRVZ7gB3/hyR2pXwarDN9Re8DEFk6GYFlTatL/hYa7YL1zwx?=
 =?us-ascii?Q?XeDjm69YV6+aSvx8FeQAtZ9nVMriVs6/zvXWiNlxokh96pHFmWS4Q9PsR0Wk?=
 =?us-ascii?Q?Hpgzp4GHCXwhsHL+C8TdlKBKSXSBF3M6uRoMxUGcn7o7gsLsGkYztxP2+PVk?=
 =?us-ascii?Q?aMejWYfIWZJHhD9d+h3glfbb6TR0QWkiZ0EQFnMuSotXd7wqoShFw3Prgfk5?=
 =?us-ascii?Q?kd79tH/Fkl3vWTfIo5QzSxbAX1pfu+bSotqXL3T6yS9rvEgk8kKFCTDc+2TY?=
 =?us-ascii?Q?58oy8KwIy6S/wavGttYwk9Y8AUUhWM5ZkQT8V8LFl99FBS7Y4HO+BHjoxx4U?=
 =?us-ascii?Q?821hS54NAJuRA+rcYTfdcV/Jpo8zowfgxJgh6ELtzyJTQpNPQN4xaE1oZGQm?=
 =?us-ascii?Q?JnqdCeRZk/5QxwamvF+N698IKoPqbd1Z8EvJj/LHto54Xd2zXRcytUE8Ex3b?=
 =?us-ascii?Q?CoN+VR4KphwFPzFxSCceGxqNFpmF052z+i6lvNVtH+LORUIiyrETYnq5+8sj?=
 =?us-ascii?Q?UUJ2cWPcaRVhWH7QbTmL9n+PDjwfpuDoCsLBpvNJ0m9yRI06ebqtRF6jY/2Q?=
 =?us-ascii?Q?xMvoeMXlKcxi7bAtS830VnzieVZShKzu8GgI/E1qsVdI1dRJnT4ruDovjCZR?=
 =?us-ascii?Q?Qi4rYaq1nxNchc7BcSDCczpss9TwYwEbwrpxyvGRIUGn992OebSoJ+zIpJ3s?=
 =?us-ascii?Q?QQoCCnwTAGzfgxVan/hWB6KRdq9XRA58mNKIEvVmu4MktWiiTLEJJO5Im8PZ?=
 =?us-ascii?Q?GC6TUX61fM+0Ejfeir6Sn/3AV7es9t50GPIs3x03deMLvwXFFb5GMhqsdLqL?=
 =?us-ascii?Q?OD3yz1TG5/5jQufpEhzih72ei8xfjWaXQd1jiODhBGS/q9Gzni3jLqQrAmNL?=
 =?us-ascii?Q?Nla7nxpDnppmK+of0R/C/Z1KCI1kVK3omDbrUGpgIdNCiLCQVYUZTvVUmrxl?=
 =?us-ascii?Q?HDiXF6aWT7CMDU4Qz93/+Bt8oNIEyIhlSUFuH3UZbi4xTKrmM77Fc628PMA4?=
 =?us-ascii?Q?mRUoSCwsq/9us7BUp3/5ME5xfvSmNitE9IVOcAx3/lk9Zt8lTGhr+UfBwhrm?=
 =?us-ascii?Q?3c/11BkVYQMiwOZR3wjoC5XCf5eodIEAAWFhexYnXcvSAHyyF8QSfW+ey8hm?=
 =?us-ascii?Q?y01I+FQaN/Rsk9EdvaQbtB4dFhw3n3Rpi3JiRW4fc6F42Qy6SI/HeZcoM+nm?=
 =?us-ascii?Q?n9f4axlYAfH86s2lfl/PjOXbaaJL30zOocw8Tkl5Nkd8oP49xMtllNfTVK54?=
 =?us-ascii?Q?k5cf1jBtQuCGdeAq17QuzO6fwRQ5QA7/y7t8l5uMrso5XkUmjyklvkIa+nae?=
 =?us-ascii?Q?TM5949BmXQFaqR2Ij0QKpIyvyQnaN9zlAZOzY3x2iFsPLCvnj21M32sQy044?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vM0jixKHmXJzI2woLyFGgBRXdeqwHfwM2XAK8HdSoQWSBwoYOzG9GiCjyAAuhE4jOnDZfiIyWjP836qHgLx5xl1RKG0hw8BbVP8SLMjX8FtDF+q/GpgrAqR4ASNHZXIlNStGIhy5qOELfQ/avJjfuNx8lf5Wa0MsQnk1r75DAct+kspjQN7UwCchmyH8Na3ogW2wniL/Ru2d9NaqD+CmEU4fY7uxU3FGtiTVfmQi/zWhpfm2asfu2+VeOTCAYYvTpstZAuvDInEHXu7roNjT4qngPfvVb8w2w18MvTCNGKL2MZ0S7c6CavtZAJRKzW9Ys6rbZQbcdkfkUPh/fwokimuuu9HdfsNpStQMwimrbn4ekdeb+h5X6+xAlYQ4dkKBwbo5P/S60x4FYJUa4URjiW4S3IwdKPFZhfuqx6e41fDu5R38txVFY+KDUvPZXLI9/YhDSD8wa0m27Uf/fZr+sCG05+skqS66Yqzpop4sRC87ZhlK31dAT1nLMivMYPGCbMENHEcMQFNdC8r+uS8CGxfYGmQPzIl44kIDUaljX/ds6Q8NyMDul3x4F1V3TAv/xlpFCsXqaABrLcaz+G4B4FidvfMl4caxvcBpGJkc3VVs2Ly80+qj2wj8Rq/QAbtthrPozGG/7aTk+d9MEJPJROYZ/Cb4zQHX4Xl4QTIY4g8WliJIaSVXLpH//G34lDB6EUKfSpqUwqbdv3vNgGrsUvlZlvtKgMs9V8M0/y8F2dB3H9bXjaQnpuuTRN9eEz2Kd1reNp//EONX9aAEie/x1lBNVeQroszT0H0vwAWOHF87aBwvy6q0yg3vP3hSuzyV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58e9814-f5f8-48bf-fd08-08db3470fc0b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 18:26:47.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nByTp5IkgRTMaLXE4Rkstr5da3QN12ezAxbizeXif/8bQ5opSkHQLS5f5Mw4bOpLVJZBJkGhpkbJ0mQhhOXD3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5881
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0 mlxlogscore=979
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030140
X-Proofpoint-ORIG-GUID: _Z0CxtVq0gWjw1EGQkHrlNWho9kBnqIC
X-Proofpoint-GUID: _Z0CxtVq0gWjw1EGQkHrlNWho9kBnqIC
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [230403 12:58]:
> On Mon, Apr 03, 2023 at 11:45:08AM -0400, Liam R. Howlett wrote:
> > * Mark Brown <broonie@kernel.org> [230329 20:10]:
> 
> > > The entries stored in the maple tree are arrays of register
> > > values, with the maple tree keys holding the register addresses.
> 
> > Why not store the registers to values in the maple tree without the
> > array?  From reading the below code, the maple tree will hold a ranges
> > (based on registers) pointing to an array which will store the value at
> > the register offset.  Could we just store the value in the maple tree
> > directly?
> 
> AFAICT that means that we can't readily get the values back out en masse
> to do bulk operations on them without doing a bunch of work to check for
> adjacency and then doing some intermediate marshalling, with cache sync
> block operations are a noticable win.  I'm *hopeful* this might end up
> working out fast enough to make the cache more viable on faster buses.
> 
> > > This should work well for a lot of devices, though there's some
> > > additional areas that could be looked at such as caching the
> > > last accessed entry like we do for rbtree and trying to minimise
> > > the maple tree level locking.
> 
> > In the case of the VMAs, we had a vmacache, which was removed when the
> > maple tree was added since it wasn't providing any benefit.  We lost any
> > speed increase to cache misses and updating the cache.  I don't know
> > your usecase or if it would result in the same outcome here, but I
> > thought I'd share what happened in the VMA space.
> 
> Yeah, I'm hopeful that the maple tree is fast enough that it's not worth
> it.  The main use case is read/modify/write sequences where you hit the
> same register twice in quick succession.
> 
> > > +	rcu_read_lock();
> > > +
> > > +	entry = mas_find(&mas, reg);
> 
> > mas_walk() might be a better interface for this.
> 
> Ah, that's not very discoverable.  mas_find() should possibly be called
> mas_find_pausable() or something?

Well, it finds a value at reg or higher, within the limits you pass in.
It was designed for the VMA code where there was a find() that did just
this (but without limits so you actually had to check once it returned).

> 
> > > +	/* Any adjacent entries to extend/merge? */
> > > +	mas_set_range(&mas, reg - 1, reg + 1);
> > > +	index = reg;
> > > +	last = reg;
> > > +
> > > +	lower = mas_find(&mas, reg - 1);
> 
> > If you just want to check the previous, you can use:
> > mas_prev(&mas, reg - 1);
> > This will try the previous entry without rewalking from the top of the
> > tree and you don't need to mas_set_range() call.
> 
> Hrm, right - it looks like that doesn't actually apply the constraints
> so that'd work.  The whole specifying constraints for some operations in
> the mas is a bit confusing.
> 
> > > +     
> > > +     mas_set_range(&mas, index, last);
> > > +     ret = mas_store_gfp(&mas, entry, GFP_KERNEL);
> 
> > You can avoid this walk as well by changing the order of the code
> > before:
> 
> > mas_walk(&mas, reg);
> > if entry... return
> > mas_next(&mas, reg + 1);
> > ...
> > mas_prev(&mas, reg - 1);
> > ...
> 
> > This should now be pointing at the location mas_store_gfp() expects:
> > mas.last = last;
> > ret = mas_store_gfp()
> 
> Don't we need to set mas.index as well?  It does feel a bit wrong to be
> just writing into the mas struct.

Thinking about this more, it might be safer to set mas.index if there
isn't a previous.  Perhaps use mas_set_range() if there isn't a
previous.

Perhaps the interface needs to be expanded for setting mas.last.  The write
path should be safe for changing where the write ends.  I've tried to
avoid re-walking the tree when needed.

What you have will work.  If you need more optimisations later, then we
can have another look.


