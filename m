Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676336A7272
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCASAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjCAR76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 12:59:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67683250E;
        Wed,  1 Mar 2023 09:59:57 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321FwmfV028222;
        Wed, 1 Mar 2023 16:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=SktaGqEyJvOn/Y8tr5/gVM0ZIF+2MSJsdWii1/w8lvk=;
 b=wucAxyAb7wvQvBrJi3Y4NRRqtz1HboKlkTpIGhloYrhoAOgdLEpb0dvPIcNLdaPvaSl4
 spewousq0lvZU+50lpgz7DFIQsS0ZO07Mf2uRtQOYhUt0RVv3x2Kc1jAjc5ZvuD+nVCI
 fcp5zWY/ouB8sv3zSWZEEwljpQuaF4byA1CPLLKOiV7Oc4RAiydG5fbHplZQ0s6xDY2Z
 7Fdp+Nf2i2P+YSgP2rEsh73baKttDf74jInFlb3OYv59Qa6SMrDlrOCy16i+IthhsFr4
 FbcVP5VsT1EmNP0s+XHpj8na+ls6afIud9n/26XgfP7dgMN0VaHZMCwvInCOuzXUYFjt mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb72hbx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 16:36:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 321GM9O9031538;
        Wed, 1 Mar 2023 16:36:54 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sfj0gd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Mar 2023 16:36:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbSeUiHH0whRPVORcVYkG+NxVvxvCt3O3daND7rACJr/TA1MR7SoOgue+52jYqc4g17OM3Sdkhh3s9yyddQPQbbV9iGxUMi2QZR6eowK6tn4rXMH3EEoLmzsS+T1MjKQ4sI5hUMsDe5YV6X902ba+I4kN27CGsTkwWDeY8765blCaYMCFAdpCafadmnstPmCIMN6UwJRmAuuSPVYS8hujArOb9IwXsZtU0+2ZZbY3lUOl6K2UbvwA3ZtUFM0sN3yqiqJB57DQ1pXtFcGDoW3ku1vv7A4U1aUtRQjNJbeBVy7LNHwydTPY6pYQgxKbW+Nl+7xqdCoI6yajLA0xmt4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SktaGqEyJvOn/Y8tr5/gVM0ZIF+2MSJsdWii1/w8lvk=;
 b=UCs/gqwyab23Ou1v8IPxfpRJ/Ss04S/tisUzIrswGLouFNFu2dNJf2ozlESOpyAJ7Ey4PKwrJQQpQlp1jbFv7rVYn/1QJQERla3qSv/AeCZnWm5Lo0FwR7UBi//oEr1cX7ZQMwI80gOAWyZHjsK2uKKp89jhOcCiJ7GCnqnfvdIPK7P5VB+VMIHREhPKdeM/lfpX4a1EzA/13NSDNVsfDmkv4IfxdDMaq7cemG0n3fEMhIRR3SBA+28CfvYvptvW+gdsVEZN3mvt8EIqUZ8fC9EgUDMvRqxs2gQNK1k+5bhAnoxjQfLZLWzBoYmlT9mwCgoxCcJkw3HLLJWGU+rJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SktaGqEyJvOn/Y8tr5/gVM0ZIF+2MSJsdWii1/w8lvk=;
 b=gI8gXwf4Q8NazJjeQDaiOcO+D16r/r8B9WKhKh/UFadzBIXcmxU/mKP3PaDvkXjaNykhWHyPFVQYn3w7O685DH6yF0zY+Xrlx0IEvi9+CwRHQWcZQuWbkGkWHQt74X41xGVcnrZzTIRtoyLYA6uPSCd02DC3b/3zwxYz7Dwtr7g=
Received: from SA1PR10MB5711.namprd10.prod.outlook.com (2603:10b6:806:23e::20)
 by BLAPR10MB5108.namprd10.prod.outlook.com (2603:10b6:208:330::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.17; Wed, 1 Mar
 2023 16:36:52 +0000
Received: from SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f]) by SA1PR10MB5711.namprd10.prod.outlook.com
 ([fe80::3e0d:2900:bdbf:949f%3]) with mapi id 15.20.6156.016; Wed, 1 Mar 2023
 16:36:51 +0000
Date:   Wed, 1 Mar 2023 11:36:47 -0500
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     steffen.klassert@secunet.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: use alignment when calculating the number of
 worker threads
