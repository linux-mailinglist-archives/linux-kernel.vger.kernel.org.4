Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605F69F443
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjBVMRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjBVMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:16:47 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824B3A86D;
        Wed, 22 Feb 2023 04:15:43 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8x0Je001203;
        Wed, 22 Feb 2023 12:15:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=nPitDTwHvFRuV7vrXIAbgD0y12noNf6P5dv7dPuZCmY=;
 b=vcQrSOwRB4aSVXaqJUWM2We6ZTPWbF1x4cSwPWl9HJwmLZBMD3ZOyH864OFIy/d6yu0d
 fz6XZnPP+4scjapq0SdLVTXGxn3M4Lx4Lu8v9c2elxOht4a+MWW2SFq2grBISEIOMAbZ
 5nEXveer9yQKY1uA8rbTfLTMF+rJZjLq2o8FZ9axVfgUmTGzZOQ+6nbCx8sPX8WbQxe9
 wCVtT79QZF5llSD/e5HdAKguqb9N/lKk6pjvi7+6fa8ErsNwHZaioAUVaW13nQE8rZne
 HJrYbV2IRE+vKWsSMQfcM4bN49HYc4ce4zLM8YfeCx/rRmRnaZNWnAngMFplJmx5pope dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcfrad-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31M9qgSM040958;
        Wed, 22 Feb 2023 12:15:31 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46fv8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6dVRJpFUSae4boBwsBcIfOPV4ruzdYdicEP4H5Mqh/BqgVun4WXWFrAAfbbubm7EORrT6S5opNYQaL702tsnNT00fWtQPyOwx3Tc7JfjPLnXS3yPEtVtvvd6FLKPVHbJooI4K8mNRF9b5TM9KZTUbY5qr/oL869pClSzrZjaMB8zKSKn384FOzRH+bohPoqvqBVciBI6JOT0NCnJKTnsLWAQ3+7pCe/YcUkjmgyoCFzMrL/p2F2zkZshna/zh+tY9tOzr8gH/yA3pfswaFq1me4AdD/g0TR1M1hjgmuYKgLryj6x4NE7uCKVt8mU/ro6zfDhXq+sbSOMLQKVthGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPitDTwHvFRuV7vrXIAbgD0y12noNf6P5dv7dPuZCmY=;
 b=ORH84igrAYM2kI3UJBCAcbMwuezWDWilRCNJs/arytaSsjJbhhriyzmvLeT9ni5+t3/WjhB8A12vVrzIwJKv/GDzcsarn7HaYWc3naLJaqhgv9b/55KlZ91EWEC6pfYhY6qvw9aLM+x/Hg/8DC5SQTjlpFTqUKOzE779WNveL36R3vyzUpORtXGJSoB4AucLoRzWdYqqSNwe4Ds1pP5zPJHeZrLkUTcdwUuC7wcTzq2y+m9LlostzxSNzQlVtyv/erw1dJKFppV2kPEhQnNJbGsR03HQxKetv2YTJVjyMG4qRu4Di89JWO/z6qAlmPmGZHlMSilcZnXP38NpsVvEGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPitDTwHvFRuV7vrXIAbgD0y12noNf6P5dv7dPuZCmY=;
 b=gWzAXddh2/+fXyHCu+7m1m/uR+neV69C+t4oqVmHo5DN+L9BT4p9tLhlVu2JiE7JwGF/yadeXPsmQ01pEqQvlZ6wL6vN4QZ5Of4CYlndiRdoKPdu+DIq5Ai137V/7D/NARzctN7U5Y5fggZof9t34aO0/gkF2rYUS3VlPJxAz7M=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.15; Wed, 22 Feb
 2023 12:15:28 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:28 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 05/27] kbuild, soc: bcm: bcm2835-power: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:31 +0000
