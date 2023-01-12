Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA9667304
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 14:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjALNRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 08:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbjALNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 08:17:18 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D8B4BD;
        Thu, 12 Jan 2023 05:17:12 -0800 (PST)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CBmCvF005040;
        Thu, 12 Jan 2023 13:16:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=UDk5kDNpNfudU4aOMdfSpeSf1JiEVy1J8GznHwKpDA8=;
 b=HCnJWqHDkYVxcAbvS8lAvPJTcB2P3Yjv9rEqRnruagpnzlE/SUJX8vsUMOMGhqHsi7Mc
 s72WdABMJnDsTm/2c+QSzZMzpPtnqdvRRNVjFtBnFxuExvAAY/b8UeiISSlkJbIPgcT1
 rx0nuqBiKUDiWd42HIP/ipjjcLjMoz8CfpbEpio7iKcJHUQc/aiAg6oVuF1TEZXmB+fr
 Mo/P0gV0FTLj5tRAjA5kxU/MgqNA1K1Kr9Ph2laX5NZsgYNtx+m2+lgW4zpYj1kMCioI
 s7ktqOSGl3dV83/FUEgHqdTHk9J7UXJKNWfPBhdhlmpa52qUoTsX7v3sxB6vNNPLrlKh Zw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n2gn8h3f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 13:16:52 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 64BDA8099BC;
        Thu, 12 Jan 2023 13:16:48 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:16:26 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 01:16:26 -1200
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 01:16:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcFTbaaDVep/WDhEqxxzhMBv4aWHZteOe2FExrDP5hJEfrakRGpusfdwn7JeT1mGt6Jd0jx91y24IXFkwLf2YQgx9O3ffdRPs8CvsEpSgj5/fpZO6dP92G5G01eCgtKPcNwrTMcnF79ckNh9xTrCRCFgJzdW0h2p0p/8H13i7GZ4Mo14d74psAvTDY6r/MdCSQ5Ap5dHArFAmNu/Y4aObCUkRgBfeGYhxveAjb7ZV1f1JeGMPgvOzatCVhp5WXuTjUGHcFJA5nJ6TzsxJrE6ZPsdvW12L40si1rLJlNqxZGsJpjRfeR48wHZE9bnopOVtwjFLKpmFrdLfqq+54qqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sNeL0jgs/nqHRPYHVdYeR+Zub5kqgf7JzNCxEGXrdA=;
 b=a+PhsuTproel1cJ06A+LPk3SrVm2bWi/yiaRiduzwfg7mahX2aGU5SXbzCSEHcbYAROpvlu3dRj0FtDMcjhMmEaOukFPvNtfSTUbNj7VNugpte0N+DZT5Af9wd1Z4LDEE1bt9Q+3q8rJ73ojbULZhomVMAR3K40v8EJmILPZmy57l6Ws6KbBh9LOEfKYMU7jXV0MPE9QA/NQCboyzEYDjISlTMtpNdcg/QhLQUNp4aOct6VYhjxKhVOBabilUQsKwQ4XkT/jWp0BwnC5FFNMH8nqRElkcWZwVdZhLJ8vmpJPbDcAzVPu/xnbKkt4iAJATObdSjquge0drJoM/0HsfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by MW4PR84MB1658.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 13:16:19 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%7]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 13:16:19 +0000
