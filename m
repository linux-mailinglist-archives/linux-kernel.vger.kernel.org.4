Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4005B5C16
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiILOSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbiILOSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:18:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C033408
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 07:17:52 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28CDUmL4003699;
        Mon, 12 Sep 2022 14:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=wlWLnnd6Ty8c5/hO2md7c9k6uVL3NuleCi18xQbNyMA=;
 b=G8nbnCOxmUh0EVSobMZ7rWx5K2WPukj340pKKJJGf2Z7RpSGOlUZDSZK+L2OkEdLrBl+
 y4w/LZxjR4xAox6GJRq9ED6w8bBpkDG1RUGSoeR5y0KzR+hurz2S06Ae3h7J2DvXfY7E
 FR5EN0RMWsHfOWB0/YXpsyHScKx9dHHmEY7p2uAoqpQjHKksxBNKvZypzMCxvYttN5rH
 3cdWQLq8UtECLOGb56YZ7QJTzkp9yTi7Vm0p+FkDPXSsEmibLyManZ7+zQsWv+I+RJSa
 cS4vcnEBf5p+so4z4uWUTo6EP9QrUgjNo4Ik63F90cSMegN9mE+1o4ECz5go7Af3Fbc8 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jgjf9uk2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 14:17:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28CCEg1k016800;
        Mon, 12 Sep 2022 14:17:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jgh12k1uw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Sep 2022 14:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq8s1x1y6lv04aDFRbQT142j9s1nNORyMQfJsh3PsQ7oip3thUMOd+Jai/ZRL9EXpSBJDLBP9WZgu/kNjDsyWgem7yWm1aF+eMs3SHEHoSuYCelGIBhmt/gjl9cIAu3WePrFa2hYOoFZb0pvwqCNqtk7zhbrKuTr8IZYEti+Dr88ysdQFOA9mM7TdQCa4pt1sWHvXkL3kL/WX8RQMcU9bjqAB3wKaYa4W/hydT5hxcwOgtRs0uzSGCfWQwi5oYyaYaygbB1DKJfWfeau3iwtLG4tHsQk2GSMEa1n5Ad81YOlDRTGqdwnGeuuobvQXRz5KQ7a4uyRXRgZ+gOAN6PVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wlWLnnd6Ty8c5/hO2md7c9k6uVL3NuleCi18xQbNyMA=;
 b=cspqV6EjdTGxck+LB8r90LusHLYt13Raf60jGAat4b2U2LWI2T7N3XJdw6cNBQVRvuZ+f/F3tVNnHLFBNJmrA6BwvROfDm2hEL09x4MTYcb2ofIMc1XJS6oTIAsUaU3gtGFYVRbzEZZ0bTQhxF/royRbqoVcaDcOo8+yYeDeGNh4YywwFbBgNjXXKbrpmbFT0GVkZ2Mxd2KZi/YTWAwHU/JM1NrHBfNIUADy5z+nLq6snqhmqgudY4rKy6ZTVPc+yKruFJiPlPPBQa4r80E60L6yBeDVhAyB6vCsxFAkrR5hJuakjmIpEqtFz+UHEFk/+81HV/yNxOIceY7hz65M2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wlWLnnd6Ty8c5/hO2md7c9k6uVL3NuleCi18xQbNyMA=;
 b=zLZwq7d2l2M3D/y0IXCDMzmUBpv9eEHhnRxA6E7iCVrriX68g3O3TbgAHYleP2UUEH8dN5qUi7Vvy3253NxKzGWtc3hAQZMFrYrROgB2epnjKZU4qMTbhEAASuB8RgOFfk1dunMojrj0O9Hr7idEnEbOGlVQTBILkbeQHmwdwJc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB5188.namprd10.prod.outlook.com
 (2603:10b6:208:30d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Mon, 12 Sep
 2022 14:17:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Mon, 12 Sep 2022
 14:17:38 +0000
Date:   Mon, 12 Sep 2022 17:17:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nam Cao <namcaov@gmail.com>
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: fix potential memory leak
Message-ID: <Yx8/eKbkOs8AwGpK@kadam>
References: <20220909141338.19343-1-namcaov@gmail.com>
 <CA+sZ8B-z7nRdJLhxeJ_tWSj_LBSwoFgtQja1-vDnBVdR=b0=DA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sZ8B-z7nRdJLhxeJ_tWSj_LBSwoFgtQja1-vDnBVdR=b0=DA@mail.gmail.com>
X-ClientProxiedBy: MR2P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::24) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|BLAPR10MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 78dfd1d6-f72d-42c8-3231-08da94c98b6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYIN/GLQsJGob5gc48VpnyEpF4Id2jOY2Q3XoK/SVvYlsKiLGeTpyJRGu1ojvEg8Mlg1H6u5bj8pY3uHt6q0VbSgpn74z0B10O2btQO4zxiAO5kqj8VCL7+okqqoyryS6B3+jWcnyjEdibOFv/5BC2BiEH+weFzNnTrnfq/yC7nJfi8nkkGo7n49NBw6B8IONW4gJtUCBa8isu2yBi7ICzygoTsSSrLD0+2TtlrbepMBAN3sMCaK5sM3OupqxyBS0oPV6P1efhuagKU3bBrdDHBlwx0BUxJdFQXdKRYPPse8/PmZYUZarVFSmJkxpWrCBwneZzPQrNNCZ3qleyHNmZUtaTRkfzm6Ff3bk0Z7OJ4rJcR7z/7at+MboaJvpJsV+dE5w2t3zqNypFxUDu2ZUGAcTkJkY+qMq4D/pare5QDXNG92QRgn2uVKZ49kxn+e5oz/g+k0eentycLuWuLz4Oq9wDY/VD0JeH8UW55k9J8BLnDlJP8hNZ2Aw/5HyngNyTWaK2LsZj+jRvfVlvEECDDgxQNdWq2HovXqAGXfDaVCToQm2zlZjIgeOtqpTBgoelLcgoA8XjohpjZ4L2HBcrnt1rT1Wdcrc1iV9oJE7sIwMeUMMXpGDKr2tJ8Fzrs+K7MxbRPHGOFf/dFlbvFtBUq6bcPHeG89SNkFzjokTGhHvsnlqQvkD213Yb05S/z8/3y2FcbhALAyPJknUaSrHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(366004)(39860400002)(396003)(346002)(136003)(478600001)(83380400001)(66476007)(44832011)(2906002)(66946007)(8676002)(5660300002)(66556008)(4326008)(8936002)(6666004)(33716001)(26005)(4744005)(6486002)(41300700001)(6506007)(9686003)(186003)(6512007)(86362001)(6916009)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9mM/QXD1xmcQI37/9Xks/hqxlZZrAIOInrpH3oUgV2Re3ma+hJT1Wk88XpBp?=
 =?us-ascii?Q?hd2IV+sHau4LDEHG/GbVMMjr6EFmWHtD9kAayv2X+0n2w2QFQLXRjFmob7X8?=
 =?us-ascii?Q?jwzTnPidlJ3tDuxlTV6fKB5aydHLVdLk1JuE9DKv7MJUU9H2SPyOOvmAZ0I8?=
 =?us-ascii?Q?eO19xBqkRbnWnVU7JlIAGqt6i4O4oYybyGDAJ0Czpp7pvWgdsgYi8sAOWrQo?=
 =?us-ascii?Q?MAKTPDpNK0oegO7D3rNPXm71tXv09EFSEzCe/1VuB6Ye6r2SdxVynGGMjdoJ?=
 =?us-ascii?Q?GFdiXXksdBSfDvNwqxGD21R25nZUkcTQ6knP492n8WwkORTj+5MUhmfLp9z8?=
 =?us-ascii?Q?F/mmBfUj+rsuGe7ouzbbTV1aSrbQENWbNhDQcYYR3pq+nQDcoB4nXJgl19Kr?=
 =?us-ascii?Q?kJOLla2q22WNggNKO4JwsUDRhNu3KjOAARkGyPGb3Ddha+xon8g4e0kRwvNx?=
 =?us-ascii?Q?caFZrKiy8kwlH9eIgrCIOiNCaZWZ+wS+8Uirn8fe5AGRxOh89593Nl5d7MVV?=
 =?us-ascii?Q?g6eNgjrL4XQrMI/oHpSRlzlidDXbI3ZZ9O1TdGRwobeTj6cmH/MDEg6vO8lv?=
 =?us-ascii?Q?hefDxsRU5tunEYdDYj0mRvF/ZFhR9RJKUSVN/m08VyECRspN6vZrSi/3ESFo?=
 =?us-ascii?Q?dE5TUPH8dIfYmibYrgkbRx3KGU7HIHO84kN1opbyemyXfOIkCL8L+I/k9gXf?=
 =?us-ascii?Q?qWXwA88x+qj+vJz44Wo5OICnaNte1qBPyzCpufFFXDDU74TKj7xMuxALlbez?=
 =?us-ascii?Q?P6qPo1Ysw1urBPTmcTNRL84zaNaVjIiCkC51YITMkt82UmmWQzxzKNYS6c03?=
 =?us-ascii?Q?fzF+w7/8JvR9XWhWvxl060hyhmM5xClL8LMCKKmuzX6btg7P70Ctn+sfGRkh?=
 =?us-ascii?Q?lsl4GQpPCIPBXWo+ThUuOGL/yXFxtQeE6SkR7cZIfFQZ7w+DApfK0Blr8sdV?=
 =?us-ascii?Q?EWY5KbDmUn19yoIGt0GGt4sILYwE12ilM7QOyGl3TEKVt93yyJ+6E4czZkG2?=
 =?us-ascii?Q?0j21AcQhUq8C7R9pxt+DP5xY9XAPZimvnrP+RolG2iTbk/qk20Ga5kLgBRjt?=
 =?us-ascii?Q?fl9UMo0OAUSBJRT/We8KZVSTQ8uhEpcP7YYCu5l91axXYX9Yz8AO74w1BoxT?=
 =?us-ascii?Q?0mL6EMdYj7Y0Cot231TnI/6gkbKxmzQruTtiXln8X6DzW7GJzAjfsx3ZfyOA?=
 =?us-ascii?Q?7BIqOAB3P4KPhbwiyFzTc0XUGjG2RfgaR6F4uUIsAMxbma+tL9hGugv9KPFs?=
 =?us-ascii?Q?nGWR+eOz+mEe544kCx6zmVwd2ckM5Ug1AQpb+sFpSC4GJTgopQNTxlGVKTJg?=
 =?us-ascii?Q?vZ8AEjSAAubHpldEnfjCaG+MP+ExQqjM5ezRknmk42b3Eh/dpUFamaR5KWci?=
 =?us-ascii?Q?rgLlz7532gJpi7O+swiV7zKIDUr/tw3g+F90eV+0gDmX78ZwN0HssU0N4d9o?=
 =?us-ascii?Q?rBqZAl8GUadpI0IkKDX1EOumu0aflQfJNWyyXPkIabPmvJrrS23f0EfcCFPO?=
 =?us-ascii?Q?skqVDzGN5OT/C7H+Qkhs+3pBQ0OQ3kHdN2uNBfsTZjtp2ExX02h91tsKWjMN?=
 =?us-ascii?Q?YQoOQcAmhcVykWHsB4qBSw/ca36UVxW3BB4WGoi9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78dfd1d6-f72d-42c8-3231-08da94c98b6d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 14:17:37.9404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqLbiN7TX40JyLpBIYH28BaQ7SYL2fCEeyQRZKzoNeNSTyxj9FlQgLHtjGxq/kc8dXB12U+OU3XNnUh4lSM0qv+p/k9BiqaIQCiIZgInMNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5188
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_10,2022-09-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=805 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209120048
X-Proofpoint-GUID: dJ2cUsSrYJ_ZI7N3-rXkgxU3muN3L5yQ
X-Proofpoint-ORIG-GUID: dJ2cUsSrYJ_ZI7N3-rXkgxU3muN3L5yQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2022 at 04:42:05PM +0200, Nam Cao wrote:
> I did not realize this initially, but this bug can cause more serious problem
> than just a memory leak. In the case that kzalloc fails right from the
> beginning with i=0; then in the while loop, "i" will wrap around and the code
> will access priv->apTD0Rings[4294967295] which is obviously not good.
> 

True.  You probably want to resend with that added to the commit
message.  I will create a Smatch check to prevent these in the future.

regards,
dan carpenter

