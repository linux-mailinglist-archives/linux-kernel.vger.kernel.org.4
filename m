Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C9B6A6B68
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCALJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCALJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:09:48 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD7015151;
        Wed,  1 Mar 2023 03:09:46 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321AhS0q026391;
        Wed, 1 Mar 2023 11:09:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=w8hSkGy+6qV7EhUimyUeTlE0Ts7EDoPZjqccZ/6uzcQ=;
 b=ZPF99IMIx7DZ05g59nFasi0oNORUKTdwoDJ+6kXvJ8ehzXgScjgWPFJqCkyt13kc/kpf
 RDmeI+YMgYZ8HtOV510WwAayi0DN1tlsQym1hT/Vmv8hW4d/nE3mHa4eLQPW+AjPu+Xc
 +HATV1DQkNoqfe9I5uTRO07L5GFDy0sng3P0Qr8GdFbOsKhq/m+FTPbjIe/Ih87FVu6B
 LXjNr43Col8BGK01YqmnWD8MWldlmvArElQk1GDxZ3VHOIZ8UwmeymEMMEyNTP6hl02N
 Jx3yWMh0XVXfe9qPnc1+UcWpuo9R0fCpSsy34CnbF3PjJGoXnqbuqP5DvXyxnFb/WpS7 hA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba7gmr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 11:09:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321A6DoE033100;
        Wed, 1 Mar 2023 11:09:28 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s89whj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 11:09:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=al6Fho3oXGUvOhh+InEwmu08PRVQNqXH0wDgntTlBwpOQldFIM8AQI1bHIdv75kbR84VXJ+oBzjw7Ao1pSbSH5qFf9tQT2nifa3WsDjEEZR2y/+nXOmjsUX65rcCblmBqzhmHAtUdzWIcsSK/AFyUEt0Ms9H8bpZHdYcoLJP7Isy8dbsi5u2R+HEQkzE3I95ZYgo4Il562JvOY5Fi5tPMBNuNHd+WjHWYrLWZLpJSQbT11POcnNaQ7zzKQaxCBR6cyPSESTogUAARlctz9bsaeoUeg12arSfDZQ3Ot+TfPCYQ+IArY1vxCyEfhD85i4zhKwHmbXXANHZFW7ye5AcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8hSkGy+6qV7EhUimyUeTlE0Ts7EDoPZjqccZ/6uzcQ=;
 b=dInSFx6maGB51sV0dg9M/j4vhPqn6OUp12PrzeIJdER3AzckWDULmyqA0sGRDRkWug/OdEs6VzWC5uciotTb/v50uaYhptQw1MZ5dJFo5wcjLHxJPWw7Vd0Tk/HPOjVgXEvFOSwLDv+4aRvQKUGbjahgWXyZXqvvYBLCtAMuuvhc20TFUPodQbhHAyMcLaLvGpikWFZe+fWQZAu9lG/zJVOJVjHKHDWIWNS3SL7jZrpWpmrABHMHlgQrD3B5NUHr2LRgCp6BRvWuEznc9nEnIOMzLC3yNf/ZxxreAW+hrNa0bzjTlv8Ij5RAXBYaDy+QoyTTWzH+h6l+4fiJGeBFuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8hSkGy+6qV7EhUimyUeTlE0Ts7EDoPZjqccZ/6uzcQ=;
 b=pb615QLLmd789fTLa/cWmCZSsLJMh/DA1SaTOXsTN22Edt4bjBHoYBh4k9tbW27uTSKtn41DzmKiCjg4mJbY/31Tqui2oVnfn/n/6oanLIico2UhhwSpQP9FanEjnoppeocv9PXQXyWS52jQiFgtFtOTqGCVMs/h8e16N3t6BQs=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by BLAPR10MB4962.namprd10.prod.outlook.com (2603:10b6:208:327::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Wed, 1 Mar
 2023 11:09:25 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::a0c1:677d:5394:bf43%5]) with mapi id 15.20.6156.017; Wed, 1 Mar 2023
 11:09:25 +0000
