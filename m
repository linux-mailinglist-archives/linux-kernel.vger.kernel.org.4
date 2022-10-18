Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22EF6030FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJRQsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJRQsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:48:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC0EEA687;
        Tue, 18 Oct 2022 09:48:02 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29IFxx9J005980;
        Tue, 18 Oct 2022 16:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cvHexqheSMnC3+cuAIghMvYitLKL2clXdAt1CdjYjzI=;
 b=FVz+vrEjqAc4R2gkJR0cDBWJeEysGbMwzlTLYMX82LNaO9gZRZL0SjBbKCaopkya7zTc
 qfHNtu0LDz4Z850F7yPJPBD+zl5XM4oSh13sV6W12H4PTGPymFjb2zy9Gax3rCOKSD6A
 4qG3hZryC0b02zitoMx/d7+Qsdk/VysDXcWXXl3sbixYjk+fS7JnWJjOJGM0iUVbkgb4
 RiGi6E8zoSaLAKtvNB2PzXR+kTBQZu05my/7lYgFh2piy3D3Bekh1Aq8sf9RGl+RV9+X
 cgM1HIRDfpF4fDugUwp0z47LkhRVSodvzo67v1G6pWxTIrD7XWW7O6ng8V3HfCDQejsi 3w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntbg2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 16:47:55 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29IF6LUi031316;
        Tue, 18 Oct 2022 16:47:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8j0qq526-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 16:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JydNTGw01dBbkH1qty9wVDwN4hylEX8GpNBHKlXnVk5P6s0XY1dFkwAQKKLNwXLC7DtKO7SinbmrPrhEA4IFRqWu5qVuRK3SPWjBd+epy/oetM+bBATa9GzqU2rOE+FHO8P+4KrbJKpgFX+D42vGn1+KojCERGXo6IUE8Hu2pD3NmgyhStdfEI8EHeHJiWNMV7YzUVqAzMwLnVBoWadZz6wKrltU4ZI4bjwFPzkZzpMo3tfGB9YWONbBOaaX6UWckZ0f7ldn2FeGB4e/vFytOVqNSi3qVHNi0oXK6YXvQD7uG9CxpCgXxPCpFAX1Q+cXRDHjFybweekhZTMOCSk7dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvHexqheSMnC3+cuAIghMvYitLKL2clXdAt1CdjYjzI=;
 b=GHFML1Pc8rrqpYP1OaxTfp+ubJg3c3xgfrvFDixyu/Ww1mgHEoJ/MAocsDinfiqVKP52RVyK/bUdr93c7JIcMol/MK+RTnc2JauCe7phnjCG3mxaG1Tes6ElPw3huJCljzkRfxc/+2+2v5cIQp7bGeRt8qUna1DnK7twoo5LEV2iOHefNiduLLn2rg2YhKqf681nPZrBqTff7RZZDZQn46vUJ2EeIbKtZ74Q/FcoKkg6s6PnqpReed15Aseio7htDCTflIHcAUCzmDk8JB/FEXeUKM7JBjuhvPAlDWS6KDSXoS4MnntJ/hqN0LLXVQYnSEBriuXpNTeLCw2DmQ6f8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvHexqheSMnC3+cuAIghMvYitLKL2clXdAt1CdjYjzI=;
 b=lwBZgFpH85uoPAmqOe7i9DT8Ey+b8BKwhi0tjtWdf39RHhDqjKt/tQ/DSRBTgoNNdZP4zh0gpl1NH57ccpCTY9dvtsriLAcaphn64b87Dcz7tcONpJ4ybwbju8xjiKvmQo9L8eN5facAjVsTJKWNM3zVu4cRu59EmqIk+CLOwQU=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6250.namprd10.prod.outlook.com (2603:10b6:510:212::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.29; Tue, 18 Oct 2022 16:47:52 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5723.034; Tue, 18 Oct 2022
 16:47:52 +0000
Message-ID: <833d4fff-7fb9-31c5-3ed8-ed9a7753a5db@oracle.com>
Date:   Tue, 18 Oct 2022 11:47:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] scsi: fix crash in scsi_remove_host after alloc failure
To:     Khazhismel Kumykov <khazhy@chromium.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
References: <20221017171147.3300575-1-khazhy@google.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221017171147.3300575-1-khazhy@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0004.namprd11.prod.outlook.com
 (2603:10b6:610:54::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6250:EE_
X-MS-Office365-Filtering-Correlation-Id: c55fed95-a56d-464a-9c76-08dab1287f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yn4IFqsIvV9BH+7STWOsMnRgS6/smYux/eoqKnNMA1IYvTVekNc8NUBRWaIn3K0sHvTqR59NzkgrYoj8/Kpgk1f9Im88tC0jeYorhEKsOpGJCh9u25/o1vyj7zbssyqeYpriV3zD3M3+xb8zYsG9CtiHOU0tZbTeoQnV5zRphh9A94kYTMaBIyiwn4QrtQssjg3i4zHGz/wN8D6JuvQ9JIz6DEFO+Ahad+XE/qxkOz8kMFPcFjcMjmfkV5Zu65Pt38kyOenO1uGLwRGlWjvyBwtcnKxOF3aNG2/WwWMHJtZAgun3tmIHftIFE1mIC7FBOyheeKFmCCCshK+7ezqt/GXC5Rwy2QcR7f0raEOLQ0ZK6HyHReu6beSwKWOgdDG41QZ2WBK+icjqCruc4675zHP0OJzZobMAhkWhMm4TpkvzQxBri2w+TiIKChVSFQzso2l4AlTPKdxSesxt080a7QfCQVN3iKWfh7KKxNY3POVwiBfDYtrcrAW6zthFonOPlVbfAAkDP8hxOrgI4e6CBdgTKnT3aZ+bTlcqla461AtfsgKEPtJ7vr/AiVw5dMcdErdBYRKAKkI9QJpIKmygJcGvxY3hLGagopBEcLXgzyeIFwjg4AeOYU/PI4lDuJ1m6pUimFF6vWEF1ZpfyBYLRX9ZrD5AcIfKj7F2FrIg3u9mDr80qGva/qBO+hoDeE4/Xi/BbfPJaOprIHjy8951rGAaIf81D5paQuWfxO24C3Jw2vbskc55h31uUUkzM8MnG59zyDETglxVXkrp5ASRuQFtVvs86Se1eywhR8Mdqq0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(366004)(39860400002)(396003)(451199015)(316002)(186003)(2906002)(83380400001)(86362001)(31696002)(36756003)(38100700002)(31686004)(6486002)(478600001)(54906003)(110136005)(6636002)(53546011)(41300700001)(2616005)(6506007)(5660300002)(8936002)(26005)(6512007)(66476007)(66946007)(8676002)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3V2ZHk2dFlJVnJneEVtQ3FIQ1M3UEpYWlUwZ1dCVXZ6bnZEY255S0hTUjV6?=
 =?utf-8?B?RURaS3E0Rk5WUEJBQnFxZmZVak40azBxcVVZbEhIRG9CWU5rL3NuQ2N2dXBJ?=
 =?utf-8?B?dkZjdEVYSWNpTGdqc2JRTFJGRnFBaVh0OVhsbWJ5SDJzaHh0bmV4V2V5bEEz?=
 =?utf-8?B?Qi9mZk9kVlBHL0xTT1JyM0N4YmNGcmRTUHhFRE14RUwwY2dHNTFhdDZGMTdI?=
 =?utf-8?B?TW1tUG9sOERLR05nUk9yeUIwZjQwbnk4aDN1dW01RmFubHF0MVY4T1JjbEls?=
 =?utf-8?B?MXcwdjYvdk9mQXlTVy9NZXhpYlNieUtybkJpcUdwZ2hLTk1sNk41U1FGR3Iy?=
 =?utf-8?B?SDJ1ejlNalY4NGxva0xZZENtc2w4ZStIR05sRGNBemMxMC9kcTVmaXEreFI1?=
 =?utf-8?B?b3dKcWRSeDNURWl6K25TV0xqV2ZoZHFTeForNnovM2xvRFlIdlBWZlhocmRP?=
 =?utf-8?B?V1hmZG1CbE9YVmZGSVNseVFpMXZCYUNjczk3am40Tm1GN09wdkVObkxOZDFo?=
 =?utf-8?B?dUJaRWY2MitRYTQ4ZW5Xa05wSkN6amJCTW9aNkhzUlQ3dEJnaEt0blV1RVAx?=
 =?utf-8?B?ZUdEbnVob09vaEVhR3hFem1keWVQMVZObndaOExpNmp3RWpNbTk1NXYyWkxT?=
 =?utf-8?B?UkMxWkMyTmdLdW93QUhPdnJjaDh1dHhoUW1WL1dxSnBNemJDTkpiSzdiMUhK?=
 =?utf-8?B?Zjg2Zi9JR1JFdlc1NzNXV2lqV3BKSHhienVDUGpKZE1vVXBSYTFUMFlzWTJn?=
 =?utf-8?B?YXVVbUhVT1EzK0FiYVI2Y3FFK2NPQ292bXhucjFmYzBLd1BRNTYwaVYzTWEw?=
 =?utf-8?B?a1NTYi9INk5SZ1hPTG50a0NaYlllTVB4YXA2WUxvTEVQZUlEcFBZeTRrSXRS?=
 =?utf-8?B?R1pPRGpsdS9uSjBEUG5tYzlxNWF3aStUWDdwYmp4TFVCQjROT2VrSnN5eVUx?=
 =?utf-8?B?VzVOczR4TVdUemp0OEcvUEFSTWNhVmhzTGViU0xKU1d1VzFXRTBlZ0dGRUda?=
 =?utf-8?B?U29QY3hHVWxNUlRDZlRsYm1IK2pDUGNmM0J4cVZreXl6bHJ6RHBFQ0hWNVpa?=
 =?utf-8?B?ZjFqSWl3SDhZUk4xVG9aVFY2dnJpOUZscmpRUzdMVm8yeVMyU3JjWnpFeXFG?=
 =?utf-8?B?S1orMk1kR1VGMytQSzQyTDlEUUlaUnE0Q0hFMHdrckNiaWFIRlFZbDJYOElL?=
 =?utf-8?B?bHBVQWU1ejlKMTlEamVlYnJFcG4xNVVVYjBNcExHOXFJVU9INi9Vb21yMmx4?=
 =?utf-8?B?eHBQYTl6a2lyTzFyT25lblQrUGpVRHRFbHg1Q0wxbTFobWhVUWZhVGtwSWtx?=
 =?utf-8?B?d1ppWTNaeUZLZDdKT1l2MGk0YUlhVGFNR3FWRzRhVjMyOEgvTFhVUXh2cXFT?=
 =?utf-8?B?OGRxcWpYTVdTN1ZsSzZPamJiWFIweWFUWUJ0YXNyZmczNWFnVmNsd1ZKTDA1?=
 =?utf-8?B?UWVCcENNOUZzb2hwU0xhaEI5K0FSd1lLSnpJZjJBNXlKbU0vUEFsUll5UHpJ?=
 =?utf-8?B?QUVyb1A3ZldaZFlHYUk3dlgxaGNLcTg0SWhwT1pMSXo5dnkwTVdlSEdvUGlq?=
 =?utf-8?B?aitsa0F0amtpSXBFUFNybjlyOWd2V0Izc3RvTFUzYTNQR3Y0T1p5ZHkySGYz?=
 =?utf-8?B?cnVsSjNsOXhXZmVGQzJ4eFV6cFFVQXczZTNpOWpUMnFEQjV3Tm1DTUFwbDR3?=
 =?utf-8?B?MnRTWVpVQ3ErdkR1b1RTS09nenJCeEZWbnVWRGpNdFNUVkdVbW1ObmVyQWhp?=
 =?utf-8?B?ZjhoYlY2bE1lUjFNeDVUVUFxQ1VTc1AzTWJWL1hyODhjNDhRZlE0WHNMYnU4?=
 =?utf-8?B?bUNtUHV1UkNxL25wYzVLNjh5bFFNdThWWVdEQm5VNnZZNTNJSFo4c1c2V0Va?=
 =?utf-8?B?aERlcE94L3RlVXRTQzQ5YVo3dThCRk51eDErYjc4QXQ2V0VWeHZNUEM3OHpS?=
 =?utf-8?B?QXNWd0VtZFk2YUM2dUxzOForbWNrZUNvdExONnFoQmJ5bURYOUlBaGtobTE5?=
 =?utf-8?B?LytqWWJVdTdIMDdlb0g3K3Z4bWdScUw0SDRXV1czUm80RkVpK2UxTGFDNldh?=
 =?utf-8?B?d3BGU3hsYUx0QXNxNzJoVHhWWnoxWjh2eG5QbDRaWE5qUEhJOG1QaXlBWUdF?=
 =?utf-8?B?SUsya2JkdmpNRksvYTNUb0dmcEVhRStjTlRVcE52UFFxblBiMHFaR2ZCVCtD?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55fed95-a56d-464a-9c76-08dab1287f81
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 16:47:52.6105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4qDzpGcBMYpUCb00fRFIIvIJ53pId/nQlKnLYDuY9gInXKBL20bWKPGYWuJXLnCl2qJcP7luKrS0BMbHllmJcXQFQOmfPtXi/sxJC/1DOzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6250
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-18_06,2022-10-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180095
X-Proofpoint-ORIG-GUID: kW2diLIwI2npxxHXH3EGK9wzFUbrIfyl
X-Proofpoint-GUID: kW2diLIwI2npxxHXH3EGK9wzFUbrIfyl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 12:11 PM, Khazhismel Kumykov wrote:
> If transport_register_device returns error, shost_gendev has already
> been cleaned up - however since we ignore the error device setup
> continues happily. We will eventually call transport_unregister_device,
> attempting to delete shost_gendev again, resulting in a crash.
> 
> It looks like when this cleanup behavior was added, iscsi was updated,
> but scsi was missed.
> 
> Fixes: cd7ea70bb00a ("scsi: drivers: base: Propagate errors through the transport component")
> 

Where do you crash? Do we need to handle the cases transport_add_device
is called directly and we don't handle the failure then later call
transport_remove_device directly?

The thing is that transport device addition success was
supposed to be optional where we were supposed to be able to
still at least setup the device, boot and use it. Tools might
be missing some attrs but we were still supposed to run.
I think that's why we didn't propagate errors originally.
We were also supposed to also be able to call transport_configure_device
even if the transport_add_device call failed (see comment in
that function for info). Does that still work?
