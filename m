Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6756BD450
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCPPsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCPPso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:48:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA86FC97CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:48:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32GDtVLE000717;
        Thu, 16 Mar 2023 15:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=DEqhhey19jSZ+ttq/XUj9OfbMD047iGW6XoqLHuLUKPVPyDuXNcc/KaAdgNWZDmlTsRF
 p39Wsu03gajY1l5d0VsZMsKiSR6hbM+dUKmZOgsPE/LCjIZURZfOYgbEdBMJm8eomIbt
 X2yL47d0M8NIipUsOnBQFSFhNTysAqoDCH2A1jbpUiQzWiUmtm3M/xOxNu4CgLKUwlvW
 8lBmbwqAqpo2EhK4X/g0ugD9jE0RpyF/7dFRiEuWaahH4BmBDxsupQDSUaJKOwBwwRnp
 v8Sl9rbEronfF0lAfn1v9S4O5J7NffuH5ELz9Iuj2DlOlrfFrO5rr23dikvnOEDjCH+M qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pbs291h19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 15:47:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32GF9lwr036835;
        Thu, 16 Mar 2023 15:47:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pbq9hqtwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Mar 2023 15:47:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiLVZB7RIhzp56IVmWwcodMjuSdWoGWPRb7FArRJN/+NhjzPhH5KBHJPo1mfh7XNK5cf6jR2IbVfGO7Pb7MOp4RgJ5PqZEYT3cV8Aeb0m0obx5Wqe/mnebFS9F5g4y4UJ/wsNHup+92GuEe2SyYMSwMmzs34SleV5Uj6qdyfusL5TyJNijxO5pIro8ZCVozUFoxJ4NVI5fH1ZWRiucFh6xi9XBYZS1TGBynfuNET9qAcUiv8pMJTfsTI9B6KkRLdg+gFgvUM0oegiMMFuTfcFyvbRi+iT0iNbTi4hKpmuVMlkol6ZaTNxlpBX3hCX14f2p95urpeVbiw1se0J/s3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=nDZ4gMadIwtdekoVaX3aZxjMvIyMpotYjbImsn++vQlxiPaH/hkhSuh5u2sanXEBTWV73qlK4GfFk836AMb+K8ItO7Jhj7jcVPmqzeha0kVb2RbtcH6Kbf26BM1kiMqydMnECwYDR1kWDcHBrBR2gX9RVejl+KqF6Qx+eiYTxEZbrHm9sKlCDilzmTIbDGrqrAVVpmqvo+c5gB3P4sxrSck7mZqVPTeV2nG/vGBvhZ623zbwXkEUoSiv6QdvEObOOOfxWuWjx3vTsPAPqVsN01HKIaB3hzRb4Z05Qv00MYqtVguq6U7xreYU3zBu/j9l8nn1PKuy+Bx9cExhcYqp4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFEQ6UrR21k7T6qVtDdXF5sM4qDh94dWCZou8Yx+RSw=;
 b=F4JmYLq35ovu8OtI5I375/yooux1+RmZVhMz/2IxkZnkdKPQhzZxnlnRMS1lN/gRNYceu9tnPrIkaRYWMpz4asDbuHdot2z9eIlh0YNYRRL3GiacmoPVV0/fL8RCJLIw6JLkkb8jjSRNBsQa/2mx289QgVXvsZYWCqNb2Gqnakk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MW4PR10MB5678.namprd10.prod.outlook.com (2603:10b6:303:18c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26; Thu, 16 Mar
 2023 15:47:07 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%9]) with mapi id 15.20.6178.031; Thu, 16 Mar 2023
 15:47:07 +0000
Message-ID: <cae43a11-b270-a5d6-7464-d92651c67c4a@oracle.com>
Date:   Thu, 16 Mar 2023 10:47:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v19 2/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-3-eric.devolder@oracle.com>
 <ZBLrTl3UHYa1FV2S@MiWiFi-R3L-srv>
 <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
