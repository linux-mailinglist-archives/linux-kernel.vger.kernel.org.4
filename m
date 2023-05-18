Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EE67076CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 02:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjERAKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 20:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 20:09:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2246124
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 17:09:49 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGrva002401;
        Thu, 18 May 2023 00:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=Fs312aoG+CvWwwpwaibXn18Jg+fsJEVDRbbGA17dTbY=;
 b=CooRWy/F6AOeFBPLZcODvsoREngtv0R+svc4eW6PFCuPCk4OEijraKHw1hPHoyhEn6PL
 0IlveFnlEt0oI/mUAu6wOkxg5metTeeuiRc3TgYmno1b5yNnLHsr1qXA9+KBcdDRBymr
 iJidLovia5dAeN8JLOwTPWfWuRSCm/zdvwO0Uq5+mn21MOBlhU82o90ygraXgHbVdrcS
 dGtf00ZynI1a/+ucTuWjwQs7pzody5/hkjG4N/b1bdaaUkZqx/Emn42QSzpgVKXHn5PY
 2HSeak3n0f3gMsgbzP3JMzUFQNgs5/Dq0rgR4zi1pkWCYeBsTSlztFvR/wqupNdYcIgt qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxps1drd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HNFIrm004186;
        Thu, 18 May 2023 00:09:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10cd35x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 May 2023 00:09:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evhIkqat5ktgThdLdO82GcXEQuyDYi25JSBJM1s82oeEJp5s6iiCkPf8XMneiXXH+evYUzfrw4oobB+IfSKjxWpqdYxZJ6RzFHWFS3jEaldR4s9q20PYJIeHJk1ANM6ZiafEjCgYv7MYJGl8pAJu+Sx8m2rJYe1K9nv0anFo9WlmnHTDisOKv8Bl2KG1vjauI/+vfR52HObTjL22p/po68sTQSKHexK4QM4AbZyke8fO+wALv0DnNllfV4SaoW8VkFym37wtQ1aAY2qYtR/k9SnQPGMOyygHRL8yxsuVS9mTc4XPgyRQ13l4uaYQbkP9w+3kz1kruE3T7XQNXx56MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fs312aoG+CvWwwpwaibXn18Jg+fsJEVDRbbGA17dTbY=;
 b=IeFg02dcH0MUBE8upg1R+eJD29kaQITSDlWy0aFs9sIVmyLZ31j6rImceJNsa58v/Z5EQUWK6Ep6uU96BCstJbRtLcoE2nN3/R9K4zdS2s+bAJfUzQK4CsPJ4Ycz+dUH7Z8n8FaxnpSmFqxM/T0EdBn8H/UyROMPnfETwL2zV2KyzZ+IclQr65lxX/o1xOC8LLo3TjhiZGzFR1MHM1Yl/TPq0qCjbz0Qn4LROC+u9rqpGyWq+pv3M1jTxjkL0eTGgQLc0xS+cGYUJ51q2F0yBNIRxEgChRZoCSdDaIicNF4gAgZVdUBU8Op1bO/QZGQRnBHx3WdhYDjTX45fX0FaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fs312aoG+CvWwwpwaibXn18Jg+fsJEVDRbbGA17dTbY=;
 b=LbaAJvemBaSbmq4gdGHD2l1ZX3JHQr5aubaB2lsLSSoFTEd0FCkbhQ2dpY7mVLdF6xLeL8k5alqWUHC1H0+y8wxwjk9DtWKw1iYRSP4fv1bi/szI2lC4isf9JgfHPu+QYKoY3bNFpKb2xFK1Sg14A4YXXHeOTCjvMQz/pGPin08=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by BLAPR10MB5156.namprd10.prod.outlook.com (2603:10b6:208:321::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 00:09:31 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.017; Thu, 18 May 2023
 00:09:31 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     oleg@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
        axboe@kernel.dk, ebiederm@xmission.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [RFC PATCH 5/8] vhost: Add callback that stops new work and waits on running ones
Date:   Wed, 17 May 2023 19:09:17 -0500
Message-Id: <20230518000920.191583-6-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230518000920.191583-1-michael.christie@oracle.com>
References: <20230518000920.191583-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0044.namprd14.prod.outlook.com
 (2603:10b6:5:18f::21) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|BLAPR10MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b4b6bb-ffd0-4f54-8c22-08db5734274a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyuNM+tMGCkbU7KLYhCSsIDSMiZNt59GCuhUxjptTX/QLvJsph5RXjO46YLBZCSSmObZ2qkaGfWwoZ6vW5yyUUMLRgfKo5y0YPQQLvn+IS7cuzOecRKfIdEXSbmoIp7b8jxnxkbaAXXnv0CL7shvdOh38ZrTjCLByzAfJeRA+L5sTvmhRfKeZc+rTqhwJ9Q1wZlYmJm+5Cm8YYbSbziaubmkEDu8LK68VKUxU7pwGjkumyBW1PB+N+OQTMe6050dvTgP3LoQT9MfMcm6RwnnFRRNjH5JisSJZ4i6TjJF1cUUtXRxHjZ1srC6z+nfXOShI0tpXI7sNQUFcXk2eeB5p5A2rhtA8vI5dy2sgWXY7eXtB+I2NDMyCmKo15bhvTSz/ugUsx4sEB+Q/nLmZZk3mPuA8+NU/vKpCpwGvvy1JH6ffgzN+TK+GDCu5rfhgteThM95nCQIfDYGDs5JnNIs6CyXPWtZZdKqw0VuRAZ1tbouObJeSlDb69fdBaMypAGIjcb5xJYSnHgu5y5zqr5GC/fVpixFHH2O2E2He1y9eaYnc0p7Rk2HMphim2fpaw08bVHXhl4nFqjSgmHmIbYXDH2anGG6ADWS1MOeZCRQpzo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(41300700001)(66946007)(66556008)(66476007)(8676002)(4326008)(921005)(8936002)(7416002)(38100700002)(5660300002)(86362001)(6512007)(26005)(1076003)(6506007)(186003)(6486002)(6666004)(107886003)(36756003)(316002)(2616005)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XQ1QHFfXn5l5zQWmpTKi1FFE7cgwIkjKK6GrXaxgMO49WVtfq2s+bXrHf2O1?=
 =?us-ascii?Q?HzCB5Hm9CJpnCS03qXsHT+gUELNvu8K3AlEw2m4Hzp2k6Q1dxii/Iln0jFnE?=
 =?us-ascii?Q?DqorjMsiQArx0NjDyvJpidPOHYmtjVaoZuIcYvP5MYhJBdSpGpyx4Tf4TY/j?=
 =?us-ascii?Q?dN9wBT/I6zgmgpSZxf8La8qjLo+XUCtFFbpiqfvxKoEOPNQCy5BLih3aFjXJ?=
 =?us-ascii?Q?hyxgBIyM+3uzulLBt70K2if4b2DjZ9g4Od2FXNVlODCfCLYeN61t7dTzrguc?=
 =?us-ascii?Q?+kYksSIXEo3IwTZqqLWp+BwUJ41C5Wg4ufthQaKER2XhSGNMUs54rnYLFaqC?=
 =?us-ascii?Q?0/I1ohzkwaflYQ9zbaGX256Xz90B1Kvnv5uHmTteURi8u8Emr5DvRTBxltZ2?=
 =?us-ascii?Q?lxI4bpj2XnhLuxsC5ocUXeLgeWrJUW25HmW2KnE3yjoUrC9O5PVCRUhid0e9?=
 =?us-ascii?Q?iCmIYVL16G+MKiX1glny1O86lAWCVylgARMrXfmwja5W0ROJdshVaJU1EPgp?=
 =?us-ascii?Q?o3o44LXLdZo54bh50eQ8VrghI0sNMu7u5N1Dd7UfpJb10oGk/ivbsh5ZszHz?=
 =?us-ascii?Q?8JPf19OgC5DqMoPkYRyNVZ7R6rhsLfVQc2iOST/ZFZJfUlPqBjMySx++hJ9R?=
 =?us-ascii?Q?TIHNvy+4YXthCe6ZdOuhnyN654D7S2+4K0ukNBdM8lHxaCQ3xTQORqDkrtPp?=
 =?us-ascii?Q?I/3Py/EhV3oiA6Z9W5uhlaaMmm3DsWM8yW4xqCxMdsI8X2yCw4JY9D1PrMSw?=
 =?us-ascii?Q?nmPBN0NQOZmOMtyax6tjVM4FwKbobTNS5kmHESvvaVFFzUn4MDndo+1EDut2?=
 =?us-ascii?Q?iW0zxqQrLfAwA9TOLHEisYyA0f/pO/PfsSt5FsBh8fSdxy4EVjMFZ/WtYG0l?=
 =?us-ascii?Q?MrOjSdgiz+SiSi2xVzFFr179rq9MDhwOs5VDzjAuZp+Ol5XjyrwdaoqIHFKO?=
 =?us-ascii?Q?fxkonTkVRpBnpEty9aoroOjUXvbLg3uIhBf4psubuKpYA8a4mk1OR1ZwDyoo?=
 =?us-ascii?Q?Qstx+4u51Rqtep7N7H6Tk/CwtZ2bcnV2vf2FoiAlGEx9rE9gcFknXB89vvOS?=
 =?us-ascii?Q?FBzsgivZI5uL3T4QU6dXC0XRa6B4S2YOV6RS2UUdX+Ax8McE2qgsvSak1l0p?=
 =?us-ascii?Q?4K+c+gDpLunif7K1Bk0movbw3HUW9hat0QheKIpn7tJHEyBumN1vk0DGPofU?=
 =?us-ascii?Q?vlnbp9Vk2xZlNJb/MTf435PfBSwUDJQPPfQCzf6Xs269JZ/+7G2twTIdHaUF?=
 =?us-ascii?Q?yRLLGnuof8ZEXDBgPvB8SJrPpIEQxjHE1p56/5QwTtwNlkKii4JhqA52J5Nr?=
 =?us-ascii?Q?qC1P3heUAX1u3iv1Q7mZfwQPuwJTHpyDmlHp0PqkQ0ppj415XjDlP5aMO0bD?=
 =?us-ascii?Q?wiljQkOuywEca6RFD7lkOePmwUk1QLvUwuxnekFvmX3wuNkE9t15Blkhmh7H?=
 =?us-ascii?Q?IZsm1rDHaw7Zpgw8EU6wmCNzAM6wZPbAsEE6L1KmoBFPP7p10lS0s5caIElD?=
 =?us-ascii?Q?1uVPrloUIqf/XN1OHDApErIpXqvncq3bDxmoss4xwpCirjSnMV8kw5jmLHMs?=
 =?us-ascii?Q?QnfRo9Mp8pHhws8C9l12Uk2tSHCgIQdOgPdVLKo7AuDe08X5m6qWSKwiSufG?=
 =?us-ascii?Q?hQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dNR/RphXE4ecRvtdZeoRV6bDY87DSuFd0xz/K3zM40XwDawVb9jWB7fJlLTT?=
 =?us-ascii?Q?bu8yv377n0CbsCGCCuftkyuANsGCP4UZPEQHv8vlCXqZv5KN9O2AOLUm1J7L?=
 =?us-ascii?Q?26ssOWcchi/t1/2e42x/Ak+Yn+ak1Hq31iuuX8TgThtFkOKxbLlfs/G99Yp6?=
 =?us-ascii?Q?ycFS9zSOpa93XK39ogrMYCQUcdZzWQLVZoL3VcZtk9cNFtzzVZH1h1li9DmX?=
 =?us-ascii?Q?09i8kXh5ZyJxiKHeqDioEwZsRU6HRCVrxS4zVpjjTY8R3aARG84zz8+LNgnB?=
 =?us-ascii?Q?KjaQx+dc+qrhxFV9zVZ1ZFncOfXoq9HzCSK6St8wWTmEk1+Who+eXg3xvIQt?=
 =?us-ascii?Q?IsUDoiOcxxGgaVvtDkC/lQbHIMAuLoll/GFyErAJS9ykE0Lz6D7mZuT23s66?=
 =?us-ascii?Q?M1ke/Sv4S07xLhor9Oyx6sjJrzzLduhEqw0UUY4by5KRXVczsHEjx/uqGFKM?=
 =?us-ascii?Q?o8ptVD67CUgjcan7zCN8gtI8Uxp4ybt0m+aGdr2vwaZeqhIGk6/ouY1hzP7P?=
 =?us-ascii?Q?0so1PcMSEMtkpubihoqVayGUYmjhahaQyJUb5I73wGtFsP5Izm9LLSJXLbuJ?=
 =?us-ascii?Q?cU2iutUTeC5twU+elN2nfWfyI3YOH/J2SDGV4XuLzfpiX9Zn73tlkZyT/K0R?=
 =?us-ascii?Q?vcTlkTsoXaCSaLoMbG9x6k+78LcErkRmQS1HTdHozDdhbHxt5fPRsL9TyXfL?=
 =?us-ascii?Q?kH9LLkJlCdO8YsonHLLqCM49gzRTQr67lomnAfnRTi77NtZ6mxJ4nL7dtnW+?=
 =?us-ascii?Q?3Is/cdQcwxSOM0BzB2qgW0mCs6P7+Ep430qbtq6nPK/qCbqB9P3rXKp+5q0L?=
 =?us-ascii?Q?HvqNLyReShUW3URhDr/R/rQp7atkg0aeApJ3eOG/eJoseObFKVLymE90TH1l?=
 =?us-ascii?Q?dDYZFJuD4ivQLNXsyqn2gSh0jQvwRO7HYQJHe2UMTrT2wvCPJUytJughBSpr?=
 =?us-ascii?Q?DDRC0YAAXXuJQO2AAZR3Su5Phxr3Cxpn7eSoa2QHZssO7CLnt6UjUVse50lY?=
 =?us-ascii?Q?AjhevqfsK99ccofdAWM0TAstHqanso0GbfWZn/HyKt4pY5uH+lOaQdk0g8dQ?=
 =?us-ascii?Q?A0Tuu6bA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4b6bb-ffd0-4f54-8c22-08db5734274a
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 00:09:31.3453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+XHmGTvvfqvzSLWoItV5AjcLPuiN624OQXpnrWI7p6z773+PL6afGX1hMB7rZErfELTVjV42hEUnFmRg7Rdx+FCmWDuzBTFn3OHOo36uJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=962 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305170199
X-Proofpoint-GUID: CuQpZX-DTFdwjljR3R8dab2brcU0E4Tr
X-Proofpoint-ORIG-GUID: CuQpZX-DTFdwjljR3R8dab2brcU0E4Tr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the vhost_task gets a SIGKILL we want to stop new work from being
queued and also wait for and handle completions for running work. For the
latter, we still need to use the vhost_task to handle the completing work
so we can't just exit right away. But, this has us kick off the stopping
and flushing/stopping of the device/vhost_task/worker to the system work
queue while the vhost_task handles completions. When all completions are
done we will then do vhost_task_stop and we will exit.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/net.c   |  2 +-
 drivers/vhost/scsi.c  |  4 ++--
 drivers/vhost/test.c  |  3 ++-
 drivers/vhost/vdpa.c  |  2 +-
 drivers/vhost/vhost.c | 48 ++++++++++++++++++++++++++++++++++++-------
 drivers/vhost/vhost.h | 10 ++++++++-
 drivers/vhost/vsock.c |  4 ++--
 7 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 8557072ff05e..90c25127b3f8 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -1409,7 +1409,7 @@ static int vhost_net_open(struct inode *inode, struct file *f)
 	vhost_dev_init(dev, vqs, VHOST_NET_VQ_MAX,
 		       UIO_MAXIOV + VHOST_NET_BATCH,
 		       VHOST_NET_PKT_WEIGHT, VHOST_NET_WEIGHT, true,
-		       NULL);
+		       NULL, NULL);
 
 	vhost_poll_init(n->poll + VHOST_NET_VQ_TX, handle_tx_net, EPOLLOUT, dev);
 	vhost_poll_init(n->poll + VHOST_NET_VQ_RX, handle_rx_net, EPOLLIN, dev);
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index bb10fa4bb4f6..40f9135e1a62 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1820,8 +1820,8 @@ static int vhost_scsi_open(struct inode *inode, struct file *f)
 		vqs[i] = &vs->vqs[i].vq;
 		vs->vqs[i].vq.handle_kick = vhost_scsi_handle_kick;
 	}
