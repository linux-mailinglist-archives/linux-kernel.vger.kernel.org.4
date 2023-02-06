Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC9E68C5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 19:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjBFSUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 13:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjBFSUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 13:20:50 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D832D4F;
        Mon,  6 Feb 2023 10:20:49 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316IJ7vC011754;
        Mon, 6 Feb 2023 18:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xAAgt06I03mvAVLddrK7dXE21T2V5KSTaqodXyHXI88=;
 b=E0XSK+1v9ncgfIrI9M9YLL8Uf42R1ECaAzbhCPrC7+OpRFyE9mygdiZyXAJ3v8gVEoJX
 1yEQ5NPbmoAgbbTCxjK0lEhg+meNSlwCn0JOTunasszyOWeVdJWad8hB+QAupiZLT1+W
 QC9Yk8coj0SPrXY00ztMLBMskQO8W8ZCNNn8zBVgr74mzpAR9gcZM/QFwtz2kspRoIG5
 VWO70L4rbj/gs/7gCXxNbBwS9v7n15hc0hNPYGLl/8mHeWNhNwwANa1+6CnEjM2MUXRn
 A7cWU9RGXJTcfLRGDjTSTy/Ro76cN6PsT+SqNqfIvKulRgqxlPCu05jjbbf4NO/y+aGq lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdy13mj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 18:20:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316HvL9C016840;
        Mon, 6 Feb 2023 18:20:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrb8yans-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 18:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDlekPzxgfHZSZtzfMMdEeLb1CsBlVbTXasIrkpI6m5dtD2drp3pwrGFtyD20CykgB8VxR1vkoaWejBDCp8nFlRc4YwLVrPv+Cx6Vum+ixbxcfmgU4ru6ifYVTnZ4vBorFJK81YabdK6bmucRU5DbquYFz30BPXgKee0OHKY0P8ouJiH/cLa7rHq2bF59TGb84v9EUmqHU5s1DHLWG7lVj1CqRw8mEf/Ty8OIH0/EGFhuMhLCj8MCVCix1w4Ybny2+Od1y12qzRiR24mFTCo/qvOPAYdC9pEKgYQgrUpD+E6Ptzb0nwZSX4KpIydquX9PBZFbU9Mesq6T/ASFc0CTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAAgt06I03mvAVLddrK7dXE21T2V5KSTaqodXyHXI88=;
 b=mE19BqftKeG+sNDFZcudM4stHPmPoVO1F9LWFT5VPRom4MHD6WHq1Y+P61xSPm7tsBlQ2GAN7NCqmJI55wf4w3F1Ok5H9TeB3fozWAtJvXSd2mw/A/Ylzgf7agDZik+GK/rVY8KFlkVx/9Lxho816NCaLk/u/g5qO8svIKzRJzkQaPjqhwEvd2PmKThckD0Yu0fc6MPxTB63ao5f8b1VzH5AGY0npMffawe3yIBNAIG4fPlY3xBIMIiA+LRZm8VX0U8HzxHqNO0S/4n5YApzdt46OEZqjq7doJRtU1O0MfIsyxaRnMPBGWJA1Id62VMt+RByrpZNHJNibEEN6eDYtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAAgt06I03mvAVLddrK7dXE21T2V5KSTaqodXyHXI88=;
 b=KpiSbXHIUZYCW2hQxdO4s5dXX7b6OPrnNKxHQfSyXGlF8nvmZTx6n3Wkd14y8nUawtt8bEgYknm8VEqnrqraBe+mSVun2rs5VObCqh/ioZAfHPRNU9YIiI5y8xEmH8iHJakw3gKYuGb+fMb0HQTgvEjDUpkySmsPxSnQf3M2WeI=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by SA2PR10MB4794.namprd10.prod.outlook.com (2603:10b6:806:113::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.14; Mon, 6 Feb
 2023 18:20:32 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::7dc6:9d07:e82f:3575]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::7dc6:9d07:e82f:3575%4]) with mapi id 15.20.6086.015; Mon, 6 Feb 2023
 18:20:31 +0000
