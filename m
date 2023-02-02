Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152A0688200
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjBBP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBBP1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:27:14 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4177199B;
        Thu,  2 Feb 2023 07:26:37 -0800 (PST)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 312E24oa018726;
        Thu, 2 Feb 2023 15:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pps0720; bh=F8Nku8n4CPpbn5XZemYVQRbKGy3wntsPxVOfdqP7Tmc=;
 b=G9Zgp1KSwLKD0ERzNGwz3gc41mooZopVvgHqVDsfnkEOAyWKn7/hTZmdfL6B1KvbXscT
 Moi+tQtVGVZuqQfyF3elQiBK+UIT0CkT1TbbTsOKuskIBTkC6qaegBfpCbSdT5F1+BfP
 zekkrU3l1WVvZv44qW3FN3d/b3qJS14R430IpDYoBQuL0mknHst3TzCXm5/TI8pJoW4k
 l1Igxb02Pnx7p7eA2hjW8kbvm6sCBhIRKzazqGcBqhIJm2IIxbRxQtBIYqS6RqSkIr4r
 ITwpj+PwPFaISHOQyQ6EtytaDf1um6uM/a/FXqDsKzeB6aPYDOxJpgmWt2N0x+fiQwr8 Ng== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ngbpetx5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Feb 2023 15:25:25 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 6842013198;
        Thu,  2 Feb 2023 15:25:24 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 03:25:23 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36
 via Frontend Transport; Thu, 2 Feb 2023 03:25:23 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Thu, 2 Feb 2023 15:25:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC37tIp5uFbAxV96kACQ7T+87Fcw8voBtsRF+hmqWG4/80swYdwlwIMdXkxkLwA2E4sLOZNXfA/msd7f3kt0cdrIM7+ThWNCpy1hLTU6n1DxpbvigvO4T5Fqp92BONbtG/IO5sp+t8wbgisXUNTpeHAQZrlQSQGOJZ8C+bS7yuTbty5fdUoNLrB/4gzCjnMLgwwn/l8tS7nmKwFqugVMDr92cz9L9bjoNOo0JutBQI0sHv2GWBABi9J+Yq1LaR3fNVJm5nbIAf4P2KOOLq1Poax/l7DSFky8hc6HyIB+UAz2Czo1W1tAFnxPmKKjzI9iccSUpCcWc7F3uWkiK2OHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8Nku8n4CPpbn5XZemYVQRbKGy3wntsPxVOfdqP7Tmc=;
 b=Al/GVQtG2i5AYuZGIbCPIzNgdBsjl7eMFass5smqj6eIVI89p3/mwqYPfXPq4IC2ffcEseOtkoTICusjDxIgMvXI1b6Qw8lUwTbbhnNw8FE9mxtFJHGwDSN6x/ZSPCkeNrSQT/zIm9sw7yJju9ubh5e4m8cFDfAdOk8SojKfzeUybf6S4PJWvDxDfMkJrHdsgyRTxfOxlqjaRxvLlGh2xDUsxndYnNwoTy5O9mh03I+MYkSOoHm+480lWfVDLEW0JrXd+SOELq2iwpT58HlBNIgC3woEkqRjmG9MmqePsSptHsmb5P27j6iFU+bT0+dPkQfkkN1NQOEZmbzLETG6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:173::21)
 by SJ0PR84MB1388.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Thu, 2 Feb
 2023 15:25:20 +0000
Received: from PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9]) by PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::c770:7bb6:97df:69e9%9]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 15:25:20 +0000
Date:   Thu, 2 Feb 2023 23:25:09 +0800
From:   Clay Chang <clayc@hpe.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <verdun@hpe.com>,
        <nick.hawkins@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 0/5] ARM: Add GXP SROM Support
Message-ID: <Y9vV1WFinNVpLhvi@enigma.ccjz.io>
References: <20230110042533.12894-1-clayc@hpe.com>
 <7734c165-5918-4677-b8d4-f7d5a3ed37d5@app.fastmail.com>
 <Y9kbsRsRcOnGS0ps@enigma.ccjz.io>
 <Y9ppGn0rLfnA3vz6@enigma.ccjz.io>
 <206f0e93-059d-4657-8359-0c5080797c76@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <206f0e93-059d-4657-8359-0c5080797c76@app.fastmail.com>