In-Reply-To: <cab057d8-98d8-a72a-8b61-8a01a0f088e7@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR21CA0018.namprd21.prod.outlook.com
 (2603:10b6:5:174::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MW4PR10MB5678:EE_
X-MS-Office365-Filtering-Correlation-Id: 474a7af3-8978-4755-332c-08db2635b286
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ETQGijRWHjY+LwbGOrFvrfsGUUmIAVYDM/Ps4d1bnR3KKr/oEbz8mn4onF2azn6H5LTtmEwrDpGIXsFV1hIpn4x8SJw3WYq+o7Jt0rUx9T8Gm+7O6TFNzB7ZGsfy9JnVcVa2khLdIgtZUhvaJ/Fty7CcE3Mkn8Vc4Erf9rdOeB9nj9YIaez7PdWZpV9fXTVUOK2RGUKkfyEZKlymezLUBkkfRbIHVXArmHB12bTYonMHi4lh+rLdBbcBdFNdcANxAekKEG/hBhOcGg7AT0r0JxbeIdE5XE/3YRBZMJjb0erCyOqgnrZ8N5rp+eafjSkSmkY6rLJqkQ2FKGMoq8lW85mvCV9/NNPkexNo+TRr9YEmSVOYef34Qki55uSyrrLJMUsOQKn0CmoQQbPtVWtrXvgIbhvS/LxAAhVOBCl+oCcT7iHU+kenE73l4ZqSsvvb6bsqPk9/8ySU/0ELrmQsXJ7fNnRCLCrMUmYiW6FRsPCef1+xepc+MZJLspuVH6ZjQErwrWDgAqvq/fIWkWUlDrhRrwWajuOp8nktb52VwZsXpfc1SK21KzuUgnCIXd+5cVRxWnWpJ210IG65LOhQvATg8JsLNFHGaajneosGdAz/ozH1OZCnHtUL1thFqOKzur11ka7FaFuR1WlnpGmIF8PPeGpZHflYiI5Wuustj4w26yfT8mmjPthTQijhDt0MbVm+rT/G4QO2OdQxqCDOupecwu+kAj1L0XNv76xyCEf0ERl0HHxvlqNV347ci4Kc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(86362001)(38100700002)(5660300002)(7416002)(41300700001)(8936002)(31696002)(36756003)(2906002)(4326008)(6916009)(53546011)(186003)(6512007)(6506007)(83380400001)(2616005)(316002)(6666004)(66946007)(107886003)(478600001)(66556008)(66476007)(6486002)(8676002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnpQSWtkRFB5amI4NTYwUTJvQTJPeVA2QnZBNHJ1U0dIMlpuWCs0bVVrR28y?=
 =?utf-8?B?YXArR0hJMVhGY1hIMHpoc1cwaFJYTmk5MXdCUStaamJGZm9mR0dsWm1DeURX?=
 =?utf-8?B?cU9rNE80cUlpQUxzQTQrUDVaWWFOOFA2WmhXdm1oWE92Wm9XMmcyeFk5bnFo?=
 =?utf-8?B?dVh1REpxTHczV1JHUzVmaklsdytoQ1U5MUpHOVFKTjBBTGJTSytyMUhDb3RZ?=
 =?utf-8?B?UjFnVUszdVl6Zy95L1dPZjNOWG1mbVQwbytPOWduZ1UvZEVUdDZrV2U4cmVM?=
 =?utf-8?B?V250bjRaZ1BmMW9lQnN1QVhmbjlKNTJEOXN4TlptVENEWUhKT1BITUxBTVlw?=
 =?utf-8?B?c1E2NzIyd2Z0K2xXbGVnaWdHQk1OYU1aSktHc01MYjE4em9YU1dBYkI3RnVE?=
 =?utf-8?B?Q3RoZVBRT3UvYTRxUjlMdWV4N3ZKdWxaQ1RhZFF2eW9Da2tqWFJpMjBCcS9l?=
 =?utf-8?B?TkV6RVptZlZFNjNjcnVoYmhYL2NiQmQrbWV2VnNPemtEZ2VjT1FYOE1zbkpu?=
 =?utf-8?B?V2JsL1lIcDBiQ0RQMzJSQkRzeThlMkI4aG5YSDF6L2I1TklEWWl1OGtZall6?=
 =?utf-8?B?TXJwYjhGZjBNUG9KYThBT3U0eWJqMkFwMC9mVk1PcCtkb2RkOUN2UzZCcTI3?=
 =?utf-8?B?SDhkL2VieWlDSHNmdjVtZUhkSk5mSHF2a04wYWtINnVmY0NhWlozMEhKVGNR?=
 =?utf-8?B?UW81ZERvZHd3eVY4UjNVMEdpRW91OTZNZXRubXJUdmI1MHRxNFJ1eW43TjdF?=
 =?utf-8?B?U09mWDlaYmFHd2dzWU9VdzkyUnZZa0lodEtha3JHQ1R6M29RMlZyWEFwR2d3?=
 =?utf-8?B?SlFrMDE2OXJuTW5vcjI3M0J2WE5INTljd0dxMFE5ZzlJd0RodXh3YUptZ290?=
 =?utf-8?B?dG5JclQ5M1hoMURMcU9oRXd0VU4zUFp0RlRXemlsSVdzVVkySnZDbjA4WWRl?=
 =?utf-8?B?UU01QWJJaFgzN213NXlTMmFWVENHa2ZZNFphcE1EV3pvTnd6VUg0MlN3eE95?=
 =?utf-8?B?OEU4cmM0M1BpTEZzRFBNeVd6RUxzMzN3NzN0Q1AvTW9HcHJ1dlBnM0p4R0xU?=
 =?utf-8?B?NUZtaU1lbVMzT1I1eGs0YU1HRlZUWmxyaDMxd3BlMlNyK3JWYjVMMmtuRWhj?=
 =?utf-8?B?TnBSYlJxbGNCWlR1alJJQXJ6WjZUcldWUGNLa1c0b3BXTnBLOG9wd1VIYXZG?=
 =?utf-8?B?TklkNkZxNkRVa1hOVnFLYXJYalM3UFpyd1dKTnhEa3FxTWFTWkJOdWFST1VE?=
 =?utf-8?B?em4yWXM5dHNiZVYzQlhaRlF6dWJoYVJMdVZ4eHlVRGVsT3lLM3dCa3pJOEMy?=
 =?utf-8?B?anZ5VW1IUlppZ3lvM2hkamppczN1V2VTcGVqSzFaZjRWMkdNK0Ixa0U4N2pN?=
 =?utf-8?B?SlZpVGNubmsxaUxKbVlZbVlwUUh2Q0RkUERLdXFKYlhmcVg5R1pvaWM4SCty?=
 =?utf-8?B?czE1ZC9mR1h5TW1VZnQ1djNIc3BiQVJRRW1FSmN3S1Jsb3lPekZydUxxc0tw?=
 =?utf-8?B?NWJjdmhkQy8xanZycmhLRUtneTBLcVRzNk1xckN2S0JzcHVESUVkL3lQc1Ni?=
 =?utf-8?B?dTQ2Z1lrNGpMVVlvdmxoQ0pNZUQ1Mlc4T0VwRXBOZXNrU0NSUkRMblh4NkF4?=
 =?utf-8?B?Q05xQmQyVEU3clpnWEpEK0RJZkZ0RG13bXV5MElvMHRpcUIxNWFYS1ovdUhM?=
 =?utf-8?B?YkFscll1YXRoNXExblZCNUNmQk1SdXRhK1g4TTdxeENYLzYxVjVtVE54a01h?=
 =?utf-8?B?YmRkeDQ5OXAvZFRXT3VkZ2NjWnBURVNFTUF1eG9HbzhzeDUrOUkrRFluUjBV?=
 =?utf-8?B?czl0Uk1kRE4zNSs2NG9tYWdycXlpUzJTYWh3V0FveTE5amRuOWo1ZUQvTjN4?=
 =?utf-8?B?ZFJaQ0M2dWFsK0ZKcHdBVE1GcmY2dE9KSjV3YjNlcENhRlRNOUVmM0N1a2NI?=
 =?utf-8?B?dFVpYmkrU2w4ZzJPRENpQVAvSjhqRlpza2hadUp4dHlJVGp2VVEvVzZ0NXp3?=
 =?utf-8?B?RFdlTlZSSWtUUDRrRnpiaEZTY0FsRVdGWTY3V1ZOcXYvbVhiT293d1hpaXZw?=
 =?utf-8?B?ejN6bStPWHh6N3F3WFdZSGhJYm82bWZKajJZeHNxYWgyN1E5VVNlY2RkS2s5?=
 =?utf-8?B?TC9jWkJHRlVTVkFOY21GdWlhdDdKS2N5VjlUS0Zld1hZYUROMXRxMzc2bDgx?=
 =?utf-8?Q?U+f7lPTJpILbMPvvQjb+54c=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NTNxOEFtaHdyRm11Z010NlZEaVRkZmdHL2RPZXFVQ3RXeEk3YkNxMFRrbVRx?=
 =?utf-8?B?dnZqTFZuVER5am4vTzF6WjdQMDFydk5TbVZRL29Dd3ROZ1ZUSVphYlY5L2FT?=
 =?utf-8?B?UWljU1B1NG5IZEo1UHkvZjR1RE0rYXNkZ2ZOUEF3eTVkQzNrVjErNEJKVmVo?=
 =?utf-8?B?YmFsdWtKa2szbXh6OEVzazYyaWZZakdXSWJjOXZ1WEhpSFFHTnVaUUdiOC9T?=
 =?utf-8?B?Tm1Nc2dvaGZpSGhDbmU0U3B6bGtjaDl6Vmt6NGJFR01iNHgxd0JYV2lrNWlP?=
 =?utf-8?B?cWkxZjB5TGF0MnpjQ29ZanJqeGxDMVhsSW9vL2dsTG9tdEV6bnQyOXlId3Bz?=
 =?utf-8?B?SXd4VWFjdXFTcnlzdUJENTRYQk8vZW5RUzZ6VWo2QmNITUNBOWs1SVdrNHpy?=
 =?utf-8?B?N09tRWFvMGRSVG52UWpjMVJESUxkZldJTVFuZDRzSzEyNnA2ZzYwWjhZYVJ6?=
 =?utf-8?B?cjNGeEZLMWsyU1VzaGNkSVFINHU4bTJ4N0VBY3pkVGhZMUJYdW85KzMvdzla?=
 =?utf-8?B?b0ZHbnpoTlpLeGZmK1d6N2FEMloxVmN0Z1IyT2h3ODc2Mm1xUVpvSXYyY0xG?=
 =?utf-8?B?aDNEbENFUHNpbktPTVJVZDYvblZWMEwxaTZyeHo5VXd6RzNsY2dQY2hGNmdr?=
 =?utf-8?B?bmFtVTFKclQ0Z1VZWTBqVFdmZGdpc0lPc2J3ZUVyd1B3bHdFaXh1ZFhGNjVO?=
 =?utf-8?B?TW8zdnVLZ29hQnBFRnN6a2dFNDNpYTRxVDFzU1VXSWcrVTZ3ZUM4TXd4a2Fz?=
 =?utf-8?B?RmNnZXdlMTRTTEtBWXVjVVdqTDNmNU0rUElMc2FaZDBTeEF5R1ZiT2dhOUt2?=
 =?utf-8?B?TkpnKzZzRUIwMHVaZk8yY3UzalNkYmFSK1BOR3NyMmR6YzJkamhwcGxFeHdV?=
 =?utf-8?B?d0tNV3JLVGxpMTl6enFQZHB5OEIyZE54aHY3LzNJSUJhYXBmQ3ZjTFJqaDVQ?=
 =?utf-8?B?NGNPMDdkNkQ2bUpZWE9pRUtKK2lVeWh3ZVFvMlJvdllVS1ZObXB2a0xKbjVO?=
 =?utf-8?B?N0J6aVc3UjVmb3BiK01NTnpWMVdIYTlrR3YxWmdOU1pPQ2FmT3FJZTREcFdy?=
 =?utf-8?B?WG5PTHVTRi85Q0pMQTBpRjRpOFJWZkpzZXV5Qk9oM2xCZGUvMmRtMnRaQWVj?=
 =?utf-8?B?blpGMHlTcDhQT2pTZG5hOFMwQWZpaXd6YmI3dDhoUTJqVzZNTTg0MzFGeG9F?=
 =?utf-8?B?TWVOY3YybTliZGtwakRUY1dYaXg3Q2d6alZacm5wRVc0TnlFK2lFaUZBQk15?=
 =?utf-8?B?TE9DTU55NW5KdFZINS9BSEY4cFlMcXY0YW0xTzB6emJJdUk4VWZkYyt2Nmsw?=
 =?utf-8?B?ZnFrRGU4bzFLOVRSQkc3dDRYcy9GenhHcHhKdllwalZscHZscCs5L3RlWTRi?=
 =?utf-8?B?SEZKeC8yb1h2NXVYVTh4Ujc2bHlDZDdqOUVTUHhPSHNMdUplZVZzZlFESGFN?=
 =?utf-8?B?cmpoOVRSWkJZNkNiZGJ6OEJJNWJMN0gzVnJzWUhOMzk4UmZ0dG82dzh1M0ha?=
 =?utf-8?B?SjZzMjBGeVVsRzFqa3FCN1BzSmR3bWRibnVMT0gxNmhOUzZQNUVqTlZZT0cr?=
 =?utf-8?Q?3IkF3pfJz7UKvb7V4ScZ24GxA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 474a7af3-8978-4755-332c-08db2635b286
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2023 15:47:07.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EH2B5qadg/lwHfDJYfQKMyT3JOYHAFNR1dPY3535fEUU041NSUZE9xrhDs0tmwHarBr3hFdEmN2cUKMMxsuT0gAbLdEmIr7AsLzaqfDwfAs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-16_10,2023-03-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303160126
X-Proofpoint-ORIG-GUID: v3ZR2hcSNGUhgBB4PViSo1hg2D55MuVF
X-Proofpoint-GUID: v3ZR2hcSNGUhgBB4PViSo1hg2D55MuVF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/23 09:44, Eric DeVolder wrote:
> 
> 
> On 3/16/23 05:11, Baoquan He wrote:
>> On 03/06/23 at 11:22am, Eric DeVolder wrote:
>> ......
>>> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>>> +{
>>> +    /* Obtain lock while changing crash information */
>>> +    if (kexec_trylock()) {
>>> +
>>> +        /* Check kdump is loaded */
>>> +        if (kexec_crash_image) {
>>> +            struct kimage *image = kexec_crash_image;
>>> +
>>> +            if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>>> +                hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>>> +                pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
>>> +            else
>>> +                pr_debug("hp_action %u\n", hp_action);
>>> +
>>> +            /*
>>> +             * When the struct kimage is allocated, the elfcorehdr_index
>>> +             * is set to -1. Find the segment containing the elfcorehdr,
>>> +             * if not already found. This works for both the kexec_load
>>> +             * and kexec_file_load paths.
>>> +             */
>>> +            if (image->elfcorehdr_index < 0) {
>>> +                unsigned long mem;
>>> +                unsigned char *ptr;
>>> +                unsigned int n;
>>> +
>>> +                for (n = 0; n < image->nr_segments; n++) {
>>> +                    mem = image->segment[n].mem;
>>> +                    ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
>>> +                    if (ptr) {
>>> +                        /* The segment containing elfcorehdr */
>>> +                        if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>>> +                            image->elfcorehdr_index = (int)n;
>>> +                        }
>>> +                        kunmap_local(ptr);
>>> +                    }
>>> +                }
>>> +            }
>>> +
>>> +            if (image->elfcorehdr_index < 0) {
>>> +                pr_err("unable to locate elfcorehdr segment");
>>> +                goto out;
>>> +            }
>>> +
>>> +            /* Needed in order for the segments to be updated */
>>> +            arch_kexec_unprotect_crashkres();
>>> +
>>> +            /* Differentiate between normal load and hotplug update */
>>> +            image->hp_action = hp_action;
>>> +
>>> +            /* Now invoke arch-specific update handler */
>>> +            arch_crash_handle_hotplug_event(image);
>>> +
>>> +            /* No longer handling a hotplug event */
>>> +            image->hp_action = KEXEC_CRASH_HP_NONE;
>>> +            image->elfcorehdr_updated = true;
>>
>> It's good to initialize the image->hp_action here, however where do
>> you check it? Do you plan to add some check somewhere?
> 
> Hi Baoquan,
> The hp_action member is initialized to 0 in do_image_alloc_init(). I've
> mapped KEXEC_CRASH_HP_NONE onto 0 on purpose.
> 
> But the use of image->hp_action = KEXEC_CRASH_HP_NONE is to actually
> delineate that a hotplug event handling has completed. You can see
> imae->hp_action set to hp_action to capture what the triggering event
> was, as passed into this function.
> 
> I will go ahead and set image->hp_action = KEXEC_CRASH_HP_NONE; explicitly
> in do_kimage_alloc_init(), as that is done for the other crash hotplug members.
> 
> Thanks!
> eric

Baoquan, as you are currently working through v19, please let me know when I should put out v20 with 
this and Sourabh's feedback.
Thanks,
eric

> 
> 
>>
>>> +
>>> +            /* Change back to read-only */
>>> +            arch_kexec_protect_crashkres();
>>> +        }
>>> +
>>> +out:
>>> +        /* Release lock now that update complete */
>>> +        kexec_unlock();
>>> +    }
>>> +}
>> ......
>>