Message-ID: <8b0cfd73-d22c-2000-d4c6-41cf75531cdf@oracle.com>
Date:   Wed, 1 Mar 2023 12:09:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] kmod: harden user namespaces with new
 kernel.ns_modules_allowed sysctl
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-modules@vger.kernel.org,
        John Haxby <john.haxby@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
References: <20230112131911.7684-1-vegard.nossum@oracle.com>
 <20230112180045.GA18314@mail.hallyn.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <20230112180045.GA18314@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR0P264CA0051.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1d::15) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|BLAPR10MB4962:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c491887-1793-4415-cf13-08db1a456ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2VuS2p6VvQcYZZaBhYcjQV17VnLlnie2a/N6u+rH06EqVn1ZBs8Wo1FFm+0lWpP4mj0TvaAaRY/bQitXXesq/450CnlTKovvnCIfkzoIiMG0CcHmhNWxQmfWKPnKlthxAZyiAHy2pT6Ovd2LqFTDUuj+J3KPfeGFUqxGDJMU02R/it7rqcllWOS6awREzUsK7v17vIycZkSFxtTWlg5DBUYRx9fbXTm5cik9lk6LreEu+z1WzMCCln0a7fo1dp0BiYd/4lMiNxTKAKj7J57KH2/ZDM6L3xRX79IQ5JOsiN3hO6EPZtVhPYmu6X7ugtgtuYxXvcG2JySqFIaKPS91BqR0RN1ERKIzs3PyiR2ncMPbI9p7OtfBtdgKMIZk11B1dwPHRXs+HOkSoYWBXrXumZBZpnQF6ryyyQsiXEcDT5wv3PtGSbBcdtL18fIUtYWaA9rNNKnWiddJHf0ag/Gg2aZ7hUXjFHTLV4V3CUjYWbFF4qYxWpZRd5B6gTagNL3b5r8xbQQ+GMLCnZk+da6Aff5e1P+QxeJY8aj3YPcL9l4bxsRZV/YgCLotQLB90JeeBPyOIms5ByT8uGThfX/W+aEaknHwFH06EBY+ZSbzdT0DumobYGy2eu8HTYHNBebCrhzJQIzqHj1Xvrwg/KaCYzJNXp6bxxbdIgp3qKwZaaClsoNlSnqm02HdwLLjiPFXh/Q4hKZcfR6+YOWh93WJMGSG6KiCxB6bJfIaZu7xMKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199018)(83380400001)(316002)(54906003)(36756003)(2906002)(41300700001)(5660300002)(6916009)(4326008)(8676002)(66476007)(66556008)(66946007)(7416002)(8936002)(44832011)(26005)(53546011)(186003)(6666004)(2616005)(6512007)(6506007)(478600001)(6486002)(31686004)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDczcy9veUZWUnRyYkl3SVpveEs3VHlHTHRxZkthS3dQdzB0a0djUk03RE5v?=
 =?utf-8?B?QnVMK2ZCeGVabXB2aENQYTJydDgrWTVQV1Q3ZW8yZ2s3ZW1YYnlJc0Q3dEJp?=
 =?utf-8?B?dFhibGxZZjRRbm81a2dxY1JMMG14QmF0Z3Y0MUNXdXlaUGM2YmI4bzZ1bkdp?=
 =?utf-8?B?MCtiOHkwUlNMUmgyRm1saFc2ZnZDcXVxTWdzRHBDODNuaEtmRTU5ZnQybVpV?=
 =?utf-8?B?bmQxUjM5c0JiVHJ1WUZkSVNHWHNrS21ScGlNcGZtWE82cnZRdE9uTFdJaWlk?=
 =?utf-8?B?QVVqK01ha2ZVdGcrRkM4eWt5ZDhZK20vMVdkdit0S1dTZUhwRDNDeGdMSk9G?=
 =?utf-8?B?SGNzUW5XaU52blY3VndiSVZVRWk5U3RXdy9qVzNMR2ZoWDZsZU4xWlo2TjRO?=
 =?utf-8?B?WXNkRXU3REhzWVdCbm1aYXNHRC9MNFNnM0FJZW41Qy8wZ0xsWG5GcWtFRjNk?=
 =?utf-8?B?SUM1YVprVmZEaWZjemlWYzhLNHBCd08xbHhRT2NZL2J3bkNhU25ZT2JmZGdo?=
 =?utf-8?B?aWxIdXRaVVFQM2ZBWlhvSjAzay9ETjZObTR5WDFRcHBDNzFZTXRGQmxVQVcx?=
 =?utf-8?B?dmx2cEloTjZFbDUvSHBya0hsaFRwT0s3WWZvSDV5aHpZTVM5ckM0Zit4YlFT?=
 =?utf-8?B?WUliVXhxNzlaMm83dTVzeHgzU04yOEQrUXBKMlFqc1ltRld1WGQzMitZMnZp?=
 =?utf-8?B?V05hc0djVzd0VFZDaXRRRG5naHJ4bTBDME9uL3hYSXVQUHBVUDNrTnc1dFYv?=
 =?utf-8?B?KzV0d3lzMUhoaVVPNS9HVkZTYmNYT1llTjlPbytKL1JtamRPSWRtZnkybXgr?=
 =?utf-8?B?MmRrK2pTYk1PdWVkN3BjL2N1VHB0VDl0VmNDTWkwcG9NcUF3by8rMENweUt2?=
 =?utf-8?B?VEovYmdsVUpuVmJDbjEyRHNGOC84ckVwSTU4allFdU1zMzRZaUpLek84QUdm?=
 =?utf-8?B?bWFyN2ErQXNXNTcrbThjRmo2OW11eDFLQ2tQZjZkdnMxdXVScDdtd3pGMEk1?=
 =?utf-8?B?bXBZSjNjc3JiT3h2blBCS1J5c0RTZEQzZDdpSy9KUk8vNUdOaFRCMk5GNlRo?=
 =?utf-8?B?ODM1NEF5MUJybmNNVUFrSWlzMjUxREhvUGU4ZEEySk5QUW5UNkFPN0F6c3VR?=
 =?utf-8?B?Q2h4Y2hKTzk0WlBIZ2VGV2dOZ1hYT2JCdVlxVzl6QjNBbSt5RTZDQjkwc3dh?=
 =?utf-8?B?YUttTmN0cjBydVVjUkpPR21CT2ZLZ1JPdEZkc0RZWW1TWnY5NFJ1anhlTW84?=
 =?utf-8?B?RGhvaVZHb1Mwd3ZZNG9FYmYxZkFwSzBFaVQ4Z3hPczlWUzE2NzlPRk1tajdB?=
 =?utf-8?B?S0pSQTJKUUh6VW80MVkydXk3VkwxZnAwMjRYamFEOE1paW5YZmZWUWZWOERQ?=
 =?utf-8?B?MmdCUlNlVlBMU2gveDVtdjh3elZwQ2E4Z0QrQ205M3JvakhveERDd0tqNVdS?=
 =?utf-8?B?Z2o1YnAyWmJ6VThCTzBmQ3V6TDlTUWhvMURhVkkwRHVRRlEzbDlybS9xb1g0?=
 =?utf-8?B?SUp5QSs1UXR3b0tFVjBKS3hBeitqL0VYSWZLajlZRXhQMFJqUTRDN05FVUxI?=
 =?utf-8?B?Vm1iNk1iSjhpS3hKeVg4dEU5bFNkcEs3eEIxZ2NIUXo5SFJpd1U4WXl2azA4?=
 =?utf-8?B?S1BjR2tGWlBpU3FkSjQ3SUJPcGh6TVNaMkczVVl1K0t3WmttY080aHppUjZH?=
 =?utf-8?B?VVF1Tjd3Zzdxdi93Q2YraDA1WVI3cjlZc3JKZk95SUpZUHhmY2ZzQ3B6eGI1?=
 =?utf-8?B?ZU83c2Q4UjhtR2YrcEhDUEJZbnBOY1cydFVsUk9JeXZPUHhTTmtnVnN0dnBj?=
 =?utf-8?B?NnBrUnBKYVlSbkJjUW5XK09WalhPVlY4Z0VGbVdaV24vVVM1QjBEd2pXbU5h?=
 =?utf-8?B?UU5sSXNyTDhnYTE5M3hLT2lwQ0h2NTI4cG5BeUJTUWFLY0cvbEhEdDRlQXVo?=
 =?utf-8?B?dk5OSDJzUW5sUkI0MjZYRW11VDBMckdWOUYwYXZ3VUk1dVkvNnRrZG03dXJi?=
 =?utf-8?B?MHRBbWEvcGQ3WmNqZ1J3WWNDVUtEY0JTc1lHdElKaUhSd0h2RUZDVSswVk9D?=
 =?utf-8?B?WFFpMDF5VEVDanZkNkR3TDZmL1JhMTRBdEhEY3IvbXlIaCtTMUY3UkI0N3pl?=
 =?utf-8?B?RHNvUWg2VlB6VTV0R1lmU1I1YjFkU0ZPQTQvZ2Y5UWY5K2xIVFh2VVhVbGo0?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OW0vbFRiTklMMDdiYVpkU3Bhd1ZPMFhXcDFoOXIxcXllUmp3T01YT212Sm1S?=
 =?utf-8?B?ZkJ4VGZ1eXM4Z0VWMWIrZzNmVWFBR3NyOCtteGR2NHY0cjJ4TVpsdzNYcW8w?=
 =?utf-8?B?cEJOcEJmbC9MWkhEQmF4UDQ0Rm00NldDRmJFRklwcmdpaEc4aVhxMms5d2do?=
 =?utf-8?B?VC9YSzEyRnpaR1Q3YmkyOFF6ZEJzUXB6UWREeld3KytnVTFpNmNvdEhPMHoy?=
 =?utf-8?B?L3lsSENYTllCTldHRzJEaHlSU0J3dmsvSEpaZFYxRkNCOGhjMFVCcG95WTZt?=
 =?utf-8?B?UWw5R0RqVlpXTnF5R1B6b0VmN29lTDJGdFZHSU1LRzRFSHJRZ3ZPbmpFZWtF?=
 =?utf-8?B?aVZrTmcrTnhmSEk1TDAzaER2RW1zVDdXNStKbjJuTU9KSXg4bW14Qk1kZm5M?=
 =?utf-8?B?eFptbXRHUjBTWlI1cVcxN3RReHYwTEQ3c1JuZUFYbDV0M0dKMTNQbm9KWmFB?=
 =?utf-8?B?REc1NjZMQ0ZyKzlGbUtIWCtyQVJxMmVSNFpDRzZVVmNxaW5obURpdWpPZW12?=
 =?utf-8?B?L2c0ZHE5MldSK2ZONmZveEpHTndnckl1aGZwRWtFMWg1WkRNUk04OWxnNEpu?=
 =?utf-8?B?b3M4Z3I2aTZxd3JnTC9jcmFiSnladFBqZWhRbElFVW50ejRiZ3hybjE4UW84?=
 =?utf-8?B?RnZpanVlUnd5MDZ4OWkwYmhqbWhFNEViVmZoRXBsWXdLQTlKcXVQVm1nNDlk?=
 =?utf-8?B?RGYyQ0tiNXlOTzIwcGl0RlllVDFuVDJTRU9ZQ3RmaDlIMExLUFlnR296S0du?=
 =?utf-8?B?RlEyUGpLemcycUdCVUhwR2RwOXhaQVFjYXdRcEpaMXNZaTJicXV3cGxoaDcx?=
 =?utf-8?B?RGtWL3pSUE9YZVhPTWxIa1hYRlJjZlN0bHlsT3dsc0E0VmlkdTg0VlVtRnJT?=
 =?utf-8?B?b3JyTTBsemNhKzlHK2dQaDZ6WFd6Qkc0TGx4M2FKS21aRE9kSU5COEZ5elkz?=
 =?utf-8?B?MExQckc0b2tURU9XRXBFYzVvQjU5dE9jTzFJRWpHTHFLNkhweHZKOFpYVER6?=
 =?utf-8?B?c2sxWFVlNlFlYlc5NXRsbDBkQlhySEpOZHBJK1l6aTZRcDVIeGFXRy9lQ2Iv?=
 =?utf-8?B?WnV0YTc0d3FGNnoybElQbjRFQis2WFp3cFJZK005ZXlFYmc1K25XdDRMR1Bk?=
 =?utf-8?B?UElJUzNQbTEwdU9VL0ovOGZ5bXlRRzNOR1lIRElWV0MyUnA3OEgxVms5dFhQ?=
 =?utf-8?B?cFhEVHpCL0VpUzI4YmpzWGcyTTRMZGp2eDdMczBDa09UT0xGdzlvclpicjhO?=
 =?utf-8?B?VlNOTjUya0pBSjIzejVSN2p4TEFlQ2JTWUFzbTZ1a2MwakVZT0YyM0IyRDNC?=
 =?utf-8?Q?JcIiqkv4+e6xA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c491887-1793-4415-cf13-08db1a456ada
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 11:09:25.4128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWyC8dsbaHzejEhJ7Fm+5chMrD2LL9zPtTLZXm5cJzy+haeM8GsvFIZCghr4iuH4RtvkLW35pP8Of/kxKia8N4LYTwRD7s+W0kY9tAEbT8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_07,2023-03-01_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=996
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010093
X-Proofpoint-ORIG-GUID: kRWh9lhzMJR_Z5R4cqZTZt7PII71jmSQ
X-Proofpoint-GUID: kRWh9lhzMJR_Z5R4cqZTZt7PII71jmSQ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/23 19:00, Serge E. Hallyn wrote:
> On Thu, Jan 12, 2023 at 02:19:11PM +0100, Vegard Nossum wrote:
>> Creating a new user namespace grants you the ability to reach a lot of code
>> (including loading certain kernel modules) that would otherwise be out of
>> reach of an attacker. We can reduce the attack surface and block exploits
>> by ensuring that user namespaces cannot trigger module (auto-)loading.
>>
>> A cursory search of exploits found online yields the following
>> non-exhaustive list of vulnerabilities, and shows that the technique is
>> both old and still in use:
>>
>> - CVE-2016-8655
>> - CVE-2017-1000112
>> - CVE-2021-32606
>> - CVE-2022-2588
>> - CVE-2022-27666
>> - CVE-2022-34918
>> - CVE-2023-0179
> 
> I think it would be worth pointing out how many of the above would
> actually be aided by this patch.  The first two would not, but certainly
> at least the can module one counts.  So I support this at least in
> principle.  I'll take a closer look at the code hopefully tonight.

