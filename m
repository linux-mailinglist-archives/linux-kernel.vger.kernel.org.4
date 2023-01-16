Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207FA66C004
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjAPNnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjAPNnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:43:15 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8271E5E2;
        Mon, 16 Jan 2023 05:43:14 -0800 (PST)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GBZmYd003386;
        Mon, 16 Jan 2023 13:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=kWEFOv5SxLA3uW49tr/Lg6ZI05MmUz9O187bIlCzOC8=;
 b=GuVJGfx0AmLwxkQAzdnYOCF7B22aLAySnmjDRNGSjmJC33WzVi4R0w2jIdjciIc7QAWR
 2KWkPUxujFrVGEPHiCihAgGTjfLAzzEUrIQa+AYpGtJh73gjXi9oy1PeDy3WZod/YZKw
 AbQZ5xl8xziu7/LC/KSKs+5RfNnTMfwtLpmCNKPh0dXt2X5nDdx6yAhcsUeXxhXfk6cH
 VowN/QxJjU6yWRZL9zibMs84JBen37R5w4bsn25uqX1IpVCJPyxL3KZnC4k1bbNxrRZw
 FZj0O3Cbk3+QikAD0QBBuVTK3cBax0usHzx3r8oA5EBSvd8awYWA26s/QVfS35DZ3O6o Lg== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3n552y986k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 13:42:43 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 088C9801725;
        Mon, 16 Jan 2023 13:42:41 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 16 Jan 2023 01:42:41 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Mon, 16 Jan 2023 01:42:41 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 16 Jan 2023 01:42:40 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=af8icf+BfxdmyV2asbanxCIyA0gYaG5AUBq8ekuVFl4uYe6N56KnK7uJWhVRkbC4R42K0+8qXQczXK0WO0JP8YX/wPJvFyFo48nOUbrmFZ4blJGAclp8ii3RNYoerTvV1QFFLoZbjRLlYTcD9OFweS7UAiYbV8SI1pgc20jNjZLEsGCsJI+eOroEKScWHVzlHp5Af5Vy3P1r8vUOZtyxGeph8YJhap4MvRTgFYF4gQd5l6WU04V65AW8ed1t07BQVLttHeGbmfyj24CNrs8ser+QlRpPhcSqGMjsCiRRJVn3eFY4jq3b+5PYAZkHb+uIF26wvox2pCo2dG/zo+g1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNNEd30YjtJnIk9C2N+iDMmS/s9xJYcLzvXsDf5lcP8=;
 b=TV8dbUlz8c/2XE8QWjnGWqlIYjgUJF2nuTIMf+n8qac8Ukcxi12KNAhNc2J0o2te4OqTSHli2oE0Qceszx3HdS3tnV22k3uI9PMhAc6CZm7f0ILZk1XQ3sOC8xU67RK4W9mv+GfQ0/zhFIREOHx+x5oMERxId6qVCi0t7KHu654MhXyPJ6dZk9nUcM7MaWX2HwZktGkKOSgc+LyhhTTFymnk4gL5XBoFuG0IBCFkk+kz4IV205HgPJkIjAlPqe78fkysQepjsCj3GJv2gvuwN+/kc6CSbYDklimkEUSI+WEVytdw11K1MHFrGqEeHn+gZ8DFXcAtxUi5Jb0jEORRRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by MW5PR84MB1796.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Mon, 16 Jan
 2023 13:42:34 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::337:c28a:4e41:d735%8]) with mapi id 15.20.5986.023; Mon, 16 Jan 2023
 13:42:34 +0000
