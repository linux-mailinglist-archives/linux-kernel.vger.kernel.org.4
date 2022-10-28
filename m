Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1617610C99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbiJ1JAe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Oct 2022 05:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiJ1JAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:00:30 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn2237.outbound.protection.outlook.com [52.100.163.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B93B2DA6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 02:00:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJ4E5NbgwB9g+LkRPucIfUwX4HRx5uRDcgaQHW8z+r+Vp0A+gedOTqqOBrD4Ib/+zM+hVD1m+iKR0kYNEvRnUb0h4vMfu3Nf95B08qtTXFrv48GaHf0d+jk8kB4G7V4aQoSl6cUwtUCNRNNYOcTboG9bd/fI6qUZVBqbf73APzT7YAA8GMJQqcTwF38dag7D2djJFjcqreyVL6OolNAA7innpWclmXXBgz9tJqpN4J+KVrdqU/gp0axjBa4WqBQPckoQF2ALilunHw/AN8yP0x9ozMmOfH3HhRQ7gp+nulKQMdRtMC81IV4nGWwgfUkwmRPt0KHu2XgAbpb73fJimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71b8Hcq0jbWLm9Mr1IJyvq/N3UExkjznuA19heg3urU=;
 b=FFTmI0Fa/GL1WdF/Xv170kw4deIMO7KE45Fe6Tfp6PmC7o2/kCx/VrgsdkwjnJPI2jvqmFfLm1dv1qO8+HhuGgxDabDIijW1BhZ2/PKWyoh79ARTsE8c+MVJuhGRc0N850J3hH0qJcYX+q7RFawbSCgfIwRj6YSQkSsmVe+C9RBWzTGWZJLI2o7hwOIDuoCTLvKbup2C0HzUk5QdLbxPiRmxNFqMvXvTmQL6ZreQ1kEzMeI8H7SfMJ33Yfi286GRrn0kLmBUSaNPNLS4KLhFAEb71z++EksoYvtl8s0bfbS0Lfc6cWhB2hIgJgnPzvBr6IELTerxwDYN3Vrsote0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 209.184.167.3) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=sheldonisd.com; dmarc=none action=none
 header.from=sheldonisd.com; dkim=none (message not signed); arc=none
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by DM6PR15MB4007.namprd15.prod.outlook.com (2603:10b6:5:2bb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Fri, 28 Oct
 2022 09:00:26 +0000
Received: from MW2NAM12FT112.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::b3) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15 via Frontend
 Transport; Fri, 28 Oct 2022 09:00:26 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 209.184.167.3) smtp.mailfrom=sheldonisd.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sheldonisd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 sheldonisd.com discourages use of 209.184.167.3 as permitted sender)