Message-Id: <20230222121453.91915-6-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::18) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: f5e969d7-cdbc-4e29-7063-08db14ce7c6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JE/Ou6ibDOgW2X6p6aj2c8EpD01RC11QEkeZ8AdpEKFJkP3gRQdYbJsdxvtIBdqh6MiGs+qVuKOjZssq2VN6XSuV78tPhjN6Y62J5FPdY26gu7u5pv0D1+NiRnsC25ZeE6DIQSzeStduhezIUNwGlFZYL6sD2tk3ab93JkiLzYpXJXTnHPxeR17qwRbYjGkGA3BRdsjqLhiWWRij+O2f3dAwK2l14OxM5QXlBjLkRn3gpxAhPX/Hj1DbDY1SatZ9G2T4itCA349N5q/hsZQFRGvaOO+BNW+r+qB72BkV7fhOQPU20gdUtIPrfEj+TUI02SLUbnlHsYvJdrPPU2fgPhn0Gp0MG40nI23fH//ieh5bs9YWDoKO/8a3oHQoB8ZCPUlAVsk49InE7CJeoqSAE2a9RMBmB7wvZEX339pLXV3A0Z2D1lFgmB8JJW5Yz0OrqDdiNDCEm7vM0UJyfKfn1I+0ajiQY9pN+GuuLuuezRWn/yCJWdcQT4V8k0p61OhEXyiBjpe32Vsx1Jnc4fNZaEhOP9jZr8h8paVti3EQQIBqjYHmUD10tYDeQ2bVKrjLKEFh3ahqHqXmk+h8kArreOOLn0be1/zPaS/ZFyn6FoJ6xgHq2bNj1VaLyZ1+Sst8iExvCNbTBIQnK5d6yHCA9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(7416002)(36756003)(5660300002)(44832011)(83380400001)(2616005)(6512007)(478600001)(6486002)(6666004)(6506007)(186003)(6916009)(66476007)(8936002)(66556008)(4326008)(66946007)(86362001)(41300700001)(8676002)(54906003)(1076003)(38100700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u0hv2oLlKjIoCguGn6OSM2VnYPYc7F8EEOvSo+o9GrchgXxET8z93jSeGIb0?=
 =?us-ascii?Q?J85BfeA5pIU8A3Pq9HxnYO5wJYpHknYwJjz6O67JZIOzS6kaHB4tvlpmAmth?=
 =?us-ascii?Q?Ez0F07I0qxqNbmY+hCLWc7TIq4WLKSSohai6erL8dove1xN1k+JFckjFSUsF?=
 =?us-ascii?Q?CVcX+3V+jeL9TcsLnt5nFva+ZOvHk6bIPeW1Y8C7gVJ5HLLy1M2/2O/vO9gB?=
 =?us-ascii?Q?vmv2XpTNpp7D3t1muNbqFtO75bpq1PKF7FPqdW+0yFlVSOtOnudyThFOhfIE?=
 =?us-ascii?Q?bA2a6PDEqTaAWTN2lXAP6sYzmw/vQYY4tWJI5s+bWyyUMUDNhZxmzIwKnNDP?=
 =?us-ascii?Q?7xRMUIC9MsgJJIiZ++RVw7MeEaHTiUM2+eM+KuziIr5Qo/6A/RpormENGoGZ?=
 =?us-ascii?Q?GwDcCQcR4GR5jmHtUUSmWP4eVOqjpASLd/ANfuUhwyJRwXfl2Ce/6SlvGA9z?=
 =?us-ascii?Q?GHjMPD4KxnBrFcAZbIqpk8X3hJm+8ccqgODb8EpTkWKlLO8s+00Pqq4HVc+K?=
 =?us-ascii?Q?r3g/Tga6/Hijobv8iuDF6EL2jjhc4CblbNg4RFQyoSUTuqjRUT+LyU2+ttjR?=
 =?us-ascii?Q?TQFGtyNgYHyX7j5xtt0KgFWgqpMFK1Ec0D2FQkqwmZaaP8jV5zw7fgQzdeCE?=
 =?us-ascii?Q?V+LBrEz5KirGBsNPEZerg8Wih8gE2xqsPsofN+uqwj5vSPPmMK5U8xA9ggud?=
 =?us-ascii?Q?aSUqDRMumxWYIaHWFRxEZYIVbe9JCApIeiZCdjEaz/iGFwxkYOj+WDURvfI2?=
 =?us-ascii?Q?K49oImkXOkogysmZhI+XHJg9kYANpqsrGIgczj8wxmeiUOfkBjH7MKGtjfl0?=
 =?us-ascii?Q?YkPTiVt46Odc/XYcZZxkd7Q1d339VmCnNnKMK51Pm/oT21d9h2akcTqg5DkH?=
 =?us-ascii?Q?XgJ/0wG2871p5kZy9nzeU5E+DqXvRNzLsnmgCtIrvLCBfkRDEokfGb06M51Q?=
 =?us-ascii?Q?I6cv5fx7/OcDZOXQVsI0ZCmh9su0i/kQhT08qpywdhl1OUSiNvulqWtq8uX8?=
 =?us-ascii?Q?fRjFkKe9OEf4lvB5NQP2eehI65xu1ImPj8wBA/csCjYccOdCzT3PGuTajiM3?=
 =?us-ascii?Q?+VF/DIQX7RVaPAayFXYdaQ02TQ7qL+RcCLgmBZq9aHUXg/3cEoxsDLPRF9vJ?=
 =?us-ascii?Q?SzUlQZXaFVRdxJEMICe60An/iAGMRjuTBNGBx3tpipOoDLoZz4RrjdVtig2h?=
 =?us-ascii?Q?R+AioRHAMmpNErpU4YejW+JZygxRiGH4hv7TBKWSGNo9bhsGiRY94XFIxWwM?=
 =?us-ascii?Q?fKm/jbNibGT7qdcHGHF3Cef3Y54PE4ShLwI+azk3oe4ezr2V/BQ5beocppVk?=
 =?us-ascii?Q?V9YQedtbmj9N0bCYyVLt2nH9iX/awR7WTHvzTvYxKb+z9FCrMaqUgLb+WkK9?=
 =?us-ascii?Q?++GYLGYchi0yKFnXmSJNAWufOH++EOj4SqYm/VfFy91A6tQEuwAyeA35M2m1?=
 =?us-ascii?Q?YJidMp/TLUr0LT/L4UDBr6jhwcQn/8YydPCXrm7KYWPZVSSQJGuB5Rc2Dr0s?=
 =?us-ascii?Q?G+iCorZLDyq4ta3UvTGAadfNI2lJwlzqdT5qmC6Ly+SixRIO75jNHVlCNplK?=
 =?us-ascii?Q?oH8+GqeEBcBvNY41mdBHHZmEDqUvbM9zDWkDuFKQ6uFa87jvT+x3sfKcfC/b?=
 =?us-ascii?Q?vQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?AHgMFElDM2LvF9ZT65q4h2HWdN/QewDBGufeg7ZhguWZRjh0H+/aRRe0iG7f?=
 =?us-ascii?Q?VcNWlPgp4p4l37HF2E/1jSTDW6Dis8Gy5Ih4z/KM1gyCH0yRrh/e7eQs6oBs?=
 =?us-ascii?Q?KVdQzfphLObutfVLoXesGZRSSzngYV+smSc7UWrAtNxkL0JmolBrLXg0vJHf?=
 =?us-ascii?Q?iD+sduMuFma944WQydA1NRZ5NJxk7I8NemQ0mxwjPs6NTqxDd5C/Uh6i4D+E?=
 =?us-ascii?Q?ftZbXiqZCIz0fdoALEcb2791b6fIWjCB2kISzh2SQwr4E7SFnx/7fgLu0oPD?=
 =?us-ascii?Q?onOWjI3bWKfrxXjCypsH+Hum8ZtujNYNS7v0wzhc/NRHeWG5CSZCwWJnxWnA?=
 =?us-ascii?Q?xrcst68UR8dTDv83NjtGxxDvkJ4/KE0aGo4yXoghHFRh3j62RA7+WgwEMsWb?=
 =?us-ascii?Q?2lrqZWSXGvfPA46pSa0guTm2j73Uuuy9tK5Qmm0kUtT3VPxDwI9xLp3wa51I?=
 =?us-ascii?Q?dblecpkNEM0eLJMgmd16R5hmPLj3y6IB2iBNyfyYAnYuiHPLPftxpch7rtfl?=
 =?us-ascii?Q?OZQvt48MATgcqBEK9yx+HaclJ29REJVqQ4qRhiI4kBI2MNKTwqo8D++/ppfv?=
 =?us-ascii?Q?LqxBzhtOrR56+1uQFcqmqUPxz0Y61HnbT6L2L27+KKRxDMwAOlV+2OyjLHfS?=
 =?us-ascii?Q?SR2XJzpUC7anZrUexFLLo8pVB1UV0hlfCI7p7hfX581wypffRMYOc4n2wNgV?=
 =?us-ascii?Q?TkabfpJWm9eW1Rt1NuzTqUQM2sUecPdxzfLuR8mgkM+2TfJAS4QtmPGio+5U?=
 =?us-ascii?Q?4VZKrzR15hMwoMSduZANzcCbN8LVzv2GekEnSJ4+engw2VhgNoaZ4av317b6?=
 =?us-ascii?Q?nBUAycupNNV1aMQ9eGgdz/ETKwT6Q6XhNRjQ1Z8uYwPXR+bdPzfTqq1yVXce?=
 =?us-ascii?Q?D478tg8UTaO5dFrbj3SOJc06qz4L83KNmBjfatRZZsxov9r22DBgUYCCCCIx?=
 =?us-ascii?Q?CZs5fgFI9THB84VC3qmlsg2lNvGH4lMt/vkLpC4D01U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e969d7-cdbc-4e29-7063-08db14ce7c6c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:28.7607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LFFwCVazvjBRo7arykBST7R395/ZcjgQLBLUCvQkeJwPVrxhX0qx+bWRZ1x6R/41s0HOGzM3etSiP/FImYMejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: MfOnipQoQBftky3nYGP3pJNa5QoeiVK1
X-Proofpoint-ORIG-GUID: MfOnipQoQBftky3nYGP3pJNa5QoeiVK1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/soc/bcm/bcm2835-power.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/bcm/bcm2835-power.c b/drivers/soc/bcm/bcm2835-power.c
index 5bcd047768b6..831bea6ce5e9 100644
--- a/drivers/soc/bcm/bcm2835-power.c
+++ b/drivers/soc/bcm/bcm2835-power.c
@@ -717,4 +717,3 @@ module_platform_driver(bcm2835_power_driver);
 
 MODULE_AUTHOR("Eric Anholt <eric@anholt.net>");
 MODULE_DESCRIPTION("Driver for Broadcom BCM2835 PM power domains and reset");
-MODULE_LICENSE("GPL");
-- 
2.39.1.268.g9de2f9a303