Date:   Mon, 16 Jan 2023 21:42:16 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        Rob Herring <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/5] dt-bindings: soc: hpe: hpe,gxp-srom.yaml
Message-ID: <Y8VUOENIhe72sqMO@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <20230110042533.12894-3-clayc@hpe.com>
 <110af65f-9c18-524d-a073-ef7be60d1f5a@linaro.org>
 <Y8AIHDizIqu9u9BR@enigma.ccjz.io>
 <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48cd3e28-f1db-487d-8971-473dc8c12c09@app.fastmail.com>
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|MW5PR84MB1796:EE_
X-MS-Office365-Filtering-Correlation-Id: 73948a3a-02bd-4480-6180-08daf7c78580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pTg25F1K8eYYZMkdKkbm7r+cP/SZhUGYC9Tl8w5+2JZ7WEoqvpiRhnTi74a7H0dhCU+8ATixyCpIqKfRd2PKS7L9Iq3sWfRngsJuM1gwQ8RcgZC4SqINskQtS6Dn1Ky7yEblFdlRNiGjGtmNJsXhQgijYK3f7rLq5t/qBkKsJJsxHoVgoUAJSnACLxP+DXNquW3Rbu1XRtXGMJNEe8R5kKGJqy4Ev3u4V34wRCkFeNRyB8tjF4ICbVbAVxRHZuYZXo2c5o9ftFU2gZ1JzngkSkyhSxt6PjRSSXhCeWuZUgIedxCUL3PgjBfLn16N+1j4jGAQM2WaX7tV8F6u0MZZlSpeX/rV8HrDa99x7YOm3qy1atkQX6M38PHVpYuUoMXtnELtru9Fh0WHWB8zmDCH9Rm/3wHXHqdfXI9c/F9dzZ84HfeTauJ41XhzIaH76T7x43Nyu322NUWdaEUgKXs4JTz46uaUdeuXapdanCDAVwMQt99PB6J3vq3kGMx/7YCtNpCeIe08GvPWn1QR/GGkxJlOKB9UWnyPDRKtZHqKzqjicqrwiqO5KlUzkumcMDr66q+E8t0UbWgKX+h3DpFHYmoOoKAibnZVfAuLJRzrEMoF4pER7g6rAscw3nA0/6OOjijUhKTLiMYxRzLBlUTGHhjpurLb4OQtT0kwmNDweI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(39860400002)(396003)(451199015)(2906002)(5660300002)(7416002)(8936002)(83380400001)(66946007)(66476007)(66556008)(4326008)(8676002)(6916009)(54906003)(86362001)(316002)(41300700001)(6486002)(966005)(53546011)(186003)(9686003)(6512007)(6506007)(82960400001)(38100700002)(6666004)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5sie+04unFyqiNEPA8leZcw51C58objRWEvS7zJ2Zs/CD+Byqw+njbwzVa+?=
 =?us-ascii?Q?ffrBv9J7PYITjFMZHBgSTyswVq6/Yyhhcy3PkOgigSz4Ua1WgI0JVkGKqY5j?=
 =?us-ascii?Q?zjCd6gJlrQV8Mh+UG7OiX71v8F+6hO1Q+zPAvO132d497xWd5TJE1IH24UQz?=
 =?us-ascii?Q?JYmJeDuciowKRvMsvlbVEAMwXM/RePfAOOG0rUb1EalCQhksBI+ySJf95SJo?=
 =?us-ascii?Q?58cp6u/14yaHFRCYqUi+5bC9V/OmSrWR6qohHh31o4MGIySfmrw/Rj9OEpwx?=
 =?us-ascii?Q?6d7kV33IbB5cuYuwVfxLh7zWE3706hD1K5YRFNb1O/GFQVSbqPPYfdJ7Yxx7?=
 =?us-ascii?Q?cem2o1LoLx3Gorkld1qUCMau+CzGDzt+8Hi4fGuD+XqgbcPEzXUcYlOJxjLs?=
 =?us-ascii?Q?7CnFFH0VETnV0DDdfOfamW3xEU3GnzWpOo/Qc03zMrtakKB8U3F43o+tzRFt?=
 =?us-ascii?Q?ZSA+uAUqO+Bt1zZCc3FMnbiEUKD9mOH2vZeZ/mERPgtQGREQKCLygSu9i8Wp?=
 =?us-ascii?Q?pOCQTbyBBfSYAQ1NWmxqwGnFCSevqLokCOIm6FzCWlOkxQpJEK5huIdAl4mC?=
 =?us-ascii?Q?JbrfHWe8L8aI+cU0wnJoARygY4mHzJD3lNv9GFxodyfnb0xAZb2R3uf6wJpN?=
 =?us-ascii?Q?IxKcj4hgMTw9xKnu82jWwkdblXpF32b3P47N80klYfTeOCNh/Z0N8cw/ks9d?=
 =?us-ascii?Q?Pl2ceNX+hVMfrTqvHDVYQW2qLwXeEpXBE5l1qIp0MNU5iERsCMewEqoIRbxH?=
 =?us-ascii?Q?ypAVMSDyVpEZVGkpxp+LjyhXqUlOYdZ6rJcNoohgmrb/ug/DyF6JK1wYAo+u?=
 =?us-ascii?Q?5Xt5zPSMPhk+jTQxbNdLehskYDOJy3T8Si5twr5Sv4QcEsC84NYiplQdyUji?=
 =?us-ascii?Q?CPP6jM96Xo5YPimpLKQsXhKYYHA4CuXrIhzf7kli4GXlq8HGfotZSlKW/gZ1?=
 =?us-ascii?Q?VKzFwucThJE1KimzEIqaGDwz3/QPv5KNfUxCUWWLQrKQEumOjkY8r81jGvQV?=
 =?us-ascii?Q?a3rgrDqcKGMoyK7JRuKRhCc0Q6mWtvGAnVggwSBW7i8rZZt4vXe6rV5//4pw?=
 =?us-ascii?Q?oYkaF7aLjWHLwL6RktNDIIdjxzMp9OtVPeXQgboA2V6NebRVKTQ1XsOcxJEB?=
 =?us-ascii?Q?dcv/t45S4e4sLqsH6tebzhpqsKZqdEOxOVjSUJL3KgRDx0lg0POQ4Ky+8bLO?=
 =?us-ascii?Q?PlIPAkUd8pR6rki1P/TcwJTLuUca5LvAWWinqvHvjJQOu6OMditFNF8T8BmK?=
 =?us-ascii?Q?ZBVRiJ0Z8IiC68mBC2fcgb8Txv3Vj4nTY7O/b9cFbBww8JTZHKQUShutDMHc?=
 =?us-ascii?Q?GJzwjORPPCa1bYbYrJ9WGh9gSMBzdmJtk4wgYSMTe4NV3Soh9lFIJoPu5LnE?=
 =?us-ascii?Q?LZBuRYG2uH0rwO0BCa4017hQsihkiVNJQmtpfhsyQYkqBSHs3X5yyU5cg9nB?=
 =?us-ascii?Q?PTNMJhJ2pRoC9sLMBUs5KrdJ0QFUT3HRONVHxuDT/dLGPTxjgcKVvnPJLIK/?=
 =?us-ascii?Q?4J0/aDnyjv4ZNcO1jRFweBRBOJkJZzfH3QoaJwMcdTo6CaBIhTRc4MUJ6+Cs?=
 =?us-ascii?Q?5pygPqU5Fas0pWpkDq5+tbcPrkQvfwJ/HbNoXrjCqaKc/0PE9EKsXD4y/qpY?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73948a3a-02bd-4480-6180-08daf7c78580
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 13:42:34.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyLTnQVb/ibmJFPxSvdmMTT8fylEzR3LIQpoL/8jP/LktifPnGZKU3BKY5RqaC8s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1796
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: ulxB82YQpxeZ-zmDXPkv1UFqS69-Kiib
X-Proofpoint-ORIG-GUID: ulxB82YQpxeZ-zmDXPkv1UFqS69-Kiib
X-Proofpoint-UnRewURL: 2 URL's were un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_11,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301160103
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Thank you for taking time to answer my questions.

