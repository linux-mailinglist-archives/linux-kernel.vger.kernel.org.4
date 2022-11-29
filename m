Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6686363C52F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbiK2Qa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiK2QaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:30:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42965C770
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:30:23 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGNt7Q022642;
        Tue, 29 Nov 2022 16:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=mq2EyLheTw9mVWD65B0+V3EYuiw20r72c130RGNlN2Q=;
 b=snaYeasH0ZElEtTsW0CZMzVtqjxhR+Wzda675tZFoDFE9e+b+Q7MnU0hXT7Kxqb4p3SV
 eDbKwJS3HBTQlT4ZAfGld0HrrQbNw/ALR03j/JS+MoAneIu3phVtbJUffW1wiwBVNWmF
 V0D63uxGq40BlMMtX5O/yeLiQkBatkXUoFWWzEKzAqVNLnJoAREV73yhUZQLvcXOphAr
 yqx7nuJU8KZl5HLcE16ZKUrHPwA7tWdiHVRQK2FdhBRXv4JFXptm094PwCBY4ShnYhk3
 7BMjZAgEbvFfBz65ug2dIaWF2rpFuFizjVMkgxhnfCjh7lYsYC1BU7jMQ84TXRfawus0 cw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m397ffaj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:30:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFY3kx031443;
        Tue, 29 Nov 2022 16:30:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39876545-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HARGsOKu8jZHnVsmGeA4zYrAP9KBnsvp3XWFUsnzJXacNaQSQJaYE5v9bsxLJoTeVvQnb8qgnWC7Otzcepu+Tj5Du3lTSEb8fZbeoRn+X/qzXcW/gSOVhhyTCbc0Vs+ZFuF57zNdz53Ak+1ug4Bm0ja2Bjw9F+wlPlcdGyoHvE7pkYAFl5BR6yHJKLJzT4i0RChI0zqBC5YEXyE0k+ku9yra8u3IdISbkvQ+RN10y7Y5u1KBVAUTH9yxjEjiDbWTXSF78fPgAFMnmfdx9WkCD92jWbhlHC/7zw1iBDJbXyhbrlrliLpXqRuAeYnY+sCAwR3sY90M2wXtS31DpBGTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mq2EyLheTw9mVWD65B0+V3EYuiw20r72c130RGNlN2Q=;
 b=eqsnxOm0AcZzAXJPOmF6mJLpJOjlJrn8eleHm6kj7tPr1/EnK8BSgUOeXr+ls9Nzc7+6IWfYIErbic5rzlyjMKymSMFmR6Dc6e+0FXkSmAViZBvtAzUa/MvHklTIivoLI+lSo7j1BGsR0mhBTYU1gvp7hKEy9mU74ZxFIzYkviPljbA9r3Vku5Zby9ZoXUz+TNtLnBwF7JF450QHXn9AVQPhBd4InMrwANngE4ppFlZP7UTORj+Du273htT3CKiEVSNqeViydc9ehzoO4zMuUTMm26WeogKyFFnWw7xyYphrBmKy+DL/cfsNy7jbBUR1DLmWt3lnzkuPzofO4BZl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mq2EyLheTw9mVWD65B0+V3EYuiw20r72c130RGNlN2Q=;
 b=ERLKSi/nyJi1wVOGrF3X+2SEk0NEIo0sweAosTWLeBxf8K7MrnU5yp65XBbbQU5F7Bunf0Yl9jpziagwHdpzuefDp6CMEN0BU0RQZpb5U4UnF8qP0iP0MvdwBdD5LxdOjdktXccDWFyu6S1mWoNjybVGrAYJtKAbZ7A5npVdqXU=
