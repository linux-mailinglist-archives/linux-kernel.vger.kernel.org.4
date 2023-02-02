Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230AE688AC3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjBBX0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:26:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjBBXZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:25:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B99222D4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:25:45 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312IDrIf001865;
        Thu, 2 Feb 2023 23:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=pTGOE28ZLu0dY7Xtp2QMA+hWdKvuK4lBBbVsaSNu7sQ=;
 b=xGZGO7cFoSXZhFyRe5vLx7Z1AFMnHa25E9hRCfO4/Jzy5lc4RTpMTwdPQKdavwjsGUi/
 tkTfL9qA61qxq3OeL3hXX0NvEJss7MG6gxl/jowoEyi2yGwYEj+jfbTc+1KMYJGWoGvr
 2atoVzHaAKQWIzepJ0xWgb+q8yHnHzrAwOMnmdPy2W2Sdmispisk7v/I4AALjaoR4kPv
 Zcgcd93gFJRzRbiPV5vnodbBOY1oROH967HYkict+TZ4y1oSdQr/jsFLikt1aIOVMKIA
 Q13lJ8Pg+Ew37SenJTxJOez/Kd45DjmtPi7RiKCdjySwoWvdyHdPM4a6cuVgIj1iWlnn Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfk64cp76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:37 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 312LHDgV034320;
        Thu, 2 Feb 2023 23:25:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5gbb0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Feb 2023 23:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aj3b4730hgz8sztqRVVROYMQm8/UCA5wgWwv1ZwmCPJl92iXiz9Wp04RTIV/dEDETTZg2YXG7EapbM12MO7jTAITY5TR59kdod6a3Cl2EhhtPwEd+tsk5gQSb6AVFTpdvrFzwwgL5jw65TNoj+er8UY268tCCgFeZexHwwV0jU+DjCnu0lGsiYBuqd8cnX8yM96MPAX9zCU+tSb399uZ5HZWYWwVr2Yk/FX84+htg2+dOuZ/WQodOy9mFYmJ8vnq+/+y2zE0hcEO6e45YQKFUsp5BHgVUjgDpPjKrwayWiIMSdWRLvKfqjEtrilBaXdQrvg51QqUAlVeEM6YOVr+qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTGOE28ZLu0dY7Xtp2QMA+hWdKvuK4lBBbVsaSNu7sQ=;
 b=CgDtvuOIx5iTKBtYWCUqudy41MqdnE6K/KMmbA9gl/kImepC8RMh1X8S1fmKZd7y+FdtS4OSruOuhvkMwQwPZ3wGmOiuRNQtvy2WOZIRd81l0kc8TWtdbwATgC/ygeudKJMHYM299yoNoxFo1yErKLCJcgv6aPV1D09XtOq4ikJRD1NpevUL7ukJVvV1JuuLyKvsLJsPjUc2OQVpYuVeFFPrfZqqPHFqC0EKbNc4mCVw7LAV7BYUSl3BgP6H3aJZFzJXNqlsRAIGzT4e+edtUi/FLQ8g6ksUaYwv9hWuF/71IynEA6B9VazlNdGUg5v/yYoX/VtsI7r+5nUrMC888Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTGOE28ZLu0dY7Xtp2QMA+hWdKvuK4lBBbVsaSNu7sQ=;
 b=Gy8uxu9uU/e2tZk5oWsKBK3vGR33naOyTvPWHQYUSLqIiuwoSE58ln2og9GnULKXN/julqC8UCr4nXQWePq6tg+u9H48v7e7+2oxvmbmGR96uQb+PEsVmEU9F7gaxhe7uAafiWLi8IDFai2ZtzjLxOICqag3xcnKtuB9fp/KYAw=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN7PR10MB6643.namprd10.prod.outlook.com (2603:10b6:806:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.22; Thu, 2 Feb
 2023 23:25:33 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::c888:aca:1eb9:ca4f%5]) with mapi id 15.20.6086.008; Thu, 2 Feb 2023
 23:25:32 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, brauner@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        konrad.wilk@oracle.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v11 6/8] vhost_task: Allow vhost layer to use copy_process
Date:   Thu,  2 Feb 2023 17:25:15 -0600
Message-Id: <20230202232517.8695-7-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230202232517.8695-1-michael.christie@oracle.com>
References: <20230202232517.8695-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH2PR19CA0028.namprd19.prod.outlook.com
 (2603:10b6:610:4d::38) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SN7PR10MB6643:EE_
