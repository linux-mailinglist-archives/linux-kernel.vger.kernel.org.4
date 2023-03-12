Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC636B62BD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjCLBsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 20:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCLBsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 20:48:36 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D1B2A9BF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 17:48:34 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32C0vOwN031898;
        Sun, 12 Mar 2023 01:48:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1j0mGnrnfj+dP5n5Za/CRBYPjLylxRlO98Wu+O9UJog=;
 b=2N6tjDpBHHKvZlgCBPejRXfXNgistdQR12wtK5cuJCWxaVV/VBMJmKiHncRA1j1Nr6+O
 f4Y/FASSbatXc9jjIqW9fxStT2C2cL+iPBCGM6t+RwN1Qlf2oU9QTvCzAbpHoTY/WqCv
 CkI+Qttzgl3bAnmoW0D/F9/KpqzmXp5DkyAm1Ui5I13rXXRCvDdxwVrqiZKh3SrpU2i2
 R4hpF9+e9vseavW+aLEUTU1UPJ1DXLd/Qwbae7Q9SFmel7/YHL6yHHZ8+nrGkp6a1t3n
 N7gh2bmcfYae34454mfh9begzhrOVfuJENA6MAVXspMzV8VNXJTd2Rx96KQZJUf4dv5G Gw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p8hha8t60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 01:48:19 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32BLA4Vl008160;
        Sun, 12 Mar 2023 01:48:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p8g337bh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 12 Mar 2023 01:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nx2OVvXShOXPazvP5ctttMyXwxkucJaJJ6zBMg+3jjAlodwDGvFB+E7s6ObPT3Z3vlTBk8niBJJluO3Uum9QKTxK+1cQIERAXaStt+w8nMl09J2AWGiCK5wmiZ1eUy0TvWAB4HO8ZjTOAk+iZSxlZ2lsoVe5i+eRx/k/lTlW4fCJ3JX3VoBcTwW+trCnOxaAlGchgC0F959moRSe/QT3zLRmV/N7d6WmL1AGcqJ8DKa8Y0LhJ0t5MgW9n2g/t+InOu9QHI4igy1qM9BTsTwkSHLlnQqxJCyGFfjpjtJoy0A4mdpVuuQXn/98wRgaPXipfeL+gtK2f/rk6YdUJPhV1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1j0mGnrnfj+dP5n5Za/CRBYPjLylxRlO98Wu+O9UJog=;
 b=Tuevks7fQ/8/6RDCv16s9KZsjLFGVXCmaQJ+S6uEEV1tffjkI798u/97MvSY6ANwFVBgSTXT5GHodPStc+swt+eaYO4PJn+497nLRdS3LuF8efnBKQ1r2o6deV4rIz8l2ZpGs55BNJNkNe5dLHQqz30wcU3ssqPBl2n9UkjYPtjqVys6o8GU8jikLw1Eb7NFXRA1doFw5Uh2FOZUuA9OV2dhEzilajA8bzIIKWXQBwTEMkuj8s9VGU+RkJVstvXKrUcVxz+wVpJ+Q8xmRzZkeyOUmqcJvuc9TEXm49BRwnUvIZZ69M+G++3gpLmthZCp6hlYGNELKIbtYs1PjaHumw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1j0mGnrnfj+dP5n5Za/CRBYPjLylxRlO98Wu+O9UJog=;
 b=LUsFflbvnDlxgiqME3QBi1YzldRWzqpENtGV1f2uBbr+5N8BSW/HlJTHbvRl2EVt2ffanwbkOb2IhDlcooFleW3gu/ReImpgJ8SL+R53qzJBSAFkHGxTeSnjA1k4fhNZu3AvM7SLx5arA4OvSAbvY0A/mV4gUt/EupAmd14aSfs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SA2PR10MB4507.namprd10.prod.outlook.com (2603:10b6:806:119::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.18; Sun, 12 Mar
 2023 01:48:04 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::7dd7:8d22:104:8d64%7]) with mapi id 15.20.6178.024; Sun, 12 Mar 2023
 01:48:04 +0000
Message-ID: <253eda66-b866-c233-335f-ff820e7ad2b2@oracle.com>
Date:   Sat, 11 Mar 2023 19:48:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 03/11] kthread: Pass in the thread's name during creation
From:   Mike Christie <michael.christie@oracle.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org, ebiederm@xmission.com,
        torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org
