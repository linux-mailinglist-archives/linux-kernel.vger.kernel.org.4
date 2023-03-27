Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1E66CABBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjC0RTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjC0RTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:19:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6554E420F;
        Mon, 27 Mar 2023 10:19:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32REdTp7014375;
        Mon, 27 Mar 2023 15:02:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=DceE8u7jYUoFaXcX6iMZ3EtykLDwyvwtpmvSz6fJ/iA=;
 b=TjMWzKYjKVMdtC7iK1oeCYkQFz6+35I/zHdqranfn3c8I0sGtKz7yqD3x6zFxvSWqMIt
 keIJyCdIb3VevV56lBcNXoVUx+5Q+iks/EDpcqLX4GwCjUpHA63/avA/0RKZM7mgEc2u
 bKgqdup0T+Vd1Zqji2nHQ7flr4T6k/4eT51pbJVy7l68rJF2t5dyR1RCJJMbj0+XvZix
 1WQ+5CIfhu6od8iZALLSIRNCy8g84IAGkgzKL7AO88U1lJdCpgQh1//HyCihjyqoVchs
 1LNRFIwqC4Ji7Z2ydvt23NKdwFE9+/6bgxVTYwb2zw1DtiPGQTkUQk4JesEjKuOx+ITh Rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pkd3j83eg-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 15:02:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32REo7Za027415;
        Mon, 27 Mar 2023 14:54:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdbewtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Mar 2023 14:54:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLKTs856JbtW9/5n3YyZju8dORPhUPltqm/KKV62qTacgrVtU/VLE2M+wKq0wg3W0Y8F5lysqIV6qR2+l7coyBqVAlGvuVWSjsPVH/m5+1UzpofuP9H+8ScjqZR3Lxm8wYuHBjgIlArpKubS1x7aBLDjz+UzIbzo4HjmbSfSUFfMp4Q7GmrIk7U12zwY+fd1nrTOdEeaapDxK8O9X7MZcM+YytX7Z4QDL5igplRMxD17fhzwIOMpjZ/cns7MYqJgdqSSvjkIrQU9KBsEXj7+WvlFF0ejJ76YAIZWtYesWLm6bJGrFSDW1/mBKxNnsYA33TRo0SMN2xm2ncROpLxkRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DceE8u7jYUoFaXcX6iMZ3EtykLDwyvwtpmvSz6fJ/iA=;
 b=SrWewKA3sEqizwpQmR3B74Ja3ivU05pBtllPiKyDmDOntnzJUfCLx378LkpC08XIyZ0x75H8R5deDLyhnm7S8q0CL9GYHRtwSygwi4nDR05DEZYljAIIsXsRegpXrEb8Y2qHHnMij0+TZ/cpkFbW5xJQnJwRB6asXN22bBSdUxAX3OIx2k2cDSAuTJ23nzWleChS4Tar6A0clSXGR74UcERlKr9n31UXpQx6Rw3CyDoZ7tAiUf4r5+WabqQ2d0BS1AmlsoYmmgpYNGvV4ntAx3s2TZIZcqEmqOPDxoWQEWFfk1kkqFdnse/fOb7k05JmoML1elPQ4SYE6jJTr/PMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DceE8u7jYUoFaXcX6iMZ3EtykLDwyvwtpmvSz6fJ/iA=;
 b=cyHQCLYBYs56KIf7K3s/VACoFsWnFBg4f4w60AgAdXvTMULh9JDFH/+sKzpQVDZ/1D/sdOv2WI8axFxUp4OmNVyJsSkwNi4Oehqg7NN+naPzf77zntrRmuLX4quTPOlZGr36P1dktWC2lG6RFEyXVx1XnRHfsMFhOBNWgYbCiCg=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by SJ2PR10MB6961.namprd10.prod.outlook.com (2603:10b6:a03:4d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 14:54:31 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.041; Mon, 27 Mar 2023
 14:54:30 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
References: <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
        <ZArc0ib697JIwKou@kroah.com> <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
        <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
        <ZB1p5zRp7rlGGuCP@kroah.com>
        <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
        <87h6uamdzw.fsf@esperi.org.uk> <ZB2zrHSzmi8FXABI@kroah.com>
        <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
        <87tty6lbed.fsf@esperi.org.uk> <ZCGBfbZztfBpgIXf@kroah.com>
Emacs:  The Awakening
Date:   Mon, 27 Mar 2023 15:54:24 +0100
In-Reply-To: <ZCGBfbZztfBpgIXf@kroah.com> (Greg Kroah-Hartman's message of
        "Mon, 27 Mar 2023 13:43:57 +0200")
Message-ID: <87355qnt27.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|SJ2PR10MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 90772760-557d-4ce7-f86c-08db2ed32af7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H1T591yTTCLNKnQuOMiOgGp4cYE/BZ0IW9PB2l6ssLGdkBKpwBx458ArVsh25W7aSo3su8Q3qJsO2BPu3Xo8zMEibbegIpA6qy94xxjXKDSc7CBQD8Zuy+9UXSYSF7lw3TXweZQRLA5JbuVhjBTehvgGowooLGlAkDpUuSgrUTAWVqCG3OIm1k7ztyXhXN083Tsb5YDoj71zdxiArGVlI17ON4sXSy9D9GgEmQVNNyUMt092JM2Zxs1R2ELbp19cNIjHcIT/S/d7J/WDKY7wr1ITDIqHnlotj3Vl0Xz3ovL6e+ec6FUjcItbWyhNqj6pjRkXtutWsqNtfgSlkeyEMzgkU9Y/nNUVSPt+5RRXTGFXXn67966qhy6s1eP0JOoixqadXlUKgxyeI6ODgM6MhEuO8C2I/mLh/7YS6EjActEh+6a54sJvugEPDI6HC/WboUROaOJGBxXmJhynFgemRjETkK4fCD6HXN6vCxlceVRUf/UW0aCi74usUixRrtGkm+PL5kMTanhJoNvrn79ekiyC4yGgbWYVXIx7jg8ARLs1Me2ifklbBoUsUOfldacS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(66899021)(86362001)(83380400001)(2906002)(6486002)(9686003)(6512007)(6506007)(316002)(6666004)(44832011)(478600001)(54906003)(66556008)(186003)(38100700002)(8676002)(4326008)(6916009)(5660300002)(41300700001)(66476007)(36756003)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jOqSmC2zlR+32ud09d5bMe7YuIPauxLNHOF3a2cx/gvbQas9vtXqAJv9VzHF?=
 =?us-ascii?Q?hn4Q6zF2xAWORe5hP5bC01+/A/pRD1/+n18OCjnIOxao6Pr4XsTJ4USJqmGZ?=
 =?us-ascii?Q?Ngp6ecVcBH+QsjtNE7NNiEkZ11hziCbujedlXUrpij/Fo5LMLIGI59fVxLRU?=
 =?us-ascii?Q?mBJnJXcMcIiUT4BH3Ho/QnmJwKhluNbLZyVl/Potxhr3+rE3wZlgUot3AaLE?=
 =?us-ascii?Q?xHyVIzArC5KRicUKFlJzxj8xlS4xUQI85VbzG6bCfh/6RcIWBDay4LRdDZJN?=
 =?us-ascii?Q?xHwFMYKmzS9yQQLM2nUG3nrp0TJHfBD46YMj8BGWVUXky/zxiI9xMnoY6mtE?=
 =?us-ascii?Q?E1fv45R92QEZcNgtU5kU72M90omyur6RQWUcu6SS7X96HPoo9zW/cJ9Gj7om?=
 =?us-ascii?Q?sYHslaVlxDCHl9fgn4CK8YJ+IvyVyYULjkADwSOQaNEgd9AJ6SIfOwl6IMk8?=
 =?us-ascii?Q?pT2cXTCwS1uBrlMzmOjBIiEY1xG+ML12wiPUCP+mRGANtpFws9Tfl7cvhTR6?=
 =?us-ascii?Q?vb47ioSiEkmbRnSIxyK9usMG91OSwMkU/EAREZx+WLclmSq7fxtH4Rn04b68?=
 =?us-ascii?Q?DavFRCJAGNNECwkD5IAEmGeQCFur+GJSWdP2aNxk05iP/78i9WiN2zpBt4GY?=
 =?us-ascii?Q?gigawgCBtBNzos6p1GM0f5la0pVu6PDHc+ZMlhDvQdvz5Yd3F/+k2vZiKwP1?=
 =?us-ascii?Q?nkeCxfsQPISunrSsbQ90pz5jPFMPm/W475FpdjeeO54qewLc4vZt68jUGXLi?=
 =?us-ascii?Q?8Up4rbf4u0YDPTX1Je5yPA9pMkLQHlh2mJHrZuuWDHNRGwoNHT0WkGzH/Fbj?=
 =?us-ascii?Q?Bkxsujo0fS+W7VxmvTGIjEL9RuKdm5ybLvFegARf56frk3x/oX4WmGtC0+cs?=
 =?us-ascii?Q?aVwNNgi73XLgOGPBsjlSOjptVhJ6I4dNwV+CW0nN+TuJGNUbdCuE21wZwjXT?=
 =?us-ascii?Q?+M2o8rkfPq2zE0ZueWqejDDJ55tV+aufq68sRtJx2S727pNUNAlOMNlLRcnH?=
 =?us-ascii?Q?/EAwmYaAiNNrCC+JKJD/8f4r2VDFh0VIBqfSO+6GqknMcs+K1wmXntwhNkX5?=
 =?us-ascii?Q?8GEmosS7MmzQcImlbNYhCTMKed2qzE1XoH9J4FYwi7BGigSQLwviV8A4Uigs?=
 =?us-ascii?Q?wxsakerBD4LsF6l8CQ3ViXL7QO0xaKyxLU5YedwvW20FCwfgCC/w846QMtLx?=
 =?us-ascii?Q?p6g6HM/gK6vUAm18/DV6NdFRovA0lDuYDNsairNK5B6JIm7Bi1DEiuNpPa8b?=
 =?us-ascii?Q?AKcZg8EkDkA15GM43AnyEXHFUOdI7W8LyHSnQPHr1NNg3NObu+vPL9tFD4dG?=
 =?us-ascii?Q?iRfDA4lKqiptDsVaeNMb0UC9YWKwJs+z088W5085ifUx/3fBJhrUBDvPlggU?=
 =?us-ascii?Q?gXQzDNt/lV7JP2GmLYjx5a9p+gfCRFjCw2hyi3PQC5MiPkgQozuEfg0bEQ/n?=
 =?us-ascii?Q?z+I48g2mMJziESDlsk3EzKnqTHFoULIEXGBJ2UW4RM1RqslB6Wi2TFaRGSqY?=
 =?us-ascii?Q?dQuA47iJk1rhqqjHDpY1Oo9JVBKMu2T5ziW/gInq6kG73joY8r+t5aP7MPnP?=
 =?us-ascii?Q?TVDuQNobOB+bYEgJ32dQnmOS3muum0CACArH2PLjGbJ6m5GBgxTGJV5ZQLlO?=
 =?us-ascii?Q?fA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?gWSDGuYnMirK1G3ZPEat2u5s+8N3KmYwPCkabh342p6hyy0eDJYZbY8Vi38b?=
 =?us-ascii?Q?dLMXVwB83HjkVTS1er6J+CHmM8NsVIetA3ig12NKE/kQ8vZUsYwsH1h6kFJq?=
 =?us-ascii?Q?LltkplwBeZM9lSppgk5JRJ6kpEDBWQVhJqNKPPlH2rW3RtWbePoFsgzoD36T?=
 =?us-ascii?Q?OcYcmcRLaywtJMPw75aTqw+z15ZA5FWK7ED2dnD+NqSvWhyKWZN965jegMez?=
 =?us-ascii?Q?u5nicL2/ao57X61sJP7TbHvyxy7ajhq/zk4rN17OJBdlSbKJrwNpGj6sI9jl?=
 =?us-ascii?Q?dmToPTm6AESJMAa443IXn1GZFNl++hHVBtit0pgjAUjILTJd4VizI1TdXKaX?=
 =?us-ascii?Q?mLJ0EWlMMfjXnthOjWmzW947visN7OrMHTXHUZtWwOwrOkcEs3RP+T/RjehH?=
 =?us-ascii?Q?ibTsp13RUiRs8/pyHf7dpO6pBgkiT4nn9ynJ2c6SZWO3UnbYpwydlDBIzfsb?=
 =?us-ascii?Q?f4yt4rSVv29x+1AJjqz914be8qhchwR2ZmnocaBotbjavk7sZuvc5xAgKrbL?=
 =?us-ascii?Q?laRJLCqAhLruTvCn9i+4zPSmOeVklvjhCojvHqwsDUZcZ5SyErZ428Qiq2PM?=
 =?us-ascii?Q?KUA0dI4RtzG38R3cfrs3D20BOb8BHYYXP9nUG1537c1Px27TI1pz2T4kYYkX?=
 =?us-ascii?Q?dyGGsg4+RNEQ4dqll5miSGKxoMylsZWAIUZkXRD5uqY6wD47vQtEZ3aKrsOJ?=
 =?us-ascii?Q?9SZ3juc/aVxmJsDAnGfxur/BxgUhnXRRK0HnoY1xN16ji+dDWwScl7lPxZkB?=
 =?us-ascii?Q?2++J8IjRNs75wpBurD+NGGzVZm8hUmZYZYTbafAg+y/Cct+atW7sbuZE15K2?=
 =?us-ascii?Q?ZOouOO/++M5mXZrHP5DAQBvUCjKgq9IbLil+LJvGINKh8UhjJy4n0jICyFz1?=
 =?us-ascii?Q?epbO113GXrCRskNyej7scvb/M9mwCsoCqhTrb/zwP9d8XrVOYgZcjLCQvOS7?=
 =?us-ascii?Q?wMI5OHBdC4GpMgAbLgjefbzXaLbc2pa2xA/ETMP2Lzs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90772760-557d-4ce7-f86c-08db2ed32af7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 14:54:29.9897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRa/mPV30uR2m+1pwsBtceNHQSlS0aKujWc5tmzmclq+SyBUPVRXdmiq3avseGN9Bmg2DHeSE1oFXBQNGipuOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270118
X-Proofpoint-GUID: zctfnxzJbdXPFopmFzGAm1Yo12uMAlN3
X-Proofpoint-ORIG-GUID: zctfnxzJbdXPFopmFzGAm1Yo12uMAlN3
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2023, Greg Kroah-Hartman told this:

> On Mon, Mar 27, 2023 at 11:46:34AM +0100, Nick Alcock wrote:
>> On 24 Mar 2023, Luis Chamberlain spake thusly:
>> >                                      Please only re-submit only for
>> > files where the license is clear. The effort of clarifying licenses
>> > on files where one doesn't have an SPDX tag is welcomed but can take
>> > time and we'll need this anyway in the future to help later strive to
>> > see if we can automatically generate the MODULE_LICENSE() from the
>> > SPDX tags.
>> 
>> For now, I have an alternative that might be acceptable. I did a bit of
>> an audit and it's all a right mess (see below), with wild divergence
>> even when SPDX is present, GPL versus -only or GPL-2.0+ apparently
>> applied almost at random and some things being completely different (in
>> some cases they were both committed simultaneously and were inconsistent
>> from the moment the module was written). So many things are inconsistent
>> that kallmodsyms would call a lot of things modules that really aren't:
>> there is enough error that there probably be noticeable mistakes in
>> quite a high percentage of kernels.
>
> As you have found out, there is a difference that matters in the SPDX
> lines vs the MODULE_LICENSE lines when it comes to GPL vs GPLv2+ stuff.
> The SPDX lines are correct for the code itself, while the MODULE_LICENSE
> lines are correct from a "this is the license of this binary" point of
> view.

Oh right!

> So don't get confused here, if you all can figure out a way to generate
> the MODULE_LICENSE() lines from SPDX, that would be great, but in my
> quick look I think it's going to be very difficult (think about how
> multiple files make up a single module binary...)

