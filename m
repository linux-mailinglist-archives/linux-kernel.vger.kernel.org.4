Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD83A639378
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 03:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiKZCn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 21:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKZCnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 21:43:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1029CA9;
        Fri, 25 Nov 2022 18:43:22 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AQ2PTHp016987;
        Sat, 26 Nov 2022 02:43:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=gzidEZGm5D3fLV6J59SFicrhOspK0yXNSX6C9AXCEKA=;
 b=uKPMd+F0x/EInH2Dg06f0Rn5LFWHAtOJ2o/5lqFz+urRxZ8bDG7NaNY6diQ0u4URegXM
 IQ5n51PWHplUoZvWdYwyy1WXYpn/geixmX+rZCfm+/SGfj/HE3xUhDx8nOiaDXwCbIHW
 HjJFufYZdXdOABhYIyeICp42eoGjQYTIgTt17lePrRURjsQD354rLQXV9iy0XTTlJDMD
 kDCE9uN5z2TIhgiF69rMNAAgLUsbaTyVIdmSpOn2wjl2LuP47Hbt22u+A2XT8RHhzmWi
 GPjCZXA4k3X7LP/779maKd+c0tZvLktFeuCP+rb7OjMR28kkd+KAatpaM7RcrBLR+y1i 1A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3a0hg0b3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:43:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AQ1X9Id007582;
        Sat, 26 Nov 2022 02:43:08 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m39821s64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 02:43:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AD+8r9q2IBUAfmacUPA1hxndY+4dguCjflPj3ywAekRcQZFJW70GVhSXiXG8rV/Nd4T+oKSVCSjfJQ9YPkisASQIPU2eqm5/7sKTMEYi9nGUF4tUsdV6Iw7kTvzOlxbphuTEc9m7aK5+x8Ali3P6FKtk+ZBphRnNnr2vWWeBsExPypNCMHCYMZUDHVL2ztpQ067F5hQpGMxsIsycLSgBumOEEtzzPmbc9swiZvu7FQZwmiNk/Uf4GxRl7M2sV1sfgsk8dzD3/lZ6DMPKt2FG0m3awYAJjyljJ/CoqE2b3fhpfYQvmoPLoiEvI5Tfkta8cCvKfkUQUaJTMGNfetzTDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzidEZGm5D3fLV6J59SFicrhOspK0yXNSX6C9AXCEKA=;
 b=JB52skSG8Mbq7MOMd2BBpvp5XXgVnjy3b9Nn1N8QOvjb9LMJKrCx/y/Cxg0fsjf9ZtAXwyqWp9/7Q4sgdzu/zATD3JLdUrWq4svX7wZq0a3UQWn54d+b1CYHU6OZaq/Ny4uTXMgsGhjri/UWvDe/Q51pPr/bIBPKsXQ6oaYnNHsBDc4moFqdU+E0b3WWu5P36UJ5P5KuFSfLREjmDSneHMOwNCMyE4DJnZTpmrhmq0zAxjQ1frJbSjhXGveIuKrLJLUsYe2pe1ZnXj7QOn8p0uo8qnjBP+KowfPdAEqD1nHc1FrLubPq//BYr2jC97Cl1ntRQFn12cZPv+rTgk4AWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzidEZGm5D3fLV6J59SFicrhOspK0yXNSX6C9AXCEKA=;
 b=Cg13HeR0+gQNZl3/XiyeP7WZ6vUwS6EOk0jUjO1oFc/5cSI75fJ3PgWI2OJpKLcFHHltD/gZHMv2V/fzJ0KbJTggcebXXHzoFjjyA1CpUsWu32P0fmIMAwGG2NizXlGDtDjt/HGTifRxRGUw5OkhtFZzt/SdDfxvpAznS96Y7eU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH2PR10MB4199.namprd10.prod.outlook.com (2603:10b6:610:7f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 02:43:01 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 02:43:00 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 rcu 12/16] scsi/scsi_error: Use call_rcu_flush()
 instead of call_rcu()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tu2mmo7w.fsf@ca-mkp.ca.oracle.com>