References: <20230310220332.5309-1-michael.christie@oracle.com>
 <20230310220332.5309-4-michael.christie@oracle.com>
 <20230311085326.m7aub5duy76hnnam@wittgenstein>
 <74a17cb6-9dcd-749b-5d06-b2c364d36ae2@oracle.com>
Content-Language: en-US
In-Reply-To: <74a17cb6-9dcd-749b-5d06-b2c364d36ae2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::6) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SA2PR10MB4507:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa02a63-7df2-4b71-fd70-08db229bd1de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LW1IcU2qZ/HGT5VprT/762mAfcxq1FLrPjE3QqmVS2U3ZoeaOKFMqKN31j0OaMobIX/d5vlCC71yUCbnUgz00b7H2Aa6fhxtQwTKUkPm3m/JyeTn/F6sBmenr1AT33rbo5rmT7bEhVMmkJLfQpNVKkmKfIwG+Q9st/JfSs+JNXrJy1FGTRuP0GXTxR0RM6JS/mUFuXuAvy6+zBWbeNErVwfcNnvMycksAd4DPnSoQN3uYlZr78LbhhnP1neoJ+FaWAbPq/dF0qwmfRVWSok+QrayKoCmOJsAiQAHTA4SFo5wrSNbR7WBKwoSwUgIkAQOIMqn13N8+sIJGslM0Wn5gQ0cVzgZPhAW+FwkDGTLzS3WRfOdNy1G2cJ2waw3qW5YYCPmOSXxtv0W/ycg4QawOqy8jvdDqlj6Eht1VyuDq8ejhocpVWixR7KruZ/Q941NGU4nj0Gg/i7lCzht5WIPc0o5mWWVNldX77Cz4b93WstZW7oP14pV3/8hdgtNWVqsYBCyT5HQ7vZwmE4NVZO0smAk4UZ6TzrnQHdpZxFuqWlqZqf1jRvH1my6h9uviKSNYm6kJOh+rpOt0I8JqbI6ztHi9hGCP4951H1r0bC1GcR0zU6p8Hn4QxxHUiXcH1Y0mjQC9ecx86/J22Y9iXHQ8bhNd8y+Tt18eHozYB3zXv1DzejbXNn5ygk6AH/jWYGKfUJXWOeL7QmgSgCo7Uu77YfIFGYIsjw2AlPI2BmnBPw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(136003)(346002)(396003)(39860400002)(451199018)(66946007)(31696002)(6916009)(2616005)(66556008)(31686004)(8676002)(66476007)(4326008)(41300700001)(316002)(38100700002)(6486002)(86362001)(8936002)(36756003)(5660300002)(478600001)(7416002)(83380400001)(53546011)(6506007)(186003)(6512007)(2906002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21CMlhnTitwMUN6TEl4NkZjZnRFNlFpUUJORG84ODhzUmQ0dDBVM0hjWDEw?=
 =?utf-8?B?bzVwOXJZV1FyV3dtWS9ZSTlacmpBWk1GcGVLUytPR0c5SUdlT3pxNnBmaXBw?=
 =?utf-8?B?bTRFUng0MVRJRjViajlZUHNiL0hnRE40ZXlRQ0MycHB6SVFpbmdzUkxPZGhP?=
 =?utf-8?B?dlVWTXVJVGtoc3Byb05ObVFOeUVJbjFrQm9FYjZ5enZraVJBV3dLM3kvL1BX?=
 =?utf-8?B?QlQ0UW8zYzQ3UVVmbytaTkY0UTlIUWFEQ3BrMzljR0IydVNYek1PQytrU0tL?=
 =?utf-8?B?enJvRGl6TUpUeThJUDhvMGR3Vy8vdng3Mmpxd0dGaEJZZ3JCcFE2US9VNUxQ?=
 =?utf-8?B?TGlBYjZwWUl3NGdnYlVEeGNHOFFkZ1lLR1UzN2lRTTNpb1lzcTFFS3ZJaktT?=
 =?utf-8?B?bmxRZDdWcXp6Rm9JOHNpcWhFZkI0emcvU1dJNVRGNUQ5bTB0cjg4L1ZIR3M2?=
 =?utf-8?B?cFpYZUNwOGFYdTgzQ2xLTVhmNDNheFNWVjQwRTA2WHVZT0ZDM2dScUxoUnBt?=
 =?utf-8?B?QlpBeVF6bytqYlJXRFlNeEFkc3J6ejlsYVc5YXludkZyWTFwNjR5YmxoZ3hP?=
 =?utf-8?B?RGNORG56Z3g4b25QZWs1SkRIaFdmOXpUL0tqZGtsM3JtZENpenBLQ2c2RDAx?=
 =?utf-8?B?Z0VhSWQyZE8vRUZsS3hHRjZ4ZHBabGZSZkdKVzhPN3czQ0dJNFpsbTFhZ1Rv?=
 =?utf-8?B?VFM5MTlKU2IxeityaVdNVnpzK09nVDVzQUV5cENnOUlnTzJhVmNXYlNPVGU2?=
 =?utf-8?B?eSttTDlZVitUQ3VOR0hKcW5ETDJwS0ZxUEk5Sm1qSU9pS09uRzJORjdsMENs?=
 =?utf-8?B?clgybjRFQnU2YjRKcWowYVJtUExFWWc5K2g3bHdLNnArdlh1SzRVRnhna1VG?=
 =?utf-8?B?b2lqZWd2ai9lSDFaTnA1U01SUld0d2g1M3BJb3dmekpGVXE2OVJMOFEzWktZ?=
 =?utf-8?B?NzhCcmtNcTExQllFb3A2ZzAwc2s2SDFaTkNIdWRlOUdMQVBmWTJnUWt3OXE2?=
 =?utf-8?B?NVRSZ2MwVTczTFVxWmNjQk9aK0pIUFNCVVhRd05RaUJYSUZHbGdyOUlKYk5r?=
 =?utf-8?B?UnVCNGdPY3d3bnNHTm9paDlHdjdQMWRCT2M3ZjlWeFd4UHZ3SDhlV2EybHY4?=
 =?utf-8?B?RGU4N0pDbVlrcGVoa3VQejFoeGdKOFptakluNlREUElub1p3Y3ppelVuc1Ra?=
 =?utf-8?B?a2FmSmptTVd0MUUzR01adzNuaUJJZVN2L3BhK2RkcG9qMlVPYWFsa2RKU3Fn?=
 =?utf-8?B?MlRGSWJjWk5XTzB1UnhmbkFLWnE5WmhRbmYxa25CeE95QmJlbGFYU1NUYktC?=
 =?utf-8?B?M0F4T1lMKzU5YWsrTmhJbjlQbXBFSXRvS29aS0xtblVKa2pqaFl4c1h2M2k1?=
 =?utf-8?B?a3FtbGhnRHNSV2d4aEVrRUEvMXI2dkZOMC81anlPS3JZK1oxS1lPSXFWeit6?=
 =?utf-8?B?N2xUZ3hVa1c2ekFGS1NXc0hnN0hRTGtKSktocFJxNkNrdlRDL2NvV29CblR6?=
 =?utf-8?B?T0VobEJQelErU2VROUpqUE1VbEhyWEt6bE9mVWNRL0Y4R3pZTkxMUVEzY05a?=
 =?utf-8?B?S1lIS25UYnMyeXM0WVhCQlVVOVFTUkVFU2Q4Sk12aVlsUDYvUC9EL3BiTGVr?=
 =?utf-8?B?NE1Oa0txMzIxZjBLV04rTU9vbU5MSEdXRFRFUFlpVGlhYVNHcjlSZG01WVNI?=
 =?utf-8?B?QkJpekIzVzFtanU2YlAreGs2MmVhckpFcXZ6cFl6a0xMVCtSaGFjeGNHVHRV?=
 =?utf-8?B?ZExBaUdyazNVaG5vVTFoZkpJZlF0bnF4TE9uUW5vQ083TkVqWmdjcjFLN0th?=
 =?utf-8?B?UnhUR3QxOTUxMHlJSFcycVhyc2VialVBYlpsU2VGQjJvYmZNZExhTW85Sk9F?=
 =?utf-8?B?Mk1EbzhMZy85Z0MxZXd0S25teHJoRnZXK293T0xiT1hqOW5FS2YzZ2krQk1H?=
 =?utf-8?B?ZzdmVS9hZDlxNTFEUDNLenRHdWppQXpzSFhnMDN0NE5PWjE0RlFCSzhDUGpn?=
 =?utf-8?B?UmRaS1ZvOFNOMzhEeXRzeHFuUkU0K2NtdzJVUjNnWlNuT1U2YWVqVGVqa0JG?=
 =?utf-8?B?MmtndEtQY1dVWVdCdHNqSkJIaHRGMlJmT1BZQTFIR2FaUGxLYmo1TXVIQWtt?=
 =?utf-8?B?QXZhZnBFQzhteDc2WGxxOFh4ajlYQzZLRVg2UEhIZEpJdFhxWS92NlNzNnEy?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YW5qSXB2UXM2ZEl1ZFN0RGVaM01OKysrMjAyVTZ2VDhPejVDM2hKdDVEU2lQ?=
 =?utf-8?B?MTVtUEVuOTk4ZjFHWnFZL0FpeUxDTUNDNlRaU3hOVDFBRWhkODVUNkF2L1hv?=
 =?utf-8?B?a3JVQnd4U2ZiMHpRWlhvaUJBSjhhY2k1TXI1SFoyUll0d1JHSStmMkQwdEZN?=
 =?utf-8?B?ancvZVVEdnZnVmFQQjFnYzd0cS9NRVJveVdsK0wwRG5pbVV2bi83QzZtRmdu?=
 =?utf-8?B?QktFaVZCVU56aGlaUDUvditnQWp1bU1EZUg1SmhZWVQvcXkyc3NIeEpreE52?=
 =?utf-8?B?UHduT1NjZUxwdzlOYkdZaUFlV2tLR3JUeXdZbDlTZlZpbStXRzZ4Z2ErSUMv?=
 =?utf-8?B?V2tuZExrMk1TVlhHaXBQcEMyS1dxYTBKUEVpcWhlR3UrK0EvUmFYZGZDVVZu?=
 =?utf-8?B?RzFrS2Y4SXFNTk5zdm5sWnE4MENHUXVQam1zYk1RSTlLRU8xZ0Rpa0dpSS9Y?=
 =?utf-8?B?QVMwNmVZVFNuMWhJVGYyYk83QjRUdTFmKytqOFFsakloY0liQ2dUUU9QMWta?=
 =?utf-8?B?TGk4WWZJbTZOS0Z3QWFXUzRyc29IOHg2NjZpTUpkeHJkOHZ0bktKcW5tcGdN?=
 =?utf-8?B?cWVFUjFZaUhReTBXZTkvTk5IRklPYU4xQk9OcXZIbllkMWZCdWNURy84MDlw?=
 =?utf-8?B?dTJIUTlLMlg2c1FFYTdwVkF1RUU4NjVZeGNySTl6Qy9kSThnKzF0L2JHbjFQ?=
 =?utf-8?B?cDhOWitPdkRIdENwZFJwajZLejV1SHp4bFpFSmtUUHVsRlhacU1TRjNtK0p0?=
 =?utf-8?B?RUp4OWNFMlIybE54eDZ3dE8yK2pIeTlxVlBTZWpQTnVyYVRvSlZLR041dnlH?=
 =?utf-8?B?aGxBWVdFcWttVTNZMFhKR2pHVHRRNGtSdzRnZnVxdmVRQ055eHZwejJUQ1kx?=
 =?utf-8?B?dWpJUnVUOC9ZK0d1RXk3VXVUM1ZYWGo0bXI3ZlYvQ0xnQW5vZms2cmk5dlRR?=
 =?utf-8?B?aXgvdy9pNmpzQVVHNGlVNjVtTDNodmI0KzdLSjZqekdla1loTnR3UENScGhu?=
 =?utf-8?B?eWlha0dzdzdEajNoUkVSMEx2T0tJRVVJSmh0WlNhdFNjRThwQ2VWd2hyWjJC?=
 =?utf-8?B?Mmw0YytJQVRCYjJNaUM4THBkV3piNUN3SlBnUnRJQXIxWlpJYmF1K1pIM3BV?=
 =?utf-8?B?Rk1pSHg3YlhyQkNsU3BzU0IzOFVHdC9CYnByeDU5b1FheUhUL0VjWklqazVE?=
 =?utf-8?B?Sk5xKzQ5REJSOFVWWHJRZHdGRm0zVkZ3U0htWTUyZWI3U0FnSVJOTU4vR21h?=
 =?utf-8?B?YzhmckZVRDh4U204RUpwS2Q1Q09NLzNWRVd4c1QrdjZ5VGlyQWV2a0VCZElr?=
 =?utf-8?B?SEltVTJLMUpRWjlxUWU1UDhNbFdqOWJCK3BWWC9VeTM4MGZLRWVRRzNJU1Ex?=
 =?utf-8?B?Q1A4cFM3OVdKSkE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa02a63-7df2-4b71-fd70-08db229bd1de
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2023 01:48:04.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3mraN96qZ1THxsAWl8OQXAB3SgoQNyAUTT6admD1ddesGBmtsexSRqu1Nm1XHp/bGtvO83uGUc/FWGpsAl87RN3QQU3l0pZEAJFlZPfS00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-11_04,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303120014
X-Proofpoint-GUID: 4frQvg8Pg4WyeB1SetTZhWej0dczfXUq
X-Proofpoint-ORIG-GUID: 4frQvg8Pg4WyeB1SetTZhWej0dczfXUq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 10:11 AM, michael.christie@oracle.com wrote:
> On 3/11/23 2:53 AM, Christian Brauner wrote:
>> On Fri, Mar 10, 2023 at 04:03:24PM -0600, Mike Christie wrote:
>>> This has us pass in the thread's name during creation in kernel_thread.
>>>
>>> Signed-off-by: Mike Christie <michael.christie@oracle.com>
>>> ---
>>>  kernel/kthread.c | 35 ++++++++++++++---------------------
>>>  1 file changed, 14 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/kernel/kthread.c b/kernel/kthread.c
>>> index 63574cee925e..831a55b406d8 100644
>>> --- a/kernel/kthread.c
>>> +++ b/kernel/kthread.c
>>> @@ -38,6 +38,7 @@ struct task_struct *kthreadd_task;
>>>  struct kthread_create_info
>>>  {
>>>  	/* Information passed to kthread() from kthreadd. */
>>> +	char *full_name;
>>>  	int (*threadfn)(void *data);
>>>  	void *data;
>>>  	int node;
>>> @@ -343,10 +344,15 @@ static int kthread(void *_create)
>>>  	/* Release the structure when caller killed by a fatal signal. */
>>>  	done = xchg(&create->done, NULL);
>>>  	if (!done) {
>>> +		kfree(create->full_name);
>>>  		kfree(create);
>>>  		kthread_exit(-EINTR);
>>>  	}
>>>  
>>> +	if (strlen(create->full_name) >= TASK_COMM_LEN)
>>> +		self->full_name = create->full_name;
>>> +	else
>>> +		kfree(create->full_name);
>>
>> This is monir but wwiw, this looks suspicious when reading it without
>> more context. It took me a while to see that kthread->full_name is
>> intended to store the untruncated name only if truncation actually needs
>> to happen. So either we should always initialize this or we should add a
>> comment. You can just send a tiny patch that I can fold into this one so
>> you don't have to resend the whole series...

Hey Christian, here is a patch you can fold into the original. Thanks
for your help.


From ac82986ec4e7faae245ec48cb9213a4ca1c1d4d6 Mon Sep 17 00:00:00 2001
From: Mike Christie <michael.christie@oracle.com>
Date: Sat, 11 Mar 2023 16:14:24 -0600
Subject: [PATCH] kthread: Always save the full_name

Simplify the kthread name handling by always using the full_name.
---
 kernel/kthread.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 831a55b406d8..5596ec3f75cf 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -349,10 +349,7 @@ static int kthread(void *_create)
 		kthread_exit(-EINTR);
 	}
 
-	if (strlen(create->full_name) >= TASK_COMM_LEN)
-		self->full_name = create->full_name;
-	else
-		kfree(create->full_name);
+	self->full_name = create->full_name;
 	self->threadfn = threadfn;
 	self->data = data;
 