In this specific case, 100% of the files I'm touching cannot be built as
modules at all (they are covered purely by booleans in Kconfig, no
tristate), so by this definition MODULE_LICENSE would seem to have no
meaning for them? If so, I don't see why you're objecting to ripping out
these meaningless lines. (I have already been told not to comment them
out but instead to just delete them.)

>> But... for our purposes, we don't actually *mind* if non-modules list
>> things like licenses inconsistently in two different places. Removing
>> MODULE_LICENSE was a means, not an end. What we're actually interested
>> in doing is removing .modinfo in things that can't possibly be modules,
>> and since a .modinfo in a guaranteed-non-module is at best entirely
>> useless I don't think anyone could reasonably be opposed to that end
>> goal (though they might reasonably be unhappy about all the churn
>> involved in getting there). They object to the removal of the visible
>> MODULE_LICENSE() argument text string, not to the useless compile-time
>> effect of a MODULE_LICENSE in a non-module.
>
> there are other things that create .modinfo lines, so I'm confused why
> you picked the license line to trigger all of this.

I didn't. Yamada did. MODULE_LICENSE is the only thing that generates
.modinfo *sections*, as of this commit:

commit 8b41fc4454e36fbfdbb23f940d023d4dece2de29
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu Dec 19 17:33:29 2019 +0900

    kbuild: create modules.builtin without Makefile.modbuiltin or tristate.conf
