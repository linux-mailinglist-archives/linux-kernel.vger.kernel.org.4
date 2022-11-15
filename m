Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E350A629FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 18:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiKORAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 12:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiKORAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 12:00:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD64E26ADC;
        Tue, 15 Nov 2022 09:00:23 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFFRimS005432;
        Tue, 15 Nov 2022 16:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=c2lMuSzcsZqCTmgo4wp3qCTxwmikI3lZnD1H7YsQkuQ=;
 b=vmpddvdehrNjeFWmtbV4PpmO5ITtlDFNlk8KPX67koposDLuoFKUIpuGFSXZs0DbJuqU
 JNnhGEtsiM49lme6wRTLkVMiEQLDuPSxdhhD9x4LJfJZLz/km+9swdlGkpTf7DMQiG/K
 aIKQkdVPBbmuMQkSougQ+A2RZFqSwPyqDamXfEQtSBanELvAdNe6S7KWddVfaSOnP5t4
 wK5lphpqWfGnNI4zXXRXDRZ5U1yFfhnHYycWlQRm7AB5YC40GSKaRqoED5nqPUEHl/D+
 S/X7c7tsDh8R7E3d0IXwWWllO+C0LClNRKLlTA/GK0/4FNuQWrsNYyULzGRLG8whnKcs Zg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3htt4mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 16:59:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AFGeQ9n010215;
        Tue, 15 Nov 2022 16:59:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1xcb4r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Nov 2022 16:59:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGoBghgbv2Q3rHSEiyJvwiSrAcNFb5lmDI3itka+989mxi35YeWVRJlgkRZQ73zplhJc0wB9W78P0nqCTaYLizfb56LbfWGjua8w9XkeMhYDFhCxBtU+v1O0Nc7JaMtcyc+Wg5bD9GjFa90nS1ikJQcNTIqko/qQKTfAv2ybqV9wDbLLNqNWN/uA0Fv6D3gnaT27OUMYsGamEeTzI3YoyhV+nZ2T6UKwA44nGATXYoa96/GcK89lfIc0xZ91szY4F552bgMuqvYUjXbGJkwWFQtlEes4CJvaWSBDPcJ07sJDbPCAvz+nd0dCJhoX4RElafeuQF0WD/1tlX4SQzWhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2lMuSzcsZqCTmgo4wp3qCTxwmikI3lZnD1H7YsQkuQ=;
 b=GzUGaXfwUbah5E5lKBqfdDP+LtbV0+30O1M9nc5uGJee5ucsoXQzUyEfsakxnUzz2ZfhC7hCJHMd3Pp72Kb00lPVpy7oXMQjMCNEax+Idq3jqQJqRfXch08dVVvsqjmd0u/6i/EQbOUuoShHk5gIjqv49b7LYuoSr09zFh7M6BiSCJv6ePSORGVmzMpxd7kKam2S975nIffRAiJxuz9TkCjwfyO4we44xuo+Aky2Km9K8YsNLRFDiPddIUXXnXdSMC0NCFaDz6Wp3bKTruZOXpAOO/D+0qMuZaU4IJRdnS7QYXiObxwpJfMeJZgchb4mcaWzaZq9tF1RigYp2h8dHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2lMuSzcsZqCTmgo4wp3qCTxwmikI3lZnD1H7YsQkuQ=;
 b=WMWAL7z/tAk4LeDpxtAwHJzYqf640hrh7UeB1vuULk+5U+/69dUTiFMoosSv7riCoemW3gKGRw/F/m2WYZNflzDaqPNGL/b60xBFPkPlQN5lDheMQOLrrQoR2Auzwf9HhjyxQO24+zTv3ZDN/vN4KfP8gVNcoJVUoXVmsaI6QkM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 PH8PR10MB6669.namprd10.prod.outlook.com (2603:10b6:510:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 16:59:47 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::19f7:e081:85b4:c5df%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 16:59:47 +0000
Message-ID: <9eed00ba-42b7-081e-cfb1-e61a413ccb3a@oracle.com>
Date:   Tue, 15 Nov 2022 10:59:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] scsi/cxgbi/libcxgbi: make sure sg is present before
 calling sg_next()
