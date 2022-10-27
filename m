Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F161023A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbiJ0T72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiJ0T67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:58:59 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAF189806;
        Thu, 27 Oct 2022 12:58:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmpSZ001416;
        Thu, 27 Oct 2022 19:58:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=GjKTItGRUI8kN5aekgaKvKQ5PQSrDvAFYUoz3Xiv3Bfk1DgtsFCVXaIUq8M8Mq+GNSN4
 mYomXUQ/X7kTHPtg3YKq/00ouLV2VggOaeiy+TEbghISqE8FDhmJzpJY90yYTTTDSZig
 qVtYiaKhBdcqKOzb4luyfQ16WTx6eVp9PkuR3WBifwY9Cz+kVUo5gf8Zrs2dM0aELCmo
 UOu8W8h82XWpMNguz55yCp2JR/B1TlugUyMlfctKA9xy5bl1K0zsGWfL+K1k0IxjfnNV
 6sHYl1siy8mC+JvdOg9QO2Rho0CtfdNR93N9XsAXG+Qut1nNRPXk8U8fYJf5ildsI8Q2 Cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfawru8d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIfcS0009431;
        Thu, 27 Oct 2022 19:58:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfbcth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3fA/HGXbD7E+7wlWilGc/xZEsLNm34hEfGpTNi3gPOqu79/sYM+r4u00JuSn4FGgwZPCQPgH3vE+mdeuis+M/gtKyLCejL81d/XVNFhJHj0spF+KmMuKsrrob1TJmdNfhE1sVAjk8MzvqJM3h1D1KPl2EXo1oQJvEg+eyd4ZEEUfk/SxlCqH++QQ0HrBiUUIjt62tDGCkTmuTI7UTBHJr7BxnaypJzkdsCEqlPNkoEgGfOgyC2/siFDyLmVmGOyfVkLmv7fjZn/Fd32UxEsgPtR2CExrFdEOtPUdhbxRj/c9gYuInpsX7iY+Kc/eefamgvm/8R9XMqPUxH15KEyYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=ONFNnALnRdq0mxsXzyEzRdNRsZHRtvkk7S4sOjgSEAlJcGOGqknMrv3WJgcqejFJDOjO/28dFe07u9b0t6DDDo1D0fiuboapKiFQX+C5dp+NhshWVqu/CSENmoLeCIFKBZlxf6XQD0+EkonTMRFM5eFNL2ZL4+DUOYZbcgrHhbtRJE1scqmS/EQ2T+RKaAy1eNo+Ik85Mkbci8marmTFittvR3RYlw+Qr58y72Fhd4hbADwEJGT3PIp8XzqXUleUT4MwieZqGxa+KogTYhEju6tR3NPd4v1q03eiDvpt6n6Z8BKP75tnSgg2rqMnZM6JX96VTW7Nhtd7m+PZPQu06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1d1bqXhzhDNq6Kusl94sLc+gKjQzctiUPQdP4RW9Ac=;
 b=CSon0jwImoxGjG3nuwGkx7IWAYONDS+ytmaMiSo2A2nsmyH2XJRCS3sxH2x2uEtdWWN8R+Akv8SZVdOFcwM/VyZhAa6B3hGNZZnP8CcdRpb4EWz3xTO01dFElm5JI0nX3oXGx1qT7i3mTQYXduUtWtkyL3ybDOO0SNFSfECcYv4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:58:37 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::ff03:d749:df80:38e1%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 19:58:37 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, rostedt@goodmis.org, masahiroy@kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v9 7/8] kallsyms: add /proc/kallmodsyms for text symbol disambiguation