[...]
    This commit simplifies the implementation. Let's exploit the fact
    that every module has MODULE_LICENSE(). (modpost shows a warning if
    MODULE_LICENSE is missing. If so, 0-day bot would already have blocked
    such a module.)
    
    I added MODULE_FILE to <linux/module.h>. When the code is being compiled
    as builtin, it will be filled with the file path of the module, and
    collected into modules.builtin.info. Then, scripts/link-vmlinux.sh
    extracts the list of builtin modules out of it.
    
    This new approach fixes the false-positives above, but adds another
    type of false-positives; non-modular code may have MODULE_LICENSE()
    by mistake. This is not a big deal, it is just the code is always
    orphan. We can clean it up if we like. [...]

It turns out that the presence of .modinfo is the *only* thing Yamada is
willing to use as an indicator that something can be a module: he's
vehemently refused any alternative, such as anything going back to the
tristate statements in Kconfig (using a "gave me nightmares" level of
vehemence, to be honest, and that is not a figure of speech).

But as a result of this, if we want there to be any way to tell whether
something can be a module, we now *have* to use .modinfo, which means we
*have* to ensure that only things that can be a module can contain
MODULE_LICENSEs. After the commit above, correct modules.builtin
construction requires this property. (Before that commit, all that was
necessary was Kconfig.)

