Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33C76D8933
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbjDEVE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 17:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDEVE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 17:04:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B601240D3
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 14:04:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335J27CL010139;
        Wed, 5 Apr 2023 21:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+K2DGl89O8ItGpv3JNOoKmv9zP9mBLSBFv0IXwqi/9E=;
 b=Nk9UDR2k4VFWB+6ZSYni0eAvizXaVyoGiMToBAvb480MVFxTykrZ3EH2gSqKRUsHPOD/
 PMMd05ajM3ryD2J0+2qS+MnnZjLDBx0JxFHKXBsVPZp9KW+iAOaMwhK73tWyZkeLU8+G
 dN/9cDRzdXlD985EgpCstEfVioPSZPeeBSmk/2e2+4bwz4v7suxCsTr/lHj9Fvx2wRE+
 qc3CkEyy/X7JQEZN834v2nk6Cvo0Xgzrd/1qxKPvrACaOQEGjmZi86xeS88Rta4r49By
 0kM/w1n6WgoJ2MAGDnoYebQFGHdFHozNgrKQc3UjKUzWEy0jLCWtWf0HyFVHhwNHDZxj PA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd41fx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 21:04:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 335KEHjA017230;
        Wed, 5 Apr 2023 21:04:33 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptp975gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Apr 2023 21:04:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1AyhiXUa7ts+QyLKE1rZXNpjNy2jld0ZyU4XjbCw+Aa09WsSlinMxE5HYMDb10UM4VTGfoK0/8y3HfywkmP69wJlyRefoKADuBWZ4RJACaW4HdrwW04ofkkSC1wP5WfA7DskN1cnzOZAuHiWGwF5XlrHpyhUMImxAtVJ/c2FIOV+PcX2g1LLlCOKmmxuql8nkZs8fgIF3btIbd6s3E1NANBmLAr4ND62nvVhdvu+ym58h3bb7/yjVVyphyZeug9jX6bqQuMUUhzHSMk/fZJmkhH3Njl3n4xjlHXOm2CEJv5e/jPT0f0tVXPgqWXVQ1f3g2frxjbQ2AhABkzdlb4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+K2DGl89O8ItGpv3JNOoKmv9zP9mBLSBFv0IXwqi/9E=;
 b=iGfXz7kAYKsHIGSxOIDOzwEgKRnb0lHr44z+u9mmFOP0UwCH8ezbWXjZHCBVTQyMmpmYtSWpdGhLgqsR2D2upMy75uz5bFOkh/drUnuiqzgaBFExKpYHOq80paoYC7MUgGKc5uCPQSCqijfT/TLGz9S8f6AoowAk+KURH47B46oe3vzwgqiL3D7/3fOrSdR1aY/cLWoz60xLFM/kiItaBPtY+SeLdYYOm95meqVKlicdoj5LtQNik2N4qKc6T0Df6e2hlFt01T/1kWF25SzfPXyf5r/hh3LGCv9BSN+col1Zt5ZDqVuM2o09E68aFAKxsrJwYw2z5hxaozef7HeBeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+K2DGl89O8ItGpv3JNOoKmv9zP9mBLSBFv0IXwqi/9E=;
 b=EnaUaqGEDYcMhWgnbMn0meu3UdEHxQnvVQwTvkwthUFX6uujwuj5T0m3UrYXFUDXf4x0Tw0muR1M2Mv3fTv9Pz8dFHscmKP+8w7KbF4hFn/P+FuMmOlLBFeIoK3m6zzRLaVsB7Jt4RKHU9FuYjjaPzfUQS/0BkCeZgGZtl7bNcw=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BL3PR10MB6091.namprd10.prod.outlook.com (2603:10b6:208:3b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 21:04:30 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::da62:d148:3055:6392%6]) with mapi id 15.20.6277.029; Wed, 5 Apr 2023
 21:04:30 +0000