References: <20221122010408.GA3799268@paulmck-ThinkPad-P17-Gen-1>
        <20221122010421.3799681-12-paulmck@kernel.org>
Date:   Fri, 25 Nov 2022 21:42:58 -0500
In-Reply-To: <20221122010421.3799681-12-paulmck@kernel.org> (Paul
        E. McKenney's message of "Mon, 21 Nov 2022 17:04:17 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0022.namprd13.prod.outlook.com
 (2603:10b6:806:21::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH2PR10MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 099481a0-39c3-4500-2701-08dacf57eedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88fhhgaBTpBcu/wcnVJxMwgtX8EzGAGV7qlhoZUV7uTNgUsWCtXbkR+Gcbm7kRhUZvEFh7712hyAiM2cxs5zR72dc9cMdsmdLkXBB8gI+5V7gsZQrGAZFyIJpotTgYMqiD/Fwlewg3xurtRSDssZpn6kzNhkL1RG+N5J+Q2XgMDCTqw9gAiPrSvxQ0HW/e2sEXqDTmP7shbcM3VGbHLf+ysxSrDyFD7DEQk3SM8LBUWV2HtM7LNpa6a72rgun9OmFYkqbGwybhL8lscawV59x/CHd84K8n3oRNtgOffRxYj4E7fnyC2T+WQnM4NgbtFdFvymaLWyMkR9IxfB+VWePFUh2Ptvmg1Ief3y9YlcHyzh+AfZYb2VpLwpkr8V2Y3Ua6wXWmCbFxNuQ50uqAzrpmwnu2X0On09wNJqMVBHuSWzorWHfkdLwUkvK19LRdDkF2Uk611BcRaTsE5/ieBbjj51NkEGPcD2FopKiOWxd0NELRcRZQsgPGy5i6RDPhexNRdEK6jmnG+rcascR/KjnDykylkEzmPlcIPfv6R++1o3TOa4NwxcJdagzjyK3LIh8kNryUU5ic5l4qGOFdNSJ9d6sSPBhGl9sz8khWBqBsDlmP1PLW2uGv+/JaBCf2djXMKUIAsdaA2/61JEdpohAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(39860400002)(376002)(346002)(451199015)(6486002)(36916002)(478600001)(26005)(38100700002)(66476007)(66946007)(4326008)(66556008)(8676002)(41300700001)(86362001)(316002)(54906003)(6916009)(5660300002)(4744005)(8936002)(186003)(83380400001)(6512007)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y7obcPy2zXb3wl59dJWEWLpE8IhrteqiwMbcItYUKATdTk8Ex4aKhoK9s0X4?=
 =?us-ascii?Q?n9pmQoC6NPlkfiyY6R9pETFogQEld9B1jpKnlUzApE/E/a+cSWhNApeTgwPw?=
 =?us-ascii?Q?Crkqje7tesQSAE13X9CnDyB6sjNFpwT3kf/LxyxiDLZSw0mSduAy3KO/XN8H?=
 =?us-ascii?Q?q1TN6awj54u4YV85gVcLTIRGRzS4LCkM90mF4tZBG8rU9SGs6nkc8v245Z5I?=
 =?us-ascii?Q?0ECPxz1kYtjm+wtiZT50rOL+PvnMjP2NpO/7v9UDcdTBpResmL+qDguyspbU?=
 =?us-ascii?Q?v0V3OaOtHjeFGMH21ksMQ8TKgbG7sNvFkuDItQEnR2o5OC+Mrg/v4v8YjWh9?=
 =?us-ascii?Q?oAL1funnK30q6SiebE3jeTB8p6ah1ByHnZfgXNXpCXMeZ+EOLTJOCxhysx9y?=
 =?us-ascii?Q?wum0eUcFiXlhQzMF22f/uW++FZXO9Cun1JzPE3K6xRuNWPEnCPhgeQVj+W4D?=
 =?us-ascii?Q?ISkVbyJf23u2buuEsvqhifG7gC73dW2lJTCZVTli2VnSCI//yabDVPMz0U2b?=
 =?us-ascii?Q?B5bpZ9Q31TUwlOC564Tl+pD6YKx8rT2Uex8VwqcHCkxn91LhHpYC8nrC2kma?=
 =?us-ascii?Q?u12qW2Sdl7XMpqEj48ojoqrIEX6yoZUhReXZNJoSglBpmxoAknmAWzLUcnps?=
 =?us-ascii?Q?TZlbyQmDfnKosfIoiwEA57va+jycPoHADUXvpDN0ocT3gKxZBRHgP+Zx+9WX?=
 =?us-ascii?Q?wXC5T82S7DADtUqK1zMLtTQNTJJEvT+hd/4x7WA9R+uNMh0xq7EukJBF9PRY?=
 =?us-ascii?Q?os4LIW1mRkkk3k2bjNCG3cUsMnSH45HqO2ElCXdfr8C/2LEvoNHLMgmaUni/?=
 =?us-ascii?Q?Uwzzqlb4nT/n217zoQcKxIGe091uTgQx8QP2NDZWp96Z4yR03LGevRYlZSQy?=
 =?us-ascii?Q?kf1XsZ03JrolvsJ8VbVPQp9VJdW3XkqibbFUG0H5Z7IwSEmcZZKF+QwdK6dV?=
 =?us-ascii?Q?HuAc0l+PBSUN2Y/oSKkyTYVx5+O8kpb2DqWu3vTV2P2T1BK+DFR5zqG9kxjM?=
 =?us-ascii?Q?TGZKs/PxmL6ZDaujF1NsICEUgSXWXagEHBuHi8YchLtMARwqR/yYhPM2J0AH?=
 =?us-ascii?Q?FgKIRFVU+KuFatieltz5XWQvdgr2qEVoJukscJWZf4acOVtwGHsk5gV73PcA?=
 =?us-ascii?Q?TFTlU+4bDlWANBaMbSJ+HHAxzLUbi+rGpkFyDznrZY5K/8O6ocETl0qL4TSW?=
 =?us-ascii?Q?yyiOJDlntFnDeenTRW6D5aFPpr8MVq0TNRAghj+NoDa2rxoyAGzprqD/jPdy?=
 =?us-ascii?Q?n/ct1OblYktX6LdacNYTuXd9TkCBOTHE/FA35d2vqqipzJPY4IJMHeP92OL0?=
 =?us-ascii?Q?k3iRclWkU9LJiwXEr8Qtu4iYDSneePczxQrXOADDG9fVX8ssGCuVG++hTTaW?=
 =?us-ascii?Q?AXbutAcmaZxR6UnjjCQwq/copRUxvDrbygwce7rlzAKw1dOv3Lba9EOo+oIP?=
 =?us-ascii?Q?h85ogPWqlwhKyX2QGeBHnZvpPUnnVkkcez3ujqUQdKBa6Sk9KnTMMl79qyQB?=
 =?us-ascii?Q?b6aHTBWeb7WFtsunj4AQZonnr0GYJezz0xOtyXd2+J9QSxM5ALO9UhLGvF/A?=
 =?us-ascii?Q?Arf4mfBHzsT9B9PJdo+t4lpZnxqIC6xMg4fC2kK/kf9F36rRHhMbrPR04spQ?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?6NahN2ko6VUN3rzX2PLCuZcUXuU1IwEiPb8fBPv2zqeedIPoQXxm6SYrUYsY?=
 =?us-ascii?Q?57EYp5pMQRmwctfWXS3paqwL3QmTLe3XNjarvodpOzGPFSMdl42mii5ky6WR?=
 =?us-ascii?Q?qW3J7XYHj27vAjP7mUFyCvxNx38c23ePevEVu+96vFe8N63bGR3MW/CG/Gt+?=
 =?us-ascii?Q?Hjla0vJ+YS6prQ3LV/NoV2C0N4XKfhtl+LHA34RAddxM36qNTWCPEqbE9MoO?=
 =?us-ascii?Q?YYvmSPtfxYs/Y1SlQTusTc8ZoJKoLh+BJ9YkXBEXfpDEudMdLy4GlCwV1EAO?=
 =?us-ascii?Q?0GhkW45065kp6qGEeka5Pd32elNTgT5P1XOSj//tORJtGpAtLSdEjJ/v79b8?=
 =?us-ascii?Q?DlIhEJ9BOcZXmUgcCV0x18mWBU+C1rUtp8hWhaQejbVZOHyn2oyhVOQy6dcV?=
 =?us-ascii?Q?4N897Qrg6rLCbgPO43bFPjHGdhXbIm/eKMk3opfGEjLdmd0x4f6gvofPwqvO?=
 =?us-ascii?Q?vNyVFB6qOQhNyvJVHW9jed270ILASyVgGr8JSjKqQRCVbNsZaHOWi7Xt3sIS?=
 =?us-ascii?Q?umF4mbsUBEHQcEV6AwenQ77OUBneELpwcqpt0Dqg7gmnt1QINgTZXQMU4+3p?=
 =?us-ascii?Q?XXhhO8f7MV7dCBr3ttPD1ciJzi2XW9IF+UdTbkA1X+QfeDPBqjg6xjGgljnQ?=
 =?us-ascii?Q?GbYseIzMFRQLyYT87wGKMfaDbJAlUZewp4nRMj1txJzoeYQ/DgLyOiO+Go69?=
 =?us-ascii?Q?yl/tcXHYtTWb9fA0YLyvmWX69O7A/gEZ2wPMsGA8D34wq/zNOMgKtmo/PVkT?=
 =?us-ascii?Q?4JebyUnWEEWCNbqMVPMVg/7UBLKf+eoRRsrPeoYMXj8nYejoxzJ3xd0F94ov?=
 =?us-ascii?Q?EjNCvGSKcXMdbO1k+LZ0cnJYugQuhRavFTnvjV9sob/8K1blbpESIFGTTf7g?=
 =?us-ascii?Q?LkaGJvIZxNxE2fumRXKl0LRzdGsD8ejA+1zUXuxS5xe1j+q8QCX8MvBCl+7z?=
 =?us-ascii?Q?Aq09FjZLBSMcBXvhiHVodaZCtTTJuaCsbeGHQiqMpODPYBfKBRrxd+5bGCH4?=
 =?us-ascii?Q?nnYZQRMmt6URzWUa2WxFdSxp1AtO/RmogrvRmX6BF+WirOM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099481a0-39c3-4500-2701-08dacf57eedb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 02:43:00.4041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVRmyrIrc3XuFdh8PDiW8qvpQPf7UnPZqg1ba8J4orxY9TNDVwqGiH1OqNnyz/bhGZrQCUUkLaxqHrZMmP/pYHWy0li/6x6AxOHN09eppv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4199
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-26_02,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211260018
X-Proofpoint-GUID: yWqFaSD1jo-uJc0Tpo97iU1d2tt8ScHJ
X-Proofpoint-ORIG-GUID: yWqFaSD1jo-uJc0Tpo97iU1d2tt8ScHJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul,

> Therefore, make scsi_eh_scmd_add() use call_rcu_flush() in order to
> revert to the old behavior.

[...]

> diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> index 6995c89792300..634672e67c81f 100644
> --- a/drivers/scsi/scsi_error.c
> +++ b/drivers/scsi/scsi_error.c
> @@ -312,7 +312,7 @@ void scsi_eh_scmd_add(struct scsi_cmnd *scmd)
>  	 * Ensure that all tasks observe the host state change before the
>  	 * host_failed change.
>  	 */
> -	call_rcu(&scmd->rcu, scsi_eh_inc_host_failed);
> +	call_rcu_flush(&scmd->rcu, scsi_eh_inc_host_failed);
>  }
>  
>  /**

OK with me.

Acked-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