Received: from CH0PR10MB5020.namprd10.prod.outlook.com (2603:10b6:610:c0::22)
 by SJ0PR10MB4622.namprd10.prod.outlook.com (2603:10b6:a03:2d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:29:59 +0000
Received: from CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::1458:2f4e:91aa:5bc7]) by CH0PR10MB5020.namprd10.prod.outlook.com
 ([fe80::1458:2f4e:91aa:5bc7%9]) with mapi id 15.20.5857.023; Tue, 29 Nov 2022
 16:29:59 +0000
Message-ID: <c8c13453-c453-7de1-ae07-045064a938b8@oracle.com>
Date:   Tue, 29 Nov 2022 11:29:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] drivers/xen/hypervisor: Expose VM SIF flags to userspace
To:     Per Bilse <per.bilse@citrix.com>, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Jan Beulich <jbeulich@suse.com>,
        "moderated list:XEN HYPERVISOR INTERFACE" 
        <xen-devel@lists.xenproject.org>
References: <20221129150058.266943-1-per.bilse@citrix.com>
Content-Language: en-US
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20221129150058.266943-1-per.bilse@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::33) To CH0PR10MB5020.namprd10.prod.outlook.com
 (2603:10b6:610:c0::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5020:EE_|SJ0PR10MB4622:EE_
X-MS-Office365-Filtering-Correlation-Id: a7df1633-7b4d-4f76-9621-08dad226f563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BPDE/o8HxuqqTh2rgqyjnZikHH9zNjVj2FDT/XIvs7eoxL2T0Q4w64DRsHwinfinQUyNOCpHAIipLqispkxsLYBZRbnXOn+ZZQzUW3K5Y7y+WLpaGKSMTNFRuUgzzwd69SnQ3Y1xno2kGHCLZAFu4lPZkuo4Xib84lGpPo2xySBXm6yULBsdwGAzV23eCpQJR+Z5T3KfUFQvc5Czdj4kk4cGK2tvGQ0nETqB7VVAR696afp7R1oFfpi1x/fj0o6C9b6M8ZyGHn8k1IqjMrdovohFDzgUikQHs+7cCuQZmtnSMXTB7aLTmGSfoagkrnzS5yoSOmEqiFQD0UynhNP8CdsTBZWoyKa0k8eKQjOSzAG8JYiP21umfsQeG5Ym9bMtV9Zmd9p3jf7r33zOpjwv1xSt5BmPmQA25wQuRHdjqV5xEM2qrvhtwv9tZs4CWf5AW8LeqD3Ud1r/ZDIPixjFibrncyYIe9Dgqfclw/swfYoHD9sIasSa9joG9BnIFoRh5I4c6iF8u46+A56pvemwiAcCd62Nohvua4kC+ebG9TfK1bT6GQMwY5Tmaf8eYL8JpNaKLbUibUvdhHCL8oc8qQJ7/6lFqBO3TimiAlaVIroNuikwOPgVxOO5rMIxnNpHvQ84CrOdiU6RG+tPuRE8eJj3ehCof0hd7UqfMyDxRoEFkfSLTCtuYrn8KZsyvG/XgqBvkSC5Dwllhrobywmrlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5020.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(39860400002)(366004)(346002)(136003)(451199015)(5660300002)(41300700001)(8936002)(44832011)(4326008)(66476007)(8676002)(66556008)(4744005)(31686004)(6486002)(54906003)(478600001)(316002)(66946007)(2906002)(36756003)(86362001)(53546011)(31696002)(6512007)(6506007)(26005)(2616005)(186003)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEJDUUIwbm5CZHdhNXNkQVFlQnc2SnVYMm5QNjJ1R1RyWHVTUUdOWXRjdHBD?=
 =?utf-8?B?aVFhTlpncVkxaHY3VGxHWDZwVTlaTXBncjlFQit3eHZDclQ4VlRaUHJpbUQ5?=
 =?utf-8?B?SktkcUxKUHFCa1NBRXpEYm5LaklKM0ZFaFNqYVllbkdhMmRDOE9VbG4veXhm?=
 =?utf-8?B?dEJ3ZDh3SnB2Njl4Sk5SSWN0U01lb2dBc3FlTkRiTTNXazlKb2l6ODVzZkxP?=
 =?utf-8?B?WGJXSzdkeWFsMnlYb3NFMjk2cmpIQkNKUTJSRWFTTVBvS1hIRjhBOXpEUGtK?=
 =?utf-8?B?Q2FUeXBMY1hBcnhrMHR4UHhXTitFVEdQR2FRUUd1c0Zaak0vdG43aU9Benpm?=
 =?utf-8?B?ZTkrTnlacDFxdVBPdGo3NWs5UkFhQzE2aGtrV0tXbUF4YUZXd011K3Vqc0VY?=
 =?utf-8?B?THpBbGlpM01mMHVnNHRFYy9zWThmT2hPa0ZvVjNqWFhLeitOYnhkSVZVWHhv?=
 =?utf-8?B?K2lYQzdSUGdQTDYrS1NOYjgzSnZkV2RuR01EM3lRT2RwaTE0TWlpTm85MVk2?=
 =?utf-8?B?MnhXQTVVN0VwZmxzMHR5K3RObncyS3Fsc3R6Y2lCWFZveDFqS3RjSS9IM08z?=
 =?utf-8?B?a2dJa2g0Sk5rT04wcFltSFFxdFJGaHBXU2YxOFM2R3djdFBETy9HK1lSeGtk?=
 =?utf-8?B?dHlpTlpkdE5iSUc2NzFVOVkxazY0VDlCMVg5cUZ2RUNzTmlKd3NLL0o3TE1T?=
 =?utf-8?B?RHFjOWZFTDI3VDBSVlFMMXBKa3VxWG5hODYybU12SjgvNkVrV1k4NWxsdWxW?=
 =?utf-8?B?c1NXL3ZiRzM3bDdKN1hnRkVjV3J0blhoa1FuZ2pMRDF6NWN0bUl4YWx4Umdi?=
 =?utf-8?B?eDlWdWVVbTkyenllRFBIVld3aWZLdTRjU2l6QWtZaFBrOXo0ZnMwdzl3alRC?=
 =?utf-8?B?QWM0YUZTblhaYUtKWkZpRExXNHQ2ZWtIdEltTzI4RXlKNmVNNGhmV2ZGb3ZU?=
 =?utf-8?B?NHlOSVhueU1NS2hlQ1pjUG5jdXg1T1pQcGF2OVFlS2tYN0cxbGRyWVcrTTRJ?=
 =?utf-8?B?YWhHNk1na1o0ckR2UkVSRUVFcGdDVUdTTi9BVU1RL3lrWUdEK2dMUnNFY2R0?=
 =?utf-8?B?SFBacXg4RVlLY3JhQ0tyS1gxVUxNWVFLako0ZHFMdi9kSlA0TXZUQS9PUjV5?=
 =?utf-8?B?STRzTFlTN1VBVUptT3czS252MDJnMStsYmtneGJ0OXdKdVNNTkF2VmR5azVz?=
 =?utf-8?B?aUt5NmdYa3Ewby95UFhqcTF3Q0E0UkVsYnBVdW1sdW1ta0p4dFdJc1ByWHRw?=
 =?utf-8?B?cUIwRkFiMWxHYmpaVmpxNW9PSUU0WEJMMnJGKzNmaU1PNjBRVk9QMk9xWld5?=
 =?utf-8?B?WkFWbVJybmMvSmtGeUFrZzVqSlRUMnhZTzByV2ZjL0NPWW8wVm5LdGxqcm9v?=
 =?utf-8?B?cUhBR1A1ZnhIa2hwOFBFaHNTSXk2ZzdUOTFORitvK3AxSmF5dERTcEJnSVVR?=
 =?utf-8?B?dFhjamY0VnhTcTYweXJYdWx3NGNUbGxvd2VkOUpWZ3k4T3dIMXM4SzJnOEFO?=
 =?utf-8?B?MThNUGYvSXQ5Y1BCWkdTVUFMaWk0RlVMM25qTXBCT2xtT1A0YStPb3pPWVdB?=
 =?utf-8?B?ZVlmRVVuVGplalltcU9SNWppV0tGZzg2ejRXV21jMThxLzcyMU5ZTk84M1hF?=
 =?utf-8?B?MmZuYlUyS1phM3lKMFFjb2ZwQk5wci9CU1YweG1HNldycEQrbkpLcHAzZ1Zo?=
 =?utf-8?B?LzVhS3FvdjMrc0psenB6ZHFtYXg3MWlJWGNwNzR1UEIzMC9YOWhyRXluRFNB?=
 =?utf-8?B?SG85SUNuRS8zaTNsTFROQ3FWQkZ2K2RVbzdZOGw5bWVVWHlqSHZnVWtiZDF5?=
 =?utf-8?B?NnhqNEhrdk1LRW1wUi9LNzU4dlJXdVhrRSs2VWxMSkhFZG1zQXZVOWwvdUN2?=
 =?utf-8?B?ZTJLMlF4QUc0MVBlaDF4cGhBaDQ1TUM1a1pJYzFyZC95bW1mU3RhUUpCY1kr?=
 =?utf-8?B?NHkvWUNHUDVmeFNQcVpXQ3k4dWd0L2NPQ25Ea3pLT29QdWlJdVFHSmZIbFdV?=
 =?utf-8?B?MTZsb2NJbGFKVjdOZTUyNW52ZWxxQWgySDloYzNEdmt0N3djT0RiMFpaSTFN?=
 =?utf-8?B?MDZBM1YzSDBJL1hoYnRkV2c4ajJsV05FR2tZd3ZDTzZzMDBhUVF5dng3WkJq?=
 =?utf-8?B?VzJsVHhISzZSUi9CVklHU1hLL3g4NDJCMGl6aE12Z1FRUmJrNHhxaHBkTUNy?=
 =?utf-8?B?aGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YmR1M2IyZXMrd2d4c3BjRWkrNEIwMmQ4QUd0RlNYMFRkOTQ2UWxxWW5qWEg0?=
 =?utf-8?B?OEpYdmd0WEFJUmFKczBZRVZBMGtNMXQ5dEVXVlpjcWVFMGdrcW5GQlcxaTVH?=
 =?utf-8?B?bVVrMG9ZYkN3cTFXV0hvQ1R2L1lrRVlVWXBkYVpsNHNFUlhxYlczRnNnM1R5?=
 =?utf-8?B?bkI3L2xDdWpLdEd5aGdMWXBvUGtIQTR0REhTeDluOTBZQmM0V2IvRWZFMHo1?=
 =?utf-8?B?cG1CVk5wSkZvOE9EM0Q3WHlpbWg0S1pNRmhtTkQ2TE9yMklRVWZOK1AwekhC?=
 =?utf-8?B?VHRveDVSbmVmQjNGRDhEaGZwSkZBZ3pvZVdQeC9oMndnaDVRK2RXcFd6TmJk?=
 =?utf-8?B?a0Z5emZHT05YVUhJUWN6Y1BlSGdzQkxLNFhvaWJyQUIrb29PVnkvRmZwSG5w?=
 =?utf-8?B?THlWTERPTmpqUFRGSUpxUE5vY2F6MFh6dDFEWXc1ZnNOc1BxUllYdDhIcFpv?=
 =?utf-8?B?L3laZXhMZE1lUEN6UjRiQVZJMFNPZlYwVWNhRHprdW5xbC9TR1RvNmc2NTVt?=
 =?utf-8?B?NmVsVUJJWU5SVzdHMkdlVERyTXVoV2RxREJGMmkwQmpEVnNNMTYxS09GdGRY?=
 =?utf-8?B?TWwrblUxZ2lxUkYxK0dJMDAxUWtRTWZELzBsa1dYNzllTXFhZnM3YUc4VThZ?=
 =?utf-8?B?L3NwZmt2MjN5ZzRxVkROOWdoNGVKdjdMcS9oL3owVTNkaGFPMEg4VkliQXN4?=
 =?utf-8?B?RWVsWUhKcnY3WkU1cVFabTlDb1pheFFmZFlNUzlCdTRpK1dSa0ZkMDZIWmhy?=
 =?utf-8?B?cktMdFpPUkpTV2Zxcm1CUllubWg5UUZxcDV3b1B4R3g3dzZtTm1Ud0ZQY1U3?=
 =?utf-8?B?L0REK1BEclluNnIvVXp3Y1U0S1lFT0hsWkgzMkN0YzVLN1RWYS9xajNhblFr?=
 =?utf-8?B?SkdudlhtdXBBSGczNTNIeDZpU3BYbmMrMkZJSE54OVFtZGs0Q2syUFVSd3U5?=
 =?utf-8?B?UUJqVDhWNE0vcEkvUnBKQlVzT2c0V3hlenNJNUhiL3RjR1dEYzNCZ1ZpZkMx?=
 =?utf-8?B?NGg4SDlseWhpTEx4YmNDTmpKVitDN01rK3RhRDJaam9BWmw1UkduM05NbVpV?=
 =?utf-8?B?djl5SmFicHFWR01oWXVxUHh0emRJWEFRZ2YxM001Q0NQcVVpMCt2YmpoYzhr?=
 =?utf-8?B?MjRDbjYvSThkOWxxOW11enhGSW0xa1VxOFQ1ZUIxTXcxajVLZTdHdDZsOWlj?=
 =?utf-8?B?OWZhL2lJYmFZekU0QWFMc1N6b2sySFZHYjhxam5RRjI0Z2FZRDg4aDdPd3Bk?=
 =?utf-8?Q?BJYxviPc8bgaN6B?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7df1633-7b4d-4f76-9621-08dad226f563
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5020.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 16:29:59.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3AYwm0SVCi5huqyD0tJcso79nlbmdGLHTzWV01XlPrRXR1bRfqaXRx07kPwhRyyd4IsK2Q7heI8v9ESXSAKvSzqnu2XnQFkgP82CQyzmcGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_10,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211290091
X-Proofpoint-ORIG-GUID: Xiq5bDBWYPVZSA_n-EtBEML4M8ryGzXJ
X-Proofpoint-GUID: Xiq5bDBWYPVZSA_n-EtBEML4M8ryGzXJ
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/29/22 10:00 AM, Per Bilse wrote:
>   
> +static ssize_t flags_show(struct hyp_sysfs_attr *attr, char *buffer)
> +{
> +	static char const *const sifstr[SIFN_NUM_SIFN] = {
> +		[SIFN_PRIV]  = "privileged",
> +		[SIFN_INIT]  = "initdomain",
> +		[SIFN_MULTI] = "multiboot",
> +		[SIFN_PFN]   = "mod_start_pfn",
> +		[SIFN_VIRT]  = "virtmap"
> +	};
> +	unsigned sifnum, sifmask;
> +	ssize_t ret = 0;
> +
> +	sifmask = ~(~0U << SIFN_NUM_SIFN);  // ...0000111...
> +	if (xen_domain() && (xen_start_flags & sifmask) != 0) {
> +		for (sifnum = 0; sifnum != SIFN_NUM_SIFN; sifnum++) {
> +			if ((xen_start_flags & (1<<sifnum)) != 0)
> +				ret += sprintf(buffer+ret, "%s ", sifstr[sifnum]);
> +		}
> +		buffer[ret-1] = '\n';
> +	}
> +	return ret;
> +}


Why not simply show unprocessed xen_start_flags as a hex value?


-boris