X-ClientProxiedBy: TYCP301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::18) To PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:510:173::21)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR84MB1480:EE_|SJ0PR84MB1388:EE_
X-MS-Office365-Filtering-Correlation-Id: d1e2f2b6-5299-465a-40c3-08db0531b1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aV7QrFzl6lmo4Fi+k3o1LYvAbJjvg0DVUpaCnWhE731sF96uNBGp5i9xtXhGrZLOIdEWQeoeqWl9TYRl+QHq70OGPKTSemJo0k3AJBLp0Lb6LnuGXYsaGVwy49oSIyHR3zetjHgqxDZSWEe5SxuM8LZ9vOdtYogQIyA5Uh1AKp2D1S4bpUnCl3fo/Tm1U1si64S0a6sBt6YOn4ZSNEeM1nXlzHY38QCVwrAhVgBQalaQreeMe+ncZIzoNmbhXYC0iP1+n/O5KBfpjm9HgCL3V2aeE7uUBTbUUQl/ZwTVqI3+9eAbFuTprL17JLkB/gDPH9HSWvEq8nwhX/jhtYn84jWgoX8nyEVms/sP+0989fsjknBroGBpoodXf0buM3gvk2iZsp6yv3+C0/JnjdTihOCHFDnOkzSSeYnM8R0Pllh/g25oNa1N50ZjQAHGOOO01XvIhynE6jeqEpdBNzhflaOZH5mL9YjPw9mnPqoSwOwsUVtqYCqXx7tqE6Lk9ADDYZ6sPHvsvBOzAq7sY5YZ4onwsb+NzOjwK5pa0bZQYTa/b6AYWSnsyTqjvbsu2Je0f3xrCtssxxTwWmymG6BhsEZ7jiBXQrYUiqhIgo9ducGR6a5lm7RnyazxTVVmEAWjITdkA/iupeqRYoqHQPhgtfXCuj2ohTRG/0TYjanTcGMDVaRzLUphDjKMygi7rEgYUwCtaUby6kg4EEwytSRTXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(6916009)(41300700001)(8936002)(8676002)(66946007)(478600001)(66556008)(86362001)(6486002)(66476007)(4326008)(316002)(54906003)(7416002)(6506007)(966005)(5660300002)(6666004)(2906002)(6512007)(38100700002)(9686003)(82960400001)(186003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5V5B3KLUd6K+5aw6UecdczaNZKeUNr1njhGgdl3gH4T+9PdufMOKY3dJyS9s?=
 =?us-ascii?Q?hGOEXlMenPpPyfBQeQELebUuAZvkwt+gmbNJXXpQGeExZPWfThQ4/FLUDOWj?=
 =?us-ascii?Q?1o+1amHlY7k+jeNP8IeCZZr2JbsyoswGjbHsSdOBYBhkyFjKhu/lG51/X4Uy?=
 =?us-ascii?Q?Fk5rlDdFmbRZ3IB64jSRgAtzpleqXzdbdI2taapjii12KgUQOMAKk6wo2HRS?=
 =?us-ascii?Q?HfZVvnexNSAjCqT9+d5GkX4tbuWuigBpwsDgFT/mZyF728tCLBoykkA5J0fm?=
 =?us-ascii?Q?xdf/Iodvz75LCVtzPyvX7FL9UyhuwQwQyc0uWE8Jmqfj7I8W+7R+E0P0303A?=
 =?us-ascii?Q?s34etECW5I2fF6SBSmIkJWCTA+cLhdLhW6PtbpAcxlYV7auaKnTSNkVYHQRU?=
 =?us-ascii?Q?OlSwd5XmF6RMJ+nGncqH5V4VeAGEyY+zHZcYzr/PO0cy4hRyCZw8YSRd+Rws?=
 =?us-ascii?Q?LSwJka6hLI4EuKxvw2psv+6A2wt0YMt3l3z0XtrNoPggiTmgssHPfQuemY0b?=
 =?us-ascii?Q?eb94dyMaECv0C9CHWRxsYESXxgoJmNUItthGEi6wolR+1mpFNmgkNeTYUlAp?=
 =?us-ascii?Q?QscP7kINvdwO0my/wlrhGyUfsJDPReMtDrWooP0C7UYUWExR1UZiIXX0O+7m?=
 =?us-ascii?Q?1DdtKtym/EAfHZ1zAYCe3p9a15IR6vTmOSwOTAhABQrYRRk3Z9bfs1J8Nkkp?=
 =?us-ascii?Q?xrr3bwUL5MIkRu4bmm/JVFxJfv8zix/KNsK9Sfx0KzSq9UtpNm1KlxaeUVRQ?=
 =?us-ascii?Q?SWnGo1G6e+fxxQCzbzPVP5RIVkvqucQMekdc3aWYFVcY7i0qtp5gXHLJFpEf?=
 =?us-ascii?Q?zk/PQyC3RwKA6qBxqn1kTVWl0cjJT2sQE1ZAA8zKtQYJ+0+mY/5GfGlFM4ee?=
 =?us-ascii?Q?OnqTB/Iak5m6nY9uIkJmahcNQGpa5mzOp5dx9ToIeC3HjccSuSYQSgyB+a45?=
 =?us-ascii?Q?1a2KPJdFWXpnNd3M1K52Bl48qcoVmp/62f7q0hjG4H6MQJzjCRYa9W0YSq2l?=
 =?us-ascii?Q?RHdU9E7gIpbJBjuaG4uloxPV/mDJeSkeAQXW5Q3QJ0OEJRER5D7PpAl7Dy1k?=
 =?us-ascii?Q?vY3CF30wHImcCjumrujsmU0GL8GrJ6g/CXES3xdstBVrV3DtKfGGwYpB8B4Q?=
 =?us-ascii?Q?S6dR8tf6ha55Jg63y+AcG1YNXowEO2sBhP8coIFk8ot2Q1YTFY5LztNN8vO1?=
 =?us-ascii?Q?re92Q6HLckrj0BIYr22vkMjTlFQi1z932yG0usZxgdg7cKTsOBeraZDBrVN/?=
 =?us-ascii?Q?+juovUBflfrSqDyNJJ+V9iBuE1PlUFmjIbNj4ibn8l7/L8dqonMy+VhoSY7E?=
 =?us-ascii?Q?xWu6yLErmsIkPD61BHN7UmrQPYKTLBcSk2QRzVrc1KKtiOf+KNwxrKvSxTc1?=
 =?us-ascii?Q?Ud+EcybV+MEQcMf0anHNrMTjEFSRgrs4i0j1ucdLhU6YVqPUq03ZdG1Ek+MP?=
 =?us-ascii?Q?fMLF0HNV1g2Tch5aArz8iomP9gV9HBTwfXhjGoVDng3JGfevTemRRCuzmuXA?=
 =?us-ascii?Q?gy8dVujdAR8jHE2/mhsZAzBp0pIpb9dWlymDOKsnCVJCWbcR8ifKUw4J199L?=
 =?us-ascii?Q?OKJfSuWzIos62yCAnaCaXyAo7eOgOQarX9kKG9Rj4ldEpdYA9/ojx3dkoVA5?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e2f2b6-5299-465a-40c3-08db0531b1b9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1480.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 15:25:19.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2JvItBbYfdVJlaKsTBDf4VhyZwuy+VUa00bceSyd7TCnkJV5WntZfqqtbUYO2P7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1388
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: QZcVqlJrdNxa3-yk-Kc995iLN2gPvcP4
X-Proofpoint-GUID: QZcVqlJrdNxa3-yk-Kc995iLN2gPvcP4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-02_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=930 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302020138
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 11:42:49AM +1030, Andrew Jeffery wrote:
> 
> 
> On Wed, 1 Feb 2023, at 23:58, Clay Chang wrote:
> > Hi Andrew,
> >
> > On Tue, Jan 31, 2023 at 09:46:42PM +0800, Clay Chang wrote:
> >> > I'm trying to understand whether we can find some common ground with
> >> > controlling e.g. Aspeed's BMCs LPC peripherals based on Arnd's query[1],
> >> > but the description is a bit too vague right now for me to be able to do
> >> > that.
> >> > 
> >> > [1] https://lore.kernel.org/all/66ef9643-b47e-428d-892d-7c1cbd358a5d@app.fastmail.com/
> >> > 
> >> > Andrew
> >
> > I briefly studied driver/soc/aspeed/aspeed-lpc-ctrl.c, and IMO the
> > similarity between HPE GXP driver and Aspeed's could be that we both
> > expose the LPC memory addresses or registers for configuration purposes.
> > However, the functions to be configured could vary. There are a few sets
> > of registers that HPE wants to expose for configuration in the future.
> 
> The talk of "exposing registers" feels concerning - we're trying not to 
> do that directly. Instead we want to lift out an API that constrains 
> the behaviour a bit but works for both of us if there's overlap in 
> functionality.
> 

Let me describe it more clearly. We don't expose the registers directly
to the user. We describe those registers in the device tree, and then
the driver exposes them though sysfs interfaces. Users access the
registers through the device attributes defined under the sysfs
structure (e.g. /sys/class/soc/srom/vromoff) exposed by the driver. In
the show/store function pair, we get or set the regmap or memory,
validate input, do sanity check, synchronization, and so on.

I learned that in the drivers/soc/aspeed/aspeed-lpc-ctrl.c, both mmap
and ioctl were used, and revelant ioctl commands were defined in
include/uapi/linux/aspeed-lpc-ctrl.h. Is this what you mean an API for
aspeed? And we are trying to see if there are commonalities among us?
If yes, yeah I think it is good to see a common abstraction for BMC
chips.

Accroding to [1], I'd comment that, in terms of flash update, what we
want to do is similar to what was described in [1]. The SROM driver I
am working on partially layouts the registers for flash update for HPE
GXP hardware.

BTW, the way for user to access the registers is flexible - ioctl should
work as well.

> Can you point to any documentation of the behaviour of your hardware? 
> It's still a little vague to me.
> 
> Andrew

I wish I could, but there is not yet a technical document or datasheet
available to the public. Sorry.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/commit/?h=v6.2-rc4&id=6c4e976785011dfbe461821d0bfc58cfd60eac56

Thanks,
Clay
