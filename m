Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39F574134F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 16:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjF1OEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 10:04:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3926 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232287AbjF1OCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 10:02:51 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35SBT7Eb003587;
        Wed, 28 Jun 2023 14:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=eayAxsdhB4luKzP7BeN40QpL3dzNrUHWQskXaJXloxU=;
 b=RvJANVrZaefYz105/gE4Q8IOu+j7mzunCR/5iNwGY+jN3Tbiq9R6n2rKsWTbySHaiHH/
 /ceoZ4gYuXwMWjhlKo5KU591c7IBfzzOmpXT2eNcMgR5Ya8CUNI2SnIy6Nm/dYwPL1Mm
 7mQua9G2Ows70bLyxqtok7wdb5nNdtmAJ+d+2fWnuozY1CfEhYhjLgTAwmwUe3DmNJG0
 8T1cXkQGqSGhtY7heb+WpVJAv0jqxCEHYxSY92+yYABQL9QZJFfSmVWZ+JNoJg5zRd1C
 KSz3o65qEzaYpcMVVDTt28Gx202nqJro3c/xjJx2MDgvAK+/78X/PRl8SbYjZnl+j3TR Eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq937k5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:02:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35SDLd6m008684;
        Wed, 28 Jun 2023 14:02:19 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx6209u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 14:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0besn2AiU8V6mQEGg4zoipbo/vNOL/+fe0uMttlP0SlL6UMNRmOe/sH0zf1Poc5ndeg9lgGkvqyZxgdpTHvtHp3Lrwnr1YS2wcE9Fr07JYds4hYs/fCIgVe4hHz1Ho1ojGqOkx/xl10/bcrGCivG53CEuTbggslyrLKAUzijCoUrvcAVzQK21fNDLWR00Rg2V0oNuHvNrvsKgv69xLS8U5BpUFfiJCeb73g/xm4lPw+r4A9g7KL3Xd6Dz2j1iQxXbyMS1NPIcb2GqU1BxCWMj/Eh5MkP07p3Dhx1N3jQRuwIbYsDRXbVZPA6uxW5LR0Ke/g4EsuNL05+/fU3TyUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eayAxsdhB4luKzP7BeN40QpL3dzNrUHWQskXaJXloxU=;
 b=bWNYC3VgS7Q3pgiQcoc+S0X2WxDE2ZwbBOd+mAHHF7JhIR1hMd0XXRz+4eIMdWZkodOTQlo3iRjBYeivbLkVLrAhNQPziSHj/Ju2Sl4xp4sMa1yOHnlmL83s0WUxf77TeWGxPLvNUB82rUz+juxsuMAVH4MPRW/zrvNdA0QN5Xc9HE1p1uEehQg+An794Z7+0ExFBTq4VKAL2XjmwX5Sj+Zrpd8xl2escsiUy22GP77slkIEZ9h7236Q6e4fdazjD3R9/M6XWnKx7ye2K6TWw8nnMLV+07vlZA/eIp9YLGGjAXNQ2B2Jnl4LYxKCpusp/P/GCTat7N4t4K48d5AsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eayAxsdhB4luKzP7BeN40QpL3dzNrUHWQskXaJXloxU=;
 b=ZQF+pia0Xe2pX7aK9dVS3chAJvf/7SIQAQTlme0ZMtUgrqdfux5cvH4VFm5LRWJ7zpWzOBzTIaN7vQk4G2obSATLPIf3L0dHammbUh4xHVQ+rxse7uo/czqaKCPdOut3rV7A20kRuqcUpTCGf7h/ftIL0zmcgK6/KE1/D5dml7U=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SN7PR10MB7029.namprd10.prod.outlook.com (2603:10b6:806:346::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 28 Jun
 2023 14:02:17 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::9c17:d256:43b9:7e96%6]) with mapi id 15.20.6521.023; Wed, 28 Jun 2023
 14:02:16 +0000
