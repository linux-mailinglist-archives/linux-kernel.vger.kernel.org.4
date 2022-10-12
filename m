Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340E05FC0B1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJLGer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJLGek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:34:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C2ADEC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:34:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29C4tVrY027844;
        Wed, 12 Oct 2022 06:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=xL1L9ucpoJqIsgOMEzafl9yDUGwScFweAnZbTfriMNM=;
 b=BdBhgjVFDV2YwNeOnxwn8J2vVDTf3VU/2fdxSmwz7fBrswhIQOPpn1a/rzRTEF8cr73I
 YOvPf/uXMZ2F3x1dU5BWtzRCYxiYNDa1lVF8gkVd7DGJZkNQ8Eb7WMshiPBBxH1ZvK9L
 Ws4kp2CAuDxya8NjorD3Jxb/vxB6bLl6cDBRgUyXqU2UXXXG9PWU9e5lJRo8VfAbJhCS
 Ywt50zlF+dP3FEKUP9R/ceHsGRuZYIDCEZBaPybNyir6yj7Yglc86bsWctkklo/UBhgR
 F3NVzr55FH0Rdz450J423F2938hXgG7Iwc5vEWcBvmYCdJx+bS9CkUzV1aboo/IZCuTW ZA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k313a0s36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 06:34:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29C3bNNu027354;
        Wed, 12 Oct 2022 06:34:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2ynavt3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 06:34:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nedFb1gOfL/FAdfT5LckVHIEdg6CxNl48PcDhllLyunlNr3qEO5Lgdy+c6JgZNIVwyMX8x3a2pdOfg5SZqUeQOHwaWaiyKQxgQLiyj4CQ84hHgA8zD8L+PvmO8uqO6R/969hURejdNsdvTvaaA4kyuVNtFaPzx82Kbx9lHZl2fTb2wRxN/BfThp9JfQ+yWELdPcqKyIRc6WWt/1eQQGM0Oy3WRIXxKYHSQRIttFxmlpqD2CIv2cEt5uia5yHKLoBjoAHCg8ACLNqRzNTrTDGOwtJuafgmK1xzw4UvvkauZWU6qfg1zmWuMWaCycUjpu3yav1Ccgs638SyeNFkyWYqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xL1L9ucpoJqIsgOMEzafl9yDUGwScFweAnZbTfriMNM=;
 b=kDTdxBSBLJ1tWtd5kIANGKRfNMeMWg4dP9MzmkTlxiC2KBS+GplhgvAFPPlZKZu6iR2OnUDxF6ivUBYzQ3KB1TE3MfZGm27HUus5T6uyXiV4lphdEFOnG046TNoEI/qOUpbleuYWdsUnu7X2r2qsyOz9Ps/CF1Y77R9EMEX0bRFbUaC/S/1ItokiM+t5mTktJmLwqGMEopS8/70mc+kXD/qilNcNDUYIK1a7zxuPyfYFJ5jYxItdrZJdL3Lzwm9bKh5Yp9HXtzDdmDHD5xfKU8s1bJCSc0vUTds35OETNPQz9FbpRCcwyB8wjK3AY6/N35Z9krDzESTd6s4nbD0w8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xL1L9ucpoJqIsgOMEzafl9yDUGwScFweAnZbTfriMNM=;
 b=MxVRjP/MwVz9SoEc5TvFR7Ktc472JCrxtpi4SON2Zs6xrcuTWHT41WlxyRIIcSec0Bm30IYNbTvXEFmMsPV9qDFATCf+sIveTwZH3jKOm0RRjY5VvjeFY9/9m7rwfyodgpfW1RTo7zteWSxFMClC+VfUeN9lz/H7xVxY5j3EaE0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Wed, 12 Oct
 2022 06:34:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 12 Oct 2022
 06:34:30 +0000
Date:   Wed, 12 Oct 2022 09:34:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>, kbuild@lists.01.org,
        Oliver Upton <oupton@google.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [kbuild] arch/x86/kvm/x86.c:4988 kvm_arch_tsc_set_attr() warn:
 check for integer overflow 'offset'
Message-ID: <Y0Zf6g7ahY2b7MBK@kadam>
References: <202210102159.8nYEC0Hl-lkp@intel.com>
 <Y0Rm/Y5flhd734NX@google.com>
 <2c36799c-af38-fed5-3f31-a8bde25368d7@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c36799c-af38-fed5-3f31-a8bde25368d7@redhat.com>