Message-ID: <a305b9e4-349d-8936-b0ba-3dcaa4199ebc@oracle.com>
Date:   Mon, 6 Feb 2023 13:20:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] vc_screen: break from vcs_read() while loop if vcs_vc()
 returns NULL
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.cz, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <1675704844-17228-1-git-send-email-george.kennedy@oracle.com>
 <CAHk-=wi5h32VBgzYgFy8KoXbcDMa9K_ihDjfxD-iScy7L+M=QQ@mail.gmail.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAHk-=wi5h32VBgzYgFy8KoXbcDMa9K_ihDjfxD-iScy7L+M=QQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|SA2PR10MB4794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2137ba8e-40ee-4894-1b37-08db086ed50d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n/ze/6N0b3qjPOyJrDp9UkkyExGG3jq8jSFP2kFV/gAqcvJCL2IP/LWFiuvbdNQKpYdf18nDwl+yGN66/Ls2mq2c9g3TLmNW0zkLhFsE4Ho9Xq2z2nrUCw6CuC0COVveZhAEOg1hR2rZSCnRjihC1adWSJ9VFbfA0xDhdj1qTsrTN1s6DWlFTDpBmyh+DoBttCcpQg2VlEiod1lYNF9EBN1d2Dx4UCf3v5vq6uDI3HRStwc2VwtipUbOeEHVeek3zcgPDbULai5+v5EQ38pc/8vaWLkKtJAQcX+7VAPOFpX+wrT0dFNdBlAB7v8XYmb3ieIZEUQjeQvlSK04EV2zlPYgmDkHPEONL9K0fgR0b1/iNu03ZJgisYfMFHjlcKsgjQCtPYy4eY0YaL1dJgWUpBOYG/ZeI1x9dJRPuaPZgZvGmiutewbyBP8rLThKSvlurd7xnhUBgT365RtyD21eUfoh6nwlAOr5bFtcG8PJ9PTV2Zt+sx0M7aOybirm/3Gxy+uEn8fM6sce0yGMg0ceNhvp7k7KhMWj9BszjDNUBb+yynVsP1m3AhTO5dZo0SMY42MYAJFVLF5VA/pBPFDbQ8mrZWgfzH40jZrqe9UAeX0Eh7y9CIZ3vk5x4c4OF+henupE5UWT+paA18wzl7gtJvgyz5Ir9/enmB4cmf4lVCzi/d+GzAvA2BqmxkLI7qHtgR+CLcBeBbK5DzUsd9LAZfZ4BRVSHvKzO0rpwelwG5s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(366004)(39860400002)(346002)(376002)(451199018)(31686004)(2906002)(44832011)(5660300002)(41300700001)(8936002)(66476007)(8676002)(66946007)(2616005)(6916009)(4326008)(31696002)(66556008)(6486002)(478600001)(316002)(36916002)(38100700002)(36756003)(26005)(6512007)(83380400001)(186003)(53546011)(6666004)(86362001)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUNvbTloM2l6VG9xY3M5MTBzRlZIWUdhdDBMTEcxT2ZVVWRwUmlZZmlUZlRM?=
 =?utf-8?B?WHErRGxzTi82eGdDRHhGdUZOYnVlVmN6VTlqYnVPUHJRWnY2Szg0akZiT1dv?=
 =?utf-8?B?WHM5YnZWOHh1MllvQk9zdzVXbVoweGJsbFdwb2htVkpCTGx4amRGK3dyVGJ3?=
 =?utf-8?B?VERDVG93S09Hd2FweGVIQktlbU9EdkxNTTJ6eVpQZ2NRMWxYdm4wdyt5M1Zt?=
 =?utf-8?B?amRLQVhVR0luUlhRSEFzR1VhQ2hZS2s3WC9nWVExbkpPcHFheWp1bVlSMHgy?=
 =?utf-8?B?ZzhuOGhaa2lGQUJnM0U3TFNTNkVCNkJYVjlZQ0xIRGI4UElpNHZnejdlQmxm?=
 =?utf-8?B?NmxIWDFmeVNGWlp1ZGlic3BzQWJvNjU2ejF0eEtRbWVwMEV5MVhmUEczWEVE?=
 =?utf-8?B?Wm53RnJSTlQ5Sk9ia01CNjRiSVRYWHVjT3VlTjNBWmx1R0tHSmpDeWptWXhj?=
 =?utf-8?B?bTdsNk1rRlVJTFVVNEFqS0p3b3dnZkkzMjJuRjQ5ZXJ6cFYxRTVjSTNsSmhT?=
 =?utf-8?B?UjI5MlRJRUQyalQxMnMzVk5QMU0zVG9UNEI2aDBFRmJyV2pydGorTlFBa0Jl?=
 =?utf-8?B?M0RmdDN4TDN5a1gvOU5LbS9BRzdJK0wrbGI2emlQT05UMFBjNnNvQ0oxT1dK?=
 =?utf-8?B?bW1rQ296NWNkVkdHWE5QdVpST0J6dlhmeVJiUDF1Nys2OWgrM05kMDlxTHJh?=
 =?utf-8?B?bklCRm42V1c1QW5OL2ovR0RVdUpiMWxoWVM2NlZoK0tkZnlKVzZRREladVZZ?=
 =?utf-8?B?OWd0Q05KOGcyaDVwWEVBRjJtcnA1eHg4UVhEZVRLTG9QZThJcFVaL3Nta1Y0?=
 =?utf-8?B?RlVrT2tCY29LTENRdHhaOTlTRnVTbVZNdWtOOFRLcFFTbElLWUhQZzRrZEYz?=
 =?utf-8?B?TjNHU3FOSDhCd3Zmb0YzUHQ0UlU4ZWhQVVJCZk1QUlZtS2RTRkRTMTRSd0V5?=
 =?utf-8?B?VStPdk90eGs3aWYvdWQvOWd5cTFYSHRpdVUzQ3ZTOU9XeGZuT2FxcVhsVVdu?=
 =?utf-8?B?OXpkeXVrUDlNQ2s1Zy93cjJVNGJqczdmRGIzRU90c3BWNzlOWHVGQnUvbkw2?=
 =?utf-8?B?UklabEpSK1RzdjFGVUZlTzhXOHl5SmIvSDkxZGFMUWNBVzBzSDRCMFNwSXFS?=
 =?utf-8?B?WGZvUHhpQmtjYWlnQ0Zlb2pJdDhSa2ZPVUhKWGcxb1crU2pFU2oyMGhCYkFN?=
 =?utf-8?B?eGpYZzBwaGwxRnlqS0F4SzBVZlZZZlkyRTZMemVnbmZWQlZGRDlKRThaUnVU?=
 =?utf-8?B?Rlc3WUJ0OHJDK0grUlBJUnJUa0VnZkpaRmZZamNhZGlaMWR4WHd0bHpWUnFR?=
 =?utf-8?B?OWtEME4yTnFKNHNXdHhHUVdmekRQSlZJcklaS1NpQlJocTBva2JiSElSOWtY?=
 =?utf-8?B?YkpCTk1NblRjK0lPTHhqMW5ScDB1VWt4YWpPWUgyUitaMkVaWTA0NnlYamJ1?=
 =?utf-8?B?TTdxTDh6cFk1S3VHdGg5V0h2YWtETnkzSnpZY0JWME5XNFBoZkFqUERQcVZv?=
 =?utf-8?B?VnZLR0w1aWxydlRmSEp3bjVuZXovTzRSMVYwVXBtenpRS2pQVC82VmE3UnFo?=
 =?utf-8?B?cG0vYkE3OU92NkdVUzNUNXE0ZkRjc1RnT3g0Z01RbUFHZzQxZnkyL1pDWnFh?=
 =?utf-8?B?RENkTVFWZGxZM2lZb1Ivcno1Rk1odUlQVWhrTDQ2K3IxaFBKRnAwd3VLQkJQ?=
 =?utf-8?B?Y245dGxnek9FcldXUmh1b09QRUNqaDJBNllsbzlMZVhtUGNDTk1pV1dnVEpD?=
 =?utf-8?B?RFEyRFdURWZySmxkU3lBbE9ReVdnVm02THF2RC9VVjhKY3psZXhGM3hxTDBn?=
 =?utf-8?B?Snk0SnFJVVJDZUpxZTcxMTE3VkFzMFgwNDEwQUNrMW5vdnNRQUg4Z096Y3lQ?=
 =?utf-8?B?ZEMvTy8yQ2lNOG1iVFNUdFZhVDlyMUpRRmY2SHlveXNBRE5jbURBOStyL2xO?=
 =?utf-8?B?dmJzSkJhelhHamIxdUFMaEtPMXJKMGhOb1l2RXpUK0JQa1hCd09Gc21acSs2?=
 =?utf-8?B?Q05QdUxmTExSbHhuUzFuQ2h2dmRkdnAyWTlYY0RET2YwS3lFK1VuanEwbCtH?=
 =?utf-8?B?aU1QUnkzR0t1NHhDTVEyTGx1d3pPdW5BS3dxaDNjUTNYcHJVZHpXSUdnblY0?=
 =?utf-8?B?RVA5N3ZEQitTQmRFRFJsSXBxNzRTazN0SmM5MWVLelpTb2tvU0N2RVlWRjV6?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YlY3K0kyeEs3b0VjWitMOEhuZWVNREg1T0taMWxKbzVYc1BGTExIdXVFYjNp?=
 =?utf-8?B?SkY3Y3FERFZ0MG9kU3ZTb1g3ZnY0UCtMUEl2Z3NDbU0yZndyTi9KcUxINnB6?=
 =?utf-8?B?Q1BYVGpmdEFweC9qVDArWS9OZDVpSDRBUW1UU0dWU3RlcE40aXlvaUU1TDIw?=
 =?utf-8?B?ZS9rMXhaSEZ1VEh1SzUxb3dYNVV0UWUrZVRBOWY5N2pTckQ4Z3UrOEJZd2FC?=
 =?utf-8?B?SkVod1ZGTTVnWm83MHZoOEZmUTQxdFlWMzYxcGdnZHFlZlk0ZnJZVlNvMXRn?=
 =?utf-8?B?K05UL01RQjRGc1JJOFhlVWVJUW9JSDFaaEdlMkR6MndiUWIzVmdwL2lCeXpE?=
 =?utf-8?B?VkZQQkdWMTJkNXNqUWhGZ1pvVmZMUmdRbVJWRTEwcWxhZzZKYVpSV0I2Wktp?=
 =?utf-8?B?ckY2cEpkeGNhejBCNk1icWJra01iai9mNGczSFJ4U3FZVnRZYVRkb0x3RUNt?=
 =?utf-8?B?MjdxOXRsTnc0S09OUGw1ZlVobEdySFp3eGZyMDNnYjd0OC9pWTBFUERCVXlp?=
 =?utf-8?B?WHg2c1dKb2RKUFBySnNINHRBUTFvbnZxZkI2Z3lUTXAra0FZYjNlRS9MdDZy?=
 =?utf-8?B?dU1WdWkwdjE5RHAzeko5V1dyRE9Na0VqVWJIbDQwRWora0p5Q3BMeDlLTWxX?=
 =?utf-8?B?OWRFQ3FsZDR3UjU1NU9iUkJacm1NVmpXQU9RdGxGRUYyR2tqc1g5YjY5aTZH?=
 =?utf-8?B?N1BwQ2pQdFNaNTZiSkZCMlRCUDJqTnZYby9qVG14YlJIR2hsMHE0cDhJZVcy?=
 =?utf-8?B?T3NhRnZJdVc1dXgxeW1WUGl3bHcySm5uNW9qQnRxT0ovV3ZnYkxHaGVqZFQz?=
 =?utf-8?B?Nk1CQTFTd0swYTEzeGxIZFFFd2lNbmdZWmJjY0kvOTNoRkpuRXljV0hISmR3?=
 =?utf-8?B?QmtkMXBYYUhsTCtMM0IzamZJU3JjSWhpeEV2TDF3N3Y5NXMrdnh4a0taUitS?=
 =?utf-8?B?dENHeXI2UkFsS3IvM1VkUFMyLzAzZnplZFREeHhWS1dCMGUvdUFzckJxaW9n?=
 =?utf-8?B?ZnpEam1IYmtFdEN0bFJtVGltQkhQdGRqckJtcUJnQml6K05KZ3BCZHpldzYr?=
 =?utf-8?B?UzRvaGtXUlFwVEhPa2djV1R1UkkxUEpxTEw0b28ybDFhcllKTy81a3hUUitP?=
 =?utf-8?B?UWk1SEpUV05DZ2EwSjcxZE9QZXQvSG5COXp0cG1NblhCS211eTN1V25NOXpB?=
 =?utf-8?B?Vk5ld1hWZThKUHNkMzlLZjNmVkh5K0ZsaW9SRDBhN3FSTFUrT0QrUTN6RWdx?=
 =?utf-8?Q?YVkRjShyQutXUVN?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2137ba8e-40ee-4894-1b37-08db086ed50d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 18:20:31.8918
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FXV78uThG+wMNlthiyv31OxhOGYcnoMcC1tf8OaizJw+L6HY6o4ie0189x96MmoxT+/FguZQBklgG3SBcaTueUdzKdu/qP3qMFtpe2rsOJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4794
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060159
X-Proofpoint-GUID: PrLELAHg5uCdqYs9aoSK9YCk-TZNPOFl
X-Proofpoint-ORIG-GUID: PrLELAHg5uCdqYs9aoSK9YCk-TZNPOFl
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 1:12 PM, Linus Torvalds wrote:
> On Mon, Feb 6, 2023 at 9:34 AM George Kennedy <george.kennedy@oracle.com> wrote:
>>
>> -               ret = -ENXIO;
>>                  vc = vcs_vc(inode, &viewed);
>> -               if (!vc)
>> +               if (!vc) {
>> +                       if (read)
>> +                               break;
>> +                       ret = -ENXIO;
>>                          goto unlock_out;
>> +               }
> That works, but the whole "if (read)" thing is already done after the
> loop, so instead of essentially duplicating that logic, I really think
> the patch should be just a plain
>
>                  vc = vcs_vc(inode, &viewed);
>                  if (!vc)
> -                       goto unlock_out;
> +                       break;
>
> and nothing else.
>
> And yes, the pre-existing vcs_size() error handling has that same ugly pattern.
>
> It might be worth cleaning up too, although right now that
>
>                  size = vcs_size(vc, attr, uni_mode);
>                  if (size < 0) {
>                          if (read)
>                                  break;
>
> pattern means that if we 'break' there, 'read' is non-zero, so 'ret'
> doesn't matter. Which is also ugly, but works.
>
> I *think* it could all be rewritten to just use 'break' everywhere in
> the loop, and make 'ret' handling be saner.
>
> Something like the attached patch, but while I tried to think about
> it, I didn't spend a lot of effort on it, and I certainly didn't test
> it. So I'm sending this out as a "Hmm. This _looks_ better to me, but
> whatever" patch.

Thank you Linus,

Will start with your suggested patch and will test it.

George
>
>                 Linus