Content-Language: en-US
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        Nilesh Javali <njavali@marvell.com>, Wu Bo <wubo40@huawei.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, yc-core@yandex-team.ru,
        Varun Prakash <varun@chelsio.com>
References: <20221114150923.3544796-1-d-tatianin@yandex-team.ru>
 <ca3a88b8-da56-d78d-1c01-6d4b4ea6f8d7@oracle.com>
 <84a02b26-392e-994d-bd1f-ecc28231fbfc@yandex-team.ru>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <84a02b26-392e-994d-bd1f-ecc28231fbfc@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:610:4e::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|PH8PR10MB6669:EE_
X-MS-Office365-Filtering-Correlation-Id: a25498fb-a98b-47b7-8a9e-08dac72acd3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /3WZm7ZMloFLEsxvmNZBZqDiqn3sSS2E8ULdghHIVCntoJIvaOFthWGzqbYJFa5Vy3064C8N5xwruxlxVWmWYO/VOnabzQqm+SUkysufQtICKqJc+Yr3eUD8IepeaasXmuv0S8Im2Tp2PUcUWrPBAoUaeOAqcs7WWmA4YKDXip5z3b7DypsUZI+4UZEBXJOf+kbQZeArxvJ2mKlv1fvjSBPcOzZuRaqTUiOAmPjBZobuQ7xisXlwq2j82GY15xlvdlT6dKGAntiijR1wyVLQ9cW/gXzJg8lf6rlXCdT8CBZjT8/wKgxBoEiKnVfy23sQeTcD4jHO+yA+UCAaIt7ttulvUIMPbBpddOPDS1/PKWZGI0Uy3r1RMyovSJ2ZYpg9G7F6FoJc5eqW0FNNUGwFLlrQyL/DMJenC28reM+RrysOToH26Ttt0Dvbs1zbtcA1THQmN3KSAhKP70l+hKWUiAZPWVpJP+566sltgBSQYHJAgf24hqOv6o0PhE+odWzBh5c5KOo9zsApQ4vOUhYWeBCl81Cnwab4Dz79WHkxFi/z6snNVVr0BgEfZmN95BdnbWbFCI3zgomg0l3KN+iUU1f8YwA+qNImjPtw/d0cWmxrB1frMlxxs0+t4ahMiC2c+j/48+DsxtrL3n33dwHeGnYSrcB7fcpKABXgQfD4Hwk3APx49QoquleKe5o5BdUB4GID/miukJfinIvS43k9vgXcEkjS2ORemUWmhx+w1OhFBd4y6i5M1ZYJ9W+2EFrA80sd7GGOrrXiCs9s9Ze64u/KMCsg3vGHebgRd8p6prA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(346002)(39860400002)(366004)(451199015)(2906002)(83380400001)(41300700001)(31696002)(6512007)(86362001)(478600001)(7416002)(186003)(36756003)(38100700002)(6486002)(8936002)(26005)(6506007)(316002)(5660300002)(54906003)(53546011)(110136005)(31686004)(2616005)(8676002)(66476007)(66556008)(66946007)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnVMWU40aFk1SzBleWlQUVJVVEFlUmYyTTJQVitPRjI4Vm5hSjhyU3l5eDlW?=
 =?utf-8?B?eXpveU8rUVg4Y0lQZzNQaEMvWkF3Y0dwOEVHdDlpS3NVaEFxb1NPSXhrWTdK?=
 =?utf-8?B?RnE0SkptYWFad0xMcXp3YzVhUWkvdnRVVUpKYlJ6dmhPRlNTQ1N1UXRFaEhs?=
 =?utf-8?B?ZEVadVBLL2ZXVXpLWWc5dTMvQ0VsNEVNQjFVam5tM2ZscFdoTU1pdkFydWtm?=
 =?utf-8?B?VkFOZVkxN1pvTW5FZzZLY2pkR1MyM3cwSGVmZHJMR3MvNWJGVzJ5cFZncDdt?=
 =?utf-8?B?dVdXMVdQQTNnRXo1aU5SQ2I1ZkVPandyY0ljdytJZWRrWXpGNGxYT2Ewb0Fu?=
 =?utf-8?B?SWgycHpXNDR6R1gvVWpjQnBQYi9jV1o4SDBiMzF5SHB4Y0pSRTlRbXRFeDZm?=
 =?utf-8?B?NnZPTE9uMklsZ2E0R2llK1UzQVgwcjlTRUcwbmtzdS82UXNWM1JwUG14amtm?=
 =?utf-8?B?WHgwZ1dkWVNVZTFoeGdMVU9DQzB0OHp3cHFUbHJoV0gxb0ovY1V6OHBsYjVP?=
 =?utf-8?B?ekpBUzg4MWpma0o4VHRCK2lZbzFTVHNTaXhHVFpFS1RQSEU5aTRNdzVvVG5n?=
 =?utf-8?B?dndidEhDRmVzRTl6TUJ5b05VS1hEYVRRRHZsMXVqZUE2OExQYXhGcnhKalNG?=
 =?utf-8?B?MGtXa1JTM1NBZ3gyMERvcnNnaW0rZmEyREthNnhsd2hFdTBpTUcySGUvamUy?=
 =?utf-8?B?WC9UK0J5SURnclZBUlc1clBoRTlIVkxkeGlrd3FUT3N2QmhScVJVdHhLTDZx?=
 =?utf-8?B?bDRLeWozbnhRajJ1alNEV2Uxa1ZrcVhleDE4TTRwTHJRdTFaTXYycGhVK0k1?=
 =?utf-8?B?TkM3UlM0YlB5eDIxWVIvclEwS0VGaXBURG1taFVVY01yNDR4b3JDdFBUaURu?=
 =?utf-8?B?aW82ZTY5T2VaYU82Y0h3cVR5N1cwNnpzN0lhdnV3Vy8zODN1V3VQZGdsZjJP?=
 =?utf-8?B?Q1JhMGhjcHRVN2s5MHM0bmxuaVB0K2JVZUVOdDdzYW4zcEZHczQ0ckZrM0ZO?=
 =?utf-8?B?c1BKby9aVHg4NzhQcDgrNTdZZjgvYzNRQ001VjFJeFFDQm5jLzBhSXl1OFZQ?=
 =?utf-8?B?THNBaWxVMmNtYTFnQ0R6cHA5WW5MK09GMlBzb3JDOTZEWFB4VnE1bzFOZi9F?=
 =?utf-8?B?aGVMclgwdTdyeUQ4SGUxclE1NkJzMDRsdnUraVFXSzBsM2gzdGJqb3l2U0Q2?=
 =?utf-8?B?WGcxNDdNUEkvMnNmL2c3RVJwdThlNGYvMHBTekNiVDNyZ0xGZ1VZUFJVYWxH?=
 =?utf-8?B?azYxYlVMMHNQbElaamFTV1dpU3RPQ0p4UXpnakdvbm1YMDdCSWxiVUdHc1J5?=
 =?utf-8?B?UDl4MTJOU3MwQU9UWUEvanllbTVPUXQrUldYeXNJWkJ5WVd6bjlFOU5ZeC9Z?=
 =?utf-8?B?K0d0VTR0cDh0aUJndGpaMzRuSUtSRTNIanlkWElSWDAvaVE2UXFVbkhDOVNE?=
 =?utf-8?B?dmpwc1htUXpUb1pmNmRxWThpUnlzRmI0Q2ozTisxUitMd255bUVZclpFZHVV?=
 =?utf-8?B?b0Q5MFFLbzZHcUFBOTBxb1plQjJzY25qYlgrdmlXNjB6MVZzTmpRNkxOc1ps?=
 =?utf-8?B?aWliSkdNTFp5K0owWTVnN0ptd1BZM0V1ZGNTbTN5cm00MUdwMDFKeDh3bkx5?=
 =?utf-8?B?UFpRZktORjVFL3BWK2tNYU9YeFpGcmlVN0lHc0E2TzhHbDNBcUMyZmxXZkZm?=
 =?utf-8?B?WmZPMmN5QlFReTl4eHNnbEFjdTEyZGhSVW9nb0VVazF0R203S01zTEhaUnQ1?=
 =?utf-8?B?WENicXUvZ08wY3h3czlPOWxPWjlIeTN5bWVlN0YwdzV0a3ZuY3FCQzhMU3pV?=
 =?utf-8?B?SFIrZXJJRmdmdFBMK1NlRlQ1Zk9qRGRNeTNDdWcwR3ZRL3lHWGFITHBUcWM5?=
 =?utf-8?B?VFQ2OHptTlVtb0oyQlpsZ2d6d2VKZTVlU21OR0VkRWdFSVZ0dDQ1Vm9mRzNX?=
 =?utf-8?B?RWtwdkwwcVRWZmY5VUlxWVRQL0dPN1M5VnlFWEFua0k2blNzQ29nV0hXWUVC?=
 =?utf-8?B?S0Zwcko1YlpIRzdYYTFUTDNYamRJbW5qWHBoeVVsTmdNWVA4WElMSGU0Vitw?=
 =?utf-8?B?M3l3Z3hmTGdudjRydHNZYkZpTHlRNnlVTlVHREpRcTIvaXAzNlpHTTNxQTZX?=
 =?utf-8?B?UXVNVEVHNndYeXNHMkJxNkFZaUlNQ0JXd0VnSExremhyTnVUYU5ncTE2L3BQ?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dkdZakpGdjUxMHRpYURPZWszS0ZudEd4NUlUSWpBNURjMlFXMU56YVcxSkpX?=
 =?utf-8?B?N0Q5QVU3UnhGQ0lqN252aW1qNU02cEFzTHhYMVlWZWlsS3R1YXpxZGhEaXlp?=
 =?utf-8?B?bWtKY0dVMnNiNWFjTHh1SUVJTWQxRi8xSUdMdFpueXFsQlg1MlVCbDBQekhi?=
 =?utf-8?B?SUszQTZPbFR3c1VJL2xhODRVZDVyTzRvVXFXSnV5aU91SzFqcUNhWHZoYnp6?=
 =?utf-8?B?SjFOTDkyQ01rZnM3dENEb0NaV21SQUlXWjBYQlVmeWJqVnpHR3gxRCsxMTg3?=
 =?utf-8?B?dU5wUzE2VkFTQkZqSWFKNjhoL0VnRy9weEEwM1N5YXU2UHZ5bmt2NXpnTWhq?=
 =?utf-8?B?alRuanhtM0t4a1JPNUs2VVNQQW10Q1hmNzNPVW1IK2J5aWxGVDJDVXVUamda?=
 =?utf-8?B?MU1kS0U2emhSTEl1L3k3b3U3VDU1bS9UbFNBanpveDBhSzZXYlRObDRHRWlh?=
 =?utf-8?B?NGVseHdpYVAyMWV4Q2cvL2Q0cUhIWHJWZHlNaVREVEU2ajNYUTYrNUFLWDlp?=
 =?utf-8?B?R1FBNWl6bHBSa0xXd2hLOEd2cTBGZllEb0RKTzhiYm1SbThUMFd0UnhJNllK?=
 =?utf-8?B?aENVTnZTcnRldXlOZnhORCsyYzN5a2xVQWc4NzRuNGU0bkw5SUhLRHYxSkQ2?=
 =?utf-8?B?ckl4eWRlcW9NMjBUdmVadkpNREtxbzJzN3VVeDVkR242U0p2R1NPK1dVaW9W?=
 =?utf-8?B?YW9lZytwazNPbm5DdXMvSlRVd3lVTGJVUks0N0g2TEl6b1Q3dHdqZFhnYUxi?=
 =?utf-8?B?Ry9hcFlpdEJTVk15YmprK014ek02aStLU2JLUnl5SE1zUmVodjN6Z2JqRDBx?=
 =?utf-8?B?dVRGd2NWdWxGTFhzNVBnaDRUZFI3eU5OWE9GVUp0dFhINkRBS1MyNGZzL3Bz?=
 =?utf-8?B?Q1NGOE9uZzlHdXI2WktOL0pINzJiR25XS3IxMTRnZDVheGZ0THd0QlBGWHFD?=
 =?utf-8?B?UVczT0ZwYTZmcUZ2RW1aOEdjU09laTdRbWpSTWVKV3FHWGdHeE1CNTVxb1R4?=
 =?utf-8?B?OXJIQUZOT3htbVdzZGtwMEZsZWk3d0ZhOHhFNGx6UXE2cXY4RnZITjRYTVlw?=
 =?utf-8?B?L2Y0LzNLWWJFSmJwQlhTL29rNW9LWkdLUUtuOUJtMEVDMlhETmpORjU4aFRr?=
 =?utf-8?B?UUtSL2Jxc2p3SVRVeWkzZFRldERVTmVhUlY1cEVDa1FZN2NzZlJ2Qm1acFdL?=
 =?utf-8?B?Q05JQXhNWjNDV2NSVTZPRjl1dmZNeVFnUk16SjdUTGZZQ0RISDRHZW1HWThl?=
 =?utf-8?B?WkUvODhic3Z2UWFlOXJlUk1XOWVJRXR0cjFXeUJWYjRNRWs4bjNwVFJycUZ2?=
 =?utf-8?B?N2F1YVJhYmZ3elBuekRncjcxUzVDZythYlNLcVJCNzE3cnl0QVQvcFNpeUNu?=
 =?utf-8?B?OVhqT2k2VzNvaDZwV1VBTWxyK3Y3UXVKclUvZjlEOVVnUExwS1Y0QWM5K2tk?=
 =?utf-8?B?WS9JSW5TcWRLWXk4cVlMeXFQb0FBOGJSZnZFZ01nPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a25498fb-a98b-47b7-8a9e-08dac72acd3e
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:59:47.3422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jlSRrOgkrm5yLQLxnaa4k0eIm3Q3uBFqnpmpZC6tOocgq3PaGd43DO6/ZXvHsJSd05eojG8g3It/ZHKL4Lifa+v9+qfN2zuaxiRH+dCyCPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211150115
X-Proofpoint-GUID: pcPBl16TMmebDqqQVftXe_Cm3mixhoOq
X-Proofpoint-ORIG-GUID: pcPBl16TMmebDqqQVftXe_Cm3mixhoOq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing the cxgbi/t maintainer, Varun.

