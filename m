Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D662B6A1148
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjBWUfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBWUfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:35:09 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDFF1EBCF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:35:07 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31NHsxea029272;
        Thu, 23 Feb 2023 20:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=Kp1tsRAdjr90PokaGQpBM1E8Psyi13T9ZIEWcsf1s3g6n0x8/i7vn4zPsjY3XtaD+Wvh
 DNUN89CZzZ9SjRAlWOfxB/Oz2lGML1LAR6mItBLqM3+JHeK0mmLUUbBOq4oCFQ8n6zxT
 upC2+FoeS1PaVQCivYt7QqmOjRH6ytS5kZol39/tuqnpd5RRVlv20PKDXOIogy9L5ymR
 DQGd0jFgBhFLueKPlj7iMVu2BrJUiRbBvdEE6u5foAomIUfkdDJFj1pnwsDEIEktBEcI
 j5Afjh+OBvJh6zOSrmB1dEfum108bCxi2Ej/pO866r0rbYuBYGCgO3zrJNs+FYMZ6JG8 4Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnkbug21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 20:34:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31NKBBs0013497;
        Thu, 23 Feb 2023 20:34:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4f5u11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 20:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzu5yYL+Xe4GmnfgwzcAFOCxZf0NKtqWCP+ET9mfF2PPJNEpql0IJdvES6AgZq8fNC4U50dZ20GbIk17Bs7ZXTBg2jsW7jWZsXqqXeC25cFtpGzloSNOQurFpcF+e/OALoY+9406vAUte7muNIWJvljO+9nN9X81eYaDmX9DnqQmz1HdrrCJx3LON+M51/meqNNwm1nPkJC1v72rwkfHOvi3B1MOvVkhEw/EDk+3JLNyxW8oY3Z/p4Gq6zrTo9P6eC91/r1GB/MN46EL/IkoRuCHLr9UxIQwaEWpAAWMJm7sF4QEj8g83x7EpLYSWpPcBs4d9N5hDLt8Kn6vOc49iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=azFU5mPQFXtvfSWyKH/v2Fj51iHcTTAbdkYAA8lqWqAwmJzcomda2OYk6RYaUm8gTXrUTroTnggcd8tYtSO6hEgHR3sVd2wxNCFhsOFZ5FZPR39LWvZrO68dav/jBLtO4ZnJDFv7cnNJRG3gcE4nUFc/HUeJfD/2GDssfQKCm4ZssMlpG34djlAONa6sI0WFXMbVgavdlrQTfuC3I12Xf6rhU+sMXSOz23I7PQO2cDswoN3QjnxMlTKC44cmvxaQosdjMHaDvTHf6J4j8O2au4GA/nAVxADYXYReD8sdJqVil/5MD7anQK6IQyGjrxEPOtJVxHlt46Lzx7XNTcMvrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8WUEhCKi4r7xNZt9LVuweZve2az2dfYF84nR+F3eJE=;
 b=pUSTJ1tCby5p9mDPRGRYi6PtNp8FWYRQVA6zuUvZYzuGlZR5xlmUVIv5Z0+V47E9LGXBl4e1yT70WIfv7FdMBnPIzNOjwuULLcGiRItc35SiFCHWBB/ERTgZZeYg/vKOj3fhRpIh9W4ILtOX2msx0QQDCLxxzWjNUcAYcMsjrSE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB7128.namprd10.prod.outlook.com (2603:10b6:8:dd::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.19; Thu, 23 Feb 2023 20:34:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%7]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 20:34:39 +0000
