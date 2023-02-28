Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171CB6A5F0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 19:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjB1SyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 13:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjB1SyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 13:54:11 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190822ED41
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 10:54:07 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31SGwjo8000338;
        Tue, 28 Feb 2023 18:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=b+XA7TvHZ2PCiAFSw/V9KskXuxBA0at3Lkfvm0t5y4sLh1vis6q7yRTms0dJ8wLYF6+o
 zPMsrhXD9lN7cbVxwnNlF6NFplU9x+0gBbwHgzR5wTLleWuf8/Xko5dIpXuYaXu7FXXH
 glxPlW5XLb4YOmf0zqUFfLQaxA7F2l1z8XfFWx1QW28SA/vd1VoakeLvtwGvrChT46XO
 lIFLHVnzp729qbvsQcv/09Fdx+wqr7CazwztneGB7bWr35lbSSjk7QPLY8rf0sl8nckW
 jbYdOnJafJgGDRUBfuPZmoRAPO/ZIAHuE3WeoaBYtICs7+kjXUFYVm81d5XfkkaHAl9A zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybakq5sf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 18:53:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31SI7Mkc015880;
        Tue, 28 Feb 2023 18:53:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s7hk83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 18:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzGk98NZP/CyJcM6usnY4EeyAkf2Znaenee5ucLtSrGd4+dq7rO20MGtit2vk/lTB9FexK4novZc5Olxaf1+/MwgPW9HNdzFMgvDsY7hVbCr97glFD5GQvndOZjli+7gNYFfy2bMaqA8OKWPF7BxJTB1wVhMO+G9IE/31balZ1jITy4a85xQhaY96MSbeUM53HM5/a1kSBDDHxQvmyGMRO2VKpFtHQIpEdxRpTVCnDcug7kfifxPd3G/oAnyVQ8MgSj9Ffxm7vGq3tCWPj0d6O++l91lXzxvmSdxsbh5EIVcW66WvBqhSX8TbYFUqFh1H0eNt8glGdBd5fCKymby5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=fmGxMBawzr0lOS/WCA6IcAXfJqPd5pVpbMVqY5XqLg2hJdLl9MNe1Qhrv4Z6OZm77TFBZ3vtfc80nJN0XzOb4A0VTz4Ca8V70aQ6zJHilQyVWmQMK/8xIP/n/WJqvmEatnV+O/wwo/EQ0oCoe+tCn5gBOOVPUncndc6wfjrxXkDGqz+uUFZa0P0bqML8pyg63MHX3aMeBuk/wGeRjjr5g9H706pjDbgeqVixlKQRYJF5fZzC8OD9iXm43ADSNnMk8pfx+eMwvdAHGoEuDfCP/w96NnC1NTIgzmhBerNT4QltAgVjFHgvUT7+0VFonNajbmIkjC+1pF9rsas5EijHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlTWkFE6J/M40fJeeAuai0dwDaf0255EUFIhzuN2e+A=;
 b=zLy0cNb2K+qg3WK0sWtuR4oxExbMTxPbTpKbFJ422Im+UV9V40/PjmvfCHYV305QkbI2w/joCdO30HdXPVLk72N9knGJs9ZISAQAYY0JcXI5vX+8JFIVPh6N4hMrqUwuU7qePkLSHVt24a2hp0H9+uYFAv7tR3TjQ5eI8ORy2CQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SN7PR10MB6668.namprd10.prod.outlook.com (2603:10b6:806:29a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Tue, 28 Feb
 2023 18:53:08 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.017; Tue, 28 Feb 2023
 18:53:08 +0000
Message-ID: <7b0e3676-40e1-3ea1-6d58-6d934970aa27@oracle.com>
Date:   Tue, 28 Feb 2023 12:52:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-6-eric.devolder@oracle.com>
 <87sffpzkle.ffs@tglx> <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com>
 <87h6vw2rwf.ffs@tglx> <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com>
 <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y/33OOdv22CEaTNA@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P302CA0037.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SN7PR10MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: c4135e87-014c-4111-58e8-08db19bd0804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AfBL6xS+YFJkXoKIOOtUuRANYQAs2ztA87jH+AwzNzvzAc4Lfm2JXRvEYMQRekP79vAtQqWTVSv+2GxHVtlxYwJ/t/dMSGEXZyu1vLhiXkwnyWGrRg5VSsSh09HCI+eonr+7W2m0QBhbhb+VYF52w+AZbJA/UzOyNEmImt7+fxfaJTS9139JT7Ag1TGBsZ+upIusfVzs5oNuRQiJJZEMt68vGLALIn7oWQLYsLVcUu/fTfwSIKXuQg7TXExcjBSVrjV4zYCgt1XUhO3oBhLw9MhFKGb0e28IZrv812A4PauWmc2yVGPbO+x/ZmHCQLVAUWfFjCdAVO2nUc3xFcSTa6o0mgO8y3O5aU9Suc9POYSyLmYtI6cSuK3urSBV/87dNeEdK2AFAWgoIHFiBIt0U9O8QzmahP2Ul3hWV/4z7EdXf66SatVcKq8fkDJOK+DvCYSJ5eZxJGvThzYYToB+ITIN/3FQk3fFe66P6wM7ixxFi3TB4BeE1soVv07cnpSlBF3idwUhyxDE9T+OR5SmRKeEAmdZglkNSO9i4dMkEplDPsZPO0/xNPne5oTjeej5e9b9mQY49TWzQtY4qFQjE/aLSYPCUIdbkBkjnjqdv9i8k4YtQjzYXgErAad7QWmZKKU/QQocCuuvFsYQbELWBYY56EWzxnGZzNQoNTH7T+oZhsmMmbc8TWQRdHnQaGKQuzUbY+wEQK7oF4wS9J/ThnBvNF3jhwsaGyDqHvtI4+I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(366004)(376002)(346002)(136003)(84040400005)(451199018)(38100700002)(36756003)(31696002)(86362001)(2906002)(30864003)(7416002)(66946007)(66556008)(66476007)(41300700001)(8676002)(5660300002)(8936002)(4326008)(2616005)(6512007)(6506007)(53546011)(186003)(83380400001)(110136005)(478600001)(316002)(107886003)(6666004)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkluMU0rZDhNTW5DaUlXK3ZncE05RXRhNDhZd1QrQ1B5elYySzFMbTVNOTF5?=
 =?utf-8?B?dVB0K3RKd1RMY2dOblB2UFVhWlIwUS8zNEU1VUxld0ZhSzFuZ1liUUs1WGxu?=
 =?utf-8?B?NHo2NktPcXhIZGs0RmIrU0IzckFKTjNjYnUrQjBKSzdGQW9tRXNsMFdBaFhq?=
 =?utf-8?B?KzR1ZDcyZXFGczE2a01tYWwveGVZeTZIWkUzUjViQnZ1ZUEzK2hmcHZxV0xo?=
 =?utf-8?B?Q05VWU9ZeGNPanFOREhRa29WVkxhWm5KZFRuanZZUHFyV1JlYlFnZnphV1VE?=
 =?utf-8?B?cWRZN0I1VzBEMWhYQXlhZkRVTFFiMzJzWFAvWk5HcUZ1ZHROdlFJOVZLVUZE?=
 =?utf-8?B?SmtBU3VmT3o2eGQ3VXlPMVplM0c3bzJXWEhmWHY5MG0yOXQwL3lkUVFCVzhU?=
 =?utf-8?B?R1BMbDlKMXpsNnVnSFVtdzRBMzZ0b0FjbWppV2xSWlF0aVN4NDJQQkNoOHhQ?=
 =?utf-8?B?TFFFSHp1VGQ3bThnd3oxYTYyNHVoYVIwTGdCRTBteVFDL2FsaTBqR3RodGVI?=
 =?utf-8?B?Ni9mNkh2SG53c25rUHlXZk9tYkpHVWpGQnVyS1p3V2Q4aXJ3bHkyU2xXNWVH?=
 =?utf-8?B?SzFGelQ2RklsU2Fnd2gwNUQyaFRPa0tzSkdrQk9CbnhpL255a2QxUFlBOFhq?=
 =?utf-8?B?MWFsU21UbmdRRzdzbTVXcjdsNnVRWUJvZjZybUtJV3ZiVUpld21QbHZlTkNS?=
 =?utf-8?B?QWdaRitjTHNiaXV1VllRQTNMSmFOZGl5eGl1aXhnUnZLSXdaZkIwbU43ZE5q?=
 =?utf-8?B?N2Z0eFZvK1k5L2R5blFUeHBmekZEK09IYmhxN1VJcldBaGttallCWXkyMk53?=
 =?utf-8?B?Y1NMM2dqZzV4VGpuOVV4SWp1YUVlTml4MWJMWGJNZjRjM1hEdS8rbW5iK3pE?=
 =?utf-8?B?ZmhjTHoyUi9DSE9jbzNZb2F0QUdaQlZNYlJQYkNkUk1PR1ZVemFvU21CWkJ3?=
 =?utf-8?B?UHErVHk3cFlJOG1Qb3VyaE1hdHBKRUE2cXFySGIyM00vV25yaEhFeEVZOHBI?=
 =?utf-8?B?a3E1aVVtZ3ZSVWxBMGZzZ1M0eDZDWWw4blk4N3JONUJiL05qVG5TVjV6Y2Ru?=
 =?utf-8?B?VXlqSmRqR0tWUTVST25MTGg0cU9yaEpSRkduRjV2eXNNaVlZSDFVKzF6SkJZ?=
 =?utf-8?B?dmpEZFBWWHc2UXl1UnNQcGVWcGN1QytMVmp6Z2x0eGJWd3AxeTU2OWphUUFs?=
 =?utf-8?B?T3lxcjA3WG1pOFVsdnZiVWFRbDBMTG9kdVdJSVoyLzg4TlJIbklHL2hJZzVW?=
 =?utf-8?B?VE9yRXRyck5TWWc2ZHlOY1ZJMlNTWnJjMUxxYmM3R1FHNGhybURTelNuRTNL?=
 =?utf-8?B?cm9MK3ZnbVVDTE1kelNEbmlvQ1VFVC9pcEZnRlBLQkVTVG5OTlJYVXhLNGVY?=
 =?utf-8?B?KysyN0RnRmppRGdHaU4xblNUWFhja2FVa0YvMVhQeTg4M1Vudkd1QjEvT1Uy?=
 =?utf-8?B?dzBlM2dvdVVIQ2NTeHRMbDUzR21KbGJzaVk1SlhTbE5PODh3cUN4SUR3R1Ay?=
 =?utf-8?B?ODlyWUxjWUZjZ3ZnaHdlQU5xbERkV0ttWmN1K2JJTWorZnRJa0pRbnY1MXRh?=
 =?utf-8?B?MjNPdFZqM0pJQmtDRVFoVU9STXN3UmhETXR2NmNJU1JLTjc5Y0wrclBXS0hP?=
 =?utf-8?B?cUx1RHE4dzNxV1ZuYzIvUzlSV1E1NlYzekhYcEtEaG5KNnNzeW11LzJKMUpr?=
 =?utf-8?B?MnF4NXFSbEU3UEkrZ2x2elRZeUxiT1Y0TW9PZkJ1ZkVWVHloOWI1WG5NVm13?=
 =?utf-8?B?VytrYWMyVzNRaldrZElqNmhEcG1Na3ovcDhCKzZWOEVncGU2U2hZWkpTNFFN?=
 =?utf-8?B?Slp0Y2drQ3pzM1BYZmF4ZVR6Um16T2FubEtQQUZadXZJOVZocDBZSFFGYUFD?=
 =?utf-8?B?eEY2MEhFaHpzY05hMVAzM1hRbTNJa2ZBdUV1V0s5dmlNZXYzcHdqYkVxS2tq?=
 =?utf-8?B?K1NXYkVQQWpZNFZLdURzTmRsYjVEWVJWRkdaOGVVQUpQSWwzQTE5Z0xNN1dN?=
 =?utf-8?B?UkJKVWRGM1k1b3JHWTJrZVZ4VE4yUTY2R04wMHh0SEp4QWcwazJUeW9JNm9Y?=
 =?utf-8?B?SVAzTFN6TmdKMlJUMmtWQWg0bDRVK294dkdNdldBRHlXcmJqRko0VUcwVEw0?=
 =?utf-8?B?Q0tqZUxNSUhPQkJNSWR0MENGUjRhbTJUUkg2TEcxR1BOa3hLL09uYzdSOThZ?=
 =?utf-8?Q?lCt68hXBCzouLORdTsrp110=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?eUhQTDlOUitUbUlYSGdBYXF6d2twTUdwbWRiSFF2ZTFhMlNDdjBLU0h3M0h0?=
 =?utf-8?B?a2dpVEJCZU96dWYzQlNjZy9oM3ZRVjlKNmdSVExzVHFjWWppQWk0d1YySElE?=
 =?utf-8?B?YU1lTGdFZDJTVDYvdXhlVytGT1dPSTZqV1NjZ211YmRyQnRNdm1nQTZKSTVr?=
 =?utf-8?B?ckRoN0JXdUZZc0RGWFJsRzZNYkFEdGlPMEppY3l1WlpFekh0S09VWTdNNmJj?=
 =?utf-8?B?akNuTTBrQWlsUmliTTVsVCtybEFmMi9BUWxDSEd5a2Fsb3p0dEtuVXlQSmty?=
 =?utf-8?B?NFlMZ1dYTU4va0VEdVV1UWR4cHZPOEs2ZWhwamd4dUpRcGs4ZzNESFRoZXBa?=
 =?utf-8?B?eVJWVGIrVVMxUDc3YWVUWjZGMmhhaGNDVnNvbis3SnNBS0RZZDZhOEVBZVNJ?=
 =?utf-8?B?bzVTMlBpUmt3L0d6ODJzQnk4aDdwdXVCZVB2NE9wQVIrcXEyYk1VZTJIRFZH?=
 =?utf-8?B?bTJJeWsxcm9qdlhabmduVzdjTDY5RExtdTdQNXFtQ3FHR0o3VGQ1SCt6cmxF?=
 =?utf-8?B?UFlHdlJyUjhNbHByS29SaW9UdW8zS0tOOXBXb2k4VUZNd2ZhK2x4UnZOYVZM?=
 =?utf-8?B?SU1HMVZEbCtwdDh0azdQUzIwK1ZTM3RiSC9KSW5xN20yTXJvRTdtWGRFUGNn?=
 =?utf-8?B?eEZERDRBcmtvcTVZbVlpMFdzS0JSUzJ2UnVIQWxJU2ZwVnRSWlRvdFYxQWtO?=
 =?utf-8?B?QklGbnlzYzkzSHd4ejgwSmgzUVdnM2F5MytQT2p3bzZBbXFqMWFRQUJ2ZVB4?=
 =?utf-8?B?djl0UkZpd3hjSjlzTWVqZDVTMzQ2Tm5xV2hiWkRxeEJ2UjR0ZzdWR0FKaUZI?=
 =?utf-8?B?MU9zNGxjWnVJTTc3N25TNS9GdjUvN3dUODFFOGdua0FyTzRXTU1rNWE2K01D?=
 =?utf-8?B?dU5DVlFXUDFhWGpSVDEwRjRMTWllLzZ1SUdLY2hZOFdlUnU2R1hOWTYzeERB?=
 =?utf-8?B?ZVdZTytpVTk5dzVKcWpRK2MrN3drMTFRT1NTVktmUC9RK1pvQnpvcjBaSHNy?=
 =?utf-8?B?VGRwL1hMSDdjaVd4SWxxdHRqeis0ZllkekJRY3QzaWpTci8vUFQ4eDNrSklU?=
 =?utf-8?B?Y1d3dWNDYlluZ1JTdDNKK05IUHlDcEhMaEdmRXphWThvekVKcHo5cW9FWExP?=
 =?utf-8?B?V1F2YWtJK29RL1VxTTMwMWRVRTE3V3FBOGR0Q05ZSVJJcUJHL1FkdnY1cHkz?=
 =?utf-8?B?RGFqWnJmSjdDSFhmTlMvUS93aXE4V3pUUE1QcXIwSHBJVVdmcXMyditxTnlQ?=
 =?utf-8?B?Skx1bnRlTHdCSmZkVCtkcXVaaGk1bHA2RXBIMEsxb2d3Q3JQRU5YSGhwK2J1?=
 =?utf-8?B?aUtONlRYSFBxaWZ0NUZlNjlJV3lnd0JwSnhpd2NrR0U2VDNPK1VKNDVjdUVD?=
 =?utf-8?B?WVVmcXU3ZHFOSEdkbHFVTDYwdzAyeXpHMWxsU1YzQjUweFJSR1BQVFJMTUVZ?=
 =?utf-8?B?ZXNVcWw5MjloaHJ3YzhHOEhLMUQ1eXpqYUNTOE5ZOXhMQnQzMU9QeUZoRUND?=
 =?utf-8?B?QjJWT251SWRuVmlpVlUvcksrQjY0Rmh6SVZ1MWtNeWlOcE5xZFFEclgwUzZn?=
 =?utf-8?Q?LG4GVlI8wXhZGoKYtdN6NhyKk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4135e87-014c-4111-58e8-08db19bd0804
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2023 18:53:08.1150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9jEJF26wtr94SUDG0C4xKNLOKopVNUlx7jl7LVJOVDrDsQDKJdonoAMEKOB2glXmeLtMdH8mypHheiAIdTcc86vyDPLAE3sSYgIS+JrIlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6668
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-02-28_16,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302280157
X-Proofpoint-GUID: gKqZUecDUUM3Ceng7Kl860NVmG5nXqYg
X-Proofpoint-ORIG-GUID: gKqZUecDUUM3Ceng7Kl860NVmG5nXqYg
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/23 06:44, Baoquan He wrote:
> On 02/13/23 at 10:10am, Sourabh Jain wrote:
>>
>> On 11/02/23 06:05, Eric DeVolder wrote:
>>>
>>>
>>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>>
>>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>>
>>>>>
>>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>>> Hello Eric,
>>>>>>
>>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>>> Eric!
>>>>>>>>
>>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>>
>>>>>>>>> So my latest solution is introduce two new CPUHP
>>>>>>>>> states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for
>>>>>>>>> offlining. I'm open to better names.
>>>>>>>>>
>>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be
>>>>>>>>> placed after CPUHP_BRINGUP_CPU. My
>>>>>>>>> attempts at locating this state failed when
>>>>>>>>> inside the STARTING section, so I located
>>>>>>>>> this just inside the ONLINE sectoin. The crash
>>>>>>>>> hotplug handler is registered on
>>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>>
>>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be
>>>>>>>>> placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>>> placed it at the end of the PREPARE section.
>>>>>>>>> This crash hotplug handler is also
>>>>>>>>> registered on this state as the callback for the .teardown method.
>>>>>>>>
>>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>>
>>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>>> {
>>>>>>>>      struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>>
>>>>>>>>      return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>>> }
>>>>>>>>
>>>>>>>> and use this to query the actual state at crash
>>>>>>>> time. That spares all
>>>>>>>> those callback heuristics.
>>>>>>>>
>>>>>>>>> I'm making my way though percpu crash_notes,
>>>>>>>>> elfcorehdr, vmcoreinfo,
>>>>>>>>> makedumpfile and (the consumer of it all) the
>>>>>>>>> userspace crash utility,
>>>>>>>>> in order to understand the impact of moving from
>>>>>>>>> for_each_present_cpu()
>>>>>>>>> to for_each_online_cpu().
>>>>>>>>
>>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>>
>>>>>>>>           tglx
>>>>>>>>
>>>>>>>>
>>>>>>>
>>>>>>> Thomas,
>>>>>>> I've investigated the passing of crash notes through the
>>>>>>> vmcore. What I've learned is that:
>>>>>>>
>>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references
>>>>>>> to do its job) does
>>>>>>>    not care what the contents of cpu PT_NOTES are, but it
>>>>>>> does coalesce them together.
>>>>>>>
>>>>>>> - makedumpfile will count the number of cpu PT_NOTES in
>>>>>>> order to determine its
>>>>>>>    nr_cpus variable, which is reported in a header, but
>>>>>>> otherwise unused (except
>>>>>>>    for sadump method).
>>>>>>>
>>>>>>> - the crash utility, for the purposes of determining the
>>>>>>> cpus, does not appear to
>>>>>>>    reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>>>>    cpu_[possible|present|online]_mask and computes
>>>>>>> nr_cpus from that, and also of
>>>>>>>    course which are online. In addition, when crash does
>>>>>>> reference the cpu PT_NOTE,
>>>>>>>    to get its prstatus, it does so by using a percpu
>>>>>>> technique directly in the vmcore
>>>>>>>    image memory, not via the ELF structure. Said
>>>>>>> differently, it appears to me that
>>>>>>>    crash utility doesn't rely on the ELF PT_NOTEs for
>>>>>>> cpus; rather it obtains them
>>>>>>>    via kernel cpumasks and the memory within the vmcore.
>>>>>>>
>>>>>>> With this understanding, I did some testing. Perhaps the
>>>>>>> most telling test was that I
>>>>>>> changed the number of cpu PT_NOTEs emitted in the
>>>>>>> crash_prepare_elf64_headers() to just 1,
>>>>>>> hot plugged some cpus, then also took a few offline
>>>>>>> sparsely via chcpu, then generated a
>>>>>>> vmcore. The crash utility had no problem loading the
>>>>>>> vmcore, it reported the proper number
>>>>>>> of cpus and the number offline (despite only one cpu
>>>>>>> PT_NOTE), and changing to a different
>>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>>
>>>>>>> My take away is that crash utility does not rely upon
>>>>>>> ELF cpu PT_NOTEs, it obtains the
>>>>>>> cpu information directly from kernel data structures.
>>>>>>> Perhaps at one time crash relied
>>>>>>> upon the ELF information, but no more. (Perhaps there
>>>>>>> are other crash dump analyzers
>>>>>>> that might rely on the ELF info?)
>>>>>>>
>>>>>>> So, all this to say that I see no need to change
>>>>>>> crash_prepare_elf64_headers(). There
>>>>>>> is no compelling reason to move away from
>>>>>>> for_each_present_cpu(), or modify the list for
>>>>>>> online/offline.
>>>>>>>
>>>>>>> Which then leaves the topic of the cpuhp state on which
>>>>>>> to register. Perhaps reverting
>>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right
>>>>>>> answer. There does not appear to
>>>>>>> be a compelling need to accurately track whether the cpu
>>>>>>> went online/offline for the
>>>>>>> purposes of creating the elfcorehdr, as ultimately the
>>>>>>> crash utility pulls that from
>>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>>
>>>>>>> I think this is what Sourabh has known and has been
>>>>>>> advocating for an optimization
>>>>>>> path that allows not regenerating the elfcorehdr on cpu
>>>>>>> changes (because all the percpu
>>>>>>> structs are all laid out). I do think it best to leave
>>>>>>> that as an arch choice.
>>>>>>
>>>>>> Since things are clear on how the PT_NOTES are consumed in
>>>>>> kdump kernel [fs/proc/vmcore.c],
>>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>>
>>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>>> If yes, can you please list the elfcorehdr components that
>>>>>> changes due to CPU hotplug.
>>>>> Due to the use of for_each_present_cpu(), it is possible for the
>>>>> number of cpu PT_NOTEs
>>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus
>>>>> does not impact the
>>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>>
>>>>>>
>>>>>>   From what I understood, crash notes are prepared for
>>>>>> possible CPUs as system boots and
>>>>>> could be used to create a PT_NOTE section for each possible
>>>>>> CPU while generating the elfcorehdr
>>>>>> during the kdump kernel load.
>>>>>>
>>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every
>>>>>> possible CPU there is no need to
>>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>>
>>>>> For onlining/offlining of cpus, there is no need to regenerate
>>>>> the elfcorehdr. However,
>>>>> for actual hot un/plug of cpus, the answer is yes due to
>>>>> for_each_present_cpu(). The
>>>>> caveat here of course is that if crash utility is the only
>>>>> coredump analyzer of concern,
>>>>> then it doesn't care about these cpu PT_NOTEs and there would be
>>>>> no need to re-generate them.
>>>>>
>>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming
>>>>> into mainstream, impacts
>>>>> any of this.
>>>>>
>>>>> Perhaps the one item that might help here is to distinguish
>>>>> between actual hot un/plug of
>>>>> cpus, versus onlining/offlining. At the moment, I can not
>>>>> distinguish between a hot plug
>>>>> event and an online event (and unplug/offline). If those were
>>>>> distinguishable, then we
>>>>> could only regenerate on un/plug events.
>>>>>
>>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>>
>>>> Yes, because once elfcorehdr is built with possible CPUs we don't
>>>> have to worry about
>>>> hot[un]plug case.
>>>>
>>>> Here is my view on how things should be handled if a core-dump
>>>> analyzer is dependent on
>>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>>
>>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash
>>>> notes (kernel has
>>>> one crash note per CPU for every possible CPU). Though the crash
>>>> notes are allocated
>>>> during the boot time they are populated when the system is on the
>>>> crash path.
>>>>
>>>> This is how crash notes are populated on PowerPC and I am expecting
>>>> it would be something
>>>> similar on other architectures too.
>>>>
>>>> The crashing CPU sends IPI to every other online CPU with a callback
>>>> function that updates the
>>>> crash notes of that specific CPU. Once the IPI completes the
>>>> crashing CPU updates its own crash
>>>> note and proceeds further.
>>>>
>>>> The crash notes of CPUs remain uninitialized if the CPUs were
>>>> offline or hot unplugged at the time
>>>> system crash. The core-dump analyzer should be able to identify
>>>> [un]/initialized crash notes
>>>> and display the information accordingly.
>>>>
>>>> Thoughts?
>>>>
>>>> - Sourabh
>>>
>>> In general, I agree with your points. You've presented a strong case to
>>> go with for_each_possible_cpu() in crash_prepare_elf64_headers() and
>>> those crash notes would always be present, and we can ignore changes to
>>> cpus wrt/ elfcorehdr updates.
>>>
>>> But what do we do about kexec_load() syscall? The way the userspace
>>> utility works is it determines cpus by:
>>>   nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
>>> which is not the equivalent of possible_cpus. So the complete list of
>>> cpu PT_NOTEs is not generated up front. We would need a solution for
>>> that?
>> Hello Eric,
>>
>> The sysconf document says _SC_NPROCESSORS_CONF is processors configured,
>> isn't that equivalent to possible CPUs?
>>
>> What exactly sysconf(_SC_NPROCESSORS_CONF) returns on x86? IIUC, on powerPC
>> it is possible CPUs.
> 
Baoquan,

