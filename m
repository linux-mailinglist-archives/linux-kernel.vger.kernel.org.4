Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9272EB08
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbjFMSc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjFMSc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:32:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB8D1730
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:32:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGiSKd011406;
        Tue, 13 Jun 2023 17:23:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=gZcdCqUwbM3+JkRYTiK6IxxvrtextNqWYCw13TbP6Rw=;
 b=JD4tHXMiq6xALcGpbYM6ydkESPP03JxgqxK3cQbUoNym7PgS/UKXZPTOnCPDkt2TPjEG
 nZi5MNWmOoj9cbIBJS3FO/qmmIf/u+8UO9NU6yVO/t2rjfxu5zpfoJJ0lC8fOPQ7Wcex
 t2h+OJIzO+H4G44X+AmKHS8YhnvWP9UH4ZgILabjRa8FfLkYLVHYSGhKPitMBHHrl3X+
 a1P09iV0KGU5kDGwEZaEc5EBV6q3DIsT6oQAVYVFMqeBHh5qo9sA6F+hIFhhFLGBxAEM
 1zvUu1qdpP7aU7BS4lGFLdEcTkEet8uNH+zN82wxlXIT+Ufkw6DDzUxVq2JV1XbdAJgV hQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fkdnqu0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 17:23:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DFshwF014003;
        Tue, 13 Jun 2023 17:23:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4792c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 17:23:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBVI7WSjaRYQ4W0XN50gWUbxTa1hgHmFziF2K+Dv0DSiUCe4MNu1NG21vL6TQTKaXEUL2WDC2ystck6EFG/trjKDFiFoXNh6QIxd4lqKLZ31xFyd3AsRaIRzWqBVxuUXYLzB7g+XjVS3aRgio1EfMZ/G+AvEcytpVxlUU+jEapiH5qi7FOu1fT+W212+dI6NWJNcyLlOXa6xYZZOSDm1mN0uJQdiMr/O/6uItWR4lHmBTq38p27unc8CaY6cAwn5lwVeL3+tE3wUZmA8rmCGVTExjjB+KC9u7q7jmlkFkxvMEodgHjZQJ4AwJVdAUiaXxzOCj5MScFAOv+ftFwDPbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZcdCqUwbM3+JkRYTiK6IxxvrtextNqWYCw13TbP6Rw=;
 b=MlumsgHUA2VpSb7rJLe1WaZ32OykTEe14IQUqMiYaFlO+MiN51PMKd8DQiubESwFnaGshS/Dxp9vCcxjB9HK6xU/TRliBmoGx06RGJwnTSeExpojBNyhW7O3BUafvx0vL/pbQ6pQf8ncZvoMBMkANYM3tZ95R9+O+ItEDfFhjdLRcMq8oDmMC5q7vxDYcbkgSAxwFCEYFEBitce/36Xrd/WGmtouHPLD62aOPFUDQxS4vSfKGelFmdN2ggBcPkabFspLLorMtZSaK8mjGP+2hDIG4zxy5ujpNvDB+IYRHy/igRpr77s/Ir02522JZBJ8Qqiq+2hqf4rbEd3UUL2SRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZcdCqUwbM3+JkRYTiK6IxxvrtextNqWYCw13TbP6Rw=;
 b=Q6eDiGlw00t7sc6+J3ygkNYl9L1AaXNrMUIj0JQCt1UXpjMy0XDoPIeihTeDkuNjeagwkJVaAjp7giyblZmEfQbZveNWOQ1ZYjnO6Y2RcsbLzrCQxwFa2f8sybmUIzv9W9txAsYKeL9g9yhlObLVodMjsHFALW4u5Nl6LsYN/M4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 17:23:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6455.045; Tue, 13 Jun 2023
 17:23:54 +0000
