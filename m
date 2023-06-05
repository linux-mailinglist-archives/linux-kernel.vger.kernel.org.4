Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B9D722BD8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235094AbjFEPsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbjFEPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:48:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B150E7E
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 08:47:45 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 355BZ2rL023244;
        Mon, 5 Jun 2023 15:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eYovTuCNFv7det7LAD6z0dBLG4RXhHLWugtNHTDGLwU=;
 b=WpWDF4BDHAerYPPolt1IcaLqB7gDKYZGjnRwmZB1OwDG0SlFynwhT7zUEE3vrhxq6Fbl
 RSfcyHvMQGq3SUoXAIqXr/NZZCVGE2+cFtt+KC7m2CA25XyKjiJQvifmjlMIupOfExGA
 lpt5clOhsS3PzMIH/fNzvvggWxsh76Mhc55fdRqhyUBL0JOQMiVsCpXYuv2zNjQOUR9n
 dBjL413ps0uPVHIB+oFMMQoyVcFwFVPJOoCAUYHVYvDqSk1GSBPwGd3DcHZ1zA+dCe7e
 LKhntljTn04J2jUJtBJn9+UmiDMYZuAvhhm3+3RJQgVE4Ishy6pKkAGXOl5OXPwskkue Fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyxh9k8f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 15:46:58 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 355FhZe1011175;
        Mon, 5 Jun 2023 15:46:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tjy5grd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Jun 2023 15:46:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNalRUPCzSP695c3sN0h8+gLtp3WCSkhQYeNgCnZYGs3Tr6DuQ7qD0VkNYtYMrdTtwl5VmYxP+5Dwm5gN4gjBtAI4torXOaWP5vzYoyh6OWvUWETQv8SYc32frTcnHXLbYFMujA+0xmfCZABtK8A+gAVmxW2CFmOUPlR5b0Bc7e06f1gfNYefIm5aRKat1PcPQxqEnyJI33zKhDONJ8FKRON77R27ynW7EZLZcuCPf/3t0vo+2+Df1KYNcg/Vkicphk06Vg0m4EJCo7ODnZ+msTSgoDVdOFrpgd081bm4Vx1ElJQYJQdboRw2TD47rbtblpn/nW1objBz/2V/CU0TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYovTuCNFv7det7LAD6z0dBLG4RXhHLWugtNHTDGLwU=;
 b=g1MheXV6Xm54/lzrNZhcjzyIvRMWXSInsK3nv7COYobrM2xHmBrmfu5gdUIAEEdHD6laUo7Ilb0CWAORNeNVMSoDL/Vnu9PbNiG027AlBbhrXZE68wSoOYO3cwbvXhZa0aFyeCsP0nEpyZRm8yM3jVbxs3Ej5h9qjUs+hYRaseWJqV2SmGQxg82Lajklve+fNj8l/3v+8wxK9SxHZZVyU4TVWM8uWl2NB3b8DzsqVUgz0C0EvBrXX1rjwSOKX3gQpnrHkW9NLkxPlWVkpuvw5blv/bzETzPsGuiWhZ5K7mBd1SLT8KSjbkGMJ8/RBqstNoDDMP9kHKJohDIbBwvwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYovTuCNFv7det7LAD6z0dBLG4RXhHLWugtNHTDGLwU=;
 b=b3kc7ue+aMc/Eea4VwzCSMkoROH0QcJ9M/OMbSqeT0bRGmWt8UAf4rT/BvTZZ+YtUT9bwCM4XjIE6Ydq26DqU+HBt86Vvi5pznnXebhg2RrTJ5QhFzs2iiQ7PlnFKFH7ZSv3drduF2+G3seOw89q645LD0zkWdtiJkQbr5plxF0=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:46:53 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:46:53 +0000