Message-ID: <20230301163647.zkldvrdkkqxffvo3@parnassus.localdomain>
References: <1677112392-17332-1-git-send-email-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1677112392-17332-1-git-send-email-anthony.yznaga@oracle.com>
X-ClientProxiedBy: BLAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:208:335::11) To SA1PR10MB5711.namprd10.prod.outlook.com
 (2603:10b6:806:23e::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR10MB5711:EE_|BLAPR10MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: d7dd90f2-01be-4164-cf0e-08db1a7328e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wVqylxiY+Xb/fB8MLDXg8ToJ9KuJVun4s7ADYCgF/cPebfQtrYQot/zWqwZ/etU8UPB5wUha3qJEF03IWFy5T+56YQJXJqu8hNFhB4HT5Y/ja7Rl6KSg+4QmVCXIg71CGD39ZvxB8v2QnRVvyT5OdZhf2Kg1XAkOeFDjPYo8brV6HbZEZajeuoJY6pScWsLO8S7O0lr7Wg1ESgqSazLoYUpdYco9H5FJSrPKHuRw68fgOQxekZf8mOdrCyFu6ZyuV0PEtBiSOcKqBW+Rk6aM40adA/TjEwi/2QRvpgX6/eSTv82XJlvDjFa2osUrHWKVABfZ0HhiXvoUDOmsxFCtenDkRffVuzlfGfl3OCUGVnbTutOaB7KrHotzFN7jpRzx4nkP+5hykSs8PuQ1ncpQd6A18h3/KOEbkf5MPPmZU/FxFjrCEBTpV/tSQMEggDgJIe72bHw4fe746+t5RR5vZEU9GFuJ400rO3ixZnfzi6htgC2VimkOub2OcaQ02GjU22L9B0hR8620k6YGAbyLqIgGD3ROKSzr7lpU4nmrlI99IW54siFRc72UfpmCYTNZu1xBnpDkWjhIpYKvu2z55CwR4bw0FOeOJe3UAzhdg7aPH14dzcykD5MOgQ2mtyl5m8HWSqK/OpfYj/VmguS87g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB5711.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(86362001)(38100700002)(83380400001)(6486002)(316002)(6636002)(2906002)(6512007)(1076003)(9686003)(6506007)(6666004)(478600001)(186003)(6862004)(8936002)(5660300002)(41300700001)(66556008)(66946007)(26005)(8676002)(66476007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hJoOGIo99Gz2srpLKzIam7kwnlAT3J2NHtJZLXvQpUsEN6JSFqWp2WUeXuO1?=
 =?us-ascii?Q?5hPatqat04f+JUZA44CpZ7TU2EK+4D5TI/QafSkH0eVEbiXYJLa6u1jREYXj?=
 =?us-ascii?Q?mL0AbUNKLsPvwjLlUF/EDAS4IpYq+mHaKlPisTckBDZga2VZvLrHLuzZZWsQ?=
 =?us-ascii?Q?sLK4+WuJTZUAW5o+Wee/pggPgn+VLxWOLwv+IqFTuDJY9MDYC0fiii8693f4?=
 =?us-ascii?Q?pK3uF0RSWbsmuVNyvNMxcrm6RVydCQbE5z9+OTh3owkiXm4Fm6QK1v1tvhOa?=
 =?us-ascii?Q?slqbiaRyzbDQflr2uGdNk3jA8bdd4snzVN+Cv4II0KMJVLPXq8f2QLXTxeUG?=
 =?us-ascii?Q?om18X2Yaoa8JyrJ9UhuZm10zjVUFWrb6yiPMQt+x33cVXq2UWFoB5QiL9TvO?=
 =?us-ascii?Q?YiM3a6uYFXu1nAnBofkZEOXdC9cDNm1nc1VPeVQRUq3oph7T1+2QYRRxl+d8?=
 =?us-ascii?Q?EZ42Y7s9MD/j6OCTDvvo8gwmGu4uQ1Pblrm18V4O9P2ZQyuU39OlvkM7JhvD?=
 =?us-ascii?Q?TxZgSRcqGRiGHKU+F+5sBNhZdrkrv8os1OODk0f1KK66CTfc64cS+m+CbOMR?=
 =?us-ascii?Q?XGo2sVnyJzrKBKihnbSFJ7wbE94HJiI3MgprYOElY49uSrE4yY8ZUa+rrF1W?=
 =?us-ascii?Q?i6+34t+UL6jgNcBHAtd1oIuT/eDZuXVugjJaHs3d1bDw0JFeLILr0c52GUQ6?=
 =?us-ascii?Q?mUetttwmzwJQhwQZpGMXEUJqfiE0Kwd1yUssgsvbT7lkFIXSo7f8D6HPe3OS?=
 =?us-ascii?Q?slF0rBdx9d4sc16CD8ez6vz8y19ZbS1kaix+oC5zR8cEwALewMn5tenG0m0/?=
 =?us-ascii?Q?GY+yXa3A8zPUfbFXnOvHwO1nkInh884VVWJ/dqrIHXHvnkYDS9gJdCotIIuY?=
 =?us-ascii?Q?N254uDb9RwkOh0rK9IS0rTtzgBgNCm6fbBUetyqzO9vYL7s2a2flwo9On3gu?=
 =?us-ascii?Q?boq9QtutbZu0oidDuvUpGxO4rbJkfbQ0yT4fevKowUNWl1CR87El8QYd6+jD?=
 =?us-ascii?Q?YKXMAz9aPvrm3LAfYOZccKeWbu5w4BGsbDBDxlOobRx1WCr/KLNcoTotRJU+?=
 =?us-ascii?Q?sBm8kLl7Ypi68zQ/U74lL3CUEfXiK5xffuRRct9I7wPg8dAcYfTGlBqRp9b8?=
 =?us-ascii?Q?svYaTPT0gulZdOBqjUUn5NZ3HArcIOWvxJ1QxPygLtlNDfA+7x7rzJTacS0s?=
 =?us-ascii?Q?8GyexjmLGcM2cMH9MYTULC6VN88KvJSvfieQdTONe60XX5yDNhe1jkd1/QaJ?=
 =?us-ascii?Q?G+KMHN1lK29cD8QIz/dndVFSh1X3O5K4lXxtgb++b9M/PupEmpWkL1z0AAe5?=
 =?us-ascii?Q?gzHyrsSxPloYXla7NUK4wPzZMscCDeR3Chv+kIwhdS6FYXORIAA0Qi1EDGl4?=
 =?us-ascii?Q?PMkKoXxyCP78D1nOn0zcG01nE4ImSByl06GnrVirqSONjTpd0kYFNN4/UYOD?=
 =?us-ascii?Q?5M5WgoB4Taw3y6dvyfun/lrVe77McVVNngpJftSl7ahMPCimGnIhHfluDY40?=
 =?us-ascii?Q?ISm+99ZWZ9fNHrJxaq9LHMAibTPdKrxX/TTaTTk1FNPvp/vkqna3AisUlzRR?=
 =?us-ascii?Q?z//W9REBDfaku7wxRHVIrJOqIK+4SRNE0vKgpR7x0H0oRSQ8FjkcDvoCJpS0?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: M49kVcvzwN+f8g/0DS6Vl4PFntqzf3y3yS7MJ6bouazezHYwOAA/yMVFE8cr0cWBMx1XmhYMbeFA4RjbbKzPM0OD66ZD4x9VRKSSYUZCb8Is+zjM7ZZqKUpdBRGmGwZJVhhhpdlCyX/rSRda0Yngm24KG3Xp6HIVtMu/oOdYInc8oTRdEYfN5v9o5c/96BCMY4ex+ASNw5OKD2iuMl4+IZfIuNmYyr8/gvNYwVnfEQbDmEcWv8m2KgpCUMLAbQV1gaHJHXNxRDuz9k/Gn+/tx74iPQRYe1rY7felxqPxYZRSPN2SghVyF+qsOrr6FjOy8dukgv/H11kJa+UzAXnezhiS+32a3mRb6kqqFZnt8bTOj4IAb4xHENSmT1DvFPethMaf9u2Pd7BJjal4O6IjvK0LwENM9OVpz3Db1uIxXpW0gkkTBJKHkvjj7Tpv+Aa5u8tIEbr6U/2Z+beoVfqi0EjiaePffNX7ZNLFljnZoEuDxcYe8qR+6tWl97CSCVarnZRyEJsIl0B00kRjwQsWVLoFnIbT8OVfFEyusdZuWOmfS51ezOZ7UPYNsx8QBytflRGHehMNVvS3W4TaVcyyknkAWoiqNYN8/NJyrLAFtfmq24hwkmPgN+oLsl3KuuI4WrayvkZgfGerFAr1p14yIaCYYPkuApHMUqWQ4dYq843H1BtnRCS9o8dHI9Du3RmilNAZaglAWS2vquMaNxFP4QoT0/bG1fWLiBi8uZprPp0+Xvo5nCCrdPaNJK4a8ejfMUmBL/Ili1zWmB9bQVf9hifHwEDS2FpD3PS4a4h7Dbc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7dd90f2-01be-4164-cf0e-08db1a7328e2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB5711.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 16:36:51.6008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTLKxMJm+nE4kZN2jiUY9kOWidHT+8G3VCstMy/vD3I9+F+HIeixBdG55ftSNmMc5ip7SM6mi5bFoRRzmH7cghzHi+ibiw6+/kODjr2lTUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_13,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010137
X-Proofpoint-ORIG-GUID: 2znkJpUJNTzNnvzYx2e8g0v2MZClPBwo
X-Proofpoint-GUID: 2znkJpUJNTzNnvzYx2e8g0v2MZClPBwo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 04:33:12PM -0800, Anthony Yznaga wrote:
> For multithreaded jobs the computed chunk size is rounded up by the
> caller-specified alignment. However, the number of worker threads to
> use is computed using the minimum chunk size without taking alignment
> into account. A sufficiently large alignment value can result in too
> many worker threads being allocated for the job.
> 
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>

No effect for now since the page init code uses the same align and
min_chunk, but it protects future users from this problem so

Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks.

> ---
>  kernel/padata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/padata.c b/kernel/padata.c
> index e007b8a4b738..4abc536ecdb1 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -491,7 +491,7 @@ void __init padata_do_multithreaded(struct padata_mt_job *job)
>  		return;
>  
>  	/* Ensure at least one thread when size < min_chunk. */
> -	nworks = max(job->size / job->min_chunk, 1ul);
> +	nworks = max(job->size / max(job->min_chunk, job->align), 1ul);
>  	nworks = min(nworks, job->max_threads);
>  
>  	if (nworks == 1) {
> -- 
> 1.8.3.1
> 
