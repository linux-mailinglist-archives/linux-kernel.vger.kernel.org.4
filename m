Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A146C388F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCURqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCURqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:46:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850F0E043;
        Tue, 21 Mar 2023 10:46:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32LGnDul024876;
        Tue, 21 Mar 2023 17:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NWWDL8oGQ0dmlsjyvAnqPgh42bjAB8YnQoDa9xH7UoY=;
 b=uXvO+/ef8b+f1/lKak6o2EMQGBy8ad3XRV7cNEVcA4WEJeBWeBK5DsmjFD+q2f78wE7P
 Uwp31c5cyoE7FPaIgHZOfV0/zSJ8YLpce57KXLetUZiam1IdtrjfVZxaYmEiOQJN3go4
 tezMr0gatfGEXzb57r9VqHbRWKJLlxTKSr+nmw7b7n+4am2KVECtwCuLWEmayoX++XZ1
 4bFNVojXosBaOrXNcElv2o6ooPaiOSv4QKNDCuk1Ld3cLOvyYJCbmcknXYvBIBDixHLP
 Sy2j856aNdLdf5jp0H2VESB+lMpouzXzXn0RM4jUDI6EFZod/1SmGmo+tGFZUicLHa5q fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd433q2px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 17:46:04 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32LGSSwt026559;
        Tue, 21 Mar 2023 17:46:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r63pdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Mar 2023 17:46:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXE5DGrZ5Go+P16BOdVhq98ACjrxToezhKhaS5zHpwR6RG35wPgYR+DQxCUqioMdNFYYtxaMD3vEsOguxgJLr2HMGFDJa/Z7Q8ROCb+VR/Rfy7Mrn6e7wgiJDitE19VYCu1A6U67GNpzBDm9uPMqLr2RaLSEQnKcikLeyAEgUG3heFFc8214y3ffUkYXXkwSbpHuD4mhSK10/G5OSVdRgB6enLdZKg5kL9jUCvGprrXvWyu/dMXq2K3j+9NPzcvM9X7JD1Gq/Pvl3lSUSo2aT2ht56Pz07j6qqXKqFUBrxcMh97KIE+zIBT1Cyw0NXsTHy8UHibcYigc4dSqjgKbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWWDL8oGQ0dmlsjyvAnqPgh42bjAB8YnQoDa9xH7UoY=;
 b=n6TVICMf7MgwQbLl1l3NKya++kKEQagnvpli8Tlq+PYhU/LbyJE3lVeI4+VKFBNkK2gYIa6bgSIFU3jq0B/JbJsbluie/hRAudqc0uk702CaHMn4WiH2amyqiNbjjGBhF8kJA7d5Mz5dwchICpXnghPOk1C6rDyJStWLEgztFHVtoKhdDNvshOmfaZ88h4tt4/1o8epfr0MKl067/tXahq3RmeYL2bee0BO+P6SPJ8oXQwdddC2++s0QUDN9+bxdHD0smbQkTs7GGwib/CgZxwOW8asrcYUmYslPjSJZyRS1dZCqhl6FcbDGdyCh+ov4ZKg9a945tGM/yWTfs1UOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NWWDL8oGQ0dmlsjyvAnqPgh42bjAB8YnQoDa9xH7UoY=;
 b=j3GwUwbUdzEzCU36YguwaTJbZkKuutymdKxCh4T94+c1xgZM2S3MA85EVvHdzSeqm3BvdpqUwarQcjpYuTmNleyN5m3AvAeltxiI3gAt7lHBR6a7FkjBr8tS7GSNPfv2dWhmzVDFHMsbIg2Mt6MPYokFRlvW15/BI+tSIUMdptc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by DM4PR10MB7450.namprd10.prod.outlook.com (2603:10b6:8:18f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 17:46:01 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 17:46:00 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, jim.cromie@gmail.com,
        linux-modules@vger.kernel.org,
        Nick Alcock <nick.alcock@oracle.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: RFC - KBUILD_MODNAME is misleading in builtins, as seen in
 /proc/dynamic_debug/control
References: <CAJfuBxyeKz3bsc=WfjJZDKgAHScC80_irQvmsecxPukjM-J8gw@mail.gmail.com>
        <6af9da81-7a7b-9f47-acb1-d0350bae7f3f@akamai.com>
        <CAJfuBxyoeuurDoUe2tLs=JbX=BbxGdYpf2yBEP6bkhtFh2XTtQ@mail.gmail.com>
        <ZBjKb8fXHOxnHuHD@bombadil.infradead.org>
        <CAK7LNASVpBih3iSHd=RXkKNZQ-v5LVzEOuZG3H_i3fcZfsGhDA@mail.gmail.com>
        <ZBnb4KVdx26tMDLO@bombadil.infradead.org>
Emacs:  (setq software-quality (/ 1 number-of-authors))
Date:   Tue, 21 Mar 2023 17:45:55 +0000
In-Reply-To: <ZBnb4KVdx26tMDLO@bombadil.infradead.org> (Luis Chamberlain's
        message of "Tue, 21 Mar 2023 09:31:28 -0700")
Message-ID: <87mt46q9po.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1.91 (gnu/linux)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0009.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::21) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|DM4PR10MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 21476fb7-ee95-4430-4366-08db2a34225b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lku+8iQqsGcWRlPcw3zQ98g3HCwNi/CltU9P4fTfVZI07qe1QNPcOc4/+7Hk39Yk7TS8xO3l2EB4O2pdSmgEKwWnNSHUg71cVtjsabIooulKeunZqXfief5sMwTBgPvizTYAk1o5/IS0bu261k3WoIJmw2Thx4BJWm4nR4bWk0exQbV+CFEL3q/w6S38fYT5MOXh0qDzUg8xMWVJIzxY+HSWdADY2hEdZJlIiyJYBQfQaqHCJuQT6WrN5rvuqlwbYOJY9nHsmBwouSLZg1O2zknqbNCx/WZUsFEDymxQ4y/ytYjukrtnzFuyyFy+xgUVXmro8Y6fM0Dfp5EmAamv1288q/vBXxm49o8/6cIG+dPqN4a73tc8a6cZonn5sY7WJHM+G2Gd2V+i9GOYwd9gOFa6g0N4UtE3WaM5EmuasAHTzvXxRa/dTytmocp3Rv9kh7Hu8OX4sHK6yHsdejU4uwHP1mt/+i23937n5UI0JV8MIFeKbm2JcqRk9iFRhvdymwFnXZiDZK/41A7KU62v8ZmGupq4At+nmJk24VZMpzueVK7hGHaEK1K3T7f+/bY1PXYEKAB2gtfLPsnlMAfxq+Xxvd/adfGVrflxxAiIp4k3cCnRzzD/2Li72G58xVFrUQWivWXwGGv1NOsldXZ/mw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(6666004)(6486002)(186003)(53546011)(9686003)(6506007)(6512007)(38100700002)(86362001)(83380400001)(478600001)(316002)(54906003)(8676002)(44832011)(66946007)(41300700001)(8936002)(2906002)(66476007)(66556008)(4326008)(6916009)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q0hYNkxCYTRBbGFYbVBSOGI1UENDK0I3ekNTT2oxUEh2dmdpSWhkUm1rU3p2?=
 =?utf-8?B?UDJzOEkrdGc3cFlDSkM0cWdPRm1tbU9vd2ovSnpjSU56SUlJT2tsQm9hRm41?=
 =?utf-8?B?VW1aMnR3VFk1VWJqOXljcjhJSUlhcStWMUFQSC9UcFc3UjJLbXoveFVkZngr?=
 =?utf-8?B?RmRtbWd0ZkV5ME5kNmtINTdZZ05jbjYyUFZmZkV5WHN1V0gyRU1kY2lwa3NN?=
 =?utf-8?B?aWtlSlNncUlMSkpwNHJMSjFYb1VKOHJOWGJMZTIvRWhwN3F3SGIzT2R4cmFT?=
 =?utf-8?B?aGMzM3pld3dIbDZMTFBPZVNadThTZzM1SHJIalJRbGJUeHFqQXltcXlrZXd5?=
 =?utf-8?B?YmZGR0p1U0x5SEtDNlZub3dTOCs4VUtFUWtxaGp4R1hpV3VuU1hNbk40NlhB?=
 =?utf-8?B?NWd2NHZzd3lWYjZDK3pZeVRKcVk3QkM0MkttUThEenJYRVM4d1YzM21EOUt2?=
 =?utf-8?B?M1hkdk5OVXdXUnRzMGRoUGZqSmJycWZuMGlzY0FUcnphSkFoRGYydWJ4RGZs?=
 =?utf-8?B?TUtqZHM4N0VpVS9lVzc2SVFWa0hKR29MNFVUTUhMelNsRk0zS0prYjQ1WGtP?=
 =?utf-8?B?T1dGQjV2ZlhYVmRLK3pIMWhrN2s0N3lrK1BTL1lWa0RMWXpSalpTK0U5alUz?=
 =?utf-8?B?VCtMbURuTGNhRDVLYm1ad1ZxUlVoSzRlSkQvQVM5NGpTWUFaT09LOXpMN09n?=
 =?utf-8?B?KzZUR3Rrd2oveXU5czBjd0Eya0MxRFJtN1o3U0o3VUtyUFdoa1BhRFd1SkMv?=
 =?utf-8?B?T3lvN01pTDFob2t0OHhqd3RvV0N4cEZNY3BPbGhzTmcxM1RlMTQvNnJtZGE3?=
 =?utf-8?B?R1dKTkJQR20wK2dvbzZDTnpZaGtneVA4L3h5UENuQlI1NzZHV2lONU12d0dt?=
 =?utf-8?B?NDdqbmUvaE1ROGd6SkdXVjB0dFJIS0hYZkUvTWxhTmc3THpQeEZOcWJ0UUh2?=
 =?utf-8?B?UmJwekNmWlFDMDcxQi8xRnE0aDJ3ZlF3WUFVaDRCYzRuY01ReFI2TjMxZ2F1?=
 =?utf-8?B?dDN1TGp5Z0dnNGo5ZFdNUk4weUhIdFhWKzhjSTRLd1RydkFEc0hCS3prcVNJ?=
 =?utf-8?B?RStaM0kwQUI0UWp4VjE2dEpMbmtuVlVJRGlGa3VpREdVL21tOU5TZ2JhRlMz?=
 =?utf-8?B?YnFoQXc2QkIzdTREMlJPZlZ2cTJlN2xnVkMvdEl3ZnY1aG9IWTBNRjVCK3Qx?=
 =?utf-8?B?VEhYUjNJaWhmcnFxM3hTajVqSk1VVWJDWnJ3Ry9QVW45Z2FsSHJhRlZtWEdw?=
 =?utf-8?B?dnJRWFZMYnJJS2diZVMva2lXYVVYdWUyOENKWW5TU0lkV3lFaVZTLzJUMURH?=
 =?utf-8?B?KzF3Um9QZkl6RFlxa3p2NDU1V3lPd0hhZVVIUmJVTVlwb1Z6WGhpTmhiNHh3?=
 =?utf-8?B?WXY2M2pObGJ3YWFRVENFL3c0bXRjMXhPcldJNlZFRnhGMFVqWTNiSlVZL2Iy?=
 =?utf-8?B?OGcvc25OYk5sOWFDbDZxUjhMQy9ScW9EME81eFlnS2ozWFJyZ3lpY055SVJI?=
 =?utf-8?B?VDhJYXNIMVh0RU51Z0NnMy92a2xPcHp1SndtejhuZEd0QWZMVG9jeHQrQzRl?=
 =?utf-8?B?dlp1YW4zcnFlaHNZWUtkVjlhMmlta0dNMHN3cWMwMVdSVHJ0dVZYUHlLelV6?=
 =?utf-8?B?ZXMrZEJFZWlxcUlUSU9jaE1kcjdxNzdPNlV2RlFIYVBqeDZ4TWxaenFzYmdE?=
 =?utf-8?B?NDhPYVA5VVphVTM3OVh0NHpLd0tBVDhZWmVkUXVKYWZyMnF5eHF5Mlc4KzdL?=
 =?utf-8?B?WmtKVjh6TlY3dnE0cFJFeVJBZHA2YkZTK09XMzJnSXlTUVZvQXYwWjNYTkxs?=
 =?utf-8?B?Nkgvc0VBN1ZtMENPcFE5aVpadUZ6MmtuMzBnRko0VHVLZFJCMFREQXZHa1Ry?=
 =?utf-8?B?UGI5MXVFUGVpenZPR00ycDNOelp6M1JBaDZaa1lPek5yb3hNWkVEM0JqSjJY?=
 =?utf-8?B?NEQrb0t6WnRsY0E3R1dNYjdpczM5UEZILzROem9NREdQODlzR0ZtMW9wWEtv?=
 =?utf-8?B?T0FCUS9vM1BLQXlZa0QwUDlpSEx5UnpiR1RHQlg5V0tvUkhVUlVNNkR0U3FZ?=
 =?utf-8?B?YktpelZTalltV2ROYVhuTjhhT0lEWStWWGtnUHV0R2dVN2FNakJpZE1Wc3o5?=
 =?utf-8?B?dm5nd01mWnlaMFhsc2l6NkZWMVBsVURvdnpmNnJpRHE1QW9yVWU2TG90S2ZW?=
 =?utf-8?B?b0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: C3NCMHoLzjjSu7Ar1q58wCRMnpUw7qXptcWUv7kmROs9suGMPqyOfhtUNAfV01ocjpOyKeJJpydQ3FsNhe4NnigfnoMnCYt6P1uVmSvc5rl2684OAgQxGem8MGbglal+gOvhAjzmEB/vfFl63X5YMyITqtkuW3JkvV9ml5qWb33lVXxTJH8lH6IVdQOo6eaORbZ7+oZEUoK2sWunc32y2idzVeJr6ZSx6vV4CmnWIFAFkofEPZntw5ShxYIkeNOWQGolR91DOm3nwf+K/1FoqopeqrBnpHq8GIYgjlQgqHkKJs5IWkImOAILfrlQrNbKZaHyXAr08o3hPsOvEm9P4GtF7uSlpVfKSY5q0pjrhLyXdCNZbhDMVJtp3Ru7Eu6tV6p+mbsEKeRCVvHiU/DPe5XhdzjnNt49WaCUBTqlxzkJVmKVc/ugs2KOTZJU7bshIZ9GNBBHm5ex61q7Jns6fwOsRt+ScaWgs9BaA+RWyllc4y3U+9QZDrUlbJ9MHIsAF9eHrakdyVxJXIpBp+KY1Mw7iW2tZXq/lLY8obVy+JW9UAMUnQlw3kyg+V9i6t1wPzcjqtImzaw9LAX9sWIh9Ihmalhgyk3Fq+fVK0LxOkNmu3aXQYDebiMP2JyxUn2P6510x3bi/6m5eTwf7qs6MUhEDe+W9W3Q/DqBVjcms/gD2ISiLxmd0Q4Yxh7euB9HxG5r5TKpK9jTEHKlrsi+a+KrIELBpPQLkfWUDVF+/psGBJPLYviCwgH/bWxMP5IsKE7tjxl+mYnKMo1Olj3AWTVH2pNVpBG9tkyq3sclBZBdHtXBL7B1/ZHuP74rSFgH1VFBV4m8vsdEUJn4cXw1VuRuXaRXjBe7KOQFC9GkcO4OsrrTSYF3X26Sc4L/KPXLOX8D+UtEfa2kH84bD4Qog8QOIKt3fh4wTcopCr2KRzY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21476fb7-ee95-4430-4366-08db2a34225b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 17:46:00.8317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ElJXd2yt7FneYUOpSy6pf+6pzaji/XqnQuVEWQXEEe/eB6FsW0zadqubAjrCCN0OEecFdUzLVtjPLR4o2uPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7450
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-21_11,2023-03-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303150002
 definitions=main-2303210140
