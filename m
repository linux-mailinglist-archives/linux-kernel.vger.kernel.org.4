Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A746747F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjGEIVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEIVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:21:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6C1FD3;
        Wed,  5 Jul 2023 01:20:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3655urm9016002;
        Wed, 5 Jul 2023 08:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=zhdnQsD9QsPhRb4cz3LqqukJCx8/B+/8uqLLjdorUHY=;
 b=di7bmYsqV9qJw0hPOarrd+imE6tVJlOdEzBmqt2ldOeOGvindvPwyWYsOrqpdElI37Gr
 kGfkspO5PxDc7yr46AOfpsvRDnUlhC8LgkGqs0dw4It20+0/PtSVJCBriU5dJCezkbI1
 trxfMbQoA/625MPNL/liFv2DGEB75l3vJnogzzQYxpN6Fwjjdqk/2wPFcjke5gCN/F4y
 tK2vIXQvZMmuK6NREUiBDG8Z5MHeg5EG5oAKzAPz531nSKRUasEES2nYj7rZXFsHmPPV
 0/mIUjMZrCRBDC9waS8P6JDgeTF13sl0WnuXE9xHnxcH5UO2OaBa0T3KN1QCsFV5rvcM FQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjbrtdu70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 08:20:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3657CXG4020738;
        Wed, 5 Jul 2023 08:20:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak5b7nh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 08:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URv6XhSdBL6Ij5TDBVL2a0EgSDvS554XqCT8Rk6guVM7VZILeTANs0IXpe6MlUbYyXwUeIfHBp05BO4IO7QmZKPkit9jlZ5wtFcVjsnqJr9rq5xr0o3/K201xQa3etdrOfBON99Lw2ExngZS97EisRxwl5LKjbtpl/IX52s9ite4p3JORe7lsH4g4fMe5gVTL0ztQRGFpdwO6/yQ5xT7mBasFD97Jy8PpdzkyMmKRl7zhDGJf9XsvoS8CmQi/EK0lMqd3ZxvDeJCUFJKAQJCNU1/zAh8ICP7fzSnjeoD2a/SgryaG7Pc6pMvMiKXQt8fM51SN2JZmvrIZBCSmnR8Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhdnQsD9QsPhRb4cz3LqqukJCx8/B+/8uqLLjdorUHY=;
 b=RIBtyKlXRWSpPX4iUXKesVsYHKg4+uBjoBm/jL3dZ5kzheXRi6xB3bpmCe1qm+MY7m0xKw79hUlr1HIhhpRLCDH2wCPGgDx+kYr0rZIwl6gcdB6vV0I9Ir9Nbaal5RInHnpi9ZwCzUOauQHZG1p/PIT+X9zQFnpJ5q1jyyNMWrrYdxfT7pjgbgphqVxMApn71zcbAmxhlpbkfAbg+NwRaP8FN2AYhhLBmZ2nV9mhqQt/9SpbhKZOt55UJl81+R/P/Zs/N/VwzlPqNomWPecmd98tt68ZBGc/Gy1NbC1v8KAeUhgcNttgHGjbF8EsKdvysEX1xschzTR0RzlwR635Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhdnQsD9QsPhRb4cz3LqqukJCx8/B+/8uqLLjdorUHY=;
 b=zYIRfGDHY30mZ1tEvvyLIx4AThNVFgCXHp6mHYw+TmNN2ADxTQktTQRIPQNB3s1ihQyzzFZ2F1GhpvHrNXoEiP+WWtobiQ6dq5gmh5vBHHpA2qF02x0Dg4P5x3s5rfzRlmse3pQOUPfXAKKyDPmgfii1ICm3FjHdV6chOv+0BIM=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by CO6PR10MB5396.namprd10.prod.outlook.com (2603:10b6:303:13c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 08:20:14 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::9bee:4705:4313:2532%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:20:14 +0000
Message-ID: <5cb7f767-91f0-ef63-c343-fe0edf588c55@oracle.com>
Date:   Wed, 5 Jul 2023 13:50:03 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH 5.15 00/17] 5.15.120-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20230704084610.981452877@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230704084610.981452877@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|CO6PR10MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: f4dbcc4d-d1fe-4abf-d0d2-08db7d30a854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7QElpOZCq9qZU5WwW5jQKR54qlcprp4klh2PC6DRD5N7K0d/5fgI0GXr5HKZw2HGpYnLpPvaH4z3Bdb+cNLb1koqr8RjurGsEpQ1YVrRRymbRjZMME2YGtbgagS4H2JF91PLR+5UlJGbr6jUOzD4+r+9H0EJgywEpqQMw7Ei9L5RSLIji3BAHHLvEZ6n/KxCV8FHbPjlqigiQuwXwSUVORcXelICEYtzAy5YcJAzQRkCygKIHwfYgyI69KA5N7e2qxNIwG1OSNhRzPpgbPEy1OADiEQLN80fnbiNFvBlS7BrET7UP+zAYe0a5dNLADzyrkouHEreK6o6wdv8egXtJ0t9hmsy2O2RonGOeKoIhFvgEzWIQsutbqdUtBNbwDAN81Qbkf60Rxwglo3i8NvcWxzF+lD+YgdQb48FofFwmQCprZj1pXC5CWV/9SjtPQ1Zz/XLwWb5cCjCNrmC95WuQiyUGQUvBuInkQS+IWWrP+Ijowe9laI4ZiKTD5b4+jf2NsWsJ4O1zsAB/7U4I4X0QpwYb4IWKlhSTUuKXR5YQnLrHrTbjeP1byurYW/cSNGKMEaxW5gy1iiMYc9AzlgD0FD8Vx42XU+LJZ+2qXJDPJrvbGkpxeTeu2vYxIkJcSE9VQ0RpfWffEfjMkraHmzz+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199021)(41300700001)(8936002)(7416002)(31686004)(8676002)(36756003)(6486002)(54906003)(4744005)(316002)(5660300002)(2906002)(66476007)(4326008)(66556008)(6666004)(478600001)(6512007)(966005)(38100700002)(107886003)(31696002)(186003)(86362001)(66946007)(2616005)(26005)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlI0eDd3ay9sVHFQWGtXRmtYY0FTOTlPQjBQNHJpdjNzN0JkRVVaRjhrdXVZ?=
 =?utf-8?B?YllMRzZtLzd6ajZHT0JBaS93Zk1xNDVNZDVLZ2lEWWovMC91Mzl6VXFLWExx?=
 =?utf-8?B?c3p6Y3R2YUZYTFppQ0ZJNCtOVXhQUEZEdi9mQXc5enJPc0ZoaG9jYTdURzR0?=
 =?utf-8?B?ZHVxcGllMnBGQWxTK2VJRzZlVWZoelp5OWErZ0RBTlErSkxmTjVqajhEUXgy?=
 =?utf-8?B?ajY2Q1NEbUtLSXQ4NnFtbVJvVmkrai9kTkczLzdKbWl6cnBjQTcyWm5SUkJR?=
 =?utf-8?B?Q2V6YjB6L21kYy9uL0kwMklrV1ZSbjR3ZkZnMTRGbWNPYklEZEIvTHNnVWdh?=
 =?utf-8?B?azdJTFdsRlp1dXdtcEk5Nlo1Z2hTTlc4dnArMkNpaGdpcWp6N2s0NkxSblls?=
 =?utf-8?B?QW9lRFNzWXdsdGlWSWtvYlU1a0F0b0piQ2VEWUdYbTR2WjVjdlh2Yk92ZHVx?=
 =?utf-8?B?c1V4MGhYV1dsVVYwSTRUdnJlMjRmNVVZWkNHL2RvZHRtM2NPU2RMWVBucHA4?=
 =?utf-8?B?UVBGazhQKytYQ29LRDlGL0F0aC8wWkpUWlFBaUMyLy9mY1ZDTjNuaVRkZnlG?=
 =?utf-8?B?eVgwd1FLcWpkYmY3S2RCTnZ2cDB5RUNvckttNFY1VWt3YW1aMXp4OHlxMFd4?=
 =?utf-8?B?Z1JxTXRGaDJYOWdORnJIUDFTRmJwbUlMd3NBRFJDZWVseDVCOVQrQ3NzbVl2?=
 =?utf-8?B?YnByL0NoVnovZ2tnUkFHQWh4MWRUOW11bWxQOU53cUV0Z2pkN2tUc2ZmYVo1?=
 =?utf-8?B?VThNU2N6YUNJY0JKTU9ZN21NYkQ4OHZ0M3NBNWpCUXdIeG50SXU1ME9xTG9n?=
 =?utf-8?B?TUFxaXFGSzg2VnAzTFYrV3d6blUxSXNONVlxV1pRTXl1aklrc0dMVC9TclVi?=
 =?utf-8?B?YjZlZEFxYVd4NDJQdXFXeG1DY0pYYjZORFQwT1BmWE9ES3JEZTQ5Rjd4WWxD?=
 =?utf-8?B?RVVBQjNhRjNSRVV4ZHRJd0Z5NGZvSDIxL0YweW5oNHJ5TXBvSmdsSEpMNHB0?=
 =?utf-8?B?RUxkcHZmem0zV2l2LzE2OTVldXltTTY4QisvaG03amtGbEdXOTlVUmd4Vm5s?=
 =?utf-8?B?U2wxZ0dnY1ZCLzFSaXZrUjlFMTNoOTVPdGh6VVJNVjRKcVhiM0FSaEtwekhW?=
 =?utf-8?B?WTUyeCtyNzFEVllhS2FOMlJPS2lUczdCWm01d3dOd2JRVkdFOFMzSmduYmwy?=
 =?utf-8?B?aTdtYytFMzU3YjZ5MzlFOFlvYjU4cW5BeGdUSCs1cWdyN3c4dHpwQytOMWZ3?=
 =?utf-8?B?TnpRNVFUcDhNWnlJU3EvMFRwazYzcnI3OFlFZW9ENThQVUR0RlRLMis0RFdj?=
 =?utf-8?B?UFhGaWZHREFvM0wxTkVUMDZvNU1HWHJXVnVleG9oMDZFZU1jaWdKRkFOVTJZ?=
 =?utf-8?B?czh2QzZHYnVQUXcweXhJNFZ0bnN1UmlBdmRQUmF6aEhyd2ZrbU9RRUh0M3ln?=
 =?utf-8?B?TmRJYm5RTnVqelFjYXJlWlVORWdHN205ZXI4Ky9PZW1wdEZCeFMyM1Jna1J1?=
 =?utf-8?B?TkdrOWxRSkJhYWhmNFJma0R0c0U4ZVM3dGdmNmdsTHcxRDJPQVdCdWJJMS9r?=
 =?utf-8?B?Q04vbnM4czQzdWhSWjZFSTBXc3R6SWMxNXFaVWU3bmpvTnRTL0trVEFiN1NY?=
 =?utf-8?B?d1QvZnBhNTFFakpsYVE0WnhrOGYraUpRTEFQWnArcUhzWmpEeGNrbjZZV3cv?=
 =?utf-8?B?a0RJL2grNGszekZ4czBDSUlvVEk0bFdKbTZPMWRWa29VZHVnakdFS0JhR1V2?=
 =?utf-8?B?emhEK016MmJ1SG1QZWdncHJsSXhSVTIzSmtZTUpiWXhzMTBna3ZyT3M4amlF?=
 =?utf-8?B?TUd0RklqZFQ1V29VTnB5TEVHRHZYTmUzR0p0Tm9TMHI2b1lES1QzbnhwUlhj?=
 =?utf-8?B?OGVzQ3ArWmkwTlJDZnFoUUg3ZmhSaEZIb09jVDhTYmRQTGpYcGlvSVcvVlJX?=
 =?utf-8?B?bXR0TjdhZWpUMG1zeDMzdGxmY29ReGYzaEhLeWZPbWxrbFJpaXdEczVSK1pP?=
 =?utf-8?B?dWNIbks2RnVHUlRabFdhemtDS2RJV3FtRDEvQi9BY3FvREFhVXFWN1Bkbis4?=
 =?utf-8?B?bVdLVGs1RTFRcGtVaWQyeDlsUy9kZnYxd3hwVGRMNGxQMC9raG9nUXJrTWpr?=
 =?utf-8?B?WVZCSEk0d2F5QzhOb2g2bGtNYlF0K2NYZ0ZQNHdiUVRPNGgyZFVMWnh2ZFFj?=
 =?utf-8?Q?KKnULhRNUhX/Fqehr9HhPBw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?NUcwdExLWS9ubENnbE1TOHJ4ZDYzdEsrU3B0L3UwenN3VmFvSlNvM3cxT1Vi?=
 =?utf-8?B?ODRaWnFYNlVsZmFCN0YyVmlERHlkOERpN3lDNEpkcTBuVnp6VHZMNDdaNVIx?=
 =?utf-8?B?eXVYcFF0dVl5NHVGRmZ5akZXbXcvWGFDNDQ3WVduTzZqa3Y1eGNQKy9Ga0J6?=
 =?utf-8?B?QS9FQ0JBbmgrSmRXazBGbWdibnBKT1lkUm9CeXc5Mm9IRFVIVzg4VWFxd2Jw?=
 =?utf-8?B?bTA5TWFCTU1zeE5FcGFUNFdXNnhXcVBQU1JydHQ4RU1GbVdpckFmYlZrUXFE?=
 =?utf-8?B?WHlpWk5rSGVFWWNZVmFDYmFHSmhFeENBU2RqZFpJMllsaTNZYzdUc05zelNw?=
 =?utf-8?B?Vy90dVB3M2NYWVR0b3ljOUFRVm93Z0Q0QTZVSVQwWjVId2pPeXNBK0lBamJh?=
 =?utf-8?B?dTVnU1BnMXBCaXk5VGZRdzNSOUhDY3l5dWQvOEZIQzVmZEdCaVkwVmY3aWxz?=
 =?utf-8?B?bUN6TFBjRUdnVFAwN3dtb0hPalRzaHdJUDJoMXI0RUIwTUNZZmdlaXBJczFj?=
 =?utf-8?B?U0E1MG93anR3ZjQ0ZTdOSW80MHRydGZtVlZvb0VpdmFOREZ2K0kwZ3Z3TzlO?=
 =?utf-8?B?c016VDNxTU5JN2x2YnpGTXRKZ0wvcjRxQktHeGVsVkI0YkZCS2s2TjFjNkh1?=
 =?utf-8?B?OHlhWDYyNnIyVHZIV24rTXBpYkpqR1BkSW1VY1JSS0RCZXZ2NDRqUWdiUlFY?=
 =?utf-8?B?N3pObUxvYlpMSmF3WFRpaXlqaFZsUHRyNFRnTDRMb1hLSnpjWG1CcUxGemdV?=
 =?utf-8?B?WUVSVnlTSnZSUmI4T3ZFNTBLcEpjWVg3QU9scW5TczU3RjgzRDh0anR2YllJ?=
 =?utf-8?B?UEdCd3NzS0tQeHMwcUwwY0crQjJkeVd0MWRTL0YrKzV3TE83RVVid09TcFkw?=
 =?utf-8?B?Z3RRRnRManpkYTRTMUYydXdIL3NIQThhTVZ0SWNLNnFxWHZPK0F6R3B2dHRt?=
 =?utf-8?B?Z0RiRWFpS0xGNTlYbWhqN3htWm5tWGN2Sjc4KzZLWXF6NTdHSURGVFN6bVIv?=
 =?utf-8?B?R3FLRkM5b09QS2tIblA0dU83WlNkZkRRYXg5RVp0OVc3aWFyT3p6ZXZFQVI5?=
 =?utf-8?B?KzNrUTYwT3BKSHFxSERlNWVKR3RVYUh3RjRObE1NSGUzbFNNQzZrZkpCc1ND?=
 =?utf-8?B?Mm5XZTkzTXVFTzNhQmpORWNHeEVsWm5FMDc2T09JQVpCVGY2TEd3Vi8xYzFO?=
 =?utf-8?B?R0dOYzUwVEx3L0JXTkcyRTVUV203SDhKMG02TWpvM2lSdVJvMllrOHRieU9t?=
 =?utf-8?B?Um1iOGZyd3htektra1ltbXFXRUlwdUpNekZHdTErQjkzd0h3WU5ZRkFqM2hS?=
 =?utf-8?B?Q1JRVHA5TXlTaktVcTl2YzlMbWlvMFVKSDEycHMvczROM0tEQmtWeS9WVkg2?=
 =?utf-8?B?R1JqVXYzTk95bndhamp1YzFBM0dpL0xhaWNya3lMY3h1YkVuZ1lIdVZ0VGxM?=
 =?utf-8?B?elBUMzZWMXFNMllhOTlTWExQMW8rQk5rYk5pT2JNaHZ3NXdDSHliN21mM2ZB?=
 =?utf-8?B?dll0dmprbE9ObUNPN01tNWhKZ1NYbS9NOVNxN3VjUjR1SHdlMElRbWVDc0Vs?=
 =?utf-8?Q?iuNRd1Np6eDqvbrC4fkz5qCjT1ohanFsqBYz2Yk62LKUEn?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4dbcc4d-d1fe-4abf-d0d2-08db7d30a854
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:20:14.1372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qz3KG0Xdl+38J0PZ1Ia1JEeLXr4rwt+JZsia6bivi3ip1WNWXM2Em4c9gej+n59o2RPMl7T7qQNttF1cLSsVr4CqQHg49w3CsAuS7uzZBiHDN8DAvjjSPrGLydLgIUF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5396
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_16,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=984 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050075
X-Proofpoint-GUID: toDW0iZhBELcUnYQhbnu1VqzZMFj303Q
X-Proofpoint-ORIG-GUID: toDW0iZhBELcUnYQhbnu1VqzZMFj303Q
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 04/07/23 2:18 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.120 release.
> There are 17 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 06 Jul 2023 08:46:01 +0000.
> Anything received after that time might be too late.
> 
No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.120-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 