X-ClientProxiedBy: JNAP275CA0051.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CO1PR10MB4531:EE_
X-MS-Office365-Filtering-Correlation-Id: 490c006e-6ec3-4899-7285-08daac1bd0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zi9y7n5n9NPnm1R7MJzf802CZL4skJIF5nAjhyhwbRjx1B3pwfusChgr2b53dK6clTTZA/Ii2iVaVk4HRmzaOSPoBS+crvk7S2l5A4LENUs7Mk2VfKsqkrBODNwMzVqTE0glnedq+pDG59Vc/O4pNj44bcOi/HUOPrFCfXbIeexMrz7bYnL8DCoWAgq1XLPMZZIuqwlviAsE7ekzCfs9aDek0y8tu1Ah+ONGCBBZxsVCDCIDtOG7e8biKNWp5hiOddXBhTytR5jkT4uKBN5GoF3AyMewHylvIbDYbZv9UzQQiIfd/PPZYYH8/CJ202GKQE77Gq3NieQKLAVmbqmYak86WDqBYJXTB/X0X0ck2NnkLVZAsQlhH/Jp8wXL5XKSwGlluPGTSIDJneb1WgLIBeizGhZlotzt4XZd7zoOm1vVHz3WGAbKvS7AyAe4Yns9IdovZEQRj2mCCEeoSreI1dGAPJXqViw7cMZe4b+Xug64xS+uR/oQRaFpKGT6yTgtO2X7X36R7YlhfUTZNinu6GAM7KLg1BYG8yu7gI14Vbje7/LqLJFL2tMSBLCIxfRf4++4ehvDlwl5WTiPXR1rWdM/KHCLCi5+YtGhSv12zcEIhS8Cbm2BotXzq9rgIvUCQOzxZjbG6KIUNc9ho+LkxZcLWvZekwzcoK3uuQ1XHO7ZqDrFIRkqg4kpX525t7GcUpmf+NmJ7oTsvWxCvEebIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(396003)(376002)(39860400002)(346002)(366004)(136003)(451199015)(186003)(2906002)(38100700002)(5660300002)(44832011)(4326008)(8936002)(54906003)(41300700001)(6486002)(9686003)(6666004)(26005)(6512007)(33716001)(6506007)(478600001)(8676002)(66946007)(66556008)(316002)(6916009)(53546011)(66476007)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7U73nL73S3C3l0HThsZOjhdDO/xJYCpJVPpIPFPzGOjUz/Z696CsSlvGjSa/?=
 =?us-ascii?Q?K67dmdaWo5U2zPub6F+D48h2MtXLVWjT64fcBsK+YddbdCPovaC30BbQAC1g?=
 =?us-ascii?Q?ff2lVs9aqS/wam0g8STOLrDTwbQzyKB+gHJYqP3fGejk87SsgVjMyBPY9Dty?=
 =?us-ascii?Q?y/B1cTpUQoJD3X20EOP0qBxN9TV+PPdCuKFjy47lMBrAAmmT0+32CByvAtlF?=
 =?us-ascii?Q?gHA4tIHhvRXTb4EdYW57xfZ1ovffncJtJ7se5W2YeSZeWpjqRtgLaGo0BOGe?=
 =?us-ascii?Q?8MIPpWJb+2m1LsWZqfTmpaBXRGgPOrCoS0h3Y8Qa53hWMbMpE0qgVfTsz8lh?=
 =?us-ascii?Q?CRNcjQVikSu0+BVRLmEMTK928uvfR6EDVzIVoF+QswhTKKMqw0UAW3AvP9rM?=
 =?us-ascii?Q?Pla+zEyXT9lWduaLWzvc10YLBnQuj8d4pmNE2Ieh/HoTp9duOluhnY6dBlIz?=
 =?us-ascii?Q?BzqmqkVwft0esCCd8r84ODuVlsUyT7Prteiixx2vicyYiSzISzs7EgSO+j4J?=
 =?us-ascii?Q?0h3QVseDZnwWOtGqO4Ei4qbm1Utf5R2KuuS/l5kSarAyieAz8kWOpKVAjcRV?=
 =?us-ascii?Q?nmruZjY0MD08XAaQwpRKmYU9T/PHYk2Bmb6FPyOCtKP5sL0ku1dxnUc6mfOu?=
 =?us-ascii?Q?tFDO7jOtg6v0uco/1OQ9qGf6iCJofemFTkF+VfFyNdMcZlX+9w88ZhcTDCuf?=
 =?us-ascii?Q?V2n8Vm1uqIJTiYzttjH+J8BewvYvFsbXjoeefx8E8ucIrk2A0KfIJUUZxJFt?=
 =?us-ascii?Q?ILvfrRmwCGdaLus5ciLa4VWBWGGLdprAul5nMft/eemfpWN7n9wlulPOLnLl?=
 =?us-ascii?Q?oF8PMBbU+igDMo4LufgFxxlKgqMQHshODjbJavlyUqCC5UJXD7HpS5RUgk/q?=
 =?us-ascii?Q?qOaT8WYe5xdF1tDsykCO7Byxe016twUuKDR9Ah8N3UVpXA2xe+Y+Php3idX/?=
 =?us-ascii?Q?AWsPHTTB1izt37j9XGNkB5tyoVG/96uIpG2ZsCDx/eXZUxGMlQE8/U2O7/XK?=
 =?us-ascii?Q?3GYITxnbXgGLjx7pRILwgXbrPnBxNNrVWTiP1pS0RD/7gWIY3oDcFeTdK/zL?=
 =?us-ascii?Q?SgHEpoMJ7VnIsSoGFp0MdbhM53z9kJY3LBHXzmhPld4yZVFXimSeuQvnYyT6?=
 =?us-ascii?Q?SZq4TJexjr4QvWJHRIConUwKly5ChXysYFnBwJDhkIPkQhw6cYGtWDUfmDKp?=
 =?us-ascii?Q?jXgNXAif2Z9Y+n+8npRTSN+J/l40MBz8CxCPR0CgMi2TXU2MRGRxdzDkorvV?=
 =?us-ascii?Q?IEk4ae60TOhJ/k9Tr4q+BdWaHVCya3ijRfvfqTjKltCM5ZSXGDDhWUfhTTVT?=
 =?us-ascii?Q?IoCUO95T42Wr9AhLLz+tNmfdVdVKYKf8xnyXqjBzS4Xrq+mNU9qybU6Dy2Sj?=
 =?us-ascii?Q?PqbOd0KszqW7xQtlp+PcljmwD2JMoAtN0YE1wjkYomG+wxfj9e2OjuKmIDSO?=
 =?us-ascii?Q?h8s6W0MZXjuq5qDzUt1aiEBXYD2qb0vDiAhESO/aP9N41a0B/q+YMMgKnofh?=
 =?us-ascii?Q?ZQVtrrVV4yQmyQsycXd2PSRt8E7+GzqRk0j8RxFliUwJtQG2+yDH3CpJYI1b?=
 =?us-ascii?Q?6kqnpVMUYty+gVYt+PIv2tdoVsv1cps6LhI4gg6WCNsz/Sc17gCjXGmrfzeq?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490c006e-6ec3-4899-7285-08daac1bd0eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 06:34:30.0063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ss/PYXWAt4PjpfN8dN9FjgyMa/b6sP6Lp33/z8ZHnixvLSP9S/8FZUHO8aNPT7FtDubWFFznL4BQcpD5HdKaAwIiUQ595GFh6yyIUKN598c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4531
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_03,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120042
X-Proofpoint-GUID: QEV6A6oPGuhnzloOTIewQb3eOyvPzg7J
X-Proofpoint-ORIG-GUID: QEV6A6oPGuhnzloOTIewQb3eOyvPzg7J
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 03:02:28PM +0200, Paolo Bonzini wrote:
> On 10/10/22 20:39, Sean Christopherson wrote:
> > > 828ca89628bfcb Oliver Upton 2021-09-16 @4988  		tsc = kvm_scale_tsc(vcpu, rdtsc(), vcpu->arch.l1_tsc_scaling_ratio) + offset;
> > > 
> > > Smatch hates obvious user triggerable integer overflows...  No checking
> > > on offset.
> > 
> > This is ok, and even necessary, e.g. if the host TSC > guest TSC.
> 
> (which in fact is the common case).  Also this is unsigned which is fine
> according to the C standard, though I understand that static analyzers want
> to be stricter.
> 
> > Is there anything
> > we can do in KVM to help Smatch avoid false positives?  Or do you/Smatch already
> > maintain a list of known false positives?
> 
> Seconded.

Thanks for your feedback.

I could probably make a rule to ignore clock related stuff.  That's
honestly been a known source of false positives for a while.  I kind of
have the infrastructure so it's not super hard to do actually... I'll do
that.

regards,
dan carpenter