Message-ID: <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
Date:   Thu, 23 Feb 2023 14:34:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR13CA0111.namprd13.prod.outlook.com
 (2603:10b6:806:24::26) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 3612adf6-f430-4f38-5cb0-08db15dd6283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6DSNjQ2/pZE2A9YCUbsZEaJ4eYLBpAFaH4EsN2QgMUs6HZxDnGLl8wl0fXzvRQiOAxJzcxshCms/L5OPVeyWrhXkCTNNXC9r+J+GxbHD9PPI0C9g8qoJMVVNkSr5JJAY5QQpZnFmUhGXxb+TGxG+t7RNwVYG1qpSUMOby9YyXYfLCHRrXh2k9NSBZ+6CHeA7qHc6pUv9lsgbPKGlG/Y4nz3chDFkqQaD7o6G9gKE6MuyRaGz3Znqevl6HA01vNGM1TbBvzSZjX6ZbY5yVXhq17Ib5XmC/hmCqt3+dRG4Zd1TnbPC1wi5ZN9Y9Y+4IKnZbN68JoFbtp0sfC2CefzOhVgkktLgFS8RD5TbpkFCvWc3/SZl94hFnI3fEOKQO4ekf5ngeYQ3zxAIa/ZnnLPVfXJvRXYmBBaum3HSbFLm5ocLKqr7cfEt8DayT9KziKHI1vycX5tw11ICftnOIeUNus49dWG+gGSqJjqKjn/5qB/d3JLFPWvRtWn+VWt+NjYnhbeWfY6b+JDMmHPF5l9SuPHxCRTeknpMgNvW9rMnfWYYSCkiuSwFpnFJU+6pM/IV3HkzLaw4/Zq9BlqmfTnPVweleJ9v/TscjYkp/Z4bCDot5nJzRrC67W9F03XONfqSCB6Z6kaKfxVm3TUaCJh+063YQCXJi09POqAJwqWSIrTLQvmJRztREZ5sXi+YqbJvQkys8uCFel0GeEJmoCmgyYDX+fo+Qb45neoP0A7kFms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(84040400005)(451199018)(6512007)(316002)(31696002)(86362001)(6486002)(66476007)(110136005)(31686004)(66556008)(2616005)(4326008)(66946007)(6506007)(7416002)(5660300002)(8676002)(41300700001)(53546011)(107886003)(6666004)(478600001)(186003)(36756003)(8936002)(38100700002)(2906002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXZ6ZkVIYU9lWDVFZWM3TURXeloxbk5YL2Q3NjlZN24xcnNENGU4a1dyWTRv?=
 =?utf-8?B?b2dFSnFWT1ZVdGtITGNTYThlWm9LYjhTblBmcXBwRW0xQTJiNkVvWTgyMlpK?=
 =?utf-8?B?NFZnWkx2YnlFYlJlVFFXbHNiUGI5MXkyVmIrbnNmUGtCT0NuRUZsWitlUWpl?=
 =?utf-8?B?NnY4Q0UrQkdpemRsVGZWZlAyQlFhYjc5R1FYRDRoa1V4a0hnYWlGYXNwcTZX?=
 =?utf-8?B?eEdzVkJydTBaSThoQnlhYXR0UVlBRy92OTJ0ME1hKzVuUTkxdGNZYnhtanBO?=
 =?utf-8?B?Qk9BZzV6dTJndDU3cDJBMWUwbUYvQTNuMTQzTWplN1hzUUJoZHJ4cW9tRG41?=
 =?utf-8?B?SmFtVHFGSlB6dHZ0djdyMzRmMTJLcWVMTUFLK2xJY1Z5d1ZTQjZZUWtkM1pF?=
 =?utf-8?B?d2tPV2p4eXV0TmUwVkRwU001OWZYbXhTV3JpQjQxSnIzcGRXWXpaV2I3a1Br?=
 =?utf-8?B?RHJPOHRMVnEydWVsbWlMdytuZEdaUy9udUUyQklieGlQdEV2NE0wdTNVbkI2?=
 =?utf-8?B?WHpxRUhUc3NNNVMvQklkanA4L2QrV0JLUjRScEwzRnNDaTVUbkNvNE1vT0t5?=
 =?utf-8?B?dTJ4UFdPeGhiaENUbzRnelN3SXUyL1UvQTVBYzBtSHQ1MFdxVWN6Z0YzNy8y?=
 =?utf-8?B?RE01dFd4cTBRU1l2ZUVWKy85N2FieSttdnZwUmljVWZWQ2MxSU5QZmk2K0h2?=
 =?utf-8?B?Q2ZPdzJLRmpEVE8rV2hJVDluTTFBWHZ6T21BV1VjWXgrTXo3VDhCYTl1SVJQ?=
 =?utf-8?B?a2VuMTBRM3VIODA1WEJOODl1ZmZ4UFF2WTlsYnZDVDMzVVpCYXdHY3pjZTZW?=
 =?utf-8?B?cmtwWlgyWDhGY2Qza1B0YU5TY2Y0WnQvWmNsWVU3Y3RoUTNYbm5IRnpKc1J3?=
 =?utf-8?B?V1JxeXFRL2JMKzBrbUxZejNmNkdFYjVOLzYxRjJMVUdQUUV2b29yTU4vQlp5?=
 =?utf-8?B?S0JNV1ZScjdsWEV5WmlCU2o4ZUp5Ny9DWW5mbmFIZXBMWTN3UGdBTzdkY1R1?=
 =?utf-8?B?VmcwclY0L245dUcrUzBKTzZHbmcxMitlTU83b1JKSDVDQi9RelFTR0VJZjNV?=
 =?utf-8?B?V0hUaDd3QkV6ZnY4Y3hOWHEyUHA1aWNGYU9KVEFBdUppdUplYUIvQ3dxMVRw?=
 =?utf-8?B?ZmtuTjB3T3J3WG5KbE94cWcxdHFaNk9CSExQRUpOK1FOeUVTaWFuVGlvdFBU?=
 =?utf-8?B?Mmh1VWp6U0t6NVV2bmhLK01uZ0x4MWFNQ1FCbDdrM3NzTjg1Q0pGL3lES0U4?=
 =?utf-8?B?ZlZqQTMySjE5R0tSYWR2cEVqY1owZXhZUFRHREREUDlCc2JiSW5LTU1jbjJr?=
 =?utf-8?B?RWtMSlJnelpzaEo5SlBneS9SeGxPTTBLSmxWQ1o3Y3U3UWVDNjlGMGNBclAr?=
 =?utf-8?B?cmU5OTJpOXZxUkhnL3Jvc05CNkZ3L0M5UXRxalJLR2FMM1VYRlNFTjNmNFdV?=
 =?utf-8?B?aVI5aUFHRmxkM25DZ1lPZUJzcytJaUpZL2U0MnlVUVVxcUw3eC9IcittNFJ0?=
 =?utf-8?B?WDJsWEpabzcydGdSQ2Q0eXpLVml1dlFlM0hRZU4vWkpVVFMvSnRUYzF0UDJE?=
 =?utf-8?B?USs1WTV5a3AyZEVOUUxrM0NieDJHVjNra3VsL1FOVGdVVWtzMUNsV1dDMmho?=
 =?utf-8?B?dTlWQTlLTHNGTWVnWVJwVzBWdnZNSTMrNjVhOEs5V05VcDd2OW16eklnOWJq?=
 =?utf-8?B?U29UWkcrT0Y3MzVhR3lNYWFmbHp0SWRJUGh1RUdlNWU0TmxESjNVS0FmdzB1?=
 =?utf-8?B?TVlxa1EvdTcrUmowL0RLc1FGamFBZGFmSUxPdFIyWFFuZUVCOUtZMUpmRmk1?=
 =?utf-8?B?a1UvaG9zWG1XVVlHcHQyVE1jTGd4WmFWMCswdnZ4enl5YWpGc0tWNHBoZDdI?=
 =?utf-8?B?TThLSUZzWTR6TFNMZXdPZGlJT2QrS1BhMXdUdmhQeTdndm52YmRONENMOG5H?=
 =?utf-8?B?Y1BHMkZPOE45UTI4TFNDa2ppeUFyd055QWo0ZUNDSGZPdU1XV0FXZyt2Z3Bv?=
 =?utf-8?B?WFdqR0NLTDVJVHlmekRIcTVoSlplcVBsK0NyV25tWXpQSE1aRmUxVnVyMFVE?=
 =?utf-8?B?YjJaQkNOUmRNWGcvRVZjTjR1RE5DQUJIZjhSZUhXd0ZFdGZPaktERDJYNVpj?=
 =?utf-8?B?TE1pNkNNeFhVRDJkZGRMa3BtUm9abmI0ci9uVzdJekxITXJXT3J6Unlldk13?=
 =?utf-8?Q?6LnoMw61zprnx7bbDaQdezk=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UWF3WDk4Qkh2K0VubGlRZjZoS3FudG1WSlRqOHpHNzAxTWlQMy9td1ltQ0dx?=
 =?utf-8?B?S2ttVnlDVHlleUJEdndVUXM5YkYwMU4vZTIzVWVBYVc3UGpoU0dua3Y3eWpF?=
 =?utf-8?B?WS9QSnBqUExWOEFMMHdmRC8wOE1tQ2JrandadjVLQ0w1cEdYTHhzaHhMTWxq?=
 =?utf-8?B?aWxjTXFYOEI0M1RQbE50UE5aNHQ0bFZiVXptVG14bEZHS1o2Ti9talpPRDNZ?=
 =?utf-8?B?VTltL0dTT2lwTC9iMGtHNUwvbEZjWklDNmI4YThjZ01wWXNVUlJJd3RzRmh0?=
 =?utf-8?B?eUgvSTcrRUM5OG9iWlludTJub1BmM3d0MVlMR0JKd2NrTGcvbzJ0RUd0UzF6?=
 =?utf-8?B?NHVvYm0zWmpGSlVwSUwyY1RBNTNudUxSVzl4Ly9WOVVXdlVpNHhVcHdlSm5O?=
 =?utf-8?B?NW5XUDVSRm82akJTVHBSR1R0SUk0NllkTm1rTVZJdkVxQ1hGcG4wOFJzZFhy?=
 =?utf-8?B?dUk2QU1JU1YvUldPZksvQ0ZRdXZ0VHMvV3VtNkpLYW5nVFg0VEc5d1JSL1lj?=
 =?utf-8?B?eGpwUEJjMnZsL3BUdWhrNE53OGE2VHpvN0tqMS82VW1rcTVzYVNaaVhhM3VV?=
 =?utf-8?B?c294VU1ZaGhqaTgzWWRlcStoa2F2dkpBSkd1U0E0ZDRnOUl2SXVCWEwzUk40?=
 =?utf-8?B?a0hJZ2d1eWRoc3BWaWZsaEYxMHVqK3pTL3IwZEVQU2VBRkZHTjVnK2hRZy9R?=
 =?utf-8?B?dytGUGwvOFNzajNycVFqdkJZdzh2b2wxUzFQUVpaVVhVcFhwYUY4TFZ5aTRB?=
 =?utf-8?B?YkxWQ0RYclVYOExQbWtzV2p0anMycUMxT2lyTy9lY3Q0QlZsYUNaNVNrWTFy?=
 =?utf-8?B?bmZXcklUT1d0YmtoSDZEK0xNUUJ0b1JPcWpiNkxnMkFjUUQ1dVVJVlI5Mk9u?=
 =?utf-8?B?eVZGZXhPQk1VWG5FdlpGQlFoaG9tRUtwdVdWeHdveWJZdldVVXRUSzN5ZHd6?=
 =?utf-8?B?WVMwOHNqSENWZTNRd1lmTCtrckpvTmUwSmZBbkxGOWhmSmlWTGtMQzRZTWR1?=
 =?utf-8?B?WHZFRmhzVXNVUUdraFE4NE9YYWFaUjVOcjlkRExmaGRrek1pM2pSblVNYjdI?=
 =?utf-8?B?T1BGQVJKMHlBUHgxZ1dmQmkwaFVBQUNUUm5UNlU3SWMwWlVBUlpMaStGcXlp?=
 =?utf-8?B?cFFFZUJWSWdnWGxNbHk0ek4wcCtuYkU5djlIblBUdWp6YUJNRjhVcGd0dGVi?=
 =?utf-8?B?Vkx3NjVvQkRyWGJxTFNPR3R3MVU2aUtGek5qYjZ2R2VLek5TSXZaTmRXRDNX?=
 =?utf-8?B?Wno0R2VXUkJzM0d1Z2JKSGJwN0xCREZhTmQ3K1JUQzd4bjBkaHFyeHZwRDFI?=
 =?utf-8?B?cnNLK3NZeU9odWZhYmUrUEhjV1A1eThDY3kvdFltRlhDbkt5VGZCaHdZUWdm?=
 =?utf-8?B?enVGck5XUjhwMHZvNlI5Q1AvQndXRFp4MlFjbkdNYmFzQS9IT1FYdmI4Z2lE?=
 =?utf-8?B?T3Bzdy95N2dPWXZyZHZodWRIQThGU2ZYRlBrVUc2aldqOEtON1pPZUxVY0E4?=
 =?utf-8?B?WVFQU3lLNTRzd3V1aUptcmZWS3hoOTh4SUh2Qjk2RzVtaURDR29zUWVNd1N1?=
 =?utf-8?Q?tAtv/nzcRSiQv7k4MYXxeNi5E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3612adf6-f430-4f38-5cb0-08db15dd6283
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 20:34:39.0757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 38LaFpeEcBr+r0n7BeA9cDzpuF69vidJfYfw/1DGh4sUQ11KLMDpFKW4kkyHaeR3zcdedBDIGZksRG3jzPAhqV+jqIiQBTMF1nlMwV26jD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_13,2023-02-23_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302230169
X-Proofpoint-GUID: G98Qbz0QT-L8jkxDrHkM3yMdTNsxD9Xe
X-Proofpoint-ORIG-GUID: G98Qbz0QT-L8jkxDrHkM3yMdTNsxD9Xe
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/23 00:29, Sourabh Jain wrote:
> 
> On 10/02/23 01:09, Eric DeVolder wrote:
>>
>>
>> On 2/9/23 12:43, Sourabh Jain wrote:
>>> Hello Eric,
>>>
>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>> Eric!
>>>>>
>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>
>>>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>>>
>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>>>> this state as the callback for the .startup method.
>>>>>>
>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>>>> registered on this state as the callback for the .teardown method.
>>>>>
>>>>> TBH, that's still overengineered. Something like this:
>>>>>
>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>> {
>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>
>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>> }
>>>>>
>>>>> and use this to query the actual state at crash time. That spares all
>>>>> those callback heuristics.
>>>>>
>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>>>> to for_each_online_cpu().
>>>>>
>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>
>>>>> Thanks,
>>>>>
>>>>>          tglx
>>>>>
>>>>>
>>>>
>>>> Thomas,
>>>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>>>
>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>>>
>>>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>>>   for sadump method).
>>>>
>>>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>
>>>> With this understanding, I did some testing. Perhaps the most telling test was that I
>>>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>>>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>>>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>>>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>
>>>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>>>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>>>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>>>> that might rely on the ELF info?)
>>>>
>>>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>>>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>>>> online/offline.
>>>>
>>>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>>>> be a compelling need to accurately track whether the cpu went online/offline for the
>>>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>>>> kernel data structures, not the elfcorehdr.
>>>>
>>>> I think this is what Sourabh has known and has been advocating for an optimization
>>>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>>>> structs are all laid out). I do think it best to leave that as an arch choice.
>>>
>>> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
>>> makedumpfile, and crash tool I need your opinion on this:
>>>
>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
>> Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
>> number of cpu PT_NOTEs (as the cpus are still present).
>>
>>>
>>>  From what I understood, crash notes are prepared for possible CPUs as system boots and
>>> could be used to create a PT_NOTE section for each possible CPU while generating the elfcorehdr
>>> during the kdump kernel load.
>>>
>>> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
>>> regenerate it for CPU hotplug events. Or do we?
>>
>> For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
>> for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
>> caveat here of course is that if crash utility is the only coredump analyzer of concern,
>> then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.
>>
>> Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
>> any of this.
>>
>> Perhaps the one item that might help here is to distinguish between actual hot un/plug of
>> cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
>> event and an online event (and unplug/offline). If those were distinguishable, then we
>> could only regenerate on un/plug events.
>>
>> Or perhaps moving to for_each_possible_cpu() is the better choice?
> 
> Yes, because once elfcorehdr is built with possible CPUs we don't have to worry about
> hot[un]plug case.
> 
> Here is my view on how things should be handled if a core-dump analyzer is dependent on
> elfcorehdr PT_NOTEs to find online/offline CPUs.
> 
> A PT_NOTE in elfcorehdr holds the address of the corresponding crash notes (kernel has
> one crash note per CPU for every possible CPU). Though the crash notes are allocated
> during the boot time they are populated when the system is on the crash path.
> 
> This is how crash notes are populated on PowerPC and I am expecting it would be something
> similar on other architectures too.
> 
> The crashing CPU sends IPI to every other online CPU with a callback function that updates the
> crash notes of that specific CPU. Once the IPI completes the crashing CPU updates its own crash
> note and proceeds further.
> 
> The crash notes of CPUs remain uninitialized if the CPUs were offline or hot unplugged at the time
> system crash. The core-dump analyzer should be able to identify [un]/initialized crash notes
> and display the information accordingly.
> 
> Thoughts?
> 
> - Sourabh

I've been examining what it would mean to move to for_each_possible_cpu() in 
crash_prepare_elf64_headers(). I think it means:

- Changing for_each_present_cpu() to for_each_possible_cpu() in crash_prepare_elf64_headers().
- For kexec_load() syscall path, rewrite the incoming/supplied elfcorehdr immediately on the load 
with the elfcorehdr generated by crash_prepare_elf64_headers().
- Eliminate/remove the cpuhp machinery for handling crash hotplug events.

This would then setup PT_NOTEs for all possible cpus, which should in theory accommodate crash 
analyzers that rely on ELF PT_NOTEs for crash_notes.

If staying with for_each_present_cpu() is ultimately decided, then I think leaving the cpuhp 
machinery in place and each arch could decide how to handle crash cpu hotplug events. The overhead 
for doing this is very minimal, and the events are likely very infrequent.

No matter which is decided, to support crash hotplug for kexec_load still requires changes to the 
userspace kexec-tools utility (for excluding the elfcorehdr from the purgatory hash, and providing 
an appropriately sized elfcorehdr buffer).

I know Sourabh votes for for_each_possible_cpu(), Thomas/Boris/Baoquan/others, I'd appreciate your 
opinion/insight here!

Thanks!
eric