X-Proofpoint-ORIG-GUID: rcyc9qXOPsFPGLiLnBZa5FoQAy2sXfQ8
X-Proofpoint-GUID: rcyc9qXOPsFPGLiLnBZa5FoQAy2sXfQ8
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,SUBJ_AS_SEEN autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Mar 2023, Luis Chamberlain spake thusly:

> On Tue, Mar 21, 2023 at 06:03:01PM +0900, Masahiro Yamada wrote:
>> On Tue, Mar 21, 2023 at 6:04=E2=80=AFAM Luis Chamberlain <mcgrof@kernel.=
org> wrote:
>> > In general we could all benefit from an enhancement for a shortname fo=
r
>> > things which could be modules being built-in. We're now seeing request=
s
>> > for dynamic debug, but it could also be usefulf for Nick's future work
>> > to help userspace tools / tracing map kallsysms to specific modules wh=
en
>> > built-in.
>>=20
>> I think I rejected it some years ago.
>
> Good to know.

Indeed! It was rejected because it used too much space in the kernel at
runtime (it really did, it was like a megabyte, it was ridiculous).

The new approach consumes only about 12K even in a make allyesconfig
kernel. Any realistic kernel has much lower overhead, usually about 4KiB
total and often even less, but once we're below a page I doubt anyone
cares much any more. Load two modules and you've lost more RAM on pure
page-granularity slack than that.