Message-ID: <90f35697-5941-d42d-b600-245454cbd040@oracle.com>
Date:   Wed, 28 Jun 2023 09:02:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [Jfs-discussion] [PATCH 0/3] dedupe smb unicode files
Content-Language: en-US
To:     "Dr. David Alan Gilbert" <linux@treblig.org>,
        Tom Talpey <tom@talpey.com>
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net, linkinjeon@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230628011439.159678-1-linux@treblig.org>
 <9343462e-6a4a-ca7b-03b8-4855e5a33b72@talpey.com>
 <ZJw4iLlFWRMq6a3S@gallifrey> <ZJw50e0pvn/IN5Gj@gallifrey>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <ZJw50e0pvn/IN5Gj@gallifrey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:610:52::20) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SN7PR10MB7029:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d23dcd-4353-4e76-13c5-08db77e047e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rLZPuYONjpGuovQz4Fiudq3UMMIRnMhd72RdaYACN6T/8LZjnz84k4moKVSpp7BZuT/fKzHy5TxUtKitTJeFMjD/ugCVOnkcW6Gy6YeGVolmUgn+SySRDMHqG3Wa2nFf9/CEfnIn7NuFgiGDnKcDCNbAQqVk3+eQQjhQXp6w/SHTW+rlraszj3lrcCuQGW/nuWDkakPGhxFqJqY4PG6/GzYAByGv+ww312619WAQRj44lLbaETP3uADBd/dBvWsImYETcUkKmCU0zMgFxCnaG0CzBKrL5pN/C0rK99k2qUbsf/fqkb8OXnI/IWwnl+qp2zgc2oj6fdJUq4e8Tu1TeDX55QBskmBU4G8CaVgn18ISWYcnoqHvsimho7UzxpLChvAfjZRYLOqERnF9UFjP89wU51nx3o91AI9xbDkSiHNP6qwjQhl7wB4aGk5agq2hvth8Cx/59hHP9LrZKYclY4WBs2fySToV6u1gvtQVdUmUCVV3hOUGuXKTP/tAswmIgE9W2CneT7yPfpXIHKi8NAUTVWxpjy5xDMnhWYCyBVGWGSM5DKsU3iA/bkU8I9s1I2A8HJXe8sWC6xMO57e3NSlP7RVRMXQccfEMsar5wxKvH/CT235B7tWYf0oBAZuf5s76hRQfpoZHenKAeYJRWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199021)(31686004)(36756003)(38100700002)(5660300002)(44832011)(86362001)(41300700001)(66476007)(8936002)(8676002)(66556008)(316002)(4326008)(66946007)(31696002)(478600001)(110136005)(966005)(6486002)(186003)(6506007)(53546011)(6512007)(26005)(2906002)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnFIdUpFMVovaTlHQk5BbE92YWhPQXk3Y3IzUUhVcTdmb1VIQlBFaGIyd3RN?=
 =?utf-8?B?RERGQVNldlBEN25OYmhDeFUwSlJiWENiQ3RWSDlEVlJnN3RJbmFnSmF5RUp5?=
 =?utf-8?B?QmNmWERJTjg3amZ2Q0l2alY4YTc0WWh6U2hqR3JLWU5YWlFBQXFBQzB3Z1l1?=
 =?utf-8?B?RWxhKzdXcjM1Y2h3Qm5BeFZYVmgveVcvM3pxUGZuNDJWbkdpVWpsSy9YMFFk?=
 =?utf-8?B?QmRjMElZUXNDWXpSakFrMXdvQUo0RzlWTjdWZlNkYnF2S29RQUFuSEZQTjlm?=
 =?utf-8?B?NUp2U0ZxVHlVWEdYUVZyNy8yMHpNMlg5S0RzbytJWGdvMmxJa1NsemFUcjY3?=
 =?utf-8?B?ejcwaE1ldTFqdzVZTzlGd1djcmltcWlQVFFhZTJGZEY1V1o5cVFWZXVwb2JF?=
 =?utf-8?B?U053MmhtcFo3L1RldHFoenNMMmtnc0FBMTdqRlZBMXUva2tIckVGQnVDd0NV?=
 =?utf-8?B?bGdhYlRDc25KT0xGaXltOUpackc4aWFLR2F5bW5IbWo2MExZUTdxZ25pM215?=
 =?utf-8?B?K0ZUdUQrbVBNOGJKWWFtb21aUkRmVXhLdEd3TTVqYmM2RUF3azJ1WDJqUGNk?=
 =?utf-8?B?MUVPTHRvbVdqYkljTzJMK0JNNTJiV2hPalFGVU5qclREUzNIWnJad25pV0Uw?=
 =?utf-8?B?MDBxcU4rS0xyQnBVenFPQWZnK21HSWpZQTRReFE4MEZiaXJKR29zZDk1eUVz?=
 =?utf-8?B?WXlNcnRHR0dtVFp1QmxkbUJHTlN6cjRoWmN3WmZlU1VyaUlHTktTbGxCZ210?=
 =?utf-8?B?aWxLa2FqZDFNODYwQ1JFTEUrQXJLNitZd1ZzbmRScVkxazlTbVZqQ21EMmds?=
 =?utf-8?B?NW1IYkJ0UFcrZkJCKzZkQ3FnQlh1UGVEN1NpY2ZSMXkwb0t4WXE4ckloUDZz?=
 =?utf-8?B?VU50bXJvRDRidzhGeGNBNWp6ZTJGc1VsSmloSnUvaGxQNnhwUU5CRW50QXlr?=
 =?utf-8?B?anBnWTJCQmt0SWl5emZBZGw3ZHJqbmFJY1VXM3FsV1VJNGQwbzMzRXhJQnFq?=
 =?utf-8?B?RE1UTnVwRitxcUFmcjVTSm41NVN4dVNEdGlRc1hLWlFIUGllbXdIcGRrWm5F?=
 =?utf-8?B?RDlUV2Q5dTQyRHE5M2c4dzl0d1ZVTkNoVnM3dEtyL2F2QzVydjlwbXhxRmda?=
 =?utf-8?B?cW5pRUh5aHprMGNxRURieXBJbjdNYjNOUWkxZnpXZ1FXQXEwM0RXbUdUbCt5?=
 =?utf-8?B?eEJpQ09aeDV3WE1LL0JnNVNIZkFGMms4MzBWR1hjRUJZcGI2RncrUE1vUzdB?=
 =?utf-8?B?UWlSUitjOEkrbG5XRXAvb25zNWE0RDJadWJGVVVCakU1MUtsZWQzQVdJVndX?=
 =?utf-8?B?ZVJzY3kzSkNUcWxLUEpraXJTbXRxMmlucDVFa0xiMXBYUXdUcHJobjNjYTBv?=
 =?utf-8?B?WFl2TFZLdzd3dEFvcDF3SzlCTUtTczloVXRSVkt4Tm03T0Q3Q3BNQ1JHQU5m?=
 =?utf-8?B?ZVVYTWVOVkhrWjFvOE9iczJDREl4KzVyVjg4bUhZTG1kVWx4QW9Jd004anpW?=
 =?utf-8?B?U1o5UUNLdG84SFNKanA5SlZXVm5hWEMvNUZyd1M1Q3hiRGd5ekR1bkNmM0ta?=
 =?utf-8?B?SVJWbVEvVzZSVFp3Z0pBa1lSck00YTdjQTBjYlBLbVYrcHFYWU9FVmdYSEs1?=
 =?utf-8?B?dzc5akFGd1AvQzMvVUdidHlyUkltMEJnYUt2NTdHNVFNRllDeTRldGFNK1lO?=
 =?utf-8?B?aFluQ3dUSThmb0V5QUZPMHQwUXBwR2xLMGZkNEtvLzgxT3ViMFhxUklCMXEw?=
 =?utf-8?B?SitOV1lObm4xZzR5aHNib3hoTzc4SDR2U3ZkU24wQjBuNEVoc0pYakE3S0J5?=
 =?utf-8?B?bTZ2bnBJS25RMUZOSDduaVZCMEJ0ZmpzMU1yK0JQZmgzZVJwcUlGQWNpM0ZJ?=
 =?utf-8?B?S1I3ZGdrOG1DWTlMMHk5MGZsUFJpZTZZc1hWdXBhVXBlcFJZcFlWdDFSQXpC?=
 =?utf-8?B?MklHdlM1Q0dEWERiaHJRNXBIRlRDVGNub3lnc2VmN0JqaUdXcTJad0NhenZZ?=
 =?utf-8?B?VExweGQrM2VmZHZ5dlNoMkJpc0RibzM3aSttWVNpYlhvenprRW9PMVdkeUdU?=
 =?utf-8?B?WnlRb0VEU1hBUHJXblhqWm9MeGxNWHJQQWdVdHhEN2JtditlK0ZvV0FjSXlk?=
 =?utf-8?B?N1NEVFNNOThjQVJTOHZmSHRtcUdvYTZ5SHkyUlBJaUhzZXpXc2c0NEFSUFZ4?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZXJoWXNkOHN3VDM5SVY1dEc2bjhyV1JxUWFRYXZwaTVFeDdzME1rTFVFclBm?=
 =?utf-8?B?d3ZOblg3emdtUWM2YWVsVjBRR0RNR3pDM21nZ0s5RytyTmFvejVzKzI2emlv?=
 =?utf-8?B?OXlWRkN5Wkhkb3dvSjErU1AzWGQ1RWowS1JpSmtINEVuRWYzVjVQbTUrd01h?=
 =?utf-8?B?emRDRWJHbzF0dXZIU2MyMUMvUzVDSFZ5djN3Nk96MjZJTlcrdldZa3dxdHBs?=
 =?utf-8?B?cDNlSjNDY2dHSE1hdVUyaU9zT09FL2dxSXpsWGpTQWZvVWRpZVVBM2lTenlT?=
 =?utf-8?B?bjloUHlGT1V1TEVpQXZEZnF2QWZNeGxXM25ueWpCTms2MjRBTVNLZ25OdWZr?=
 =?utf-8?B?WkVLcjkxVWc1cTVsb3BMUGE0SDdRWUNRNDcxVjM4VmxSYjJuWnFjcEZVaTgz?=
 =?utf-8?B?c0FLYlQ0cG1zT3VQenNLWFE5eFl3aTZwdEhVdzUrc0NwVHlZWE5qUWxJL0c5?=
 =?utf-8?B?Z2VZcmZjRjRLL25tRSsxRkliZElEK0FLYzdrbTFxb2lQS0ZYYWk5YmsxRWl2?=
 =?utf-8?B?Nys4ZWZsYVVOZkdmQ2NMa0JUeklXTTBuVWFNa0xWQWUremRXbjdlNmpOMVQ0?=
 =?utf-8?B?cm9yNzRNd1ExcnlIcXFiRW90azNWR2xYenYyOFpSK1p4WjFiSkpHYzZjZGg4?=
 =?utf-8?B?dkp4V0VBUStWSENyVmVLd1hMbmsvRWZXSGtFZStaRVZoY0NXeERjMkFqOTFZ?=
 =?utf-8?B?NnhKL0FxTzdaa2dDcG5EMUo1VG4zNDlNeDF6dnJwQlRrUUp6UEs5bmdFWlMv?=
 =?utf-8?B?d0h5WTBVS1cyMG1hMWRXY1l4Rk9uaER5NmFCUHdtbktzbWx4L2pLcjlxcGJp?=
 =?utf-8?B?SllDQVFzUEh3dUN4Qy9iRExaTnN6TkN5SWVpTkNrZTFVTEt3VEJUY2RqUWVZ?=
 =?utf-8?B?MS95TlM4SVhXeE9CbGJnaU9LYmdlbk5oQk1OYzlQZkZIOFFKS0twTi9FcHl3?=
 =?utf-8?B?aThKdVpVczRuOGR5bWVaMDA0RWtzNFovOHJ5T0llWXdJUzhFRmZqV2tzNTA2?=
 =?utf-8?B?Z2V0Wno4UnFJWVhBSVRscW9vaTg5VmZyL1pLMjhqSkVWVE8waTYvc1FPQWdQ?=
 =?utf-8?B?WEN0RWhOUGF0aUxwQlZCRlg3b1o1UlFJVHVGV0l4VkR6c2xkLzdnR0RobTVD?=
 =?utf-8?B?L2I5ZlhPOXY0QTloVmI3cTVmcVpDcU8vUGdZeFFaRjBLclV3QzU1N29yQzQr?=
 =?utf-8?B?N2dLeXBibHhDYUJodm1TeGJ1d3VMTmxTM0UzV3pXcEV3dHRYTS9rYTBwSzlJ?=
 =?utf-8?Q?OCU5WC1Zf4wUVuv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d23dcd-4353-4e76-13c5-08db77e047e7
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 14:02:16.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/APoHlCnawB8L4JX8lEFMXiP1yOO3E62/ARmdos0AYj+DCkJrAiLRfejTM5V1LZU4AFw3n6H6udL78H9FsaUPNnQJx0pSwIiiIf2823qO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7029
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-28_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306280124
X-Proofpoint-ORIG-GUID: nXjiitgPNiqTEUy-Oty3aTC3vv1kPIqa
X-Proofpoint-GUID: nXjiitgPNiqTEUy-Oty3aTC3vv1kPIqa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/23 8:46AM, Dr. David Alan Gilbert wrote:
> * Dr. David Alan Gilbert (dave@treblig.org) wrote:
>> * Tom Talpey (tom@talpey.com) wrote:
>>> On 6/27/2023 9:14 PM, linux@treblig.org wrote:
>>>> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>>>>
>>>> The smb client and server code have (mostly) duplicated code
>>>> for unicode manipulation, in particular upper case handling.
>>>>
>>>> Flatten this lot into shared code.
>>>>
>>>> There's some code that's slightly different between the two, and
>>>> I've not attempted to share that - this should be strictly a no
>>>> behaviour change set.
>>>>
>>>> I'd love to also boil out the same code from fs/jfs/ - but that's
>>>> a thought for another time (and harder since there's no good test
>>>> for it).
>>>>
>>>> Lightly tested with a module and a monolithic build, and just mounting
>>>> itself.
>>>>
>>>> This dupe was found using PMD:
>>>>     https://pmd.github.io/pmd/pmd_userdocs_cpd.html
>>>>
>>>> Dave
>>>>
>>>> Dr. David Alan Gilbert (3):
>>>>     fs/smb: Remove unicode 'lower' tables
>>>>     fs/smb: Swing unicode common code from server->common
>>>>     fs/smb/client: Use common code in client
>>>>
>>>>    fs/smb/client/cifs_unicode.c                  |   1 -
>>>>    fs/smb/client/cifs_unicode.h                  | 313 +-----------------
>>>>    fs/smb/client/cifs_uniupr.h                   | 239 -------------
>>>>    fs/smb/common/Makefile                        |   1 +
>>>>    .../uniupr.h => common/cifs_unicode_common.c} | 156 +--------
>>>>    fs/smb/common/cifs_unicode_common.h           | 279 ++++++++++++++++
>>>
>>> So far so good, but please drop the "cifs_" prefix from this new file's
>>> name, since its contents apply to later smb dialects as well.
>>
>> Sure.
> 
> Actually, would you be ok with smb_unicode_common ?  The reason is that
> you end up with a module named unicode_common  that sounds too generic.

I'd suggest make it generic and move it to fs/nls/. I'd run it by the 
nls maintainers, but I don't think there are any.

Shaggy

> 
> Dave
> 
>> Dave
>>
>>> Tom.
>>>
>>>>    fs/smb/server/unicode.c                       |   1 -
>>>>    fs/smb/server/unicode.h                       | 301 +----------------
>>>>    8 files changed, 298 insertions(+), 993 deletions(-)
>>>>    delete mode 100644 fs/smb/client/cifs_uniupr.h
>>>>    rename fs/smb/{server/uniupr.h => common/cifs_unicode_common.c} (50%)
>>>>    create mode 100644 fs/smb/common/cifs_unicode_common.h
>>>>
>> -- 
>>   -----Open up your eyes, open up your mind, open up your code -------
>> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
>> \        dave @ treblig.org |                               | In Hex /
>>   \ _________________________|_____ http://www.treblig.org   |_______/