On Thu, Jan 12, 2023 at 02:37:53PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 12, 2023, at 14:16, Clay Chang wrote:
> > On Tue, Jan 10, 2023 at 10:49:36AM +0100, Krzysztof Kozlowski wrote:
> >> On 10/01/2023 05:25, clayc@hpe.com wrote:
> 
> >> > @@ -0,0 +1,36 @@
> >> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> > +%YAML 1.2
> >> > +---
> >> > +$id: http://devicetree.org/schemas/soc/hpe/hpe,gxp-srom.yaml#  
> >> > +$schema: http://devicetree.org/meta-schemas/core.yaml#  
> >> > +
> >> > +title: HPE GXP SoC SROM Control Register
> >> > +
> >> > +maintainers:
> >> > +  - Clay Chang <clayc@hpe.com>
> >> > +
> >> > +description: |+
> >> > +  The SROM control register can be used to configure LPC related legacy
> >> > +  I/O registers.
> >> 
> >> And why this is a hardware? No, you now add fake devices to be able to
> >> write some stuff from user-space... Otherwise this needs proper hardware
> >> description.
> >
> > Thank you for commenting on this. You are right, this is not a real
> > hardware device, but simply exposes MMIO regions to the user-space.
> > Maybe we should rewrite this as a syscon driver. Is writing a syscon
> > driver a right direction?
> 
> There are two completely separate questions about the DT binding
> and about the user-visible interface.
> 
> The binding needs to properly identify what this device is. I don't
> think anyone without the datasheet can tell you the right answer
> here, it really depends what the other registers do. If there are
> lots of unrelated registers in a small area, a syscon might be 
> the right answer, but if they are all related to an external
> memory bus, then categorizing it as a memory controller may
> be more appropriate.

Our use-cases are more like some register accesses not related to an
external memory bus, so syscon might be a better fit.

> 
> For the user interface side, I don't really like the idea of
> having a hardware register directly exposed as driver in
> drivers/soc, this generally makes it impossible to have portable
> userspace that works across implementations of multiple SoC
> vendors, and it makes it too easy to come up with an ad-hoc
> interface to make a chip work for a particular use case when
> a more general solution would be better.
> 

I agree with you. I have one question though: if we create a 'hpe'
directory under drivers/soc, and put all HPE BMC specific drivers there,
do you think this proper?

> Again, it's hard for me to tell why this even needs to be runtime
> configurable, please try to describe what type of application
> would access the sysfs interface here, and why this can't just
> be set to a fixed value by bootloader or kernel without user
> interaction.

The register is used for communication and synchronization between the
BMC and the host. During runtime, user-space daemons configures the
value of the register for interactions.

> 
>        Arnd

Thanks,
Clay