Message-ID: <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
Date:   Mon, 5 Jun 2023 10:46:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230605151037.GE32275@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:5:bc::36) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1aece9-8c44-45ef-cf17-08db65dc1587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCPEkiU4XlQ2sMwKrVGBzuOfLsxwzbaS/DwD4E14bSFM7BNkW1xj1EZnIsq9rPmpYhsZnXr+vuzseL1Pn+7gsmvCv8V/9Ol/B4Php9Ov6tZ2FMMb9NmAprfcEpV2PohMP6wcgDmrDwddafDqHX9w8gffVI1h3PUVbow8mSrX3HI/LgUf3n3lc80ppXkYx+gLzOEq46i5UuyOOyKknSFf5Lw+xhvlqPwwya2JvDlDndTV1rEx3wlTXDcNpoMptqgXTGx5LfYFWh0irrWArHKhIe1L7POagS8Pr8XtDELV6OYyj6d412p8Llk+WzMJUAKoMBq8D8iy4FfcacQyPNwka/hgYMjpRCp430KlkStddeVupPHdjsJT1SMG0Tn5I6EAvDW/0M5gAvx8ducwCpTzaAo6qk61MlC2/zyl/sW7jzYAkbY+6wbESPTmLVYXo5FbPEc2ioo61bpxKEpe2xVOFK2/5LqEn93Gs4mSPVgyphDbg7pSCqX3vPKdT8XmqI4KNQLkIiYyWSWPCN0haahOWToM105pnhb65/bvBrc4v4+moHIgAIXGSvVtyq0Rm0EZDHh5wYuTWS+tnldZUa9UDnvZ+2tLCp2MqaFp00AaAqGxXgJSVrSbJMkUacDg54u9YX+lSsimgt9FAy38yaDeWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(39860400002)(136003)(346002)(366004)(451199021)(6486002)(2906002)(66946007)(66556008)(66476007)(8676002)(36756003)(38100700002)(8936002)(5660300002)(7416002)(86362001)(31696002)(41300700001)(6916009)(4326008)(316002)(478600001)(2616005)(53546011)(6512007)(6506007)(26005)(31686004)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3VoaVJzSnhGYkpuelBrT25LZlhzOHliaXl6TEFDWktDUnVTdWJOUzZjUDh3?=
 =?utf-8?B?MGYzZiszVm9HSk85OUk2dEtMMU51blBBcU5tdHJWOFVtcnR0aVZncWx1aUJH?=
 =?utf-8?B?ZUFhdXR6NXIzRGhJSFNQWnRvd2RVVjBwb1pWdEVXd0t1WHhpYlNzMkZPdVg4?=
 =?utf-8?B?bGVrOHN4TDFFQ0NBL1FSNktzT0pPODZJbXB0Q1hqTWNyM3B6Z2ZINzMrbFJq?=
 =?utf-8?B?M0MzQ24yQVBzbHN6QWFrSzVPTTNDMXZNWXM5YWQyWDRLbXlrZDhVOXlxN3NW?=
 =?utf-8?B?STN2WmVSN3pjSHA4WmYwak9jRWdrVjR6V203ZUQwTkgycUlUT0s1dTJLWlhx?=
 =?utf-8?B?Q0o4NE0wbmY0ekNscWJvWWVVNGp6N3o0eHIyeFVEWnlRSFdKQjN3MUJhNXpm?=
 =?utf-8?B?SDk4YTNoQ2xSWGJybmQ1VmxxN3M5Qkw5YVZaSGxibGpQMGZITUFiWDMrZ0sx?=
 =?utf-8?B?eFlQN1hsblBNdHNnQUdFTzlDTFBoaHFTK3NJSWw0dmlMWEhmT0tUdGZHN21R?=
 =?utf-8?B?Z0RMWXM2L1lhaEdUSE9RMFVITDQ5cmpsaGgxS3ZUN21MNngyQ0FVSjN3bkJ2?=
 =?utf-8?B?VE9RTzF2VjA1RmsxOHZRU0paUGdIWERWUUw0a1NodjBEOHl0QWVoOHZDeTRt?=
 =?utf-8?B?NGJ5alprWFVOYmZpaTdrSFM5U2gyNVFTQzhqNE54b3R0T2pqdFMxa3R6aVRp?=
 =?utf-8?B?b29BbkFYK2M4bFA0dXBIZUxRM0w0bEtWVG95bTB0YmxKRElXTnV4cmM5dmM5?=
 =?utf-8?B?Zk5xbXFvcFJhNXcwUlB5Qko4WFpNbjR5cjYzZ1RZZFo2ZXBWYThIY0VvRS9t?=
 =?utf-8?B?RjhiZ2F6bEZ2V0tkTWdTTmQ1Ykd1dTlCTmI4cnh1bTVWWURMVUxqeHFXSnJU?=
 =?utf-8?B?VnQ0dW5CTmpNenc0MENCRStmVHlsM2N1OVAxMzc4QUgvcERvTkJNclJJeFJz?=
 =?utf-8?B?a1R4ZHlmdEFvR1JnTWdTbitoZC9LVEszMklqNkptRTJjd2xEcUxLYUh4S3RQ?=
 =?utf-8?B?aGNsb3ZGa3BSRDZVK05mYmhQdDhwWm42SkJqa2dwY0pQbXZ0TThaVzJZM3M0?=
 =?utf-8?B?Tjgwd2tiN29QNWhmaGFVeTgvS20zaE9xQysvZjNDWFNSZWhmdHRpZExNVlhK?=
 =?utf-8?B?N25Rcyt6QWU2dThnS2kwTzdQR253OUhPZ1NEdHo5ZVFJcnVxTDR6V2EzWEo4?=
 =?utf-8?B?Y21yVzk3VytVeTVFY1Axc01qbTUvUTIyKyszSnRoc3pVMGJUbTF3djVVS2hK?=
 =?utf-8?B?bVRralFNQXFRY2JrckY5VzVoTmhBVXh2QmFPZnVyeWJFZ0IyZkdYamFIUndn?=
 =?utf-8?B?ajgwM0ZaNFM5cnBkZzBDcGJRWVMxK3VLNTE0eHUrMmVTS3V6bkJEODlDRlJ1?=
 =?utf-8?B?OEFOQkgzcjUwdmd6M0NIdHprR3ZZM1dFbVU5L3VzOVRsUmFsS25VMFV2bGVv?=
 =?utf-8?B?bFpMUzZzRXRWajdWY2VOUGdoOXlUZlpOYzE5U3R5Y001ZkswQXlxbUU1bERi?=
 =?utf-8?B?WVRMMDNuWjdNbzJlbmt0NXRCV1hyd0gvMHdReER2SUZ3aU1MeU5oUG8wNnNq?=
 =?utf-8?B?K3VHZk9zM0tCU2hmMzFETGpTaHFlUmZCRWdpeHRZRlE3VUt3TlF3eVlqK1JP?=
 =?utf-8?B?Mk5hb2FwOXFSOUxHVGZsdTd4YzBIL0pEUWJVL3Q3MTZ6YldaVlpwNWdDWlhV?=
 =?utf-8?B?UDlEcnpMWmlnQ3RWZ09wcEhCREZKdVozR0lqOHhmOFZLRHRtaXdrblQvT0Fi?=
 =?utf-8?B?NlRGYlE2TXBCb1Q5b1hFb2o1NHVrVExyOExpaXQxaE1OTkt6NWZiMm04SVBZ?=
 =?utf-8?B?NzkySGpGeExsV0lXT01ocE5WZzE1THVxZWtpbkZSUVJZejRya0VaVHhOdSt0?=
 =?utf-8?B?a3FRY25kd0h1TzVrQjRidzZxYnRQMmVscm9aZTFWYUM0SHJCY3lsMFFlMzRv?=
 =?utf-8?B?YVc4V3VHTzN5SmpiaHBwZHV3cGx4WmNYdjVPMGNQTEhSVzl0RlZWL2VkdWJF?=
 =?utf-8?B?VHlOT3g0a295Q2lXK1IzMlV6STh6Zy92T2JMcEo5eURMb1dHOVdBOGxsci9X?=
 =?utf-8?B?WW5kRUYxSnhLWThuOS9HWVUxVjBhY2toRzJQR0FsTjdLYU91ZmYrdDNOVnhW?=
 =?utf-8?B?RVNxS2V5N1RiOG96NVY5UnQ3YkVuODUzNzFoSnZNUW4relRlaVNjcnNSVHNG?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MzJVZ2xINHBxZktzSkRTZVVSMzN1eGU3MWRYMStyOWNBYmFSNThCQmpyUStk?=
 =?utf-8?B?ZEgyM2VYQU5zQ2xwWUtRL1FKRGR6Z3lzdTl4eForbEphTzQ3K3RSV1FMSzcx?=
 =?utf-8?B?L2pOOXg4K09RdHIwcjIxaTJ6QzVmQlZqUWZGOW51K1dNSXVMUi9JU1psaDhu?=
 =?utf-8?B?ZitMY2hnUG1NcGx5eWlhclI2NFdOZHNpbkI4RmRCQm1UYUtTZWJ4eDlHNXhO?=
 =?utf-8?B?cEhNYlM2dXZFSGFyak1JZzhOL3RxeDJacTNRWTNtV0xiUURUaWFGNUZudjhE?=
 =?utf-8?B?czdsYnQ0MzFicGR5ZXpxeXREWmNyc0JQVlR6eldTZlQ3Q0RvRm5ZQ3dpSFBo?=
 =?utf-8?B?WlJCRktNbld0MkVtRzBFenY3T3oxODNWSDFRYzF0TUlrSklBMXBrVGxkUmND?=
 =?utf-8?B?TVlFb0JZRW9BNXpHZ09zNHRyTjZrS3pLMGhGL0FkbFRjVkZjbVlyOU5FRWM0?=
 =?utf-8?B?akttUlJSaGs5QXlrMGdJK1liL002UHRiM2hKT09NQ1FKL2xOa21jMnhQVVhY?=
 =?utf-8?B?aG5MdmNObk4vN1JweDNrSWp4VXJ6ME90MmtTS3IyZ1RydWJnYXJKTnFkS290?=
 =?utf-8?B?ZWZmaVpkR3R5dHFXaytYcU1vOGN4VkgrMEExVUFlbXYxbWNnNFV3U2tyVnE2?=
 =?utf-8?B?RjRIcHdDNFozeGY2R2VLaFlkZVMyOVl4SmJkdWMrck5wM3UyVDl2dURYOE9o?=
 =?utf-8?B?TTlycVJKck92THQrazVWZS9nWmVWMHU1QzRvU01uektUMkE3K1ZPUU5lOVNF?=
 =?utf-8?B?Snl6OGpXaTRreHJ0NGdRZEkwSTlyNnVuMVBzb21GWXlDT2FzcC9wRFBwV0Vw?=
 =?utf-8?B?QkJBTUxldWpYZGhKMnVTbTlxV00rNTA4dXd1OFVJd0NnQmRHNFY2SUgzbTZ4?=
 =?utf-8?B?VnFqNnJucVBheGlpN0JzNGlkRWo1VW5Hb0E4S3E5WWRSWDV2dk5xTVpyYVBE?=
 =?utf-8?B?a25WV2Q2eHZURlAxUm1ZZkVNaHhxb21YZ2Z0azJSZVltdDJxa1JESk1QZURn?=
 =?utf-8?B?b3lNVzgvWU9YcGhpNkk5MGljMGFKbjFTSkRtUEFQL0lnb3RHU1pHMmlKUHlh?=
 =?utf-8?B?aGVmNnhaSW5MeWtCVUxtc0orN1RUNTNVRElBZnBLM0NGdzdadVF4ZldMQzRK?=
 =?utf-8?B?S3ZHV3U5VTZFYXJSUGEvWFJrWW1HNzc5YWI4ZldVUUJuUkpXemFJcEtYNEhl?=
 =?utf-8?B?VmcvelhGaXlUV1N6Q2U4OEduTFlxdUthK2RGV0dEWHJOYnlWT1RDQkVJdWI1?=
 =?utf-8?B?TkthNlZlUjhpUTdKWGQxc0liMlVqV3AvQTBMbDNwaTU3K2tiVkJLbHZxek5B?=
 =?utf-8?B?bFVJanNEdGZRVnplbWc3NWxRTHBqQ3Z2aGN0ZHZkQ1l1ZG9Ic3ZnVVY2T0JG?=
 =?utf-8?B?MlI1bENVcU9taVVvbkpsb1hEN3JLRGNyVW5wYWhkdXA1RlR4NlJlYUZlQm52?=
 =?utf-8?Q?BZ/FCsSA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1aece9-8c44-45ef-cf17-08db65dc1587
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:46:53.2911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JIdeByUPXgt86IRNcz0SmIjqrNif4LymTB8MLD3U1eJYZl7hbLuvZfj1qBgwlzN+7Gxi5pP1SrtXVYeR97kj7iYQYS0g/9QVhAcr/Fuukw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-05_31,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2306050135
X-Proofpoint-ORIG-GUID: OFSlZk7lfQm1I9NwU7mLSlruzTlbcPIZ
X-Proofpoint-GUID: OFSlZk7lfQm1I9NwU7mLSlruzTlbcPIZ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 10:10 AM, Oleg Nesterov wrote:
> On 06/03, michael.christie@oracle.com wrote:
>>
>> On 6/2/23 11:15 PM, Eric W. Biederman wrote:
>> The problem is that as part of the flush the drivers/vhost/scsi.c code
>> will wait for outstanding commands, because we can't free the device and
>> it's resources before the commands complete or we will hit the accessing
>> freed memory bug.
> 
> ignoring send-fd/clone issues, can we assume that the final fput/release
> should always come from vhost_worker's sub-thread (which shares mm/etc) ?

I think I'm misunderstanding the sub-thread term.

- Is it the task_struct's context that we did the
kernel/vhost_taskc.c:vhost_task_create() from? Below it would be the
thread we did VHOST_SET_OWNER from.

If so, then yes.

- Is it the task_struct that gets created by
kernel/vhost_taskc.c:vhost_task_create()?

If so, then the answer is no. vhost_task_create has set the no_files
arg on kernel_clone_args, so copy_files() sets task_struct->files to NULL
and we don't clone or dup the files.

So it works like if we were using a kthread still:

1. Userapce thread0 opens /dev/vhost-$something.
2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
create the task_struct which runs the vhost_worker() function which handles
the work->fns.
3. If userspace now does a SIGKILL or just exits without doing a close() on
/dev/vhost-$something, then when thread0 does exit_files() that will do the
fput that does vhost-$something's file_operations->release.
