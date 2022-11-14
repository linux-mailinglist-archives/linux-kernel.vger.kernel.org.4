Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D140628677
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238074AbiKNRFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236399AbiKNRFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:05:20 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B8C45;
        Mon, 14 Nov 2022 09:05:18 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEH1ErS030093;
        Mon, 14 Nov 2022 17:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=5Kjg3WKVkB0IaOabK7UEdiMhjZTsGY3FjEcyV8REtcI=;
 b=M7QhrnWFMfmHancevCZN/6pV39ggcoAQjO5LTYGuWEvyYa9hiyIJ39JLtS7S536fjFZi
 1Qh0fJ4rbodYd9ZLuW3HqriQbzllNisP0dULHEB2ke/H4RPeGFJ+kgnTqD2Anj6r1TMJ
 HmiuFycf6M5d6vcbHLx8GLa5WoHQmtgFdmIGc+yCqrDDI8xfcVtsT3iZmfT3FIpMMk2C
 7k8gmgO9bIJTGYbIXGrfde1zO90xjkyAyopWO5ctPN+UGl6V5mlZYAMbktiyCz4nQJVG
 LyODCH6AO8onX4ZuBhWEh0ojXcxOq7XTp4seeuZ20fXjAscyhw2lUSUBD1fwBAODBqz5 sg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1gwjshq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:05:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AEGMgTo019256;
        Mon, 14 Nov 2022 17:05:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x4d9x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 17:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnDtg8miclZQfSehxjki+BLrLKZqDjiRmtnqSvKivkS8dfn737u4NWWZFFKqc4+IXlCThb/vd21rDRSIhhi6Sl/1BLJ9XvKkw4Q5OSh4ijwKcny28QGVRqJIo94CywfTKN7OwO1jmfREDT4gTNIg52MyTorBzPYbmlt5zsOx2LZydRvduLxEp4b+C8O9pLQ0jKdS/vGcZ9tHMHmxw7POfPXncbFyfHUjGIlWKIzxd2dTwuUh8KL2EkLbHFw72WyyNIAslVrcn18yK27ku0mFAPL7nFyUGOeG6y69BtFuhxR40mJvUkng3JxfAHmr9qQQqbe5SMiHg7vQMyZtr3r1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Kjg3WKVkB0IaOabK7UEdiMhjZTsGY3FjEcyV8REtcI=;
 b=ONM3h0kmxB1//lOdwx8tJqQ4JgQHqHtbfz/PL2/drY0xxWyY2YIKpqKE2B52Lmm4OhXjIzaNy0NZ3rIEI1CDkN1bO2wFefStImyS4G9EJ/EcGVLe2Ch3/8VwdL08G9frobBR9DYBg2Nt6Z1SzRTU/VcFQp3VND6A8AUv2X0qtJAbuTZxarybL3Us8h8/KxeeUV0jE7PddDM3qszntXehFtaToSqRYruAdrJjEhGMhK5SQB2IQwQfzfQ4piO0EJYPlm5v9eGfpoEZO5OWhVbVn5H9N9vLzQFdzZVbSmKDhSuDcC2pLZrtH7r5Of9FHJiAEnd50225a/FipqA+PhuE9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Kjg3WKVkB0IaOabK7UEdiMhjZTsGY3FjEcyV8REtcI=;
 b=wg86lOJFcZCjBBZGtQKKKBq2fqOU2dDn4X72wHlYWwO4/Y56FRQsLWFa+s1rwo6DsME7pgugZiVBgzT5kLYWIaZLIGDi9BuumUGk2DNwLcK1DC/7NIiTQHZPNNeiq9P27VFM2CHQmtPXf4FAz4HCrjsDxF1bWzhdIaSIzDFLuCI=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Mon, 14 Nov 2022 17:04:58 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d361:ae7a:f995:2bb2%3]) with mapi id 15.20.5791.027; Mon, 14 Nov 2022
 17:04:58 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     thunder.leizhen@huawei.com, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 4/8] kallsyms: introduce sections needed to map
 symbols to built-in modules