X-MS-Office365-Filtering-Correlation-Id: ce46ccdd-b912-46bf-103e-08db0574c7a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uu1v2tklhMBvvT7qT0eCHiBneIja+zG16JsiY4VJQ15hZbTjuANIVG5fUSZBqG/Le6Spe67XgC7eDVESkyyDZu5t8yqc7Pyoek+mOKsTuGTKm8BDOlnZAbDW9xNK1kuo6NbZeWyKPN4d8SB43LPnskEFxweTrh2GFgrPJc0QOUTxt3hWn0n+GYkYEsP22W3tMVLpKKnfMdRrdOu9xxClECf/73bbd7xHDCHNRuuarAVoq7uTFcCrNRZhhkND7mDZBqhKxBAowvTcqfT2dxqPttVCTmOeZcsRMuTpUSbgvnZebI1TrlvKczcW6b28fkAouygvzxJvJNSPuSyO37qJIRwbnEcW7JbGrlUd1RSUQGl5SmzCYzyQ3+uW4o4bS3T0+inQ5A1za1Oo7jh4I91FhUtsDrpDCo29z8qqCre2D8D8ZE/oGNiWcNdfUpVYO+8VE9/xSr6VgHSaFIPNnhD2e+s9iBzY2mGCHXKML4N+/BcARaWlZZtjElYkCvuKTqxlm17hFds6zZ2hK2zKug1bhJfnk3iU9BRU1B8GFiyAZtagEEmX3Uo0HxGH3zPAiHHRjz26mj6xPckP52WcX/nyZVjrOeIneOV+SQXJPSat4t9Ab5AlzVUZZ9Vv/EIkMwv7Y0WUrEMQgsos//FJt9Q7+YUxNDNYS2CFGiM+7cxKYrH7JczzuZjVJ2B1+4K9wNCW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(2906002)(38100700002)(36756003)(83380400001)(316002)(6666004)(107886003)(186003)(6506007)(26005)(6486002)(8676002)(478600001)(6512007)(66556008)(4326008)(921005)(8936002)(41300700001)(7416002)(5660300002)(86362001)(1076003)(66476007)(66946007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UlTaSGrfMWfOzYjEyBwOMbznnU+50LVoCrcUbSV77drkBWziMTq1d3+Abot5?=
 =?us-ascii?Q?YZatVNLbWUVomD+DV50EJ+xCS+VWVSSvbRy8mmG9OWRR/FH6FrXg87v9+XnZ?=
 =?us-ascii?Q?wDoWiEYjGKZSPK/A9s3Y2sxXdYAdNoO8xEVzsiXiUoBIzNVlcmTq5oPX5Gbf?=
 =?us-ascii?Q?75LcxUnCARy1zTLkk+bU2ho2p/rUtRweHxcaTdKIQZqUH4Ngp/XUTE5D3GxN?=
 =?us-ascii?Q?6cUWBXDREj3QLH4N2QsgGNJhTGXMGViqPsY8VKWD1pICFPqBD4VJ1xOkKXmi?=
 =?us-ascii?Q?udquokkh+GY2yFja2gOmQBxw7WrVVAcNq5bj5RTbS1KrXzc+OfUdRJcIm3I3?=
 =?us-ascii?Q?bM/AKbFAl1wQQKEVkI3IHiCwHDesrp2YM3ESnU9+PuGWOOT0Oge5c8vyiAFN?=
 =?us-ascii?Q?KGN2yYWmx5tbb1aqBb5B6ConlfvkIfbF7N13nFryly12IzUu/TF1mxceeDwP?=
 =?us-ascii?Q?cU7wsEPp+CsZdrnCMwtNhI5bQCgtDj4BtyWNQ4v2FAM5Ln7ktY3QWJwcJApV?=
 =?us-ascii?Q?4edCBvXOaDA+9DupJOIB2Glm8QIvVs1QL0aiyMHOJLzZsqpuTVWPKow3914k?=
 =?us-ascii?Q?t2wxdrj9asMAH1O0zNxrP+rcCgO4WaQOpNi+Mqzfqxifo8Pip2viVGWAGV3G?=
 =?us-ascii?Q?PKoN70dHgb4eITwsvewmtjxHysj1AXVqUv4rF8OABUEKONWzkSmAJ1C2Utcm?=
 =?us-ascii?Q?n+aizWC7//FjA/U5WSaWD7A7+qd/hXPlKYWruP3KzMpsOteSPEE5AYJJpNmn?=
 =?us-ascii?Q?Vhl9cZM+Cfg26oNQsoR77StASJ/VVorIt4p6wGIS+Ep6Qc0NKUJRzqIIFLtS?=
 =?us-ascii?Q?+RKJ0c5Ml/KJxA3Mr5JhZdsfCuPexgmfSaTBa2kOKE628lly463Yaw9JkBGh?=
 =?us-ascii?Q?YmzcQ3w8RqbBuIoGUB23C1oWGdEVVG+L+tAdi1H5n0CvXgsR1nXBlPSTr9dy?=
 =?us-ascii?Q?fCrPkyVmWrDYrsyHSTfc8EG/V980Jp5D3Qgxu8l+Wz6Fj4NqfDKO0bh+OdDr?=
 =?us-ascii?Q?kGapAw8QYQP7lJXkGuAVFIShSBLcHWG6lI5MZxYv+/W7sQq0PSYa+Mc3MLgK?=
 =?us-ascii?Q?ZuOviAX0qHVdMN28gxQU51L5/XCNNXp0n3ZCh9VjsvGd+zZ7c42pP+LCKP0Q?=
 =?us-ascii?Q?Py+HtdZIV06dnRTiGISx3HQgmeLK4alQtvIPCQaV11W/O+bQegHmQ/Gxk215?=
 =?us-ascii?Q?yGnJEOLJNgw2IYjD8uzczgHy/rz2f45cKhW1KIp30F8HcdCOm5Pg6JNI5gfl?=
 =?us-ascii?Q?AZsET2bzyYs4vy/KlCVnLwuntVefLCiNinfYgRioWUlK/l1koIge9Lu8KOG3?=
 =?us-ascii?Q?b6yG63ooXf3nebwqvW1tYI+i/fnUV0KJ7mAGfB9R5DWTPRbJIYsdeQsw1M2o?=
 =?us-ascii?Q?+mdqK+Ty/AuayA87mtjvWpHYGJ0KpBo1BV1JWqZziZw+s22WnAhMeoxmPYRf?=
 =?us-ascii?Q?MpCg8y1vJuaCujc2Rz2q1FGbzYDvJJOb4ejOj8S6OSh8O/B8cT0x8JlONmdb?=
 =?us-ascii?Q?JVZZ0ulSIAxlpNE+UqLGU5zNCRRBGCqCeb3cgNlinMkKlCjAmdyj4jERWqvz?=
 =?us-ascii?Q?n7dOwXwQmst4QTGKzh8P2YfAu17VO6CJa/AUTRyOn0BVAMYZfQTyZ4DGQLHF?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?58ECQN04zFkEg4PEkJRDW5Gh4FYhZlliR5d+36L53jTGI+iQ0TaFF6dg6w+0?=
 =?us-ascii?Q?3/Mf3PiucHFmhr3TLwZELjq8MHWxWTHNoT4u+NqtBee5jEZ2RlGBdAhTGnG0?=
 =?us-ascii?Q?NCxsuXwEi2mCRLyZtS2bS4vMlP4cDKAAO/kX2pcyMly8IB8TR7ms0MUKRFRz?=
 =?us-ascii?Q?cDpu3L8q6G356yrKTqczcoF3HIeXeaWW5dwJ0cQ7RJG30c3+4OmdncV9U+TS?=
 =?us-ascii?Q?ax4txCJcmj93WSRIH9O+ebzIW5oUu3AvWrtlunFwgQXNKFvXSDRQyXme1BPX?=
 =?us-ascii?Q?LplZXOyR5sJpAB6kBoBDC+13MKleujVHWb8w0MhUhWfWgbPnrM4NHpl1OHue?=
 =?us-ascii?Q?wj6cXvgLX8RzO1N0090NyYCmO73eAn0te6yTkfXacVAUby/UpUUb68rr5IO1?=
 =?us-ascii?Q?f1CgVYkUgDqL35Xq8vLyD2KGIJuNgCEP0dRZprlic/i+pHZ4HnNl2LSsdJbw?=
 =?us-ascii?Q?NVHOxZ2WEnmszJt321KI1bwQpViPalFCx2/RfX1k2J3wrO14kak70J+50uxb?=
 =?us-ascii?Q?FcILygWpDUIp6qRcBykfsztpuTVo6H6PM2BFZrebTtprbXaY8u1FcBV028KI?=
 =?us-ascii?Q?KNEvAtQU12o9dk1ztUmH3u98ONwNGJPaZCoXP0yTyM0kskYkL5iFHJPaxec6?=
 =?us-ascii?Q?kIH91a4+GDj2oH4sLMGE1N7HgMspZxglhzOiODLk/2uHN7WOPnxrLMqaaJ/S?=
 =?us-ascii?Q?TlwS8b2EFU5czuNxGomsOt9kV26cTs95U73rcq6Wb0/g0R214iWK8tw5cggh?=
 =?us-ascii?Q?c4HAsCooGtfRY+6jU4dr/LRpFuNDTEXqzfiQm1n7kIxAu4Tp7CC7u8CG0KLD?=
 =?us-ascii?Q?WP9qEBOXjbHn4PRg9Ih0USDArfr20offle77a+/q99Qkq1owKjFqhmOuhili?=
 =?us-ascii?Q?1/8MWQ7mH/AMOQCMNkZbpAXKK3wA7VB54dIlOqsBNKm2geXyE0+Hs4LDq7BC?=
 =?us-ascii?Q?w15nbmvBB44VLMRHniXlN5zTWNCKWLIC74CyiVY+bxkYuSIAW8TTkwaDMNYV?=
 =?us-ascii?Q?+H6oci8o4tk8IBGagU2umBEMtg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce46ccdd-b912-46bf-103e-08db0574c7a0
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:25:32.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B+Y3FhiRpTK/FcmYNNky6fi5tOOsv0qMKvtiPHD+lh3v2FVFQ+cqfH6T+k6OSclGeIOTNyXfG7qOjosAY2X+WggVN2/yLYbUul882ExMkS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6643
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_14,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020207
X-Proofpoint-ORIG-GUID: OIlJ7ZTPSlTqrpPyao5rFgRqefqZcWIz
X-Proofpoint-GUID: OIlJ7ZTPSlTqrpPyao5rFgRqefqZcWIz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qemu will create vhost devices in the kernel which perform network, SCSI,
etc IO and management operations from worker threads created by the
kthread API. Because the kthread API does a copy_process on the kthreadd
thread, the vhost layer has to use kthread_use_mm to access the Qemu
thread's memory and cgroup_attach_task_all to add itself to the Qemu
thread's cgroups, and it bypasses the RLIMIT_NPROC limit which can result
in VMs creating more threads than the admin expected.