Received: from mail.sheldonisd.com (209.184.167.3) by
 MW2NAM12FT112.mail.protection.outlook.com (10.13.181.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5791.9 via Frontend Transport; Fri, 28 Oct 2022 09:00:25 +0000
Received: from MAIL-365.ad.sheldonisd.com (10.1.16.82) by
 MAIL-365.ad.sheldonisd.com (10.1.16.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 28 Oct 2022 03:59:42 -0500
Received: from [193.47.61.101] (193.47.61.101) by MAIL-365.ad.sheldonisd.com
 (10.1.16.82) with Microsoft SMTP Server id 15.1.2106.2 via Frontend
 Transport; Fri, 28 Oct 2022 03:59:41 -0500
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: [EXTERNAL EMAIL - USE CAUTION] Greetings!   
To:     <linux-kernel@vger.kernel.org>
From:   "Mr. Paul Morgan" <wendyarandas@sheldonisd.com>
Date:   Fri, 28 Oct 2022 10:59:41 +0200
Reply-To: <paulmorgan5377@gmail.com>
Message-ID: <df5c61c1-c1b4-4980-a1e2-8e34c04357d9@MAIL-365.ad.sheldonisd.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT112:EE_|DM6PR15MB4007:EE_
X-MS-Office365-Filtering-Correlation-Id: c5605b48-2323-455c-9370-08dab8c2dac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?iFr1bSGwCvoie5yH7RALmbNBIU89lu0nJXgePIMoK8kecIfEllTnHk8VH5?=
 =?iso-8859-1?Q?D72jdQm7V5yhGe/5xLcTUZHyy8EI14F0nwatB4Vl/JGEOvEd9VL4xYQEnL?=
 =?iso-8859-1?Q?+pt+fFM1mzb/PvFA/ldInTg5Vr1+SMg85hQR54LQhVQeLnG70b4BgxPlUH?=
 =?iso-8859-1?Q?a7NTZYKRR5F8H7Y1uR8BMEmfYN5V/bRX1lYmAdPoh7gCQOBKp+5nNo1HmS?=
 =?iso-8859-1?Q?GcpDEUlzi/S/iP+odSsNKdIAnv9uNuNC1bw3xfJAp89pidkv8Zqbg6rWfQ?=
 =?iso-8859-1?Q?TE7C7+IBUP0TDHXaqp+VyOkP6chAb2MGC06+OPxgh+aoBIJQvrKt3d1nH0?=
 =?iso-8859-1?Q?hJ42Fg0zDfPGe0iMZtrYnlFDTF2pA8Md4srP9sWcNlMZInGO2ewdy/wOAW?=
 =?iso-8859-1?Q?9DpB7Y1ZyzYsY2oVFvfX06YWPMSv1r8Mdki/Pa9eR4SxvkSqeFwrK2Z6cM?=
 =?iso-8859-1?Q?9ldajzd51HGEgdwmVeL59oVYBUR38vyK8I+BJQfZxjRTX1BoWZbZ1IzEhN?=
 =?iso-8859-1?Q?8CAz9hlsmYmnNJlHj3SZdzAPreDnVICv+K1C30CrT/T0YGEPRVPhazL/eV?=
 =?iso-8859-1?Q?Tw0CwUTSDzL/QXYVSkth0ZsvK6k734UlFN/GIxaQhniPH9+/wVYSDuQJxi?=
 =?iso-8859-1?Q?vpDzgMFZw+ASG/SOczlE3W92dFKGGb9GE6oghZnSn9NXFzmxMdQAU45yV/?=
 =?iso-8859-1?Q?nnpdka24vo0Ivgb+Aqxr2ipdYXdJ6IXAFnhUHIS3XCXycfI0zNC7feqnZx?=
 =?iso-8859-1?Q?9n3oaU1np3TfI17ayYkeoTGYoetITMbvcQw4CpZwHqEvsYZKGWKSVRREAT?=
 =?iso-8859-1?Q?t6TlOyE9M2Nlr9cvetbyrxVi+2xVwf6t19wFWE+k+heJ4TLDQ7C8AA6Asc?=
 =?iso-8859-1?Q?7Mbh2p8I5m03rh88eAgz2kq0N3VAD6QOFng5HVXrujphxH701M3X1BNB3r?=
 =?iso-8859-1?Q?RFFWFykkYuIUpzCPT91jvXk+PuEQ/32FyWEmNjTK4j2vpRLsMGR33flxDa?=
 =?iso-8859-1?Q?wI5JxVWsrWqn3wDy2P7KkLYmoyNIh/DFr+LZ7qEDdeGzwlzyl35acshmzO?=
 =?iso-8859-1?Q?z24p506wInF5vkdB7YN+4+MT200vVCG3uSmaf/NOtUqGVY+BDMZerD79NV?=
 =?iso-8859-1?Q?DuzGxUULn1hBGYr0FXtajm4VFH76BITnIn+AUMC09DvgToWerDE3BMDexp?=
 =?iso-8859-1?Q?uJWUsj3mndEi0jP9HjZKUXfvM+m8lEts4VZLcxfX5ePjfuFPiUIAFm0H?=
X-Forefront-Antispam-Report: CIP:209.184.167.3;CTRY:US;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:mail.sheldonisd.com;PTR:mail.sheldonisd.com;CAT:OSPM;SFS:(13230022)(39860400002)(346002)(376002)(136003)(396003)(451199015)(46966006)(36840700001)(40470700004)(41320700001)(47076005)(956004)(4744005)(31696002)(42882007)(70206006)(82740400003)(8936002)(70586007)(8676002)(356005)(83380400001)(186003)(5660300002)(41300700001)(83170400001)(6706004)(36860700001)(2860700004)(7596003)(2906002)(6916009)(7636003)(316002)(40480700001)(426003)(336012)(786003)(478600001)(40460700003)(26005)(16576012)(82310400005)(31686004)(16900700008);DIR:OUT;SFP:1501;
X-OriginatorOrg: sheldonisd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 09:00:25.7656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5605b48-2323-455c-9370-08dab8c2dac9
X-MS-Exchange-CrossTenant-Id: 3237ab13-a154-4aab-bc15-73e6206d6acc
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3237ab13-a154-4aab-bc15-73e6206d6acc;Ip=[209.184.167.3];Helo=[mail.sheldonisd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT112.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4007
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_50,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        SPF_PASS,T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAUTION: This email originated from outside of the organization. DO NOT click links, provide credentials or open attachments unless you validate the sender and know the content is safe.

Good day,

I would like to get in touch with you.
Please advise if I am contacting the right person.

Sincerely,

Mr. Paul Morgan.