Date:   Wed, 5 Apr 2023 17:04:25 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Nitin Tekchandani <nitin.tekchandani@intel.com>,
        Waiman Long <longman@redhat.com>,
        Yu Chen <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/fair: Make tg->load_avg per node
Message-ID: <20230405210425.5v4gl6tp54tgki65@parnassus.localdomain>
References: <20230327053955.GA570404@ziqianlu-desk2>
 <943d44f7-1fa9-8545-dc1d-890e4dd20854@arm.com>
 <20230328125624.GA6130@ziqianlu-desk2>
 <76939bf6-1d9d-5f8f-f15c-f03b2322d684@arm.com>
 <20230329135455.GA108864@ziqianlu-desk2>
 <20230330174557.m6jsgb6hsni4mxwq@parnassus.localdomain>
 <20230330195157.afbqtusnnbnvtlyz@parnassus.localdomain>
 <20230331040609.GA184843@ziqianlu-desk2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331040609.GA184843@ziqianlu-desk2>
X-ClientProxiedBy: BL1PR13CA0229.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::24) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BL3PR10MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: da25dd17-8b55-4a7a-51f1-08db361958e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yu2Upz6ij39SdlB/23xP857KDh/yvZt85poDyE0Qx7wuUEs88tuCUWxq5n3F/7fhDqYYU4ekOLI8oGogvOD9rlXL3z4OQLU79DH8Wx/cxaGHsgaCEpaeiUI+9jYrI2Fcxcimn8SHYd43TMzOOXJjHHbtkgvf1ggFV/LdqvEcANgWKSyq8fCzrlH0gqOH2wo6KKj9FNp33g23lFqgp4t3Unwi8HxZnEI6Uq/jvXOAtSxrND+73O61AfL0NmAwsnk8Fgo0CTeM0CKTh/13JXH+/bCNmeOPdzAJBEmy4cyhsx11fly6TfG+wXK38/TaO//e/OlLYyE26iXASB3irnniznaKQgsS5ZdLqSU6oNThHCH4ndgCp/2aXhPeP1xnC+EKVKhqjEoHYMdEc2T6SG8om+cV07lXwDFOViT+plN3kwoeY6hQSnJnBQXNyChfOolAykMVxLyezNyTY2XzhHctZg3UctPmdpHC30zb8Xyd6vYbbS7zkLtlCCVSsa2A6fXqBnaCujkWE0WW9RM96bOANJKqb14CeiIvIDm5HlM9nCEi0+Crcy3E2Sd37mVaYPlf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(5660300002)(8936002)(7416002)(2906002)(54906003)(316002)(66946007)(41300700001)(186003)(478600001)(66476007)(6916009)(4326008)(8676002)(66556008)(6666004)(6486002)(53546011)(6506007)(26005)(9686003)(1076003)(6512007)(83380400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ByNxbDSD7CX9rVeu7b/o2StqFaD0YlMeYgKI0YBKWztzfHoNkse2FWTDnFqw?=
 =?us-ascii?Q?o8nVLH8HZyyb6kYMlgRenEuVLdlquxSfhZvi50vLq0F0hQa9VchZeOSpxvjx?=
 =?us-ascii?Q?ud2nNMXGj2xzDDB2u/p/jrzAdV5r/GjIXmPtbg/xxTzKc1AEl4AA+/wIBBao?=
 =?us-ascii?Q?xVwQZhkBD47wu2sJ1rqbDmJyjrQo3DrO00OiS7GpRztK85EheoG7aGntYNBr?=
 =?us-ascii?Q?GYFg/QZZSCaD56WnP2qDSmFdMwFYNGqTzxSd4g0Q/BZm2aLBzI7W+buQrKpA?=
 =?us-ascii?Q?78BlJEFo1LK+XJX4+agJUwRQkz3CpNEiearTxFKLPWah0Zz0RBg0bZ10G8i2?=
 =?us-ascii?Q?V7Y67eemaid1j8w1RXKo4txnhwnGamMR+KdV2ZlNWWiNY03AsSGROVX5PoNe?=
 =?us-ascii?Q?MCbKjnVxzGcsvYzJd/m5x835Qj19GAQZo0ufkb7wNznI7K9YwDP7JX30hdYl?=
 =?us-ascii?Q?OvRritHj9pNW2m+cMLmwr1RlUzHIQkE/ZfaskWv0u/S0CFQ/BCn5iWZzl9/S?=
 =?us-ascii?Q?A+oUf1bcUhSsi3ugAx+TDiLE1eo5x0h5/qZcTyUkdP1AlEJys6ZC/+1j2ToL?=
 =?us-ascii?Q?huhgh//IQ8/+1LL3l2Pwe1v+7aIJ15SwX59p0oKcMO9TGWyxx1Nsv3PxSEM0?=
 =?us-ascii?Q?VMmgKuaFiKOogMZMrYXGyZ2EDSnyhSgza81eYHGa0ktoHCyrLoBiwtgemqFa?=
 =?us-ascii?Q?pnd3yn/U3uLJLunGKIjbyFWfxBKtfyH7T//yQcMCwuhe13SwVqVEnq1YGrA/?=
 =?us-ascii?Q?CJZ/jRrwfcbN/JSmstcj297ThCadtzAL5R1DJOk+rY6BaMPAcpxdF/z9xLeo?=
 =?us-ascii?Q?UDInkzGGnpOImowRuy/JjQcwhlbXQIFi8grhj7GzNmQouyLO9XM9YYoKxcw8?=
 =?us-ascii?Q?77bpQb/NnUPdn1UMHrQoaXKzT1+IeLcdLlAENGE1iuzbGTs4gc4jvts7ulU8?=
 =?us-ascii?Q?DzBwMZkk8sLjarI/PwIZulE9vyDyQF5D61b3UecM82mcRDJ2U93gr/eNKpzm?=
 =?us-ascii?Q?EfseQWppgD2k3kW4IbSUwsL7W48wkjPlEef3426DrhKPFxTsW8QQ4XNWYrZe?=
 =?us-ascii?Q?6lhd75abbEFJYJ1bI3ekQuLwNWIwcxzrrC9sgwzbnibbfFl58sUwCdkNWZH0?=
 =?us-ascii?Q?nDO3gVEGPpQgFA8QVAPllJmZWfhhfzz7fnk/nqNf2+l19P7JujCaMF6uLxXh?=
 =?us-ascii?Q?7eI+QjKffzR5v7m3BX6xPuVbslRq9umBYsJghvLaHxWX9+rIzrNkeaLnYb31?=
 =?us-ascii?Q?vsbWkREFNafXsNcJ2Jy3rgAr/owBRIxod2I0JK6BNeSLuSoMWHobO+YHMhDs?=
 =?us-ascii?Q?hwRQRQW5YMnrXLgQlrFQMGO/272wicJWa64/bAHO8J3vh+CaQkX1PEStkHgI?=
 =?us-ascii?Q?SGQn1zc2GPldZiETLEpwktFkAM95hFr5FFEqyB34pe428GHJkkd7GNx5BPfZ?=
 =?us-ascii?Q?acM10oG8pAM5v4lN3X1q7MBmObONxm+nDbAwtV7wNsRX5OM4SqVbf+qV/1oT?=
 =?us-ascii?Q?t88ZE05HfCscv4NzprXvNBRcXMI+5xn/GS4tmurvCSKKM7EAbTTqnMhDb/L6?=
 =?us-ascii?Q?95+lNH1TyHtU+GgxAYXqz/9Jh6Io2AKTQvuD1yPFXlZD4+iGeo6FF6QOG0Tt?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?s2pkW7n/fH1fYMPGUM/hgD0B0VPuz4VeQ03bmVn+cZXj2LNHSOiMl4kjaTVi?=
 =?us-ascii?Q?DRVqAWtr4Bl56nLSKbBi0MC8u3XP6a1ZzEgNQ61Ez6KYyua8VWqMkACvewCu?=
 =?us-ascii?Q?BhbD7ekumiskcwAYrNK5kTjRk0c77hPhd0Q1He0No/kDRukjeUfnSBjNBXy+?=
 =?us-ascii?Q?YPiKRPwLpai+/G37BleVS5q0yqDTi0LbgXzsakimDjUMDRsWb3nH28EwmvWZ?=
 =?us-ascii?Q?uYWSopdf7BL9MIKIejxpvxQ6yxRe1Z+x+FfmRI6IxBbuSeL0ln5mhXT4IDRK?=
 =?us-ascii?Q?B8PHnvwEmTnkuEkg7qhWoKeEVVoutKTTL5OhxqdtS6fPEmjF8ayJce4AIKrX?=
 =?us-ascii?Q?LskruL3lG9/14mBcqX6hRp5Adtb78WJred29QvpMGmvSjAdmkmT0+VIEdMp6?=
 =?us-ascii?Q?KVUhxTkxgUdT4Wx0YDLduxkfMVs3bpEb8i4MRnV1bFmBtquaFFTs71foCy8J?=
 =?us-ascii?Q?44DqnAg1NHdkoXHCKuzdIO1/A2RrswZQhKnPA3TNN4tdqytDW3FijURYOl1J?=
 =?us-ascii?Q?CoNgFoJyBIlh0eijkCBI3MFMCpUUzbdmuSVU9KPXmLm9/GE2A2FC6RW5YUS/?=
 =?us-ascii?Q?zbB9yHgqYq/t8EBazDJwOD4T3iaGsJdeD75Ifv3c7p30DTcoLFYELTxSyLT8?=
 =?us-ascii?Q?zlkBqpEriFuN6psGXc2Ld1XZ3UsRFCTUk/cp1egE4ABJKuo4WTt8txgGliEf?=
 =?us-ascii?Q?iNvET+t09QpGvgSxKZO6uIiI/7KC7QqVu8G7cULdXdz3whUm7iLvufqFpq9R?=
 =?us-ascii?Q?S6Cbd1NGztiQvojf3sKEAjUe+ZVyVex1uT3N6oAsBJMNV/nz/bCr7w3YFYF+?=
 =?us-ascii?Q?kgkEictx/fE8xKbcIMEVD7HuXj6/lmw3Hi4TROXDCGsyXNMOwGrIpPMOeIVd?=
 =?us-ascii?Q?3fnqVFG4cmdTdcPtoPJp40Z9SSVxd6xn/irhj3arWLW24BR2YA0nE9vdlIe/?=
 =?us-ascii?Q?Wp8MEfrCpUSx/vKukKYBKuqlgNGsyfoBEnAzeUEefK4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da25dd17-8b55-4a7a-51f1-08db361958e3
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 21:04:29.9078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+hRiZHIeBWhjWcHRx67w4oxiCSs6YEbkku5MsoEDeOI58ZsTwXVpAbzsGadR25RirJQY99yuzq0JntOCfFU7/vwFgDC5ks53Bs0FsnP3Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6091
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_15,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050188
X-Proofpoint-ORIG-GUID: leFF50yN9Pmlia4BbU9ON4iz244v_idJ
X-Proofpoint-GUID: leFF50yN9Pmlia4BbU9ON4iz244v_idJ
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:06:09PM +0800, Aaron Lu wrote:
> Hi Daniel,
> 
> Thanks for taking a look.
> 
> On Thu, Mar 30, 2023 at 03:51:57PM -0400, Daniel Jordan wrote:
> > On Thu, Mar 30, 2023 at 01:46:02PM -0400, Daniel Jordan wrote:
> > > Hi Aaron,
> > > 
> > > On Wed, Mar 29, 2023 at 09:54:55PM +0800, Aaron Lu wrote:
> > > > On Wed, Mar 29, 2023 at 02:36:44PM +0200, Dietmar Eggemann wrote:
> > > > > On 28/03/2023 14:56, Aaron Lu wrote:
> > > > > > On Tue, Mar 28, 2023 at 02:09:39PM +0200, Dietmar Eggemann wrote:
> > > > > >> On 27/03/2023 07:39, Aaron Lu wrote:
> > > > And not sure if you did the profile on different nodes? I normally chose
> > > > 4 cpus of each node and do 'perf record -C' with them, to get an idea
> > > > of how different node behaves and also to reduce the record size.
> > > > Normally, when tg is allocated on node 0, then node 1's profile would
> > > > show higher cycles for update_cfs_group() and update_load_avg().
> > > 
> > > Wouldn't the choice of CPUs have a big effect on the data, depending on
> > > where sysbench or postgres tasks run?
> > 
> > Oh, probably not with NCPU threads though, since the load would be
> > pretty even, so I think I see where you're coming from.
> 
> Yes I expect the load to be pretty even within the same node so didn't
> do the full cpu record. I used to only record a single cpu on each node
> to get a fast report time but settled on using 4 due to being paranoid :-)

