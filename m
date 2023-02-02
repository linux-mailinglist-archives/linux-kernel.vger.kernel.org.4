Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59531688ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjBBXZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjBBXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444296D05A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:43 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDqUb001798;
        Thu, 2 Feb 2023 23:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=V6qOQLGaYeIUCIDhZQHSdtAL/bJJ94DjBJrTjv6j1e4=;
 b=O+KVTiECE4eOvviZysyYkH469iLxcBcE8trE2rhcZrEmrVpGcZrquJiUbHwYcMEa1Jj9
 Rnf3Ecu1JSZJW8sCEu0dE8FjJQWN0L/801OVZaocFLxSBxZJkkd17cwH4l6JuL5JRri0
 H5YS4ZWGX/WhWNPio5QtHjdxMMOrHBkcQJXnSdwZLc9fB/vp4yGAurqw4O7Phhr8gYQt
 1zII10iO9IG4Lnsc1iic5+4myp2z257bpCHoG77H7FkRypVUEV+3yu10ifG5S28xtD/l
 GT8khZxoZROL2tOUkX5NaEiDIoRc28bSvyp0PgWbnhpm5qIkPljanRBp5BYOwCN8hDRv 6A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64cp73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LJZv9030056;
        Thu, 2 Feb 2023 23:25:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct59hc8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dm2R+NbA+9ykghAev6UBxUL1b4kxwn4/vGsJKcmMXmXGLUXdusps80WvuL059NwVL451L1Xnrlgl8l61LNcI1Zaa0TgMRzEsX0LT39MfU8EiQnufmKgdjdFiuBrAsdAZrlKXAbi2BXcxPuIOgc8H7c+luTY5w5LHXhQswGN2vhDO5DCl1bvNkxMyMcIa4uOGsRotYHjS1SCBMdftK/cREGDoYKapzxEGirqdZ+rRBgkOWXmUJ0WXP5cXShb9mt87vHOKOlNDxTyJjydergsTMA8DKZG3trd43ncMH8OyINQCrqGFrwDt78yZctV3VTlkJy++w1BbqQr7rLTAfOHvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V6qOQLGaYeIUCIDhZQHSdtAL/bJJ94DjBJrTjv6j1e4=;
 b=R5xPQtxAueaZI2AQpihnj4Zw98FFy15KL1zJEsNV7ZPHTilewvGMwTMUyk9weMCmsw3rKVKVaIBq70/pyKKv4TPIKEep+J90crHh2mlvzM9mOc9D5Pgic4VBDkXt+iyJUEkM5e/0cBNed8Sob5NlqYhCts+SMFzq/E4kkDyhQ5ilufCaDFyZV8LLea5fYXwdLn4tlSj0r/Ojf13NpusNzAPANnQTrOi4/CyT0qLcZOszY3D7vdgrpBnNSKTu5m75QiaTi43Lgi4DlzV9+Y03oP+g5Vhz6FES45AFtZ+0sULpNYsIqgfDY6sm/SXB+J+Qwnl9qWqdhAbkcX52tnOzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V6qOQLGaYeIUCIDhZQHSdtAL/bJJ94DjBJrTjv6j1e4=;
 b=D/lHVo75J1MDpM1ysHtglVshZG4MavEKol7CXVnI9sqgSZAMThxU6+4gsjgEnTjYPwpzgXFRgMcQF8hOuwwzAHH8180VjqumzcRF+Fw1DOob4PgzOGrbu7tJbn3nW5RAC9VJ8cn9JQo/tkxPqckpjOsmBjx/R2+DCnQjrZ5ZQoQ=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 23:25:30 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:29 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 4/8] fork: Add USER_WORKER flag to ignore signals
