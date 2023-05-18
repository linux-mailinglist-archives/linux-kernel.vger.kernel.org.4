Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39D47076BD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjERAJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjERAJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981C83AAD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:42 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGr1C002400;
        Thu, 18 May 2023 00:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-03-30;
 bh=eaqwLOQJsygZyfR1hC+wW3Q7iczy5Nixp+n0ExYsKzk=;
 b=IjYEqpouR4pXzCmcj5bqdggzyQs8wdnNE6I4AKhmdl5LnIwb3Jhp5IyYZXY5uZYPv8ky
 Nakqw3OJvHfOVgAcoC4lFu3Wi4RLro+NJ0fAI7NhNFkQOjZGiu+KSsHxaoSC6Jr3Qvoq
 NaPmgxTeTV426b7gDfZh+V5YmyZmwIvww5TlAO4/s3erx/L4u0YY+pY4R8qPN3bUOP16
 +thI/PqGEJsv0A+o5CNDJ/a9jW/9IQVgZ7DXiWsY1Gu6x8ZiLJJu7pxWd0jS8RARkR1O
 pUnoL2BGshxra+NqEWj88bHQjV9up1EKsoeoGZ4Cu3sfAOkziYfohkZcy9kdPc7mvaiM vQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1dr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMrAxq025064;
        Thu, 18 May 2023 00:09:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj1063mxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXnQWewdWKpQ4b5lmP9gtKS1edi2QDlBcJA4Bmhhl9q6LgPOeCDlqVXLH609fUl+UOw4BylIXPwx9TqzDTosIW2oTCz41mjE/cC02PE/V/NEczhiHjoPJEyr+qHdMQS4SXyXT77RYVuU2y00VseR/8/aTmyJMwajEuekKMj7aWU20NrAPiZtk9pE5pfL7EgH4p9oC6rf9ZJ43SfGh8NroC6Bvhr+AWF2qfDRFIbbN+69jv3XDOb5uWIPky/0eAI+ge34TuJKBWIV6xPRUh6qpYaCWvqvFL8TW0Ww0MW5kCTgWLspKfjW+vd8BE7hU1ooqCrftHxVZ8+7DxEe3DsXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaqwLOQJsygZyfR1hC+wW3Q7iczy5Nixp+n0ExYsKzk=;
 b=l1Rk0tx3QZWw8+yLhh2yR4FpbIudqpXkKpErjBL+DPJlIvAwE3ZN8JmXORgtCbB6xeUiLixGgnk59NY/zczYWbNF6N3sZEcGjbJEGNUAop+rKvQ2/hLvyWt8+6iUgJDJruz76yqS+jM9jM975S4sJK50gICwPSB7SPRTVa0bROl4HC+5tDDeYh5+Vc7hNyQDBQK0MdUU8PRJ3Wceglmgev1YNfmz5GQNkSFbOWHp+ApzjkcYV3Ntoos7ekYYRpEj1FgR2XMm+DbwA3UgexjN/QqVAX7+ErvtyT2AwYOgbRZ6yj5rnGi7xU12PUzwwNOprM+hTZUbrChV67IsZCWS+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaqwLOQJsygZyfR1hC+wW3Q7iczy5Nixp+n0ExYsKzk=;
 b=R7IRwFyziyYbeOJPq+W/TBb/7BkNF7v5D+KtfGTmMluZB2Du8AOvEJALVrT3TxxG6EHM8lkRsKerrp9HzL74Nd2/c8Li6/vBpyclYrgqsQ3q4QnrrMu3mfgKcdvC/fItnpaySdrbGFGeHS08d3CuhSFwGYuBtX3qBiRAwMCFRHM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5332.namprd10.prod.outlook.com (2603:10b6:208:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:23 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:23 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Subject: [RFC PATCH 0/8] vhost_tasks: Use CLONE_THREAD/SIGHAND
Date:   Wed, 17 May 2023 19:09:12 -0500
Message-Id: <20230518000920.191583-1-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0310.namprd03.prod.outlook.com (2603:10b6:8:2b::9)
 To CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: ac27967d-6011-4e48-5a9d-08db57342277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PuvzoytDAYvACc9ypcpZ5uAsGgmI8UVpkPOQ5/vxeos/I+0V0FoOj0SSmFJqZMry0GF2UR/44Hhl8odACw7RBCfFh/puc6HPudmDv8CCsOYlfII5vYLN4NYE1bHNaBhA6Ra/9p91WMbLO1YVgeQPex2arYaczmRIdPWVgt1MqUVxJNbAI4jdn7OSdOt06w9ypnvd1z7X9q0DpWZSED9n4qe7mzy0RTnWIlMYeOj95Y9pXx9bZZhakwQg0RFoEFe7nkZTcyU+wlCiR4TmRFciMaKlfJ0Pnw1JMYj6JsltuZU6ajDgh/LJE14kPSdH9fj0l0cWaSkO6cS2fmqUhuu0IWpkpQxiu7Q0E/3j3DWAlJgHjquooX3l+9eGh4wSB5nSzW0DeRKojG/oL/F5cPWCGYm5cMb5Uz6MfiigEa6d5EE6u8j3mIqvX9iDpxBBhdEz90S33fI0UtNmtmP9HbopByd1J9RO7HdT16MlbnQrAuXch8oWogBYNafI9qijRZ57Va9332PJmJzVbG51u+81+764/660qLUpnQodXCsd6hBdDK3+/RXi7sq41QDdmsWhGJKhk4Qmua+3nhQaxXLdETv7DfDUdTADWEwsXWoSr8I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(6666004)(6486002)(478600001)(66946007)(66556008)(66476007)(316002)(41300700001)(5660300002)(186003)(1076003)(8676002)(8936002)(26005)(7416002)(6512007)(6506007)(36756003)(83380400001)(2616005)(2906002)(4744005)(38100700002)(921005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QNHN7HZkmdn7cwBQDBbXfxACtrcpvzEysn9c/0VTX2/eg7WzLVpLCbaV2wg9?=
 =?us-ascii?Q?LanQeW2o1FQkpxkcPj6Afr/xCrpoODPTrEqWV0VJWVKd/m2J3XjZK+diXSi4?=
 =?us-ascii?Q?DPVT3dgiEVqq0zDcSoN4brEqlFHXpkIGRk1P3RTO3yHbabcr4YHpjEEExExP?=
 =?us-ascii?Q?+bFoZqFbryTS0p+yJ+dgL5b4ASp+DoGQZqkmdlmMvtXgfGsfXotp6AffV7ZI?=
 =?us-ascii?Q?LBxhxGx1GmBLegi+G9beIfKtamDwG12DgeXJVVNrX1Skd3oC2uu8RFx4i7E1?=
 =?us-ascii?Q?e+D3F0tooOYdU2Lk/lkXBbRZmjp9l10dYaHaAji4IsV6G97t26SxCjHkpWsO?=
 =?us-ascii?Q?J3qzOqwKrRpw9CpknwxFCKrUUXC/1SRXRcMaddBbCtHEDrFYNqbn+cxMsE2j?=
 =?us-ascii?Q?XKraMDk7TXE9YAUt7eOK0rIXwGoLKHg9BswMKweTvGQNXVL3NyicUsiWOB+R?=
 =?us-ascii?Q?rDtorxfNWdAKL2pwmws8hUVrxiUpU9saPcj+TdhK6NV3goe75H9kptR1nGuh?=
 =?us-ascii?Q?9Rvt8k9ML5bgex98rS2PtbWHRRj2I5appAKEfVWBMoS5qVlvvFsYfcIDS8VZ?=
 =?us-ascii?Q?KwoXx5EFwjFwg4XyBGrvN+EJ7MBf2bEAeHSwlBfLpme3F4KqS5NeIHRe9vEL?=
 =?us-ascii?Q?z10+7gm3jUrYufCUk9oYoCBOqyVHfJFtK2yGJPyv31lNLGwzDcoOZcesnIfm?=
 =?us-ascii?Q?c+Ia7qQbeiDie65VliG/K6KnuGGHy9e+pg8BV4NOnl0ovMm7pwSgQq8Tysmx?=
 =?us-ascii?Q?d0g2P+IqToZU9b1SDRKELYUSfko/j7/K0KlytV/iT3iu/B3JXI8yX0pn1KZ7?=
 =?us-ascii?Q?ZXCBeZ+6jxLhlmsbduCdXPO63OXf1FMla3phqc22BzHWHDAZLdrIOSi7bWHk?=
 =?us-ascii?Q?bGESEzw1qnnPsAOnd+BL9iysQf1bJxMV2mGm9N2N0Jfa7GRy7iKDCXLhHyie?=
 =?us-ascii?Q?TMKHleMBSre0VyxUF0CH3kuRJj5QNP8EgUZLf9RngplFQ2+T3jbluhE6ypl4?=
 =?us-ascii?Q?SrOdL2ECFYV45xPKwLSAL3o+9wETl3IWHCzLZbPJcTjRD/PtEWWRiX8oKPAE?=
 =?us-ascii?Q?KqAib8y4D9O6sNYg4D/Dg5+IWBTT6ECpI3XTaTcPxyVYb2rKHhjzwV4uH3FX?=
 =?us-ascii?Q?xagZlxUKkQvNiQpt+gLY1YHa2CDaBG7DJ++v8TxM1eXYVGUSAdzg4CjkbFnW?=
 =?us-ascii?Q?WSX83013arJbcsQrML4T64Q2diTpWWO2BkXTlVJ7krafJrUmMgYeIoo01YVD?=
 =?us-ascii?Q?W98QCewdi3tjvrJhzCzUdpgvdbh53UaCmMHB/IWX7IYNdwqyA7iYag8hV2g5?=
 =?us-ascii?Q?iqyjyiawbih5a9kwV5LEJZe4jebo+ioP9UbnhVfX2StAFJrvwI/4PM9Kq6dc?=
 =?us-ascii?Q?riH2ROZOrlMC/IR0Y1wZzzn7+z4osTdkKEDkHpZ9zU6EojW7suOOc6REJgLq?=
 =?us-ascii?Q?OYJCP19EEgHsIA/Xf2xgS2lGXC2zbpQZKs6nr9MtRJuUWaJtYpH+pBtYTCQb?=
 =?us-ascii?Q?qeLQ71T94Uqxu5ypPHz1nliHGC0J7qjjm1s6Zhs1hEK/nRyDhNP4AFzPwbxx?=
 =?us-ascii?Q?mCTJpon58R5MAAdln3qYgiwAKGXJ2ZFGypUlBC1Pw08bZvDNoKTHVUAHl3rf?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?hDDT5LgrHDpXFzsqrlL+iGhqXEGV2dWWGN3yRncuBYkl2JJbiDvSPnsCt/gC?=
 =?us-ascii?Q?Bs5VyQ+c+neMZlsquuViF9hvZCMjtrmystISpdFb0ai3cJ+lzRO2SdlGcAv2?=
 =?us-ascii?Q?e8JkqHW57heeg0sAzExnMhIf2VgrCRVrn9iof/6mAhmCk+lijb1LkvYkGh+Q?=
 =?us-ascii?Q?pUAlBrRKzQ0hteVKxuDpl1C2gujYEIsqcRwuBg9NL5V7vCKlSxQj2qhFwCws?=
 =?us-ascii?Q?QnVRrpVcy/mWbSNZylWZK982eEW9EWNm5JFazsagiJOS9bsLUKvqJItNZaMO?=
 =?us-ascii?Q?kxIIfVBe1l/rROenPFUA0rIDAt1MCjjrjPXG93QAYWy12Q3SnmSZGBU0nzEA?=
 =?us-ascii?Q?M2vnT8pJ9hMEXonkIlEiy70BzC0sUKPUfhgPt8Lb5vIfr3tSEK7CUgAwG7wG?=
 =?us-ascii?Q?EeDwH+uCNYm+dzwcDrXWOPAnRAeS6mzQ/mRhoBxLptd1HT5Ur/127pClpVsb?=
 =?us-ascii?Q?uBr6QeikOjyvKaMO9fuw8CZRGQfT8M7S5KN6BHSZYBRhAPcsI6yyXLDEFGqe?=
 =?us-ascii?Q?IWpi+pG7d1wSiW/8LcmiXU/6mKDdClxQxZpZ9AG8ewBMwhtt/+8ePvKd4nTz?=
 =?us-ascii?Q?epKYW7kcz1b9tShFZVcSME2nymGly7fiIyCK4Zf1++MneRkinvt2YR0i05dt?=
 =?us-ascii?Q?cXOuTGP6UM97dtOgQYp7wbmJ9q3VecvCZS8prgDOlGJYMmR9Km6l5ywqgWF4?=
 =?us-ascii?Q?C80yEYDA4N62qctHUSkbCKfpdchWIc48ZIO4GL6/xTUk8EP5TKT6Ue2yoEd9?=
 =?us-ascii?Q?xHVngbW0N+uYAzQnfIL/6T6WcgGG2ssmdNQCvN59gYdIjrqkDPE3+Kt78NIn?=
 =?us-ascii?Q?1gQqmyr4WXedvo0Nt4zYQrgMNS+/xSY4HsIBoK195F/QznstM0u1gOS5jMJl?=
 =?us-ascii?Q?s2u1ZdJ7spgAfN41cVbbUV7JSLUdYobG5hd8zrAihgdFHLe9hNz5XKYsDzBi?=
 =?us-ascii?Q?3Dq8HpW3hO9lUeFq5vToOMXH6CJsXCNhOK09Hab1JVXNzPjS8ChFryOQd7Tb?=
 =?us-ascii?Q?fs/Wsbx4EEgebUB0B0xslAr8IiuLCSkPJ+DfaQaYU97YDJXkI7gKYt2DaUJN?=
 =?us-ascii?Q?iGHlMwV4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac27967d-6011-4e48-5a9d-08db57342277
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:23.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh2XoIPa1DN3kJ0CLwjfn7rebg4gwDjCiuMb0Fa53pNskuvZdPwxS06qf80ODlLaVFxupN28XIZcGJfoDxQTj3ZR0R3T7JoxU54twns8sb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5332
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=477 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170199
X-Proofpoint-GUID: ZlYnlrom5qoqhuycVxAG5fBaZ5G2gHBK
X-Proofpoint-ORIG-GUID: ZlYnlrom5qoqhuycVxAG5fBaZ5G2gHBK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows the vhost and vhost_task code to use CLONE_THREAD,
CLONE_SIGHAND and CLONE_FILES. It's a RFC because I didn't do all the
normal testing, haven't coverted vsock and vdpa, and I know you guys
will not like the first patch. However, I think it better shows what
we need from the signal code and how we can support signals in the
vhost_task layer.

Note that I took the super simple route and kicked off some work to
the system workqueue. We can do more invassive approaches:
1. Modify the vhost drivers so they can check for IO completions using
a non-blocking interface. We then don't need to run from the system
workqueue and can run from the vhost_task.

2. We could drop patch 1 and just say we are doing a polling type
of approach. We then modify the vhost layer similar to #1 where we
can check for completions using a non-blocking interface and use
the vhost_task task.