-	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV,
-		       VHOST_SCSI_WEIGHT, 0, true, NULL);
+	vhost_dev_init(&vs->dev, vqs, nvqs, UIO_MAXIOV, VHOST_SCSI_WEIGHT, 0,
+		       true, NULL, NULL);
 
 	vhost_scsi_init_inflight(vs, NULL);
 
diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index 42c955a5b211..11a2823d7532 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -120,7 +120,8 @@ static int vhost_test_open(struct inode *inode, struct file *f)
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
 	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV,
-		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
+		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL,
+		       NULL);
 
 	f->private_data = n;
 
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 8c1aefc865f0..de9a83ecb70d 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -1279,7 +1279,7 @@ static int vhost_vdpa_open(struct inode *inode, struct file *filep)
 		vqs[i]->handle_kick = handle_vq_kick;
 	}
 	vhost_dev_init(dev, vqs, nvqs, 0, 0, 0, false,
-		       vhost_vdpa_process_iotlb_msg);
+		       vhost_vdpa_process_iotlb_msg, NULL);
 
 	r = vhost_vdpa_alloc_domain(v);
 	if (r)
diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 1ba9e068b2ab..4163c86db50c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -336,6 +336,7 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -352,12 +353,13 @@ static int vhost_worker(void *data)
 		if (!node) {
 			schedule();
 			/*
-			 * When we get a SIGKILL our release function will
-			 * be called. That will stop new IOs from being queued
-			 * and check for outstanding cmd responses. It will then
-			 * call vhost_task_stop to exit us.
+			 * When we get a SIGKILL we kick off a work to
+			 * run the driver's helper to stop new work and
+			 * handle completions. When they are done they will
+			 * call vhost_task_stop to tell us to exit.
 			 */
-			vhost_task_get_signal();
+			if (vhost_task_get_signal())
+				schedule_work(&dev->destroy_worker);
 		}
 
 		node = llist_reverse_order(node);