(This is true to the point where I stopped trying to optimize it further
because all the data to determine which module and object file every
symbol comes from, to sufficient accuracy to make it possible for every
symbol to have a unique (name, module, objname) triplet, was becoming
smaller than the size of the code needed to read it!)

>> He comes back again and again with almost the same approaches,
>> until he finds a "sponsor" (it's you) who will get it in.
>
> Actually I also rejected the same approach too.

... and that approach is indeed gone, surviving only in a patch series
serving as a *validator* to ensure that Luis's approach for tracking
built-in modules gives the right result in every case.

The validator patch series hasn't been upstreamed. I've given up on that
because whenever I tried to upstream it people seem to have assumed that
it was incurring costs at build time or in some way being used by the
kallsyms code at runtime. It doesn't, it isn't, it's purely a validator,
it isn't even executed unless you do make tristatecheck. But not
upstreaming it isn't too problematic: even out of tree it still serves
its purpose. It's only a developer tool after all.

>> When "modprobe foo" succeeds, the user is sure that the kernel
>> provides the feature "foo" (but he does not care if
>> "foo" is built-in or modular).
>
> You are thinking about the modprobe situation. That is in no way shape
> or form the end goal. Nick suggests he has tooling enhancements which
> allow userspace to disambiguate symbols from kallsyms which are built-in
> to come things which are modules.

DTrace has had this for about a decade now, using a much older and less
capable version of the kallmodsyms patch series. I'm working on adding
the same sort of thing to perf and ftrace right now. systemtap can
already do it, using hacks that would make your hair turn white:
hopefully it can move to using /proc/kallmodsyms in time :)

