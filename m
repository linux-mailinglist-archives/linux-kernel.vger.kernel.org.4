Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA1565C12A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbjACNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbjACNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:49:12 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2051.outbound.protection.outlook.com [40.107.104.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D691D9FFE;
        Tue,  3 Jan 2023 05:49:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYe+fUZS7bl0Oe2ado3tYkuZxz94ydPAfkhfFbM6xP3NKka18lL6F0/KIogGcfqXUO5EYiiN1F5GjrTouB2HxH5+CVsS26nN/n+8G/hI7xmbdi8UaWnhqPpWVRmydp8kT5fvOueGnKW+JjrviYV8tNzL9/32ZXKih9Y0eq04iatYAUW4hHC+Kq1At8ffh1BTxNFVQW1hox79Ky9tS4pYyCDlyNR8Jld2uGOOzmV45JJIXDFuqfReemUE18BcomZfAEnr8S2ZC2Pk9OLNX5X7D1KBC2Mm09C4LFbRnah9PVtZblZs+ReOHjrGMEUp8NprcwWY269Qcbhiacc9Gzxs0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHHMFZ8nuOzCfqepj8kjidQA9WyqSaOAKHv4i/5IB+c=;
 b=RtDgbl9sHeuDmNEFGUiM8orSNfS3sMsWLVqrkRMMczsxjX57HuVWTtTHlB5iJs2fiGReYkE72u2qkq9Yf0m0QT5EDeSA2+UENQPvWPWH0cJOJ2TYA7EmwnyzpIGxLbI/ePpHfY5n7Z6mOfF/r+yJTh4guoRRxN9sCEx8OL23T6FT9N4KLHNe+bFqq6kEtR0LgSuH95h+iLbEcZc8YhK4QbdCkIyTviUF+2fQpD93rgapLWozq4k62Mv3v5GKUXQ75j3Jb56o4Hnh5v44JMKGSZ6PDmZ7ulMAQPz2DgzaO+K8zPwMMvbzPQU4ozu7vtlJV4SR+gt7qZJ/SYefgiiuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHHMFZ8nuOzCfqepj8kjidQA9WyqSaOAKHv4i/5IB+c=;
 b=mYekJ1PB1UOxKFOPZKK93OPvst5pnzOPJPeEWlrnvhhDG1zWF9yjxM1+SlGT34Jl93/iPBJ1XT9ph57YaC959dOQ9XcCNT5FMcwM/JSoJZzKLF4dBwGhMYElhLaAvXNanpnDs2zxyocxf1xfyiQPrwAOrseR06GXsi05aN5RLI4Q2ts6MCunxks2cnoIDQCfJgvV9FfaRj02gPpZx9AX072tMlSACiosf0RX4f1q0vocelIA4IJkldipFvJsAeZx2EcWH4GZT9RlWwmNYLS0yspcGQsz7Q0Nfvifer03dB+eSVm/YFJGejZ7N6Y+OUin1o6PHaUjAn3wsG/RxnmMNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AS8PR10MB6272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:561::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 13:49:09 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1f0:badf:facd:2f29]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1f0:badf:facd:2f29%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 13:49:09 +0000