@@ -376,6 +378,33 @@ static int vhost_worker(void *data)
 	return 0;
 }
 
+static void __vhost_dev_stop_work(struct vhost_dev *dev)
+{
+	mutex_lock(&dev->stop_work_mutex);
+	if (dev->work_stopped)
+		goto done;
+
+	if (dev->stop_dev_work)
+		dev->stop_dev_work(dev);
+	dev->work_stopped = true;
+done:
+	mutex_unlock(&dev->stop_work_mutex);
+}
+
+void vhost_dev_stop_work(struct vhost_dev *dev)
+{
+	__vhost_dev_stop_work(dev);
+	flush_work(&dev->destroy_worker);
+}
+EXPORT_SYMBOL_GPL(vhost_dev_stop_work);
+
+static void vhost_worker_destroy(struct work_struct *work)
+{
+	struct vhost_dev *dev = container_of(work, struct vhost_dev,
+					     destroy_worker);
+	__vhost_dev_stop_work(dev);
+}
+
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
 {
 	kfree(vq->indirect);
@@ -464,7 +493,8 @@ void vhost_dev_init(struct vhost_dev *dev,
 		    int iov_limit, int weight, int byte_weight,
 		    bool use_worker,
 		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
-				       struct vhost_iotlb_msg *msg))
+				       struct vhost_iotlb_msg *msg),
+		    void (*stop_dev_work)(struct vhost_dev *dev))
 {
 	struct vhost_virtqueue *vq;
 	int i;
@@ -472,6 +502,7 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->vqs = vqs;
 	dev->nvqs = nvqs;
 	mutex_init(&dev->mutex);
+	mutex_init(&dev->stop_work_mutex);
 	dev->log_ctx = NULL;
 	dev->umem = NULL;
 	dev->iotlb = NULL;
@@ -482,12 +513,14 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
+	dev->work_stopped = false;
+	dev->stop_dev_work = stop_dev_work;
+	INIT_WORK(&dev->destroy_worker, vhost_worker_destroy);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
 	spin_lock_init(&dev->iotlb_lock);
 
-
 	for (i = 0; i < dev->nvqs; ++i) {
 		vq = dev->vqs[i];
 		vq->log = NULL;
@@ -572,6 +605,7 @@ static int vhost_worker_create(struct vhost_dev *dev)
 	if (!worker)
 		return -ENOMEM;
 
+	worker->dev = dev;
 	dev->worker = worker;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 0308638cdeee..325e5e52c7ae 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -17,6 +17,7 @@
 
 struct vhost_work;
 struct vhost_task;
+struct vhost_dev;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 
 #define VHOST_WORK_QUEUED 1
@@ -28,6 +29,7 @@ struct vhost_work {
 
 struct vhost_worker {
 	struct vhost_task	*vtsk;
+	struct vhost_dev	*dev;
 	struct llist_head	work_list;
 	u64			kcov_handle;
 };
@@ -165,8 +167,12 @@ struct vhost_dev {
 	int weight;
 	int byte_weight;
 	bool use_worker;
+	struct mutex stop_work_mutex;
+	bool work_stopped;
+	struct work_struct destroy_worker;
 	int (*msg_handler)(struct vhost_dev *dev, u32 asid,
 			   struct vhost_iotlb_msg *msg);
+	void (*stop_dev_work)(struct vhost_dev *dev);
 };
 
 bool vhost_exceeds_weight(struct vhost_virtqueue *vq, int pkts, int total_len);
@@ -174,7 +180,8 @@ void vhost_dev_init(struct vhost_dev *, struct vhost_virtqueue **vqs,
 		    int nvqs, int iov_limit, int weight, int byte_weight,
 		    bool use_worker,
 		    int (*msg_handler)(struct vhost_dev *dev, u32 asid,
-				       struct vhost_iotlb_msg *msg));
+				       struct vhost_iotlb_msg *msg),
+		    void (*stop_dev_work)(struct vhost_dev *dev));
 long vhost_dev_set_owner(struct vhost_dev *dev);
 bool vhost_dev_has_owner(struct vhost_dev *dev);
 long vhost_dev_check_owner(struct vhost_dev *);
@@ -182,6 +189,7 @@ struct vhost_iotlb *vhost_dev_reset_owner_prepare(void);
 void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *iotlb);
 void vhost_dev_cleanup(struct vhost_dev *);
 void vhost_dev_stop(struct vhost_dev *);
+void vhost_dev_stop_work(struct vhost_dev *dev);
 long vhost_dev_ioctl(struct vhost_dev *, unsigned int ioctl, void __user *argp);
 long vhost_vring_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp);
 bool vhost_vq_access_ok(struct vhost_virtqueue *vq);
diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6578db78f0ae..1ef53722d494 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -664,8 +664,8 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	vsock->vqs[VSOCK_VQ_RX].handle_kick = vhost_vsock_handle_rx_kick;
 
 	vhost_dev_init(&vsock->dev, vqs, ARRAY_SIZE(vsock->vqs),
-		       UIO_MAXIOV, VHOST_VSOCK_PKT_WEIGHT,
-		       VHOST_VSOCK_WEIGHT, true, NULL);
+		       UIO_MAXIOV, VHOST_VSOCK_PKT_WEIGHT, VHOST_VSOCK_WEIGHT,
+		       true, NULL, NULL);
 
 	file->private_data = vsock;
 	skb_queue_head_init(&vsock->send_pkt_queue);
-- 
2.25.1