References: <20221109134132.9052-1-nick.alcock@oracle.com>
        <20221109134132.9052-5-nick.alcock@oracle.com>
        <Y3BhRvt53xO5A0iQ@bombadil.infradead.org>
Emacs:  because one operating system isn't enough.
Date:   Mon, 14 Nov 2022 17:04:55 +0000
In-Reply-To: <Y3BhRvt53xO5A0iQ@bombadil.infradead.org> (Luis Chamberlain's
        message of "Sat, 12 Nov 2022 19:15:18 -0800")
Message-ID: <87mt8tv554.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0085.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::14) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: e544e605-8400-41cc-59a0-08dac6625c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2VgmFDuvLcEmKKcgfvxnAzEuPWN6Fuxrs24D7+HimaZIx4xoCduG6RaVfPro/pQD0gnkcuiBpsmNypzn2xKT07ZEotSrPsTsFEkhJhkZIvpAWtXsr49vOyRbOIYsMww72q1r0xZhWgUlnsbWJyUFb6PcyDtZP2Cz73iSbRuO/iyVQAgjuFD4+i/4LUqw+Qp6DRzXKmOZXa191JcvxSRnlz5Ajvm/lFUOtYpEBjIcOFN7Xx4Jwnc1kaYrk30LgxjaCw22t/SW+IhZ/CaIlwzT0Gndh8fGfd3HKswMYCx067f4o76PefaIhEmZ57xTMkNCvdQTDEWdCO3qQ+Ojfv/rAhKunf/MOs9h8FtgHvtE1epqqb176Mo/iju+xUQeBnezZD3dEpeq1JfyXdQHroTHXkLsLy+q1YZ46o6Hf1MJZRTWAKzg7RsFNMzTq4GXiTyRBcQ99PRh05MD6frUG0Wri4pgjD7BWkYydwDH24WF6b0fa9+1nuaO0c3Iq14uVKChEUbhjJzJPHveKMtN5YPCGcV2RizLPa5AVtIHdN04vuwkGE1LL2sfV18Bxu69SdVkmXVwg3lB7tJPGQushGB02TOo3WqYX8e2WfsgujXZxCFncd8VQhJKZgoOF8afNt8E7P7gZDbp7Ca6OQ9TFnFzQQfQisvY4vlo2hty1raGNOZY16qXxYvAkTJsfu2Ft0G0gV0ErRDKfSWXq2e242K7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(6486002)(478600001)(6506007)(6666004)(6916009)(66476007)(316002)(9686003)(6512007)(86362001)(66556008)(66946007)(38100700002)(4326008)(8676002)(186003)(8936002)(5660300002)(36756003)(44832011)(41300700001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LKxKysIenlIISde7sCZ2ghTb9kqgxEELYj14CGS1QICL8XrnANlkj6/rFO4s?=
 =?us-ascii?Q?/y4dZRG49qn5ZPBUy1h7l5yz0V7LGR8B+bcPYV9IZ+ESvRJ00lk256xIGPTL?=
 =?us-ascii?Q?SfuY6Nc6S1iS6WBt9APvsAZ7GnmUvczZiiBsr5BkSrY1mdOgkmUXy5RfsPEO?=
 =?us-ascii?Q?PIz4DILjft9W6EkeWMT33XXoKWYosTSUHJg+CJ+CNckDl8qj/ed9X3QvFXNI?=
 =?us-ascii?Q?MDHZJQs1qM+508PkVgYceSUkujpD00vo5NwtTbx+eJxWPUnSbnbVcdJvUp7N?=
 =?us-ascii?Q?8JiLrSzwm+gWi+j87sPzlLIxaH6NkJSCNjQma/5SVMpvagdC5CAi+vYMTRvy?=
 =?us-ascii?Q?jOa05LYuxmlL08N8CZ7orQSmPKhhmXElrloH3wPnWoXiPl8Omn5CrgvNqxdd?=
 =?us-ascii?Q?g5wm5G+hZvdun+hE4zr++65ciEOJjGehcrdQJlsHZxLldCZLEtF212S/6u9y?=
 =?us-ascii?Q?4m9D4mdIIIbpZHb1ISSEJDotqvUHguFuQKpIU7DjMZFsaVKcMqEIX1VsSPhT?=
 =?us-ascii?Q?bUsTrdyGyTKxgOLnCkkwtGt5DS4AYDi3IZBITZbjSwAvi+pO+LHAx9K/qqkW?=
 =?us-ascii?Q?z218/CpXCd/CejcVgs10WNa/+mooZ7v+hJcReOSjHnW3ckn3lTos/RTyEJko?=
 =?us-ascii?Q?pRMji7iFL3GJ5cCh4Pb2HKEtiK9izvBATeotIOdf2ChrD4jsJAKSDD/O3NLW?=
 =?us-ascii?Q?Vamgs1NPtLC9VaVmAVTJWbdXkowqvkMrOslroiJXXUTz3DYVRvR7cnO3jMrt?=
 =?us-ascii?Q?rFhFt6Ccb1dGDpB998+esWL/nlxYVVJf/pW1yagOXA1zR9LUOnvZuJ5liOv6?=
 =?us-ascii?Q?xH43AqcEEprKWEMK6Cy9KBzXMESx+b+U0HBLZNv/MXOSANPHnZqdkamvlddv?=
 =?us-ascii?Q?+Whx6jGs54cui7fvbv2oyCwJKYUQ7/iXsFiBiRNdZXQHlfsQ5wt8TlfcH9p/?=
 =?us-ascii?Q?x3/XeyXYBexiLsWrypmln/wsZsUyvv+sR7pciYvjaRnZ2AJ2emoY2jcIYGM7?=
 =?us-ascii?Q?d1B6p9YvfQeA4GdC26ozKP+DDlR5bgqQDVyaDZOpdcTf9XORe1Efbb60ClVQ?=
 =?us-ascii?Q?+UTLks5H99RJgfk2RQIdk7DHjlbNBfuXDOSmiypT7Oo8KXwSbnhZM049/0Aw?=
 =?us-ascii?Q?rY+TYzX5XhqpNUifoutBRVquk+Vc38mfVyoWtwFsl9YIgVg8G8gJudFtCjKM?=
 =?us-ascii?Q?f9f8DzSsXaOepsKRhrSi9m3yOv638lBaRZ6MZuC5h0RlJbbFRj6wDEp+SFEH?=
 =?us-ascii?Q?2f5Tu/EvJDifVo1FJSvFhSHyrF+KMfGPdizzKJu8ns+Wx9MKgDxj93C7x1M1?=
 =?us-ascii?Q?0/ET3EhMnb95wfJd3DjpEYelQ1pyJWgpgxB8hxbncwcC4+oCh+wUwWn+1vmr?=
 =?us-ascii?Q?/Y8TsEFb4dPm+c2/hpWurOZUhbr+3vuz784mo6/a5KU0sGM53bu32mvhQCqc?=
 =?us-ascii?Q?SO9V/5+R/OpjPLMJCG4X3PkMR81NTMVPNMkNRz+EoZqxRkWGnoNTlK1xspYr?=
 =?us-ascii?Q?KnINk/fmP9ZCEPyuJRZtDrA3cHw6j0GS0fp6YtadryXBquShsduT9RVoC6LA?=
 =?us-ascii?Q?7RnIvdPL05z+kL9EHwwAWsoURFqOAZSsqg9MfQkC3MC1i6/itgUD5lqERF8R?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?snZcOYDFUknv5QT5/NcoE+LYZ3dwJmrS5Is4TsQVOPnn0DWESBcg3VXfoWsV?=
 =?us-ascii?Q?hgDi/vRrcbEmcOkMZhvg8J+euGWc2YjtBjnhALjqFrT8W2Eaqk+jPBx30mlJ?=
 =?us-ascii?Q?Bm3KWKFvM4CNMhZ5QXsdrCoMnBXfjv0oMOOVBy7TxHfLGVDJxzsaLljAjhCY?=
 =?us-ascii?Q?gDluUY2LsfMUHn9GGVnaKPQTGj6mChegB4nncLUjkL/s455OdbLRwW7m5N7B?=
 =?us-ascii?Q?87DkZwestvljZo0g0wPXA7nAqMxhumB44YpMMgc50gHgu5MyCHvkDimUVVTW?=
 =?us-ascii?Q?9aewSCpN4MIfv50tDgpnbahcYS816woBzZaoqYwbTePAX7Wtk8B2ob8UU4De?=
 =?us-ascii?Q?dUwm5+GYVY41v3gOayV/7HrHhV3d3gqAa8HB/TOhFA4rUBzr8Tu6SGQ92Pe2?=
 =?us-ascii?Q?zi6UPhYInqZRRvmqC0C9K8r/6XfMXIk0oWy3LQRUWtLi+fFFA5nYkcxseqVd?=
 =?us-ascii?Q?9HQn+x9uqstVc5tPJqJGSfm2EFXEa98slROzhN+ifnL6MMu67ANe4LNucf+Y?=
 =?us-ascii?Q?qashDHtAmngWIyYe/h/KukdGU5MWuUipfaaBHLgPxA19RX5L88/+U4uZZSdv?=
 =?us-ascii?Q?Yljywx1wuE0qy8q5QGKIZFSRk7jGeLVIfMGOjn34kTSq59fA01NXHNyl/gwr?=
 =?us-ascii?Q?VbjcHKUV6CPeGk07SKgKU6c8KXRi8jBX2qHPBCaecxOtTisMgqfbIG3SnJ/W?=
 =?us-ascii?Q?3g/93Ho7wxPsUMlU3fozhCmqA3umw4NgACxkzzbQyFarKg4QdJs2glBW8xkh?=
 =?us-ascii?Q?Jc3quV60B2FaTWQEx5Pt+iLTtPWOg9MxQm5kPnikMLuqlPs7EYSl1enLJ3un?=
 =?us-ascii?Q?jLFyh4t8Do9w5dAFTmHHM6K08p3/70r/602ZDvpualUz2HHktXm+AA7u/6wr?=
 =?us-ascii?Q?gOZzDllmnJSFV/h2uT5ff1g0U4NuKORByM1GNVMJc8zjVKN6GrS9AJ7g5hJx?=
 =?us-ascii?Q?skuKqbNtGBFvu7ohqeQnSUkCDpvJPpk0fYdF6z664CZtCQQLQcm1j+SBW0FY?=
 =?us-ascii?Q?PRFA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e544e605-8400-41cc-59a0-08dac6625c5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 17:04:58.6025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pk3q7hE2CWO0VihKRDRUTUFQDJw1yfHQLOj81MmMZSijjcT1BZ1MBlm0ABEFBNIsERWAnYqzZQygjWgjSrQqvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_13,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=906 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140122
X-Proofpoint-ORIG-GUID: c8qYa1lUPjcKT2wnJkxa3cHuPt336vNk
X-Proofpoint-GUID: c8qYa1lUPjcKT2wnJkxa3cHuPt336vNk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 2022, Luis Chamberlain outgrape:

> On Wed, Nov 09, 2022 at 01:41:28PM +0000, Nick Alcock wrote:
>> The mapping consists of three new symbols
>
> The entire commit log does not describe *why*.

... because it's in the other commit logs and the cover letter. I can
repeat the motivation in this log too if you like.

> Can I also trouble you to rebase on top of modules-next [0]

Sure!

> Does the kallsyms loop more than 3 times now with Zhen Lei's work and
> your new symbols on top on a allyesconfig build?

I don't understand the question, sorry. If this is about the number of
KALLSYMS invocations in the kernel build, that should be unchanged by
this patch. This was an explicit design goal because it's quite slow to
run kallsyms more times and I was already feeling guilty about having to
bring back the tristate recursion.

I haven't tried it with Zhen Lei's work: will try for the next
iteration, as a matter of course after the rebase. (And, looking at the
patch series at the top of modules-next, wow is that quite a hefty
performance improvement. And a hefty memory usage increase :( I have a
horrible feeling that one of my machines won't have enough memory to
boot after this goes in, but it was terribly outdated anyway.)