>> So how about, for the first three groups below (the groups where
>> MODULE_LICENSE and SPDX are inconsistent, or where a SPDX simply doesn't
>> exist), instead of removing the MODULE_LICENSE we replace it with an
>> identical call to a new macro named perhaps NONMODULE_LICENSE(), which
>> is defined in module.h as simply expanding to nothing, except possibly
>> emitting a compile-time error if it's ever used in a module? This more
>> clearly denotes what's going on, keeps the license string in the source
>> file on a nearly identical line (for whatever purpose it serves), drops
>> the spurious .modinfo that's causing trouble, and probably makes fewer
>> people unhappy?
>
> Again, no, why aren't you just stubbing out MODULE_LICENSE() in the
> build if it's not being built as a module like the other MODULE_*()
> macros are?  Why is the license so special here yet the device list or
> module authors not?

This isn't "being built as a module": this is "can *ever* be built as a
module": i.e. "has a tristate line in Kconfig for at least one CONFIG_
variable governing the build for this object file".

> Don't treat this macro as somehow special where authors have to remember
> to not use it (or to use it), while the other MODULE_* macros do not
> have the issue?

The commit above should make things clearer, I hope? I think Yamada's
idea was that MODULE_LICENSE is something that must be present if module
loading is to work, so hanging other things that should be present in
all modules off it seems reasonable too: this seems pretty reasonable to
me as well, if directly driving via tristate statements is out.