Date:   Tue, 13 Jun 2023 13:23:52 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v2 0/3] Optimize the fast path of mas_store()
Message-ID: <20230613172352.u4oj5ydoloztvdqk@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609120347.63936-1-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0326.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::14) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: a615b738-3a5b-4421-1dd2-08db6c32f6c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: esJSpoUfDbIG+6kdpxqP1BkZhIh1iPKdo7Jv0w+Gv82ZvLeDEhJVVbx38sVttCzDofO2a2ya9ZUesZL3elskrcsDmYjgU5qnq4TMxDWKrf/OVg3vlF/7ziuzeg+tl31lwoFeVxJgOnVaoGoW3+sndoXJiAfb80PiZ6J9ba4arWiMPQ1Ffyr2X/mYibq53+2FGi04qlpjBxzzPSPA6VYIWqP+ek+L5YNpAqFpS0bL2qZGHUQoY2f8X0HE3vH3rsbew5YqR5laQFilAcPR835ZGzbDsybogNFvuju7U0kzWE0rQpjifR9Qf+bKccem5rTZSvBU0uxS1Tg4hNSi8fcMuNuLlSEj4ncPo51dJbM2ufEgkLsHAdJh2mPIrplxkBopGxKjB3duAeDP0dXrvgzy+XfZ68MM1R2Ji9KkXfHVIRPGkLO1Hq8J+pmZMmxfitKUvLoBPSitWMHf3mkeo8ecarXhVD134E5gzC4sLyJkCWJpxI2cQ8IhgeZeLOD+lw6Cz667ntOqCtAQ6HdW2T/hjWqQA8yqVPoOeeKx4Xl4OXo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(136003)(376002)(366004)(39860400002)(451199021)(6486002)(966005)(9686003)(83380400001)(38100700002)(86362001)(33716001)(6512007)(26005)(1076003)(6506007)(186003)(2906002)(5660300002)(8676002)(8936002)(316002)(41300700001)(6916009)(66946007)(66556008)(4326008)(66476007)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DzKBggQN/NDAeSzKeWbZhhQ48U3kTL2nfyvV23+ZHD2iT+xsvW3DUZTp17i5?=
 =?us-ascii?Q?VmSdE6LQt/KNnnv52bSEBWINFjt4j6Ld+YujuCBVjPnK/nRoOmyELiZ6+HwY?=
 =?us-ascii?Q?AoH5c3B1p3udthxdxNmlRb881FV+VujJWYl6Xkk2v7oX+0br2OZtjJKn0c+L?=
 =?us-ascii?Q?4OSkuX8w3dwEIGBy2SdYYG3h/M/caehs6PtXskx4hFWPbAdznytVf7zyVbI1?=
 =?us-ascii?Q?mzEJZuwU3XZl1jWwIiOeCNhqGEOZ7/yAShOZAF4EwKyY3otgm1yhufMN9ByT?=
 =?us-ascii?Q?vAFmVAmfTwdNWNHDBO9OVP0QDm+FbMSMhPp7Bbds9Zmx0bLQr89jDyMFxiVv?=
 =?us-ascii?Q?qK2YQ5hiZQnDsfrEC+oTa/dG7KdlmDSBRefqD2La99TQn7KVbry2GHZ2aGlP?=
 =?us-ascii?Q?tdpqzkcaSUkwC52l1Np52rzFoxSLRyL93CfUkx2KrwsH4SPx3b2Zby0VNaNK?=
 =?us-ascii?Q?LN5almIxBE2Oic7BOuQQAGB/qNSPuAAsEBMLs6OwzUVKTKvBmfW5xKbM1olf?=
 =?us-ascii?Q?JALN9juv/EmQYXI+ZxeTFRtwXG1vSbDh6ethgrB0vAiHCaAsscbEZekJjGaD?=
 =?us-ascii?Q?g4Vyxbmor+wwDz6RfyOgAbePevjxsvBI+1VYRSb5vev5MDTX1QpoKkejR3KN?=
 =?us-ascii?Q?EmgmEiZRv0ox71ma/egY2knv6fjr9Eou4vZj+etX0MPYhEQh5rUbMyeuSrXH?=
 =?us-ascii?Q?B66XrFTO3lnztRY8xDj8fF8ATRKjAF2MbFi95a7VW+SQMhO/GJ1oigAdQwhN?=
 =?us-ascii?Q?LOIgPIp3BpBRQlraSqEjPzwvArC+SfY3vsUFQ9SNSFilF0uoduYFA8mVbQ6E?=
 =?us-ascii?Q?a1DyeFqg4iU1e+SP7tnh8SS4Pv7Rl/ui9Lqh6+/N2FKiBhcgrNdBg06NlhWO?=
 =?us-ascii?Q?A9XcyHUPMpKCgcBs2033InP1iJ8AiXzbcdBKJuq/EB6tJ8afPukKbFEp6gXn?=
 =?us-ascii?Q?KFrt61rvA2euhHLAdFia2w3+PQyWe13io/mJtUJyy8vwboMAgGL366mBY9O/?=
 =?us-ascii?Q?Wi/CdejQVkgaAza7vbmtY5R6D7PR2MyZlLhm3KWCkVhbi7yLo3Uqva+/8GRX?=
 =?us-ascii?Q?jrY8zvHUfCh6qP0LUN1bK3fk6kHu57UDtA/dl3DVEANTHgq3RKfF6Z9tBERq?=
 =?us-ascii?Q?ODAXAn3kXmPiF1vEvHThLuOmIswXnDto1G53jXub3deGYPrm4rE3fQ6ayaqk?=
 =?us-ascii?Q?41XLiQOr+25JLJq4lThGYHnAmPr9b2nKmkzWKBXMxKiJ/pGQQ0331vPh5bEq?=
 =?us-ascii?Q?PQwGyjUnUc5imEMfDNkEDEBxEgzlp3ya4t3XTbrEGZUAlfTUPWNq0CFbkdIR?=
 =?us-ascii?Q?LP+z7wG5DLlzKItD1Fqiof65/IySKIdW0xq5KjfnrvJn6N7VZ1PIDkG/OjV/?=
 =?us-ascii?Q?NSMJPqAHIkTVW7NITCbSZ6AQkIp9o0NkEpgVZuspJJcSXfzVR8Gjb6Q3uDyk?=
 =?us-ascii?Q?J5ub1lIuxhXfvqkhNnrp/WATvNi1Xpro/OQPB2l1wF30JX9ikqhhdV32MBNM?=
 =?us-ascii?Q?v6pfKGHb8rHLOAfWUAY9ODgkMV5EO6IHFfuj0hUWv59nbHF3ynN6KMXQpWHs?=
 =?us-ascii?Q?AR8I2nH2FdDV26/0jOqUSHWMoTAjmukYdltSjO6ouz0u//ktFyK1ousht7bt?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?2D8yg57cKE0+aAMoPc0jC8IDKADBATLYmLRRxClN+5Iz7QfLZu4J46hSCStr?=
 =?us-ascii?Q?8w21i52+CsFDeZkfglwL+j6N+LAxhUxDo3zxfFofHbXodwveWdCBUhAtXHjb?=
 =?us-ascii?Q?tFQTQrgdUpAfOilkNguzv2ow/uqpENQjl8S6wSyOWhftZHHEtcK+Q8RM/WEn?=
 =?us-ascii?Q?9v5EDS6BKJkSlx1iSyxaevggLt4EW1thASTDhdmbZgQ9jkk8pYsAc+uZYY+t?=
 =?us-ascii?Q?2rNICMylfvMj0k4uB4vd03SZ8eraqa5FkkyRbNhnle7NLH/xTUjeH4akIYER?=
 =?us-ascii?Q?npseQa/gMQaZ932VPGCS9GqfGuhr1y4Rq+lVjRZQPbKcwIps05VVk12F1eVQ?=
 =?us-ascii?Q?85vCz7SQtVpR4jmZOl1kl19p9F/J+zuq987khkXt1zUaX6/rqXzLkrsFSYqI?=
 =?us-ascii?Q?ZTK8mS7ZPqQh6MkQZszZgm8ePnuvYJC3wXJWcxD4JMJ9dy3ZVnNKfRTc7m7m?=
 =?us-ascii?Q?eep8WdCxQzHmrcTwNcIByHvWF9dQ/oRS/AFaT7xY1UunvTkHjI4+xqT15/tl?=
 =?us-ascii?Q?Klr023hqpYlDbhdozUrTcrxf/PGDzZuJ2KJ2Dy5RcRZCQ1gwdZBXvJX/YsHY?=
 =?us-ascii?Q?2i3Qe4XBoIc+WmzdiBkKw+cw8WIyhJ/0qr7vNAndxBRYfrw450FlXrHyUmhq?=
 =?us-ascii?Q?wX27lDo2fW7TYiXBZydcs+fWKH70hmYpn3im0nMcqoXmXbZk5UHTF+fQWAsc?=
 =?us-ascii?Q?jaDpielMtsu8StBzvmBjpzcLZ1O7nhjLIzWWLcOrUNPF/hxeGVFgESEoBBDt?=
 =?us-ascii?Q?sVlcATAVh/umCSdJO2+DLuRntpalhLuBHbNUTvlU7MN7328y4ObRiNHFyHBj?=
 =?us-ascii?Q?lbVlvF16GlIf9zBwoh0HdLo0iaIQVKOkw0066dzDo0uzNN2W/6MNxsqT0SIZ?=
 =?us-ascii?Q?7/xhGj3+p0ivl8R+d459Ri4e5zslueROYlW9lZbgVQ8wD+cA20osFpHDXPAu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a615b738-3a5b-4421-1dd2-08db6c32f6c0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 17:23:54.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn8zNTOPssvxEw/aHuZJAvt1p/Rxl9ooZ8ynjAbvJX90CwL9DApLVJPwyHWlCRAvmftfOrp/rQA8OOR5pwbBCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_20,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=308 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130154