Date:   Thu,  2 Feb 2023 17:25:13 -0600
Message-Id: <20230202232517.8695-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:610:4e::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: 231f0840-8cc5-48e6-35f3-08db0574c572
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pp05YI9f7NhS1NfK+a93jDHgIEiBoMciDHfF/0oc4GWUqmQLX0sRj0LWA2yXRrSD8KPOF2QNkZtfdYB4Gx6KbUqO5SMWxzPOgHnynarzpwWnHuKt9LrzW4tFBZBDBgpxFfAlbJRuBBELgnAyIOwxAoAD0JslqKXnRAtLP9JY6nFH26lwmvUSSetCCV1wunwMAJtKmk+xRX4nF4Utxs6M0q8Fo20RQ1b+8jlvG2/gF/x4iyGAb+IPRvDmZXh81LSTVfumzlLyK583cohI/l/nnfROxrjSaZlnWJbHvuo3KSbqE2+Ywgat93rFrvkZ0tA5tcvXlMGljjlLp0natWsBbT3060oLYquuOP5Jf95g3sWeoIMimRpFbofrWcDpsbaBshepW/hhKJ2pOq60YjqJIeFXWi3xMxahFDP3TEt6UFSwpP6DOJp/HeLNLbQ8sH6TA8KKUoP6zq+q+xygXgwxVWCMmiCdvHiH2gGiTuJTGKBmW/ABXWJymqbAdxBk3PSobdXOXq0QeEHtIEkUTcWkxs499f6V98KEZdvroMfl8+c0HQ8DD+tD+lXYY6u93AHoiK/IIfa0YCCYjf1hAriMIcbItX6XsTTgLYEcFUADBhBleV5qlhUHCx2gamtcURDiH6DtSPDl2XFHwoiiuGrIQfH4hQswd3WwMEHcEGg+pGekt2Ic8a9EwD/SHnPJubrf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(38100700002)(36756003)(83380400001)(54906003)(316002)(6666004)(186003)(6506007)(26005)(6486002)(8676002)(478600001)(6512007)(66556008)(4326008)(921005)(8936002)(41300700001)(7416002)(5660300002)(86362001)(1076003)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYFPeBEhHsTfzxZB1uFDwK3cRt/NJZY8typZvlBh7/bqAbGob4Ft146vVls/?=
 =?us-ascii?Q?3d88gBNOlleGfe5OUlFT419OiRpOuf+WHTGQYKIcwWz272pomBIujgwxa462?=
 =?us-ascii?Q?0bFSfb2Hm+7GfLrT4wdRNogdQqzdxflBbGLquOQ0rmYIylRGXEaj7TWkeDdl?=
 =?us-ascii?Q?sYIgygJyGMhy1AGTquWKvtTj1xhg4++MBIYEdRCWDd+CFQKEpNTb6ghIDsc9?=
 =?us-ascii?Q?jpnXatMAGd7E+PSnM3JilJ6rTNh4/m5VjsTex6uHxhiTVVuNQ2npuOXJUd+D?=
 =?us-ascii?Q?CfZc1N8P19Y3mZij1RfuNrL3hvxWzhTq422rKAVU9kkP7svg53hDj2jIvS6I?=
 =?us-ascii?Q?0d8axZD74S0iHLvYDvi78RqAoTyatOCFsjl74uNAdsyk5hCafIwRTa7hTZpC?=
 =?us-ascii?Q?dA4PSMNVCEYfWhDi3z0uWcDfR2SngvdSdYgVX9R/hkmV+TvZX+/now2P24gE?=
 =?us-ascii?Q?ZSc275SrCcnbPYC9oRuFozMCNwHPT4dCpYrS6RkkdNWp3uwShxu/hC1HAZPn?=
 =?us-ascii?Q?K6TeDVk2qwv3h+u73ExKkP/lyuckaWK6L/yaH32+mOy4bILgPe0MMTnjRa6X?=
 =?us-ascii?Q?IhQ6SHaoGUj5D5fLvuHWjsmUdiPljeOie0R6BVjPrFBDOwOQUY474crOECPv?=
 =?us-ascii?Q?w0SqGTem8Pja0nm/7pWyWV/9c5mbmIZ3wB7E2XI6iLViqMzk20ygIp+B/ejK?=
 =?us-ascii?Q?BTQD/jrF+zYKoxuLru9idmg1Y5KxgepLEzg1jEneT8hUGWb+YX/1qyQaqTYf?=
 =?us-ascii?Q?d6Lf8GqC1k/FGU7vI8bLrf3ulIP66+ifA7zWXOZ+6gq2biOUCPAwHWSgKLbw?=
 =?us-ascii?Q?nWLgKvgAkgcssX0LkbfejHZLHR1kLXFphugStS6K/dNGX9v4wf0W3IaLK7vZ?=
 =?us-ascii?Q?EMdMUQIzawF1H+ypR89b/8pd7Vu/rF7iFfpWkphtGjOeL9HUtGcwzzqFmiae?=
 =?us-ascii?Q?zz0OVZVKlMeYlzIYfpC55OAt+JHUjsGxYnyWlDLG/lHVMBAzV9guAZJTn2by?=
 =?us-ascii?Q?YL7Rqq/LJSMmA/r7FI0BmuImt4ZSW4pLBQi7eJ/vikl/wQINFhTkbFknatuP?=
 =?us-ascii?Q?HinGDNBbgfXAcrk3wcb792OGQR4pkXj8eCVthXQAUDl3ebrR+mvvf5b+ohXz?=
 =?us-ascii?Q?H8T8Y4aWrsE/g01LC2XPnHng0xY4tS9mKgypmo8CijpPZZp0vGHx8fHxGwWL?=
 =?us-ascii?Q?t72i1S1xoheT2Cedsk+UygfkMg4KDbKytxdeCPqNAfUyL5BxAFGhISSravQB?=
 =?us-ascii?Q?hA6SIjUZymOW+TYjr/WAsSf5XhSFqjZgIXcloZ5vP6TQgQgtWquNqd6AgqLG?=
 =?us-ascii?Q?4e2RDsK/XFk1KtL1y4OhW8TmJkVRWC6Jxx7sYcOR8P6M1vBpetMusrCeClcr?=
 =?us-ascii?Q?f3DyoqiWuzOn65ATyNdSG31z6Z2ZykF4Qquh2lUknq56lsVSGYCtSQs/d4Bg?=
 =?us-ascii?Q?iNikli7t/M0uLV9amfEfKvQXRmMQ/Q8PfFoZZSxrtdkfbnZAv2BRtxiM+fPC?=
 =?us-ascii?Q?XkIWJ3DXUOyg7IsTdZw5ra8m0T6zf5C/AdEqNDEVUxfiXCoO2yTL6SVJvfSV?=
 =?us-ascii?Q?sEuQE8GztIpcn+Wxp4ivk7dCnr7wOAHrTImbKAQWpLtUpKpmaP2JXh1ysjkC?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?n+S8VVckaX8JywLItpLwuuu4ykMauADpEKCfUne6ru3XXDxh6O81h68Dhgc4?=
 =?us-ascii?Q?O7z72c6D0BkiMeQJuriRYRd61ypkqZ1P4jrRYBi56rTweo4Ge/ssKhaWj4zj?=
 =?us-ascii?Q?XNvUDNKPB2Fvg+fuFeAb6LRcSlrwdsjP8A8uDTYAE6hx7OEkm83fd8PnvQYy?=
 =?us-ascii?Q?kIw6PiVm5got1oCjm3s3Y8VNxqjF2Wpo3tB2fhAAhjsFyW8Escvudb5ixQGY?=
 =?us-ascii?Q?5ZK+xne9EtW9ZU638HEchvitFfFsEoYGhwziU5Jxje7txwPXWqoj27uiJqwT?=
 =?us-ascii?Q?52XEw3u5Zsj664GqaP3kv/1RzC5oV6tR6WijnJdlkuFZkxHZBzWuHucMciNe?=
 =?us-ascii?Q?Nkh46/xPhHMPpmffM3AzdwUg9Yv0uJ3mvmgDmLhzhC4ReIqImnYraDCgAsHO?=
 =?us-ascii?Q?d+2LVH1LkE2PGW5txjLYgLyV9r03BTIJu/SzApVRMWvkyI5OCYxyzY+9XtZ8?=
 =?us-ascii?Q?TY/hubBU6pHtkWIowdVUrSOJMEW4qnb2nFHArsdxo6C9Fn15+SMSqzVJA0/6?=
 =?us-ascii?Q?tus2r2MNoV6HhWsQ9qtiGSEcbAXCUHTPnrYDbYr2MjIChFRu3SXEDse5oUoj?=
 =?us-ascii?Q?vHCEHVPLAqFwz+/N8DAXTbVNDOOibHSqybdK+HeaOha7UOryUZhzWrxmqnwW?=
 =?us-ascii?Q?qCROJRIKqKjw6yH9pqNmFPbqVkBo//7H9Aw79ChoeflXyziDSuY7Ouw6h+lC?=
 =?us-ascii?Q?jmtWrTdrVziArE8uKEFC/QDbMi70BZO9fLbL9DrbQGKR/iqDvdkxsOmrE31j?=
 =?us-ascii?Q?+rLye+nTWExRmyO78EkDakUrIotHAU0rinEmFRu1JehhCeCpt2mSBAhHwqq7?=
 =?us-ascii?Q?etbGD4toh+dgpSSj2DjPKM5TLKPqP+cJtDVx7zCyzdWS6fox2p15prZ2JdyP?=
 =?us-ascii?Q?mEij/cDJZrK6rGrHSeSjYqbpfu/4XtMkh69othrhNzIcDM3LCbygicV176sX?=
 =?us-ascii?Q?5VBG1uD8N3Hy1OWgrSlRBAWPxX22jQtfF5q+gFeCCfnpBrd0UBmhuEWvAcuP?=
 =?us-ascii?Q?txOq9A6gANYWZWk72asZCdVhUEhviVGX1R9J9gFoOV8ifCk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231f0840-8cc5-48e6-35f3-08db0574c572
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:29.1404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xmQ6ftIpB3wIasWsGnitQRmMvJTfzr4gPjk6F8gpibbOpybj7OOw3Q0NILdjgEQu1JSboG2IiDIW40Jkz/wHhTfCO/Y6alogi56ZvfoXwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302020207
X-Proofpoint-ORIG-GUID: I8NtYgJlzj251c2bGSMwR8SnTnA9KWEg
X-Proofpoint-GUID: I8NtYgJlzj251c2bGSMwR8SnTnA9KWEg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches can continue
to ignore singals.

Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 18e614591c24..ce6240a006cf 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
 #define USER_WORKER_NO_FILES	BIT(2)
+#define USER_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index bb98b48bc35c..55c77de45271 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2287,6 +2287,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