This directly affects things like modules.builtin which are now driven
by .modinfo sections in vmlinux.o, dropped by the linker at final link
time. I'm just trying to make that .modinfo sections not contain entries
for things that are not tristate. Believe me, I'd much rather have done
this *without* a 140-patch series, but this was the first approach that
none of the module maintainers nacked.

> That's my main objection here.  Don't get confused by the license stuff,
> that's secondary.

Well, it seems to me that you're really objecting to the consequences of
a years-old commit that I didn't write. Since the person who did write
it seems to hate me for unclear reasons, I think you might have to ask
him for his rationale yourself (all his few communications with me for
the last several months have been various forms of insult, often for
doing things that he asked me to do years earlier: the remainder were
for doing things Luis asked me to do). If you could possibly get him to
stop attacking me I'd be grateful too. I'm only trying to improve the
kernel here.

(I am aware that saying this is probably going to make Yamada explode --
again -- so I removed him from Cc: out of an excess of hope. Nonetheless
it is true.)

(Not everyone has been awful. Luis in particular has been extremely
helpful even if I cursed at his requests sometimes. He even wrote a
replacement for the patch Yamada initially objected to, without my even
asking, and it was ever so much simpler than the thing I'd derived from
the old scripts/Makefile.modbuiltin. But that patch does rely on
modules.builtin being correct, hence needs all this MODULE_LICENSE
stuff...)