Date:   Thu, 27 Oct 2022 20:57:53 +0100
Message-Id: <20221027195754.100039-8-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.38.0.266.g481848f278
In-Reply-To: <20221027195754.100039-1-nick.alcock@oracle.com>
References: <20221027195754.100039-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 121745df-ccf6-43a5-f0dc-08dab855a303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RV8dQD7nPx4zfe9PqsQNL7TdVw0NNx9vfgD62eXSZwQ9lkL0HJmx9zBs1+K7wt1QiKw9faKXKuHVhKOnv+9sAGEGsB/RHdcj16XOiMJDLpoLGk3ALfm5i0+nUqluWJuzHcwxvTtIzInhAZFSvSdv4xv73VxtFg6Gl5SH3thBAqrnrLfuU2ZANp1BgSzfMGlTwa3otKr/JL1aYfemsgx17APT5tXCl3MamkTX73k57NDqDXX7+obxEmFWFrC/52XY1udPX2kpkIJ4IEBmNIYJXoy2dDNLKjckYDZjnlds4MJPiXjzO4i8kpZGfQZZgoRo1ZuK7i5zkfAoL3z5k9Yrpg0WMP24G3uhTWKpGQdmWRN/doTOiba7jstY58Y/3GQ7cOTPFOQ6Wk2PWApYiPa5hTJGUpAXbEMdwmbZKtQPUzGnABXusJFYVkjWcPWoske60QOcPdUL2vw6AvMk0GQ16fRopAdMG5CMwX019FKj0yfPjFrJPFFSiVVCXhpRS2oFRnVl+/moftJt/FxwlsplJDPBwP9sgQ6o3/gsiAPy/UdMMGC4wM+AWl0CVWFY/HiGBmB9xlqNKMM3HrGvOk+m4AYf6pQ2GvtSIKFoM/YMmstvBRcsyPwNRKxdPGiY9WNlF3+8+DLhMxhZSXAEo67F+sSgUqr4XZe/2MGodnqAxlrOhoytvsb8Ut9jaOrmSSINx1RidJwzzPa7nH1giCE0pA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(6486002)(83380400001)(41300700001)(5660300002)(30864003)(478600001)(8676002)(6666004)(107886003)(66946007)(4326008)(66476007)(316002)(44832011)(8936002)(66556008)(1076003)(86362001)(2616005)(6512007)(186003)(2906002)(36756003)(38100700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fy+xnDPJMUmaOUCj1ixlFoOAuI4QuL1jZhfSeXO0gvHjf7I85+XhCGGyz/vX?=
 =?us-ascii?Q?27IWMosiMqc5Nun6ugiaFiN726h7628wiTYDTQfxEPmj2hueQGtz65Cw/5T6?=
 =?us-ascii?Q?QdB4NKafe6VDj1QBh8ZC1TgNCXte+m9vf4SNDini4pYeiEX2cWqf3kWbk3n/?=
 =?us-ascii?Q?C75SoQpOFr5sXiTS7oXgit3pC8wruT3yBsU6EnnvCmAwZEq8raQjwVcBocrp?=
 =?us-ascii?Q?OH7jc9hz4mFhzQqzD7gVW1rKUT7sC5f0xolZPOdDmJYhaR/Rb/DdvvsCU7uh?=
 =?us-ascii?Q?sIl3xpRwYAidOIvu2b0XGIrG21EcppWvoSgNfJJBD3T3TxnSqdiuVEnZTgK+?=
 =?us-ascii?Q?hlUoi25Z/TZsgPj6/uw3/LVI6z/geTQE3cg9XSH4bkN67iZbndcyL9r6z+O0?=
 =?us-ascii?Q?9NvTyfIQ8MZli8QdXoN5Z/v/o/4N65Vveq6UuJoP76Vxj2EVKkkFgSdaTrZ1?=
 =?us-ascii?Q?wDKjqouiE8Lht//ExDQ7Efl9EG8NjvVEwnDfT8AEChJQ2Jjw1vX90RKGbDh1?=
 =?us-ascii?Q?/sKhfwIE0/f53mZUYUj5zcWkbPtUmV7X4lRTcNyntnJRcu4LQFMirhrAaS4E?=
 =?us-ascii?Q?ZP97SQn3gkQ8Hz6dlbgQsiUlNLu1c8Lf0H72iZ5COhWyUUBj41DgAoK/WsWA?=
 =?us-ascii?Q?0RUBcpMrT7ZKCZKWe15xKtUShlfoN+yyQErjNTnqNjxjcoY2788vBQ8Id4id?=
 =?us-ascii?Q?CIVX3MxoUx8sPGwVExBcTIYx2YXtuJ+92vm40S83GrNbF+HEImdzxKdYl1VY?=
 =?us-ascii?Q?Ek6ETpX3xqzobvAnj59jP2UcNmLQxHmn74t8U46fpF+tGLyhfllUZ8VQfDWN?=
 =?us-ascii?Q?KrKLJ2xH0bX0YWa7v2mf+oCOpdSgVzsh6pqZS6VZlRbhVqLXgD2QDDLucF5w?=
 =?us-ascii?Q?qix+ZK8PM1HOpE76Ce5jJphZwvrho98VY23Q5Auix7LEZpQizvpIc/hnD3vt?=
 =?us-ascii?Q?PvEC+CgynN66l4M52Go3n7+eQH/qzPoc/RAhWpfsCyWROj1Uaizaw3MhYZRP?=
 =?us-ascii?Q?65XycjnXfM/7jqz6WBXxQiegZ8dpeTc/x6+FSNGohmYPqw09+pfhK5VmVgpv?=
 =?us-ascii?Q?uwVc224yBgjAKjw44m2REv/bRpo2zbr00UwetSvtk7tG8VymKPgfwLrLLUYF?=
 =?us-ascii?Q?rwQjixw8O717vNP6/WsnzwZ+F0WB42PBRd+e5HotlQ6NjZJANApVw85kG8ae?=
 =?us-ascii?Q?cY7aPXpEOaQsBK14laT/drb38UiweIdDYrWpYVHuhbI4q4SMoK7qNh3iDzZK?=
 =?us-ascii?Q?V0szDhfX8PO+DA94mYPWg5IPKPHCke1AhpvNayVxfakA7Ag/707AXah0kI2h?=
 =?us-ascii?Q?ShsbT81NKS1VGmrNpkEgjWt0APGlBYsW1QRe+qutBVbHIfEiqe7nPokVxPZW?=
 =?us-ascii?Q?s7avxOZ04W6r4zEZm1g1PLzhRP8mveTxrGPEMiP/J7Ntf7BagVVo5ypPtBpn?=
 =?us-ascii?Q?e/7gCS/ibHav5ByWPB7k3+fOgeIq50AHFgvuQjmWHf8owpmhOUHuS5hi4taq?=
 =?us-ascii?Q?C1ykbSnUbwvQ3x8bs6AGeDcEh1obM4cdEZ3ACjJk1JviG5ueAMduzZFgl1hP?=
 =?us-ascii?Q?C/oTKeU7QJtWlDgJLFzZ5bQwd9sw+gHiK7tNVMwNW0lPIswYOOuEnzef7GgT?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121745df-ccf6-43a5-f0dc-08dab855a303
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:58:37.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3GrvOQHS/3hspnQ/CZBKkpjGQVKimBtJyEjvhmjC+Bn/6PT+skIXJ4DUF68H32UJeIQRmlPa/PcFSgHKkoEHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270112
X-Proofpoint-ORIG-GUID: bonEz2udTTi81SlRd0DzxMQLkvkrIsNF
X-Proofpoint-GUID: bonEz2udTTi81SlRd0DzxMQLkvkrIsNF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

This helps disambiguate symbols with identical names when some are in
built-in modules are some are not, but if symbols are still ambiguous,
{object file names} are added as needed to disambiguate them.  The
object file names are only shown if they would prevent ambiguity, and
are minimized by chopping off as many leading path components as
possible without (symbol, module, objfile) combinations becoming
ambiguous again.  (Not every symbol with an {object file name} is
necessarily ambiguous, but at least one symbol in any such object file
would have been ambiguous if the object file was not mentioned.)

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by address, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms;
even though /proc/kallsyms shows the same symbols as /proc/kallmodsyms
in the same order, the only modules it names are loadable ones, which
are necessarily in single contiguous blocks and thus shown contiguously.

The result looks like this: ([...] to show where lines are omitted for
brevity):

ffffffff97606e50 t not_visible
ffffffff97606e70 T perf_msr_probe
ffffffff97606f80 t test_msr     [rapl]
ffffffff97606fa0 t __rapl_pmu_event_start       [rapl]
[...]
ffffffffa6007350 t rapl_pmu_event_stop  [rapl]
ffffffffa6007440 t rapl_pmu_event_del   [rapl]
ffffffffa6007460 t rapl_hrtimer_handle  [rapl]
ffffffffa6007500 t rapl_pmu_event_read  [rapl]
ffffffffa6007520 t rapl_pmu_event_init  [rapl]
ffffffffa6007630 t rapl_cpu_offline     [rapl]
ffffffffa6007710 t amd_pmu_event_map    {core.o}
ffffffffa6007750 t amd_pmu_add_event    {core.o}
ffffffffa6007760 t amd_put_event_constraints_f17h       {core.o}

The [rapl] notation is emitted even if rapl is built into the kernel
(but, obviously, not if it's not in the .config at all, or is in a
loadable module that is not loaded). The {core.o} is an object file
name.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel, and some of
which have symbols that would be ambiguous without an object file name
attached in addition to the module names:

ffffffff97d7aed0 t liquidio_pcie_mmio_enabled   [liquidio]
ffffffff97d7aef0 t liquidio_pcie_resume [liquidio]
ffffffff97d7af00 t liquidio_ptp_adjtime [liquidio]
ffffffff97d7af50 t liquidio_ptp_enable  [liquidio]
ffffffff97d7af70 t liquidio_get_stats64 [liquidio]
ffffffff97d7b0f0 t liquidio_fix_features        [liquidio]
ffffffff97d7b1c0 t liquidio_get_port_parent_id  [liquidio]
[...]
ffffffff97d824c0 t lio_vf_rep_modinit   [liquidio]
ffffffff97d824f0 t lio_vf_rep_modexit   [liquidio]
ffffffff97d82520 t lio_ethtool_get_channels     [liquidio] [liquidio_vf]
ffffffff97d82600 t lio_ethtool_get_ringparam    [liquidio] [liquidio_vf]
ffffffff97d826a0 t lio_get_msglevel     [liquidio] [liquidio_vf]
ffffffff97d826c0 t lio_vf_set_msglevel  [liquidio] [liquidio_vf]
ffffffff97d826e0 t lio_get_pauseparam   [liquidio] [liquidio_vf]
ffffffff97d82710 t lio_get_ethtool_stats        [liquidio] [liquidio_vf]
ffffffff97d82e70 t lio_vf_get_ethtool_stats     [liquidio] [liquidio_vf]
[...]
ffffffff97d91a80 t cn23xx_vf_mbox_thread        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91aa0 t cpumask_weight.constprop.0   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91ac0 t cn23xx_vf_msix_interrupt_handler     [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91bd0 t cn23xx_vf_get_oq_ticks       [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c00 t cn23xx_vf_ask_pf_to_do_flr   [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91c70 t cn23xx_octeon_pfvf_handshake [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d91e20 t cn23xx_setup_octeon_vf_device        [liquidio] [liquidio_vf] {cn23xx_vf_device.o}
ffffffff97d92060 t octeon_mbox_read     [liquidio] [liquidio_vf]
ffffffff97d92230 t octeon_mbox_write    [liquidio] [liquidio_vf]
[...]
ffffffff97d946b0 t octeon_alloc_soft_command_resp       [liquidio] [liquidio_vf]
ffffffff97d947e0 t octnet_send_nic_data_pkt     [liquidio] [liquidio_vf]
ffffffff97d94820 t octnet_send_nic_ctrl_pkt     [liquidio] [liquidio_vf]
ffffffff97d94ab0 t liquidio_get_stats64 [liquidio_vf]
ffffffff97d94c10 t liquidio_fix_features        [liquidio_vf]
ffffffff97d94cd0 t wait_for_pending_requests    [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols may appear repeatedly
with different addresses: but now, unlike in /proc/kallsyms, we can see
that those symbols appear repeatedly because they are *different
symbols* that ultimately belong to different modules or different object
files within a module, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.

This is currently driven by a new config option, but now that
kallmodsyms data uses very little space, this option might be something
people don't want to bother with: maybe we can just control it via
CONFIG_KALLSYMS or something.

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_modobj_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules and .kallsyms_objfiles arrays that relate to a given
address.  We save a little time by exploiting the fact that all callers
will only ever traverse this list from start to end by allowing them to
pass in the previous index returned from this function as a hint: thus
very few bsearches are actually needed.  (In theory this could change to
just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much
more robust.)

We explicitly filter out displaying modules for non-text symbols
(perhaps this could be lifted for initialized data symbols in future).
There might be occasional incorrect module or objfile names for section
start/end symbols.

The display process is complicated a little by the weird format of the
.kallsyms_mod_objnames table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---

Notes:
    v9: add objfile support.  Commit message adjustments.

 kernel/kallsyms.c          | 277 ++++++++++++++++++++++++++++++++++---
 kernel/kallsyms_internal.h |  14 ++
 2 files changed, 274 insertions(+), 17 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 60c20f301a6b..9667962173f1 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -187,6 +187,25 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -293,6 +312,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules and .kallsyms_objfiles, or
+ * (unsigned long) -1 if none match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_modobj_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -564,6 +631,9 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	const char *builtin_objfile_name;
+	unsigned long hint_builtin_modobj_idx;
 	int exported;
 	int show_value;
 };
@@ -594,6 +664,9 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -613,6 +686,9 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -627,6 +703,8 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -647,23 +725,74 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+	iter->builtin_objfile_name = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long modobj_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			modobj_idx =
+			  get_builtin_modobj_idx(iter->value,
+						 iter->hint_builtin_modobj_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings), object files (ditto), and
+		 * module/objfile names are known, and if the address was found
+		 * there, and if the corresponding module index is nonzero, and
+		 * iff this is a text (or weak) symbol.  All other cases mean
+		 * off the end of the binary or in a non-modular range in
+		 * between one or more modules.
+		 *
+		 * The same rules are true for kallsyms_objfiles, except that
+		 * zero entries are much more common because we only record
+		 * object file names if we need them to disambiguate one or more
+		 * symbols: see scripts/kallsyms.c:disambiguate_syms.
+		 *
+		 * (Also guard against corrupt kallsyms_modules or
+		 * kallsyms_objfiles arrays pointing off the end of
+		 * kallsyms_mod_objnames.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_mod_objnames != NULL &&
+		    kallsyms_objfiles != NULL &&
+		    (iter->type == 't' || iter->type == 'T' ||
+		     iter->type == 'w' || iter->type == 'W') &&
+		    modobj_idx != (unsigned long) -1) {
+
+			if (kallsyms_modules[modobj_idx] != 0 &&
+			    kallsyms_modules[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_module_names =
+					&kallsyms_mod_objnames[kallsyms_modules[modobj_idx]];
+
+			if (kallsyms_objfiles[modobj_idx] != 0 &&
+			    kallsyms_objfiles[modobj_idx] < kallsyms_mod_objnames_len)
+				iter->builtin_objfile_name =
+					&kallsyms_mod_objnames[kallsyms_objfiles[modobj_idx]];
+		}
+		iter->hint_builtin_modobj_idx = modobj_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -709,7 +838,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -719,7 +848,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -729,14 +858,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -745,7 +874,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -756,23 +885,82 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
-	} else
-		seq_printf(m, "%px %c %s\n", value,
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf(m, " [%s]", walk);
+				}
+			}
+			/*
+			 * Possibly there is an objfile name too, if needed to
+			 * disambiguate at least one symbol.
+			 */
+			if (iter->builtin_objfile_name)
+				seq_printf(m, " {%s.o}", iter->builtin_objfile_name);
+
+			seq_printf(m, "\n");
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
+	} else {
+		seq_printf(m, "%px %c %s", value,
 			   iter->type, iter->name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			if (iter->builtin_objfile_name)
+				seq_printf(m, "\t{%s.o}", iter->builtin_objfile_name);
+		}
+#endif /* CONFIG_KALLMODSYMS */
+		seq_printf(m, "\n");
+	}
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -780,6 +968,36 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 #ifdef CONFIG_BPF_SYSCALL
 
 struct bpf_iter__ksym {
@@ -905,7 +1123,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -913,7 +1132,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -926,6 +1145,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -936,7 +1167,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -953,9 +1184,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
diff --git a/kernel/kallsyms_internal.h b/kernel/kallsyms_internal.h
index 2d0c6f2f0243..0ee6d97b732e 100644
--- a/kernel/kallsyms_internal.h
+++ b/kernel/kallsyms_internal.h
@@ -22,8 +22,22 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_num_objfiles
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_mod_objnames_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const u32 kallsyms_objfiles[] __weak;
+extern const char kallsyms_mod_objnames[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
-- 
2.38.0.266.g481848f278