>  From sysconf man page, with my understanding, _SC_NPROCESSORS_CONF is
> returning the possible cpus, while _SC_NPROCESSORS_ONLN returns present
> cpus. If these are true, we can use them.

Thomas Gleixner has pointed out that:

  glibc tries to evaluate that in the following order:
   1) /sys/devices/system/cpu/cpu*
      That's present CPUs not possible CPUs
   2) /proc/stat
      That's online CPUs
   3) sched_getaffinity()
      That's online CPUs at best. In the worst case it's an affinity mask
      which is set on a process group

meaning that _SC_NPROCESSORS_CONF is not equivalent to possible_cpus(). Furthermore, the 
/sys/system/devices/cpus/cpuXX entries are not available for not-present-but-possible cpus; thus 
userspace kexec utility can not write out the elfcorehdr with all possible cpus listed.

> 
> But I am wondering why the existing present cpu way is going to be
> discarded. Sorry, I tried to go through this thread, it's too long, can
> anyone summarize the reason with shorter and clear sentences. Sorry
> again for that.

By utilizing for_each_possible_cpu() in crash_prepare_elf64_headers(), in the case of the 
kexec_file_load(), this change would simplify some issues Sourabh has encountered for PPC support. 
It would also enable an optimization that permits NOT re-generating the elfcorehdr on cpu changes, 
as all the [possible] cpus are already described in the elfcorehdr.

I've pointed out that this change would have kexec_load (as kexec-tools can only write out, 
initially, the present_cpus()) initially deviate from kexec_file_load (which would now write out the 
possible_cpus()). This deviation would disappear after the first hotplug event (due to calling 
crash_prepare_elf64_headers()). Or I've provided a simple way for kexec_load to rewrite its 
elfcorehdr upon initial load (by calling into the crash hotplug handler).

Can you think of any side effects of going to for_each_possible_cpu()?

Thanks,
eric


> 
>>
>> In case sysconf(_SC_NPROCESSORS_CONF) is not consistent then we can go with:
>> /sys/devices/system/cpu/possible for kexec_load case.
>>
>> Thoughts?
>>
>> - Sourabh Jain
>>
> 