>                                   His hacks bring back the tristate crap
> which both you and I have rejected.

Nah, those are gone and will not come back (see above). In hindsight I
actually have a good reason for rejecting them -- they relied on
uppercasing CONFIG_ symbols to a y/n value, but a lot of the makefiles
contain code that relies on those symbols' values being lowercase! So
doing the modules.builtin construction that way leads to wrong results
unless apply rather a large pile of tweaks to ugly hacks in makefiles
across the tree, and the errors are silent (as witness the fact that
nobody had ever fixed it in over a decade). The new approach avoids
those errors and gives results precisely matching the tristate values in
Kconfig, *as long as* .modinfo is present only in things that can be
built as modules. Hence the validator.

(Also the makefile trickery in the old scripts/Makefile.modbuiltin is
just *unreadable*.)

>         Having something which could never be a module still use
> MODULE_LICENSE() and have modprobe succeed is not fatal.

Actually I have since found code in dracut that relies on modprobe
failing only if a module it tries to load genuinely does not exist, and
succeeding if it's built-in.

There is probably more. It seems like something scripts loading modules
would be likely to care about.

>                                                          However, if
> future tooling *is* going to be relied upon to display to tracer /
> debuggers where symbols come from, it becomes more useful if that
> information is a bit more deterministic.

I'd say it's even more valuable to use it for tracers/debuggers to
arrange to only *trace* things that you want to: so this is input side,
deciding what to trace, as much as it is output side in trace/stackwalk
output etc.

Things like locking primitives are often traceable, but there are many
duplicates all with the same names because they're static functions in
headers, and you really don't want to trace all the duplicates, only the
specific instances you're interested in. (If you trace all of them you
likely cause an overwhelming flood of output and possibly crash the
kernel due to tracing some bit of locking that it was critical nobody
ever trace, which was almost certainly not the specific instance you
were concerned with). Function specialization and hot/cold partitioning
makes this even worse.

> Part of the issue with Nick's patches all along has been proper
> justification / documentation. Try to take a step back and think about
> the possible *value-add* of userspace having more concrete information
> for traces / debugging.

... I hope what I wrote above helps a bit?

I'm about to take another look at the cover letter and commit logs for
the whole kallmodsyms side of things and try (again) to improve on them.