Date:   Thu, 12 Jan 2023 21:16:12 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, <arnd@arndb.de>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux@armlinux.org.uk>,
        <olof@lixom.net>
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Message-ID: <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
X-ClientProxiedBy: TYCP286CA0082.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::6) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|MW4PR84MB1658:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6901f1-39ff-43a8-3f42-08daf49f3168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nQ2VGVKV/7plqft1VsNQ6dL85nH6PTH8fMQbECUVsLIT301Rl3BtWI+DEYSS3FV+5dvGvIrXk9021zvmvrFwSHVtaJYNwilnwIym0ZuJDCuvWwnbwmbVzV38AaJuUDGiBWZkAt69VqDZYObJ2FVpUcN2VqfzTdfsKWqHHYydMAhhx9rhZdhimQhGmu73yIeHcv8gWgrQctCPrZsqwcDEWBI/HbKw7bH86avSMgfieP7LlfEc7epET2RZ+1XCGcbND5E6Lq6p21BldCmPq6s+Cl49jYRaWK83ecdkLFjXl6hLJ54lZvyK7BuueQq/F8xq9Kll39iUY62v4RYMktPMIKJ4SB1sRFCr/VldOODdfz/U3Wz3GW6DsL5qfREI84LySmLa2tqLLdD3CkITIoDKt/XrMtGX3Wip9C9CO+A8MWga+98HeNKBI0K39eT/V3FUNxas1kkAkKuipTu0MAdyb3FoKPRTCNH8XOD6D+bpquAZuzs+wxjmhUBODb6fUlHe5VthjQTTxvGjyo5JqallUCpinQjy+yHf8RIxZnJx780Q5JIRixs5Zysoy5dVR4vUOGY8KLLS7y4bqeIcN/AXBnGMDP47JKR+xonxSR1EsATyA61wQaQPc5yJfN+XSCOYFjWLuxCD/goRyq8qIvbswH1peoa8Zw342s/K51VMt0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(86362001)(2906002)(6666004)(7416002)(5660300002)(4326008)(8936002)(41300700001)(66556008)(66476007)(8676002)(66946007)(38100700002)(83380400001)(6512007)(82960400001)(316002)(6916009)(6506007)(9686003)(186003)(966005)(53546011)(478600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0RUWhXAvQO8Q2RosKo5rbeRLnbNizjL7Gj6eeoXUELEjnhZWNdJzMBTOzU7n?=
 =?us-ascii?Q?HusvHqghoqLI8vWCvlzg9WxuScbQoNsVjNzasto6xQOdiSwrYJCxkM5Q458d?=
 =?us-ascii?Q?SQmBcI0DFsX/xISqdjk53fGAnnhZNm9DHjNsMHFMCrEnXOABbc1P89BLaKU9?=
 =?us-ascii?Q?BxZJHNg0iwK8nsNMcAnzgAd8yuhHAYLE5F8e5ZMNy4wuofCsHmtEZeKUJh/D?=
 =?us-ascii?Q?Enlys0ASUCpdHzjWC2Wd1mOY7eQRTYIkWAnB+CsS4P2Nwd/36dyFzjJOhFCI?=
 =?us-ascii?Q?A0HTuE4xye49mjf98LI6gI/Lxll41pn1UpAX3TS/ghpEQOA29+gpY8eCg9ZY?=
 =?us-ascii?Q?xrCTGSEpaBvw3G25GmVdFkzieBVAg44j+25XIX9MwSbkC4quXAM9SCpwEIsK?=
 =?us-ascii?Q?1+NlUpdcaaPGUWNqq7H9UNRr2bY/TuyeONQsPfUluZaFzjUwTF9UQ+vPLHzv?=
 =?us-ascii?Q?NpVriZ93N/3yu86/S5j9Mgi+yJu8L2zsZ2IDV7QznJgoXwydqIZVVRto/Sl9?=
 =?us-ascii?Q?4ZlPhepwDt4h6DVKQo3ekKlzqTur3AVrqw79+5aZ5tI9vsjqvB3FytuylUjK?=
 =?us-ascii?Q?d06L41SCMGI67bkVDh5z3G8zo1jwyFFWxcwWD8gqJOt1cTPFg9egBx0maWKw?=
 =?us-ascii?Q?lA+dbOlyzGTroQD+HOW+m/9dNXEGmWm5DjRdfFToAGVaZ3LWKcPE9p8PwzH3?=
 =?us-ascii?Q?N7J6OcNll2BpLK59vK10oAsI+ao0o0f5lsop+CPWgG/IDa0ztoPdGnbHs/sH?=
 =?us-ascii?Q?reu3Cfk5OEb3OC42LPP7qJ0yBYwoj5PrfdgR+uTr0+bR28dP9BqI8vv0VcP4?=
 =?us-ascii?Q?UbQJHnD+kmVoOVtHmThSbQcDEDUn8YY7zrISowV4KEsWDObXDJFnZrf3tRuw?=
 =?us-ascii?Q?DcqArsvtXToHAwShZbQv91Ngh7j9qiBL8dD1WPmICYig4pNhR7lZiLLUdf97?=
 =?us-ascii?Q?p4UZhS4hQZOwmVBieMyDrK+CVakPjQdK+aXNsOOQ2F54KN+cZsZxF3CiW1l5?=
 =?us-ascii?Q?1vCNBji5AYeid90ySDbXW0vxBHXjS8OlEBBEoDKzw+XhC/RABY4rV7+q9hdB?=
 =?us-ascii?Q?wEQXa9zgcs3K9ZETI2D1s6AUHMkhiLNQ+mVLbCtKrpNoh7fFxKIUY3SCsqRB?=
 =?us-ascii?Q?al7A/Ct1auZSxJKf1RKkfDHHpqQXBXT1S+tp4L2DHWLmfIl9LFRH9BsACH70?=
 =?us-ascii?Q?Q5/OXHN3QIp0NooAgmZmKYqyhuZPBTsx/cPsRgPLPEtj6PEVcUcllkp/MNA/?=
 =?us-ascii?Q?gyMhsfb2dMItYRlich790NCTpBL1Y4EUD88fsXEAHYNCwB7m2nGYSCk0/bf1?=
 =?us-ascii?Q?5KhrXKSuZ9YhFn3nPSAdrt580nFoDX5TPL85kTC7SwOv9zWZHLC6SbGTrot8?=
 =?us-ascii?Q?DkFxnklrUzyRZ6gpfr5jcyS8OrVDbh3N/FPW8Z+vAvGUDz7VOLUcRLSBh1uk?=
 =?us-ascii?Q?jYkyLWTdNzbh1QmOoy0gDSUYFlCKP2//cK5gp//5I1nint3yqwRo1MXdUiA/?=
 =?us-ascii?Q?oduaKCzHUaj4pPmW0n6CR3TILKxYNLsLYmu8zN8MohpSsWTupzbn8afnA0X2?=
 =?us-ascii?Q?24dquDrQkRtTOFAvPb/5JwKQVXNUUus5pByde+mnqrGlVpcd+u+fGRDT7eMK?=
 =?us-ascii?Q?Yw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6901f1-39ff-43a8-3f42-08daf49f3168
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 13:16:19.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qd6SFSjqq8KRQxLp7bGM5Iib+ONeckweXS8IuxyIHLL6P2QvIO7s9MwOjbUAwmt2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1658
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 6qptj6cMRyW3nwowEXMRFAJCTazJl6eh
X-Proofpoint-GUID: 6qptj6cMRyW3nwowEXMRFAJCTazJl6eh
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 suspectscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120094
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:49:36AM +0100, Krzysztof Kozlowski wrote:
> On 10/01/2023 05:25, clayc@hpe.com wrote:
> > From: Clay Chang <clayc@hpe.com>
> > 
> > Document binding to support SROM driver in GXP.
> > 
> > Signed-off-by: Clay Chang <clayc@hpe.com>
> > ---
> >  .../bindings/soc/hpe/hpe,gxp-srom.yaml        | 36 +++++++++++++++++++
> >  1 file changed, 36 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
> > new file mode 100644
> > index 000000000000..14ad97d595c8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/hpe/hpe,gxp-srom.yaml
> 
> Don't drop stuff to soc. Put it in respective directories. This also
> applies to your driver.
> 
> SROM controllers go to memory-controllers. What is this, I have no clue.
> "SROM Control Register" is not helping me.
> 
> > @@ -0,0 +1,36 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/hpe/hpe,gxp-srom.yaml# 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml# 
> > +
> > +title: HPE GXP SoC SROM Control Register
> > +
> > +maintainers:
> > +  - Clay Chang <clayc@hpe.com>
> > +
> > +description: |+
> > +  The SROM control register can be used to configure LPC related legacy
> > +  I/O registers.
> 
> And why this is a hardware? No, you now add fake devices to be able to
> write some stuff from user-space... Otherwise this needs proper hardware
> description.

Thank you for commenting on this. You are right, this is not a real
hardware device, but simply exposes MMIO regions to the user-space.
Maybe we should rewrite this as a syscon driver. Is writing a syscon
driver a right direction?

> 
> > +
> > +properties:
> > +  compatible:
> > +    items:
> 
> Drop items, you have only one item.
> 
> > +      - const: hpe,gxp-srom
> > +
> > +  reg:
> > +    items:
> > +      - description: SROM LPC Configuration Registers
> 
> Drop items and description. Just maxItems: 1
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    srom: srom@80fc0000 {
> > +      compatible = "hpe,gxp-srom";
> > +      reg = <0x80fc0000 0x100>;
> > +    };
> 
> Best regards,
> Krzysztof
> 

Thanks,
Clay