This patch adds a new struct vhost_task which can be used instead of
kthreads. They allow the vhost layer to use copy_process and inherit
the userspace process's mm and cgroups, the task is accounted for
under the userspace's nproc count and can be seen in its process tree,
and other features like namespaces work and are inherited by default.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS                      |   2 +
 drivers/vhost/Kconfig            |   5 ++
 include/linux/sched/vhost_task.h |  23 ++++++
 kernel/Makefile                  |   1 +
 kernel/vhost_task.c              | 122 +++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+)
 create mode 100644 include/linux/sched/vhost_task.h
 create mode 100644 kernel/vhost_task.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8a5c25c20d00..5f7a3b3af7aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22125,7 +22125,9 @@ L:	virtualization@lists.linux-foundation.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
+F:	kernel/vhost_task.c
 F:	drivers/vhost/
+F:	include/linux/sched/vhost_task.h
 F:	include/linux/vhost_iotlb.h
 F:	include/uapi/linux/vhost.h
 
diff --git a/drivers/vhost/Kconfig b/drivers/vhost/Kconfig
index 587fbae06182..b455d9ab6f3d 100644
--- a/drivers/vhost/Kconfig
+++ b/drivers/vhost/Kconfig
@@ -13,9 +13,14 @@ config VHOST_RING
 	  This option is selected by any driver which needs to access
 	  the host side of a virtio ring.
 