On 11/15/22 2:17 AM, Daniil Tatianin wrote:
> On 11/15/22 1:23 AM, Mike Christie wrote:
>> On 11/14/22 9:09 AM, Daniil Tatianin wrote:
>>> sg_next() dereferences the passed sg, therefore we have to verify that
>>> it's present before calling it.
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with the SVACE
>>> static analysis tool.
>>>
>>> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
>>> ---
>>>   drivers/scsi/cxgbi/libcxgbi.c | 3 +--
>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/scsi/cxgbi/libcxgbi.c b/drivers/scsi/cxgbi/libcxgbi.c
>>> index af281e271f88..2ff9810f42a9 100644
>>> --- a/drivers/scsi/cxgbi/libcxgbi.c
>>> +++ b/drivers/scsi/cxgbi/libcxgbi.c
>>> @@ -1196,8 +1196,7 @@ void cxgbi_ddp_set_one_ppod(struct cxgbi_pagepod *ppod,
>>>         if (offset == len) {
>>>           offset = 0;
>>> -        sg = sg_next(sg);
>>> -        if (sg) {
>>> +        if (sg && (sg = sg_next(sg))) {
>>>               addr = sg_dma_address(sg);
>>>               len = sg_dma_len(sg);
>>>           }
>>
>> Is cxgbit_set_one_ppod the same function but it already has the extra
>> sg check?
> 
> Good catch! Certainly looks that way, albeit with messier indentation.
> 
>> Should it be a libcxgb function in libcxgb_ppm.c?
> 
> That makes sense to me. Should I just move both there?

I think you can move one function with a fix to libcxgb and kill the second one.
Name the new function to cxgb_ddp_set_one_ppod then have cxgbi and cxgbt use it.



