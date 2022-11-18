Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34662FFA9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 23:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbiKRWD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 17:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiKRWDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 17:03:23 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A994A43;
        Fri, 18 Nov 2022 14:03:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AILOF1i007813;
        Fri, 18 Nov 2022 22:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kBZvFmxiqi+0K9IY+XHsF/ZuwybNAJh1xHoo8vmXJNM=;
 b=HpooCgJAMX64yqNrTUGcPNhLY/rxsEkiNPU23+0ByMsj079GfrKWRtw7fqIARc6W4rpH
 rloMC4AJbk3yLiDYwv7awOZ9iKzUe1tfknvHx7Juc17i5AWo8BrnnEwRK5jt0Wc/0tMy
 a272RVccjUFOPSea3r98rgbC5YwR2MLVwjgd0VgrO3RqlKM3tNps5gcpKAz2Bby/cf8E
 yWZUQubYTUbA946pL0nooNznWRMoxFM6unOprvjMVtSEUNUtK9etqKYhuz8/+FJJY1SU
 +plmAGAepDZOBNFWSeR8b9bbaCYYtqp1+I90fEzEbTYbsUQifbIykEyWtCP4TfRxBIK4 vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kx9699v1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:03:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AIKcOGK016020;
        Fri, 18 Nov 2022 22:03:08 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xb4fja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Nov 2022 22:03:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Otrb0Qr1cu2C8dJH0pvaMrXnsmiKYUkM6j++oXAzQb0v0NDWkhoEgIkE9OcDx6QnfzZcIWlDet+8n/tLgtSxOxRN/r1qOFeYXkkWQsD7ABDGQdTCX5uQQSqYa2Cmw8XLe4gnBlw61l6nVs7M+DJA24jrsrxsjRVq6t6GUHo9IMA0mPvH7EXJoeQSKYp0UAdzCuuPRjXIXbc8WmuUk7wTgMgB7DVpOqsQEENPw5SYs4dMdkmhyM0DzhRveoIVKF6tB0MOWjKqgxKPaEbW89gaDhPEBAqE+rABQ6NAlIAGJ3Ayn6XzujcPr5/YguKwgqqDIY9iBvBQoAnXy4EGDKTXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBZvFmxiqi+0K9IY+XHsF/ZuwybNAJh1xHoo8vmXJNM=;
 b=IV3xSScRkwHNv/D10t74qIiJ/LWFHwx0E0/nI38yWpOoICTSGysTi6xpnX+xc4tDP4qHmid7AKr6gLXKAVMUuz/Vcnqinz53QZCahFlJ085EJwxve3wnFv2/wHTfAMEg5l9ncqmwogCHBbbgr1kG2ujPOze+vGwAEUHkpABHRfC4llbxd3xgHiqJtLT2qAlh3q5NBP5y3bIZqyxMQdqoIzHmLW1ID+AU9WYHLbkmValYDAzrt+0JpvnYFxMpazxQP78L8MFiSAYA2d9tzH2RJel7lmfD5lTYqjQU2g850NunnlBSH6feCNPj0AGFVThElKgCM+kJSVCg0I1K1CDIUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBZvFmxiqi+0K9IY+XHsF/ZuwybNAJh1xHoo8vmXJNM=;
 b=Pns1WR75sLFkkM+PnJgqevtOT7Sp07WQIwL3f+s1lst4uIvIsMSP225AVk9XZudGCU2Cpxi7JSemhfVv1OEz0lPxZxb5MqNr7anc119y6n6kLjEwN9BfML1h5mcyAeKSJPlSAa6J65YXcgTYI+VuIJpUYVTDAi+enGOkdzzADDc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH7PR10MB6276.namprd10.prod.outlook.com (2603:10b6:510:210::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Fri, 18 Nov
 2022 22:03:06 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5834.009; Fri, 18 Nov 2022
 22:03:05 +0000
Message-ID: <bb060ac3-b413-6db7-9738-0774764a9457@oracle.com>
Date:   Fri, 18 Nov 2022 16:02:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] cxgbi: cxgb4i: Added pointer check
To:     Denis Arefev <arefev@swemel.ru>, Varun Prakash <varun@chelsio.com>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
References: <20221118121740.128877-1-arefev@swemel.ru>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20221118121740.128877-1-arefev@swemel.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:610:b3::14) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH7PR10MB6276:EE_
X-MS-Office365-Filtering-Correlation-Id: af3292c8-205b-4f7b-9efb-08dac9b0ab9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PkaPfIvfrx0S2c94ApAcmTJJpnWM9csaZMuiGSjLyEeh4wztL3z/NFCMJ6dzv9FZZnrUCRcufvCKlD85YQHzsLRnJSub1Lahh4hYqqyGDPJnGsDUGrSRQWDBtMt0BgqmpLljziqtkstWf5bqjD8nVklQQFO/LdOZA6+UYoBZ9Q9ItfmKlaA5SYY+arSSs8q5O56R1HsU7iX0gd5/0+H++QGRBX2yKjerSskpyDIYeyfv9kU+U2vRGYphL+U8TSOtbIKWABfj672svEt6UeP0mNskOmlYjCG7RELjJyEfvca3+No3EIfwz+phz33x9B2xtnROB1U3zO5faTy2LhQ2qYVGk7XunRHikRwv3SLnOHK9UzW884G6SzwBv2Ql57KG/P1cI5GRYq1+2+Ep1PFiaerPoG/ddb8sVASa9sWrnXeP7aaXjpWiHV6+CWNUBiSdOLQxpSFN4O+3GBn3saiRnmGfw2gCfPUnC/vK8hrgB81Zw0fd1VxEq154FKU+yLnCp/mhyBR6dZWwxJy4mRhoIctt8alk8ZWxqXCO4vEWTI0IKdONL5fw8y5psuhBrYczAsi/KtH3AE9QABRXZU3GJq60ScDTcWvh9OfjjgB+Zbvr3ftlMY/PHBZ+rpKZdPWgjZDV528sfcobiDCBQANQO1Ee/GlkaYnN0mn1xlw+VaTFYkPISnk1ir2XKmpH2r+p6oMKahXU+X8o3inV+7g3cWc9JNQKhMAJaI6e1lxtWxNoVLa69kmFssAUFdL7oEt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(66476007)(31696002)(83380400001)(66946007)(26005)(4326008)(8676002)(86362001)(66556008)(5660300002)(8936002)(41300700001)(186003)(38100700002)(478600001)(53546011)(6506007)(6486002)(6512007)(2616005)(54906003)(316002)(6666004)(36756003)(110136005)(31686004)(2906002)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWJPY0dDRGNNeEI0aVlpMEZaank0YWJSRUo4aW41emMzcUJ6RC81RTAvSUFP?=
 =?utf-8?B?RUNkWnc0WDZXL2w5SzluLzJ6cFJqOXNDU1BEb2d6Sm9PdGtnUDZHbkZCeFZr?=
 =?utf-8?B?TzBuOUlReFViN2FDM2RlQk95RzM3eStuTS9Fc3BZNnNyR1pGdmVML212VWZr?=
 =?utf-8?B?c0w3TE4xcWhic0xyYWRHaHJvZ0FXWEtQa2ZwRlhXN3Rjd3c5eWhkQ3hFQmkv?=
 =?utf-8?B?cE1BUmVueCtUZWttcFlJSVVGazhzQWlab1BNVjBmOTNRYmV3M1FIOTVlTnVs?=
 =?utf-8?B?bmdHVGVZS21rZEt2aXIvRVhJOVp0WWs3OHBzYzc4MFMyaWdOcnJhc000b1ZV?=
 =?utf-8?B?cTE1amFHK0MzcmFYUVZhNzdjNE9TVkRWQ3pJanJkNDBQcGpkSFd2QmsyeFY3?=
 =?utf-8?B?VGtVNG55ZlFRanRNSWdQbHhRZ3NCenQ4WnVvc1F4ZjJMVnZnZVBoTHZCbU00?=
 =?utf-8?B?QnBkY0ZtR01oaW5HbTJHV2RRR1NCb1R3dVVxc2h2eVNOcXpNL3kzZnczdW1u?=
 =?utf-8?B?NFdCamdOZTRtNzRFeWNrY2NpckZQdzNIVEYybTlrUWN3eW4zT3ZhMVExL2Fl?=
 =?utf-8?B?bVZ4Zll6YlgzZER4ekZ4cHFQUzRzY2pRRnFXazZERDB5SzdPQjdPdGhWMzNR?=
 =?utf-8?B?dzNidlUrMVd2a2xaR1ZYdVBrZUVhQW5tVWczdFg4WTNPbFlCOVorVTgxY1d2?=
 =?utf-8?B?QzhKLzdqeWRqdS9LWlNhVUhSL01UVy85K2RIQVFHRVpJVnRoYUxua2FBRDVO?=
 =?utf-8?B?V05xd0tSZFFmcm90eVYzeVpXQVhnb1RCSnFTejQyM3hubVkrQVpRYXJVYUNk?=
 =?utf-8?B?bXpmenlFRm9vYVhOREd2ZHRxNlpzYnJNTGc0K1JsREgvNHY5NGNIOG9WQTBx?=
 =?utf-8?B?R0FQTno3V0V5UFhKbEhKTW5FQkRIK2ovS3ZHM29DU3NybUdwVDUyMWx4SkRO?=
 =?utf-8?B?RnZuTElDYjNnQ0Uva2RQRmVRYmU4SkpxNlNqQUltdkRmZmttNVFLRCszeUZN?=
 =?utf-8?B?UlZnUXdPMitrYklLSHc3b0dPRWFYK1labjlHUHJJeEFmMk1yK0swMVNzbThQ?=
 =?utf-8?B?bUZ6WEs1b2ZsZkR3LzEyQTlocDczcDNGek9ncVJDMFFENlhld3hsVW1JV1dO?=
 =?utf-8?B?T0hoeTVrR2lpZVY0WGMzSzNReGNUVDNWQ1dFSWdkY0laazZLZ0o5SUxTU3J0?=
 =?utf-8?B?S0pHbDFJbExObXZuZS9OZzVNTTBxWEUzUGFJT2kzRG12cCtxRGZvbjk2U3pS?=
 =?utf-8?B?UzAvOU12eGtUY2s1aUgrdmxkZ2JzUVVlTTFmeWgwTFJkREYveDFlWVVSRmlo?=
 =?utf-8?B?ZTk4ZmJIRFdYUk5kM2Qxa285M2hWWEdIVFBLYUdtSUF3b0FpT0VVT2hiVjY1?=
 =?utf-8?B?OERZSDEwOXRtWjlZa3ZoamhlQ0hBRzlZRmMwMWp2bmYvZmdDUERnQUs5YWti?=
 =?utf-8?B?M29JcDVlRTVqRG84S0FJaXNNQTl5QVlkTXpCcDFZZDlqNmNQcmExc2RhWmRU?=
 =?utf-8?B?SkZ6Y2FVQW9lYTFQenFQSG5JMlR3a3VDWm1UeWdoVEo4Smk4Q3dIZDA4N2Vp?=
 =?utf-8?B?ME01TG1PSFBod3lJT1N0dmlRMjZ1YXRhT2pLenJFVnh5enNRYUJjeUVZUDFm?=
 =?utf-8?B?eGlkUmI2cFJTK3lxWDlCcHF3M3ZZR2Z5Uy9VT1ZjaHM2M1F1TUlKblV6dUZh?=
 =?utf-8?B?M0ZiRktDWHFjbG9rdC9OeDJ2dUNyeDE2aGRDV25LcjBBV2l2ckMyOVZNVlN5?=
 =?utf-8?B?UHJpWUxnUytTbHBEa1pyUm1valJYMVN0dnJyNEV5TGRYRVFHSUxUaUpUSEFz?=
 =?utf-8?B?dDdDL1NFWEJCbkY0OHNMQXBFeThoY0RmOTBYZFg1NHBhNEVNd0JoY3p3NTZS?=
 =?utf-8?B?N3NTQXc2eG5LY2ZjNHlpMDczVUlab1VjN2lBenNiSlpMYTN5VjBBamNEa3Ux?=
 =?utf-8?B?Y3ZmcWF4UHF5MjJQUWNSbXg2aTd6Szh2SzcyMXZwTXZITlM3NDBzbW1wZG1y?=
 =?utf-8?B?RlI4VTU2WTJvc2RYNDZDTTNzbVNRcG5nTFBMZlcrWW55OTBXNnBJSlFoNG03?=
 =?utf-8?B?QTQwRm4ySVJUOGs3dFNyejR1eTdrSkI1b01yU0QyQU1XcmVFTGVTSGFobGdE?=
 =?utf-8?B?N0dDTHpmcXhwVjY5TnFaUTZxK3lyWmY3emV4YVcxSlNxenJ6cmtsbkxick1L?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Nkc0VGkyTTJ5ZGlSTUw4TVFFbHVzeWJDbGxXUWV2MnJVWE9zbUFHVHBLT1N5?=
 =?utf-8?B?UElKQ1QxMk9OcXNjTnlQbER0ZEhPb1BtL3M4THF1UEUzVDhXNDFKWUUyOS9W?=
 =?utf-8?B?OFJHRlNrTytYQWt0RjA3VmVxaEdWbkVqSXA2NUpnNFg0Vmo2YnNCaE0vVnJp?=
 =?utf-8?B?NmtUQmtFSTR5T0k2K1dIeUdGS09Id3ljcGt0NUZVd0lTUjlWMCtwODBUa3Ez?=
 =?utf-8?B?QU0ycTFrMTRibnlEdnhpZGpJZHBHNGc1bmlHVGZvemNnSnNOYis3Q0JJVEg4?=
 =?utf-8?B?b1I0M2FsVUNVd1ZLaFk4Vmg0amdOZThNUk1kK0VSVUN3NDR5aytHQ2ZUclZz?=
 =?utf-8?B?SW1sKzloN2xPK2Jld0VtMVNYd3NiRkY3YnpVUW9hRk4yN2hTZFExcktWS015?=
 =?utf-8?B?YXN6K2g3dWgxdDAwZjV2RzVaMzAxTDVmWkZPOE91bTBGTEtkODRWbnV6MFB5?=
 =?utf-8?B?TDRZSXBFOU9NQTRaYmFyTTRzVGVUOGRoTXlXeVY0SHRESnpvMGpsSWVzUVo2?=
 =?utf-8?B?cGdGV0g1OUNia1FGOHRKVkFRR0toZUZyQ1ZCdTVzMTZXdHk0MFFONFZqZzhM?=
 =?utf-8?B?OWp4N2dIdjg3NDcrVitPL0xuRHFzbktWa1U4ZG9pKzJnWDZsaEtUbVlnZmg1?=
 =?utf-8?B?cDZZenVaOHBaQnRrQWpvR0o1MmdNUHlPQ0R3dDJqSlRoaHhYVzNrMHpCRXRU?=
 =?utf-8?B?RCtJOXZodS8zSzlIdG5lWjZWY2k3amFWa2I0dUEydjREYXRLQmtyMjdaL041?=
 =?utf-8?B?T3pkbEw2bURXaVpVT1krZTJFbmEvT1JYMW42ODdsamdjSEJOc0dXL3lHOEJv?=
 =?utf-8?B?cmRYMTRhTHhuNDJIQS91V2dxQ2xzMGFFUFJFbTEvVVRoU211UGZrU0Fqdm5T?=
 =?utf-8?B?YWFBMXgwRVB6NEhyUG5uWTJuS3FDakJIUTdNenc4V2c1dm9JcGJGRWR0M2hh?=
 =?utf-8?B?QUZoYTJLZ2Npd1dRYUlwTkltYlNxSEUyWXVJc3MyRmFBR2dnVGRiOHRJaFZX?=
 =?utf-8?B?c05pUHRtNHV4UENRNmdldWNscXFhNkd5OW5JMWNCaVdyTlpEZE5lOEVGbUtW?=
 =?utf-8?B?dzU0YUtXWEg1NytLazBXcEdhNC9KT25OcjBYZzBDMnZVK3ovT20wWFF1R3BT?=
 =?utf-8?B?SldOMHRLUmljc2tWQ28vR2RJNzhJelp1T01IcVZwMENLSnR6aUNjcDhmZ3pV?=
 =?utf-8?B?ZE9nMXhPNjYzSTZUVHhjTGpmc0dKZEtwWlNTb2FVUHRmSUlGWXM2MUJlZVFV?=
 =?utf-8?B?MHprSFN5SURkWG5LUm1YclhTYzdaaUgzS3lXWnZ6U3FQT0I2NVZxbWpub01s?=
 =?utf-8?Q?PdKhfFUvgXRVoRkvQp+M4mjkh5TKjXRrNu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3292c8-205b-4f7b-9efb-08dac9b0ab9e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 22:03:05.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYGZezlwkl864sE6Xsby+VL/v1HbCh2h4yhk+qCCOyqNB9NKkk5GPeA1sgVXYr10wrDGxFW2dZ2aB2zt+1beI+1EKUJeDgMnZnyv7heGA8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6276
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211180131
X-Proofpoint-GUID: i8fPNBB8kzJxGlrOnEmdD97k4y9OuJj1
X-Proofpoint-ORIG-GUID: i8fPNBB8kzJxGlrOnEmdD97k4y9OuJj1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace Karen with Varun.

On 11/18/22 6:17 AM, Denis Arefev wrote:
> Return value of a function 'alloc_wr' is dereferenced at cxgb4i.c:624
> without checking for null, but it is usually checked for this function
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Denis Arefev <arefev@swemel.ru>
> ---
>  drivers/scsi/cxgbi/cxgb4i/cxgb4i.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> index 2c3491528d42..b93bd36dcb2d 100644
> --- a/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> +++ b/drivers/scsi/cxgbi/cxgb4i/cxgb4i.c
> @@ -620,6 +620,8 @@ static inline int send_tx_flowc_wr(struct cxgbi_sock *csk)
>  #endif
>  	flowclen16 = tx_flowc_wr_credits(&nparams, &flowclen);
>  	skb = alloc_wr(flowclen, 0, GFP_ATOMIC);
> +	if (!skb)
> +		return -ENOMEM;

If this returns a negative value push_tx_frames is going to mishandle it.
I'm not sure how to best handle the failure there, but I cc'd the correct
maintainer, Varun.