The intention was to list _only_ CVEs with exploits that would be
mitigated by this patch. Let me go through them one by one, just using
public exploits found with Google:

CVE-2016-8655: this uses AF_PACKET. I guess your objection is that
AF_PACKET is rarely built as a module and even then would most certainly
already be loaded as part of regular operations? I see at least one
distro kernel having used CONFIG_PACKET=m in the past, so I wouldn't
write this off completely. You need CAP_NET_RAW to create this socket
type AFAICT, which is why the exploit uses user/network namespaces.

CVE-2017-1000112: uses AF_INET. Agreed that this would certainly be
compiled in or already loaded, so we can drop this.

CVE-2021-32606: needs CONFIG_CAN_ISOTP=m/can-isotp.

CVE-2022-2588: needs CONFIG_NET_CLS_ROUTE4=m/cls_route.

CVE-2022-27666: needs CONFIG_INET6_ESP=m/esp6.

CVE-2022-34918: needs CONFIG_NF_TABLES=m/nf_tables at least.

CVE-2023-0179: needs CONFIG_NF_TABLES=m/nf_tables at least.

All the exploits seem to be using user namespaces, for CVE-2017-1000112
I think it needs it to set the MTU of a dummy interface. I'm happy to
drop this CVE from the list (I probably looked too fast when looking at
it), but I think the rest are legitimate. Added Andrey Konovalov to Cc
as he wrote the exploit I looked at and can maybe confirm (and in
general has more experience with exploits).

Thanks again for looking at this -- I will try to address Luis's
comments in this thread as well and send out a v4 when we agree on the
required changes.


Vegard
