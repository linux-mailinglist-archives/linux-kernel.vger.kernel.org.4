Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A66D92CB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236471AbjDFJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235883AbjDFJdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:33:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E1A2D43;
        Thu,  6 Apr 2023 02:33:22 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3366wcTt002657;
        Thu, 6 Apr 2023 09:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BDmnOG1K5DTStMeuC/xWLwJZy8XoxNOEa5fXAD81OaM=;
 b=1bGj2h6ki8uyWB8oWxRkvagnZu9JaQakN4W/qWo79/MjGakHNdPxcxwedSrs8WtdbOsj
 YOMqKCgUc9f331ynXAwcnJAVc8r3U9g89cEPIwxLSOQBtIbC3OmIjldSViEQQ/00WIQp
 Ziz19fgJvQre006IMKKutP3RjemH0lMaosT+apLMlt6jxUqEutpRbF/tD6jKf5Nkv8rN
 08PG50jUek/tVT7XTh2OveHpKUtUh5qiogAwgGWihbZ4hN0OAPNQ3bAYELXyUEWVCM7u
 B9Y7FB13Vz4/1Gd1Hxvhkd3htQypE9JJAHOHg/TttQ/n1jdxG9iwFYLDz6bytD4yricP KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppcgatdwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 09:33:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3368p5wV039592;
        Thu, 6 Apr 2023 09:33:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt2964vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 09:33:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWFEDSObac/sAdC3hpUuk1MyhsnM3bPbXaGJxmtGubeZqOOgThMy0FGqHna7T2mJ8I6baOVlOdQKvzBj0CqveU54MKr29a8n/KMlTWJmK9jzlzQI5HwUI5q8BUz6jDYJaGSaDjbvsPyz3B0ZhEnYn04qNfoJ1PKRoo2Zv3uUF7AcqU/w4nhkDrjc17FB4nv4didHBjQukxtQlukQQv3OtPmpD3rH6zefTShAv66mImsuhGXDNQ2JuP1NXjPfNzciHgxTeFIA/ZSzmT2ekjNxOWPb2MhWBgdTr+QvzJ77R3EG3FTvaLS2RIhcdEla0wzMF9vb5NaTHDt8skQhtlXNMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDmnOG1K5DTStMeuC/xWLwJZy8XoxNOEa5fXAD81OaM=;
 b=mYH+Hm7SsCmSYFCB+z8Novg7EV9fTg9RTt/KzDoWciHNiAWlz1IBk8aK+clrNnXlh/ocJ+Ov32DamvhSMndBxcTpDwjO1OaHj+c2DJbmphhVZv81XHyudAvY6QNpFIYBt0/6KYYZTVIBS1ZhRDXOidA7sKG9jLoUza+QUM03XyHMCAd7OVKNjxSH1LUxvpulYLQnt48m6TBzhk5MhS1O39mTpJOD+rLa/pjn8HbbtHl5TtxfP7tMA7yf9Dba4Ow6z7oGuzJ9WESa1Z8p5r3aYqtzH5MxKJG1bOC05HJLeOSFTrrk+Qndqruz230gMUp4VHhK8/cHvo8zUsH8gr78Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDmnOG1K5DTStMeuC/xWLwJZy8XoxNOEa5fXAD81OaM=;
 b=d6FPFa1Ih5Tb9L821K9WcPGvtFA2P8Yw6lFzpe5ZlW8pe/fH5I3eRduGyuStPh2lKKhYCSz6q5T2bljkl4JmuYXITlIy7Bc2QKw0iRp1N/a3JmY3fiMJJi9w23puwLOXGE4TZMTVqFqbzFzQOsrFFlHYWh7OszhMlGAuYqMhWuM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5648.namprd10.prod.outlook.com (2603:10b6:a03:3e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 09:33:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%6]) with mapi id 15.20.6277.031; Thu, 6 Apr 2023
 09:33:16 +0000