+config VHOST_TASK
+	bool
+	default n
+
 config VHOST
 	tristate
 	select VHOST_IOTLB
+	select VHOST_TASK
 	help
 	  This option is selected by any driver which needs to access
 	  the core of vhost.
diff --git a/include/linux/sched/vhost_task.h b/include/linux/sched/vhost_task.h
new file mode 100644
index 000000000000..50d02a25d37b
--- /dev/null
+++ b/include/linux/sched/vhost_task.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VHOST_TASK_H
+#define _LINUX_VHOST_TASK_H
+
+#include <linux/completion.h>
+
+struct task_struct;
+
+struct vhost_task {
+	int (*fn)(void *data);
+	void *data;
+	struct completion exited;
+	unsigned long flags;
+	struct task_struct *task;
+};
+
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node);
+__printf(2, 3)
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...);
+void vhost_task_stop(struct vhost_task *vtsk);
+bool vhost_task_should_stop(struct vhost_task *vtsk);
+
+#endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 10ef068f598d..6fc72b3afbde 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -15,6 +15,7 @@ obj-y     = fork.o exec_domain.o panic.o \
 obj-$(CONFIG_USERMODE_DRIVER) += usermode_driver.o
 obj-$(CONFIG_MODULES) += kmod.o
 obj-$(CONFIG_MULTIUSER) += groups.o