From:   Michael Adler <michael.adler@siemens.com>
To:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Adler <michael.adler@siemens.com>
Subject: [PATCH 0/1] USB: serial: cp210x: add SCALANCE LPE-9000 device id
Date:   Tue,  3 Jan 2023 14:48:49 +0100
Message-Id: <20230103134850.53229-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.39.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AS8PR10MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc16786-3209-4c23-6d88-08daed9149f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LPU6BJbBN9+sOu7I1roZCeusP3mN/FWgV1QzBuZBZqwMYA6UTXTPvQ5OJeHwwbbQhznnGI/T2TqySFJqauyp4TBwmtJLWQHmCsRsZuG9Sv9b0dNe5c/5XFP65biQ7fMqLEfqWnoCaY4AiJr8SfFajAnQISmx7fz1nyyu3POoTDHgyoUKssB5E4uaguEVPgB+NcAUieDxC6ltu2HStuSIanNOLZUtsA6mGhEFHTjDtXS5pchZ1WBy+M95r682K1KZ2FrlJhhyydf2+BpNGjiXRgnqp+xPQj4gS5wibde8F7NkFxAmoiaTmXQiZ/TpywZQ5KKnE+ikvBKVTtfTf/1oWVjLgspEZKso4oOE+iOLZEMD+7mbn4NmTIvFkcp1gfIGXVuHVJuvgEVg5s2eUu+TvVE6xlAzErCz89IilU0/Ke3Vq/t663WIz4iahkUIrKtBoUQEhQIV7hBSUifETZClAoiJ8WlxPop/IJZcnBRnw08fWEiTfDim932HRuDrqJO4MeKDbMq6y+G2xdDDOf/PAeL5fnD95LWEENPG790QgHzdlD1Iu9YAJMntJQw7HW4ga1qVYleSw2JDzAZ+uJ+Xn/f6EkGNbbPbK40miZHNPyt5quxaptRFWqfq+TEYy//Eb2WGUy1cjLCERFm7pJwh4rTWs4B8EmG4ZVUJhohxHeH+pnXANJdaVWUSYBMpBka2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199015)(41300700001)(8936002)(4326008)(66946007)(8676002)(5660300002)(316002)(2906002)(54906003)(6486002)(6506007)(107886003)(66556008)(6666004)(478600001)(66476007)(86362001)(186003)(26005)(2616005)(6512007)(1076003)(38100700002)(36756003)(44832011)(82960400001)(558084003)(22166006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQ507K8xFTEavB95K9/xjgZU3y1DkQALpvDBFiSeyr+L0MvYxb/eKxaXJEQy?=
 =?us-ascii?Q?2m7oujvIMBcYGSfoR4I+66EJRf59baAYY1gpSVI4ZP3vy2pBtraicWgENqXq?=
 =?us-ascii?Q?PGE5xLkOIfmnu9cHZlq8hh0uu5vOdyr3Vacc9xDAp02a8E4gI26aabUCMBd5?=
 =?us-ascii?Q?5mRYixM21P79At/1jKA7u78yf/mYRCPK2Y1DEVWZbQeC4+m4Ons72JVApx38?=
 =?us-ascii?Q?ijb6stObJy2s8fD7wneeyg7POhZjlO1GYXvqAcCriZhodc2DPF08U0usxPBs?=
 =?us-ascii?Q?3pSAU8m6vfVgA1KBVxD0ru149wu2QLokKMgLx8MXbsOV+s/nOGfDVfGH5S5L?=
 =?us-ascii?Q?HG4eeOQRfWoSchTMknmONQfPJ2sYQhI8t+NPxvZhks6P9uhzXstroMsxcrUp?=
 =?us-ascii?Q?40WX3E219pfp2Gy+lmuyBOurA6694Oz8u0tvtT377I8GrjfVuqitU1FRU/p2?=
 =?us-ascii?Q?u/1wySGwcw2R1qVPMIAt2tkiJX3YkXCdma3QqWZp/+t4SURtUNdaViio6z9V?=
 =?us-ascii?Q?Rsct3WIyH6FbyZunZ/NGNdjuXk2v5SS6T0eRZauFIg5qeRl5h8o6F53+rAUi?=
 =?us-ascii?Q?3vho4R6jPlISh2mjK+beHNVGjWF2Vxh5KZUS9crdhtj/puD2WEr25ZfmSkXc?=
 =?us-ascii?Q?Nb59fkwLoZv+E03XKfXARmR7UcAlM38nY/vn7jClLURNJ2t8dsNsZGYQO1zr?=
 =?us-ascii?Q?bHVPEsN09Aq2PscCbBrgeXdMFYArFVEHlrQ+7uYGgGojjV/MWtEd/HrBaie6?=
 =?us-ascii?Q?Arx/GUZwoQsiDLDkecitYVO2A5HKhns4FaS28j3b0uDq8x5l/gGiPGDgRy6W?=
 =?us-ascii?Q?Z39Lug8W05K/ixVpWmw2VGsdMa0vnVo6MubhiPZgGTDDdQRKuAmBsh0KxcSG?=
 =?us-ascii?Q?/ZXUH0IwNenkXoj1XX73xYZq+PkX9PgXmgFSGk5UjjWcNvvD8BJjUSohiDgo?=
 =?us-ascii?Q?p1rGvk2PjaBhdVFA3SC5hoqBmZA2ckULZpwhQa4wFZdhxmvP2XKWg4vwvDoX?=
 =?us-ascii?Q?z4OlJqniYRn1blSVHf2yyQCA+eydnOIGMoUJWweBQy8dOA4qK3hYw4lPpTlb?=
 =?us-ascii?Q?Mybd4ylucyywXP1pVspTe2MniC9vT8t6oN8/z4onC0W44P1Qrb8x4d/Wmn2o?=
 =?us-ascii?Q?6m2ElplrGm/WdVxeReBLzsMGqps45ZtYgx6yJiVcVtRpKPDDk/iReVqK+ghR?=
 =?us-ascii?Q?3UptnLqk/yvYkGsxFcpgpxjwWi7CEDIgDUPQ4tTZBJvv5C+olzGusIv/xpYo?=
 =?us-ascii?Q?49SX/t6HbD/PtiO/AidT9rPNIyXL5mWzNVwTMcQauk+LRwlFbI4qeF9Am4Js?=
 =?us-ascii?Q?7qn3ZeQ4Kcmr/R9+uIEUiOa1+bM82ycSL8gFyo9KVBbsneZbVX8ZHbvGKH/Y?=
 =?us-ascii?Q?CEnBAUddlu4Ic5ND+1IGr80kruIE+WSNXr+gA0KP564OdxTyDcFFzHfFy6iU?=
 =?us-ascii?Q?mrR/KsKn5N729huy3LVPXRTA4YI6wj/ypCGwQauwwFS7APdHOyu42APL+l68?=
 =?us-ascii?Q?xMaHaonvBw5T+Z0qKTLLGUZ23V1c4pU2wW27RQ49yDdzRliy7F/0oMUq4AJ3?=
 =?us-ascii?Q?t98985MkObqUa0b6tM/L3wdrMZQRP8M+d0kPcVU7vZS1n1o1FR9n0N/Er9gk?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc16786-3209-4c23-6d88-08daed9149f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 13:49:09.4977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G9FLzANNyYrR1jn3pPx0Q19IByyEULYOivuqKViFsUqphzTsi9E/cC2JjvBzj8eF2JqM8qblT6HaqnnolNClX0GOggEN6hmrVYYnsjawEz4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6272
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a trivial patch adding support for the USB serial console of
Siemens SCALANCE LPE-9000 devices.

Michael Adler (1):
  USB: serial: cp210x: add SCALANCE LPE-9000 device id

 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.39.0