Message-ID: <cbd9d71b-c91a-9354-96ee-e1e2c541bbc0@oracle.com>
Date:   Thu, 6 Apr 2023 10:33:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH next] scsi: scsi_debug: Fix missing error code in
 scsi_debug_init()
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230406074607.3637097-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0024.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f06709-b593-4220-ad10-08db3681f372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6ywRGkvjRMNPB42hKaoKcxxQ+nMwd5KoFC2d8sQhgj93MYBvacnbBx/KByz0Clg62IcpbaK8nAxP2QZzL9znGZ5Anhsv4W0ppe+oRQjMAxcSEE6m3Y2//ZEaL5hOYbzlCSQQSkwpuh6dBhvx2fsv1x3RxiMiZVV19lU9mPC6VpKfSjXq/lK3RaSCQbeywTDPsbFmgqGubKkGj3JOubIn6ysCN7cLIwXmhGvgxaGspKGITQ+y+QXqIHws/gcrQi7XFYXpo97+/2Fg5JywltDNLyNbXcQ2sw+6uLI2lJHYwVQFDNNWfsnafrvKdvUY3CzfqHXGoLMEStMtpAxFX7n8e9aHrybl4Cj5E0UIADSfCuLOYy95wvtDTj6YGnaulHoUV+IB1qApUuDkMKAvrrYT8EIpbX4UFisJmKmbRSbS3OXHZpgn/ag73SAzfLhdhVnXi2h1L8GuEMPWrqGLzcvsFPBM8Z6uetbQ+kY08f3+u/8ZHiaj3LEKGdU/RZRtgRwKnVR9XZfasYZVETesPwUlO0qNM8XLFeAAQvExwxxTXGwmX/yRFvaSFf+c0CbqNqS1wv+7j0296w5l7Hd1GbiVzZuasf9bCTopDbt9ikFFqzuETlAhj0IZUgDc/U1dtNN2PD4fo8eRrj2Cvf4Vcknww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(136003)(396003)(346002)(451199021)(31686004)(2906002)(86362001)(5660300002)(4744005)(38100700002)(36756003)(66946007)(478600001)(36916002)(66476007)(6862004)(66556008)(37006003)(4326008)(54906003)(316002)(41300700001)(186003)(6636002)(8676002)(6512007)(31696002)(2616005)(26005)(6506007)(6486002)(8936002)(6666004)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmNZeVhCZ0FrcEhoSnZsUktmVmxJU3N6eDdQc1JNNmg3RlYxeFI4U3Rjd0lv?=
 =?utf-8?B?b0tmdzhqMGdPT1lSSTkzb0lvV3k3cVEzOHFTb3RXdDFDK0M0VHhMbzhXTThZ?=
 =?utf-8?B?TEJWZ3hreDlYendzb3FPVERiT2Z6TXJPQzlTejVpN1B2bEEvVEJuM0poQWI0?=
 =?utf-8?B?N3dHa056djhrSnF3SmtlMVF4RVFQTE95ZDcrakRjRm9nS1VFMEovZGJ5VXhG?=
 =?utf-8?B?U3VHUkhncDRlejd6UmlJMFNEckt6RjhxL0ZZakR5NUEwSU9GY0tFcVQ4cTVq?=
 =?utf-8?B?bEdHcnVaVmh4NlJ1TThHVGROOVh1Z2d6aDVhS2dGV0Q3UU1rZzFKM0dBY2Zm?=
 =?utf-8?B?WEhteDJQNzU0K0paYjlLVmlxaUlGR0ZiS1l2MDZ2UXp2UUVLVkdhVmgrK211?=
 =?utf-8?B?R2haRDgrY1pqY3MxY2FOdGt2YmJGNEs1NmdDVzRwb3U0bVlpNE4xZSt6cWE4?=
 =?utf-8?B?OEJLd2ZkN3NxUVZFeWVwNmUvYTQyTjlUWmdkZkRteittUVVhRmpyOS9jNzV3?=
 =?utf-8?B?QjlhYjdPM3NRcFozSnBUeHJqYkdNN3ZjQnhyYjNLdFkrWHlOcEZlVXlqYUo0?=
 =?utf-8?B?K1RQdFRSeVJxQ3FYQWNvNGtSZlVlci9DVGdwWkg1SFVXNmN3UjdIKzU2b1ZN?=
 =?utf-8?B?NVpJMnFSY1k2MGxxNXQ3MXVyVDAybFZ0clFYZlp0QVhvMHlpRlg2aFNZRzdR?=
 =?utf-8?B?aytkUktHcDQ0a2RLSnNBVlVKRThWV1R1NkljRU85cmNsT0tIZXZDNzNGUHFR?=
 =?utf-8?B?N0ovV2lvYmN5YXJOamNEd01pWTB5aUpTQWgvMExMdXlJTEdWdW5UemhJbG0x?=
 =?utf-8?B?ZG9rVGZ2K2RuZ2M5aWpDcDFoenB0MzEyV1NNM2dBQWpIUHZVaTlIbjNBaDhw?=
 =?utf-8?B?cjRoRm9TSm5OL0tuMFY4VUE4c3JIVmJHRUtacDNxM2VzZ3poMWdXWnovUzFk?=
 =?utf-8?B?NVozTnJYWDRsbjA0R2oxbWxFUnpzNFVhcHBKUnN4bG14MmFZUFNQYm1Mdm5n?=
 =?utf-8?B?OHJLeGRrZVdTK1lVUjNCTVdtYjJCUUg2ampNaDJpUmFBbXZpcnRKOTB0bkZ0?=
 =?utf-8?B?YlZRUmxaNXJmS0swNlZoZUZkeUVOUXhuaXZxOFR6Lzl4MGtleUoyVUhHanlX?=
 =?utf-8?B?L24vaEhoTzNhSVFjWU0zekptL2JWN0lQUmVHaWEya2MxUllycjFhZUthM3VM?=
 =?utf-8?B?aytQSWlVZldhYUVLU1JDc09yc21CNDN0QTFTQlZDMGYzdnVXams2dFkrZEkr?=
 =?utf-8?B?LzNhUG4vN2NGTmlvaTBRMkE0S0NTWkpoOVQrVlRPNWlSZjlNTDJydVQyWE5R?=
 =?utf-8?B?QzFiendoRnRiK2ZBam10eUNBMHQ2Y3o0WktERzNXMGFCamE5Q2lMRGwzYjBQ?=
 =?utf-8?B?ZU51TEdOQTl5MXlJWXp4WXAzQml4dHMrL0hsUW9vQ2NnaldpdDY5d3loREk5?=
 =?utf-8?B?aFNJOWVLOXFlTDNYMDEyVVZ6S1NRbnRiWnZQWEE3TmNBQ0dDOFY3TDBzM3lS?=
 =?utf-8?B?REV2TndzZUMxSVNVVkVZeGk0YjdvOVBxU2c5QXBHb1JRMjVjUTB5TUd3SThz?=
 =?utf-8?B?YXI0RXVYczIvNFhkUERJUGc0SVNPOEl2ai9sbWVseGdyTnR5VlNBTzZvS0hR?=
 =?utf-8?B?YTI3NDl5Yzh2VThWRE9EM3FnMHp0ajF1dGF5VXhFdTcwK1RFN1k0SlluM2tN?=
 =?utf-8?B?bWNnQlJiRnN3U0FiSk1TWGNia2x1Q0hhNWtjNHZHWGJzSWR3Q0FwcFVyRmp0?=
 =?utf-8?B?SGVpL3VneXhPVUdoTVcxQzdFNUZhdTVXNXh1Y01Lcjd5bXRTdjhCN0pYalZQ?=
 =?utf-8?B?SForSncrUVVjakdXbWswV2VDYTlFUVJieHQzbHdXY2lQcDBxRkV4OVQ4NlpJ?=
 =?utf-8?B?NTZCcEtjbnJqOGFGUXVzdm16SWFOMlFzcEVYSkI1OHREWHQweFRXUEo0ZkhJ?=
 =?utf-8?B?eU9BT20rZjdjUzVhR212ZTh2Y2tPN3hiNk9oK0I3bjFuT0MxSE5qNHdLZXQ0?=
 =?utf-8?B?a3d5YzJsYml1Y1B5MHlrZUVhM05sZ0xqV2xCTzlSTytkS0RBcmtPRXJaTnhu?=
 =?utf-8?B?dEVXVWpnb2ROVjZKN3FTcTJKM1dDY0RUakYxSFBXNnlFV1Z4TlFQUDhBelFO?=
 =?utf-8?Q?7Oy5ozWjV494xRTkKCx2gHrij?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5BCnua2LtqrB0N8y6HjS+XxZ8blM8rwoIiJvOx08g9vkA2C0SjAIpi2hkqvbTiY2HWQx1UmAoyhRhbnNSKYILERV/DsCBMYKmRVd8P29IYZwWIWNmhSJPIy4WwVEHnasXxcM9nDHdwQt4pEB4n21y2j/6dui1lW3J4kg8lxMlgLDPgWgJi2d9GTkrVY76p5kdbSz7YPpaFZuXJQtuGPoqW+/HmkhcMYxLqGjOxLu7FohNerjmOGNIrh30jnpGpmvAzqI5YLGsYWvgAFX8PYypkfZjasqS85MB7uDTWH8bxrP7Cw/jVJVGP2/gJkkTSmLl2urOpCvIxjgCZ+USbxPJHOjPXRBmgFEWw8zlwSv2LxuqhIZV9xEABuUAHMmS/Uv98bx1eyfy8nmZkWXrVdCb9pYHgB/kechfIQAIZjvVl1QdQwh6KtXQKYaxyvEfhIcDgdnHmA+NsZXBALBAyQCIQ7hWPvTVJW5Hi5MzgvPT1xgyYSJqh8Ck8tYnovM3hyWOBrdppjrqLuTeL1SCNppD7QF05kSrn4poZdIrZ70d0RG5tDei/Ep8qCFo4HpZISBs0iCahY73I+YUIhMHR2xcrtVy+wVTpOjtlpiTBh52cK9uCik7fI3ws0KSM8iNABIcUG1gYYzjSdDuNWqv7Ie5CVxSLuolxIx90kNE96jsIrMCQs3nO6PEa4q9yKO3CHLArDj69cDzbX9lzLjFtFDDTwnk2wB8v8mwG9NyWfsPTgZIC6MZchDbxEzT3IZ8dAim7QD7PIIP9fn6xHULmc9sLpbJupM9Fh0ALt0W4Bp0ILHyhLKzFI0LYUuRA6t8+Yb
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f06709-b593-4220-ad10-08db3681f372
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 09:33:16.9183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kQ9xkOckdVO1OH85qj4Ezr0wOYwEB4u5/w0Bvfhw7itGP9Z9NgW/BipK9NnoaVksRev0beqtO0U9yIqxRRffA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_04,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304060083
X-Proofpoint-GUID: AW3xENE-thug1X0ZvuljlJ8SSE9xz380
X-Proofpoint-ORIG-GUID: AW3xENE-thug1X0ZvuljlJ8SSE9xz380
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 08:46, Harshit Mogalapalli wrote:
> Smatch reports: drivers/scsi/scsi_debug.c:6996
> 	scsi_debug_init() warn: missing error code 'ret'
> 
> Although it is unlikely that KMEM_CACHE might fail, but if
> it does then ret might be zero. So to fix this explicitly
> mark ret as "-ENOMEM" and then goto driver_unreg.
> 
> Fixes: 1107c7b24ee3 ("scsi: scsi_debug: Dynamically allocate sdebug_queued_cmd")
> Signed-off-by: Harshit Mogalapalli<harshit.m.mogalapalli@oracle.com>
> ---

thanks
Reviewed-by: John Garry <john.g.garry@oracle.com>