Mhm :-)  My 4-cpu profiles do look about the same as my all-system one.

> I have a vague memory AMD machine has a smaller LLC and cpus belonging
> to the same LLC is also not many, 8-16?

Yep, 16 cpus in every one.  It's a 32M LLC.

> I tend to think cpu number of LLC play a role here since that's the
> domain where idle cpu is searched on task wake up time.

That's true, I hadn't thought of that.

> > > I'm guessing you've left all sched knobs alone?  Maybe sharing those and
> 
> Yes I've left all knobs alone. The server I have access to has Ubuntu
> 22.04.1 installed and here are the values of these knobs:
> root@a4bf01924c30:/sys/kernel/debug/sched# sysctl -a |grep sched
> kernel.sched_autogroup_enabled = 1
> kernel.sched_cfs_bandwidth_slice_us = 5000
> kernel.sched_child_runs_first = 0
> kernel.sched_deadline_period_max_us = 4194304
> kernel.sched_deadline_period_min_us = 100
> kernel.sched_energy_aware = 1
> kernel.sched_rr_timeslice_ms = 100
> kernel.sched_rt_period_us = 1000000
> kernel.sched_rt_runtime_us = 950000
> kernel.sched_schedstats = 0
> kernel.sched_util_clamp_max = 1024
> kernel.sched_util_clamp_min = 1024
> kernel.sched_util_clamp_min_rt_default = 1024
> 
> root@a4bf01924c30:/sys/kernel/debug/sched# for i in `ls features *_ns *_ms preempt`; do echo "$i: `cat $i`"; done
> features: GENTLE_FAIR_SLEEPERS START_DEBIT NO_NEXT_BUDDY LAST_BUDDY CACHE_HOT_BUDDY WAKEUP_PREEMPTION NO_HRTICK NO_HRTICK_DL NO_DOUBLE_TICK NONTASK_CAPACITY TTWU_QUEUE NO_SIS_PROP SIS_UTIL NO_WARN_DOUBLE_CLOCK RT_PUSH_IPI NO_RT_RUNTIME_SHARE NO_LB_MIN ATTACH_AGE_LOAD WA_IDLE WA_WEIGHT WA_BIAS UTIL_EST UTIL_EST_FASTUP NO_LATENCY_WARN ALT_PERIOD BASE_SLICE
> idle_min_granularity_ns: 750000
> latency_ns: 24000000
> latency_warn_ms: 100
> migration_cost_ns: 500000
> min_granularity_ns: 3000000
> preempt: none (voluntary) full
> wakeup_granularity_ns: 4000000

Right, figures, all the same on my machines.

> And attached kconfig, it's basically what the distro provided except I
> had to disable some configs related to module sign or something like
> that.

Thanks for all the info.  I got the same low perf percentages using your
kconfig as I got before (<0.50% for both functions), so maybe this just
takes a big machine with big LLCs, which sadly I haven't got.