+obj-$(CONFIG_VHOST_TASK) += vhost_task.o
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not trace internal ftrace files
diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
new file mode 100644
index 000000000000..517dd166bb2b
--- /dev/null
+++ b/kernel/vhost_task.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Oracle Corporation
+ */
+#include <linux/slab.h>
+#include <linux/completion.h>
+#include <linux/sched/task.h>
+#include <linux/sched/vhost_task.h>
+#include <linux/sched/signal.h>
+
+enum vhost_task_flags {
+	VHOST_TASK_FLAGS_STOP,
+};
+
+static int vhost_task_fn(void *data)
+{
+	struct vhost_task *vtsk = data;
+	int ret;
+
+	ret = vtsk->fn(vtsk->data);
+	complete(&vtsk->exited);
+	do_exit(ret);
+}
+
+/**
+ * vhost_task_stop - stop a vhost_task
+ * @vtsk: vhost_task to stop
+ *
+ * Callers must call vhost_task_should_stop and return from their worker
+ * function when it returns true;
+ */
+void vhost_task_stop(struct vhost_task *vtsk)
+{
+	pid_t pid = vtsk->task->pid;
+
+	set_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+	wake_up_process(vtsk->task);
+	/*
+	 * Make sure vhost_task_fn is no longer accessing the vhost_task before
+	 * freeing it below. If userspace crashed or exited without closing,
+	 * then the vhost_task->task could already be marked dead so
+	 * kernel_wait will return early.
+	 */
+	wait_for_completion(&vtsk->exited);
+	/*
+	 * If we are just closing/removing a device and the parent process is
+	 * not exiting then reap the task.
+	 */
+	kernel_wait4(pid, NULL, __WCLONE, NULL);
+	kfree(vtsk);
+}
+EXPORT_SYMBOL_GPL(vhost_task_stop);
+
+/**
+ * vhost_task_should_stop - should the vhost task return from the work function
+ */
+bool vhost_task_should_stop(struct vhost_task *vtsk)
+{
+	return test_bit(VHOST_TASK_FLAGS_STOP, &vtsk->flags);
+}
+EXPORT_SYMBOL_GPL(vhost_task_should_stop);
+
+/**
+ * vhost_task_create - create a copy of a process to be used by the kernel
+ * @fn: thread stack
+ * @arg: data to be passed to fn
+ * @node: numa node to allocate task from
+ *
+ * This returns a specialized task for use by the vhost layer or NULL on
+ * failure. The returned task is inactive, and the caller must fire it up
+ * through vhost_task_start().
+ */
+struct vhost_task *vhost_task_create(int (*fn)(void *), void *arg, int node)
+{
+	struct kernel_clone_args args = {
+		.flags		= CLONE_FS | CLONE_UNTRACED | CLONE_VM,
+		.exit_signal	= 0,
+		.worker_flags	= USER_WORKER | USER_WORKER_NO_FILES |
+				  USER_WORKER_SIG_IGN,
+		.fn		= vhost_task_fn,
+	};
+	struct vhost_task *vtsk;
+	struct task_struct *tsk;
+
+	vtsk = kzalloc(sizeof(*vtsk), GFP_KERNEL);
+	if (!vtsk)
+		return ERR_PTR(-ENOMEM);
+	init_completion(&vtsk->exited);
+	vtsk->data = arg;
+	vtsk->fn = fn;
+
+	args.fn_arg = vtsk;
+
+	tsk = copy_process(NULL, 0, node, &args);
+	if (IS_ERR(tsk)) {
+		kfree(vtsk);
+		return NULL;
+	}
+
+	vtsk->task = tsk;
+	return vtsk;
+}
+EXPORT_SYMBOL_GPL(vhost_task_create);
+
+/**
+ * vhost_task_start - start a vhost_task created with vhost_task_create
+ * @vtsk: vhost_task to wake up
+ * @namefmt: printf-style format string for the thread name
+ */
+void vhost_task_start(struct vhost_task *vtsk, const char namefmt[], ...)
+{
+	char name[TASK_COMM_LEN];
+	va_list args;
+
+	va_start(args, namefmt);
+	vsnprintf(name, sizeof(name), namefmt, args);
+	set_task_comm(vtsk->task, name);
+	va_end(args);
+
+	wake_up_new_task(vtsk->task);
+}
+EXPORT_SYMBOL_GPL(vhost_task_start);
-- 
2.25.1