X-Proofpoint-ORIG-GUID: oEvzaHHQALXqYjOWsHMptTfSvtvjUkIp
X-Proofpoint-GUID: oEvzaHHQALXqYjOWsHMptTfSvtvjUkIp
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230609 08:04]:
> Add fast paths for mas_wr_append() and mas_wr_slot_store() respectively.
> The newly added fast path of mas_wr_append() is used in fork() and how
> much it benefits fork() depends on how many VMAs are duplicated.
> 
> Changes since v1:
>  - Revise comment and commit log. [3/3]
>  - Add test for mas_wr_modify() fast path. [1/3]

Thanks for adding the tests.  I'm just trying to figure out how to best
address testing this in RCU mode. And by testing it I mean add tests in
RCU that does this and detect the failure by modifying your code, then
change it back and have it pass the test by falling back to node store.
This would need to change tools/testing/radix-tree/maple.c to update the
testing there.

> 
> v1: https://lore.kernel.org/lkml/20230602075353.5917-1-zhangpeng.00@bytedance.com/
> 
> Peng Zhang (3):
>   maple_tree: add test for mas_wr_modify() fast path
>   maple_tree: optimize mas_wr_append(), also improve duplicating VMAs
>   maple_tree: add a fast path case in mas_wr_slot_store()
> 
>  lib/maple_tree.c      | 69 ++++++++++++++++++++++++++++---------------
>  lib/test_maple_tree.c | 65 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 111 insertions(+), 23 deletions(-)
> 
> -- 
> 2.20.1
> 
