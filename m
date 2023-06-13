Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2804572EC6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbjFMT7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 15:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjFMT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 15:59:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D8118;
        Tue, 13 Jun 2023 12:59:31 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGhqxg009646;
        Tue, 13 Jun 2023 19:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=r+CrMfkanPdHkGeg3Iep/wViLSx1dJmetO03HVrXOD8=;
 b=xn58ME7kDi6kcls7Kd4qTV0s1QSzMo4f+kQsoydznHcMRoXpk4RaUn+j3JOazi3AL30A
 +9y81VL5cipSlSnJhnKaaiIqGnimBTS9pGCZhP57vsHWh5OxEAIS4anRpWym4MQwsdlj
 inP1Ra9JQrCAjc8NEHI/OO9+PBvDAN3zn3x8yQsxguQhewiHsY1JCgrz3wyNJ5vM4FVR
 ZqZjZrZkFpQUhx4PUdSma8PQiDmSbBlNH5uXzV/Ki9EnWGaGPk3ajvs/kLlsw12c4Vxy
 zk+TZcoZIeYK0CrWVNh9b8u4Nd+njZ8PiSqlXc6+BrjOvEEdUS8nSkRJKpbkzj0VZTJd Aw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d63ss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 19:58:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DIfQUj016254;
        Tue, 13 Jun 2023 19:58:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4n1y7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 19:58:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAQ3Tajcv6ANoUqLvcndF7oijh13UAZO6H+8YInh/iFAmzSr9q8r0KwC38hK9OlNMn0JMYHy1xAAyzkPGoAecwGAKmnndRDwxLNf1laOKgN6EJoE6/ekN7WKcB62DEewhfz5TXTfZlYWMOcT6lQW8gcuZNWp3e+MIxr3mFlqc/0VqxbaJ1PmIWoLg41ShbNS6V388aOeV3yPdldkUUh4vN35c6MzRaJoX6f/TFRPjeOcjHJFsK4uRLTCjUJ2DMuG6hjSjWaFF4jFwK+mNLI6MHxd5PDy+sX6UsMkeUat6azrJBAaFavv9L89k3awY33uFMeIZa9FgCGOREbtHI12rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+CrMfkanPdHkGeg3Iep/wViLSx1dJmetO03HVrXOD8=;
 b=f/KfttT6+FsBW+WS10qr8uKY+dN9PkgNU8CxZiL2pR/owHW3rz9LBbNYuu86xfGToruYmbePOIucSWUm8Bd6FqczsYQ951l//sUHdZZnTe6tT//EC9eBj14xra9JKVq1F7IoqnQBfGpOeFGCtpQCs8Kt/FN6b03Zmjb9LrPrHdltE/Dv/oH/EQEvb4t8cInKpmGzh34QR7NjYYm8Noko5X/9rF38FbMwjHnkhswiPy+47pl9xvy1tpuK8nFPFZYik/eMr3E6XApUmeC7jKMI6wKWYoXfjf/IVmtlCoO9Ks03pieGkQL+6s2GVn2Ck2RekztIH8vEF3E9PQAs3ePpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+CrMfkanPdHkGeg3Iep/wViLSx1dJmetO03HVrXOD8=;
 b=wr3oVy3dOvHodlN4NeQ7T/MH9GgkDs1OsCgn+k9JMGSGbuAnR7+0Cm8m0w0sALGwXU/dq0/CRI4gAJ/qwt48xfY/FZKSkEss5pJDnQ6TjE3p7b7gCqL9DeahvSBsa05h0UFce1AMCAwEl2knrvH8jWWVuAZrmCSvMtVk/U9BG9U=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB7807.namprd10.prod.outlook.com (2603:10b6:610:1bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 19:58:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 19:58:20 +0000
Message-ID: <40cacc6b-c3d1-c63b-e307-d95b2c53e399@oracle.com>
Date:   Tue, 13 Jun 2023 14:58:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
 <2023061320-vindicate-usual-6643@gregkh>
 <13118eaa-6fae-7b45-9f3e-ab95e7d34729@oracle.com>
In-Reply-To: <13118eaa-6fae-7b45-9f3e-ab95e7d34729@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ed448c-3ea8-46fd-aa91-08db6c4889a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9Iljj4YzL+NnA8NYphSlrgkR9WNgqOeBefsgdilVPHd/UHztQmFbSh2HSuLvBSWD7vqksTbrAGbIS/sjf2iwsfGEfD5EItUJfAcLVV5uLr5qXvuo0X+bjSn39QmXDr0Mi8n76pFl0NH26PWkYb8qAEqxsVgiVWW3GjnwJzykEuzmbH0iM4KBGyVKAmbhjvhUD2QGfVwGvbAjI66r7G0fbMZEEWSsBo6bjbHwnUso7UEr5MaK4M0o3eam/mIL2e+uKPq9Tj4L08aeaiEPnu1WoZQrUQ/70/R9+VWjV47Zz+BRAd0beod2Z0ZgDbpYF3E7b75mmDv40Ux/BVwio1kifLgmzxYW+uONz+pAhimgbPzD1z76irFJGMCZBqLszwHSxXXOcRqLLaizxoqpdqyFHtH1wbk6jUe8G9mHE7wI/0AFkJuInTUZEMzuXQprpFnehOGzus/qWxJWz/ylzYqH7vqQKhnV8AgTqWMQuE0uDabMXtOcSQEGMtVJ5qQkw84Ga6rQ/UYPP6VovbrzvnvcaT5LTx2xdM9bTL8xybRudhTeShP3FFts8sPrnnacVs2r3+hzYYmFCIfjUbahyRmP2/HrSLZ4+9ZehVN9uE6eSlxJ4GC7uZgJaY5tNjiUZInWTaoLokwdL+3qsGP0llnLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199021)(6666004)(6486002)(478600001)(26005)(53546011)(83380400001)(107886003)(6512007)(6506007)(36756003)(186003)(86362001)(31696002)(38100700002)(2616005)(66556008)(6916009)(66476007)(4326008)(66946007)(316002)(8676002)(8936002)(7416002)(7406005)(31686004)(5660300002)(41300700001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHhkVGl1bFJKMjhnR2VVeWZ3Zk53Rit0ZE9xdVRTc0hJQWpFVnhXMFIzNE94?=
 =?utf-8?B?Zi9VMzBBVTJyYlFJQmdyL1FKTnlKbEhnT0svYWRTWWlUMFpnSmVhdHc5eFFQ?=
 =?utf-8?B?RTRObDg4UVpHOEgwUHVSLzRiaXUxc2cxTUl1dGFNODNHMVlRYUFsVUVGSmxE?=
 =?utf-8?B?eEVCWldRdk1QMlhtbncwRFMwQ0IyV0RuWkdLaG5SZDNCdDhWdGxzYXJFL3Jj?=
 =?utf-8?B?UWNzbzFqZHNJeS9RNS9RK2dlUHpaT3FFT09lUzNtbGxCZTd1NE14S1JITWtY?=
 =?utf-8?B?Q3hyUlBlS1IwalptUmNHVHY3UjVoaTZpWUdWVzRxNkIxYTdhUVVleHlmRGt1?=
 =?utf-8?B?NTB2QnZVSTFrcTVBMnI4OVN4d2pUZXRWZFZUbXp1WjJTMGZLKzJ6WDhNa090?=
 =?utf-8?B?emZpcmRwUGJ2VUc4bktvck5zaklhZnBrTzlUUlNFU216V29mTkY4YXFaaEFT?=
 =?utf-8?B?c21EU1FqTzUrSmhWU2FleEVtaGNkcElZbFJLUzZiMzJwZ05DWGg1b002dTZ6?=
 =?utf-8?B?cDdzMVVvU3ExdzRyanNhcElmNUQ5eEZhWldFMmk0QkxjTlU2ZHVvL2FCKzNi?=
 =?utf-8?B?V1BqYy9yc1ZZYlF2YzNYTC9GRXUvQlRpZUFLaUt0L2lFWFJrZFpIamRmN0ll?=
 =?utf-8?B?M0p1bTc5WTZ0RUNwZjRrdW41Nkh3b29SS3pzbXlHdHdSdUVtRGJMTHRYcC90?=
 =?utf-8?B?bU1xVlYxSjZZZWZaUXEzSFFwbDBuOHdLMm5oL3I0dUt3dkxQNnRHL0Mva3NT?=
 =?utf-8?B?Wkk3bUczc1ZEdVJ1Q1U5alhaN05ERDIycmVmQlRqTW8vTVhVMmdjYmFpY1lG?=
 =?utf-8?B?UUVScUxSUlJOMTF3ZHE1TjlZckgzaHdBV0hwQ2tZRDlUL3AxMVUwcGRLWm91?=
 =?utf-8?B?MXhLcFRlUXUvM0pXK1RpN1d4M3NnTFJJVk9hMm1ObUlrcy84YVQwWVp1cTVP?=
 =?utf-8?B?TWxjN1dqemF2TDN0NUFVdU1BZXgyK0xTUlowUFRRa3YrZ0hUZXdrRVlnRXlC?=
 =?utf-8?B?bU5SUnR0T3dKbGo2bk9YbjYydWpRMHd6MEVaOTZFUS8wSGNrUEFNbnVST2Vm?=
 =?utf-8?B?Q2dHYWNDYWhjcEtCOU5qQ0d6bklja3N5clI1T3BhOGxTZDdubG0zd1JhcW0v?=
 =?utf-8?B?SldDOEkvSG8zRyt0NUNENmF0N2FFZ210dTA1MjFxU2psbWV6dURMRGx0TDFP?=
 =?utf-8?B?U2g2Sk5PcGJ2cEtjL3p1V2svSjlob2lMdCtqbWsxSEl3bkhQdmRGMFg1TURE?=
 =?utf-8?B?a01ZTmNieXNUQVpuVTA2U3lXR1ZCTEdoSWtCNkpmdmE3UXpIL0YyZTA3bHlF?=
 =?utf-8?B?Qmk0ejJmQWw4UnFKQ3B5ZkRRd0EzVU5Vc1RoOXZZRnNJV1JvN0EwQStBSXlF?=
 =?utf-8?B?VWN2TEFiSDdUOEdVK2lyL2sydFh0MjlVMlNOZlFRTG44dXl6Nk0vM3ZRNWZm?=
 =?utf-8?B?VGszYkk0ZG04Y0ZEVWk2WmIvV0Roc0lsZFFtcWlaVFR3QnRsaUZPbTRzaVRh?=
 =?utf-8?B?Qm05a3RNUWFPYllBMmYvTkc0U205M0thcFc5cW1nSTAyNERJME1GRngxeWZ5?=
 =?utf-8?B?cGNyZURFWkxyWlhTZnZpR3k0NFYvOTVzWkgzWjFUZ3NsTGRwK0x6SGRLNEYv?=
 =?utf-8?B?Qmo4TlJidXc5Q2llajFpOXFHTi9JYTgwRU1RVVdQMjVIYjlXWDRzbk11UUJ3?=
 =?utf-8?B?VitaQ1RXZjFVY2k1NFhlU0E0aHNwVUJGcFd0WEpUQ0lsUmRDWllnQXR3cGQv?=
 =?utf-8?B?M2hyUFd5ZWoxblp2QWVTNkQ1MnV1ZWpqNVlsSEZPMlZYYUhBcFNFZG42SjJr?=
 =?utf-8?B?TS9raCtMamFJUnFzYVcwVTBscDZIeTBYd0w4cE9iQSt3Y1hySlhPbHRuMzcy?=
 =?utf-8?B?L3dVRjRramZ4VjY0bjY4d3B5VHhWN3kweHB6U21TS1FJWSsyTTY1M25ZK1hi?=
 =?utf-8?B?SmplZlRJUzZDQ2NUSTVVTnovcmtJc0IxMVdHVjFvRDRwV28zc2Z0ayszdXEr?=
 =?utf-8?B?U20vb0ZnMWNRNW1QT2lhSS9Cb2VVUG84ZGwrTmpqMDFPRVpvQW1NdHN0dGJj?=
 =?utf-8?B?VzNGVDdRQlNpUnJoUXlDMFEzQ1NNMkZWUVBwamdKaHhtVmpIRWFKb2NoTnNi?=
 =?utf-8?B?aHZ3UWRBRjFIK3hoSWZoeXZWVXNGTE44NkxQMkJnUm80K0ZWNjBsbG5qRThv?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aytDUGN4bTExRHdGTmtSSnIvbmhUa0NCbnJ6dU13Sit2NjNGOG9aSy9LV2JV?=
 =?utf-8?B?c1VlbERFQXRGcWNxNXVORDN2OGI0b1JydlBmbC9BUVRTRmwwS1lkbnowM0xI?=
 =?utf-8?B?aUYyVG5Jc3EydFo3Y3FNVzNBOG53TUVFRjVlSm5JMThENHlFaTVoeWNNeVVM?=
 =?utf-8?B?L1RJa2pYQ3VKLzU4czltVTVwY24vZEhMM2d2UmpZRkkvWkczSXVwYW5sVHEr?=
 =?utf-8?B?MlpwM0k4a1NRV3VUMDdXaFlzT0dmSnBCQThVTG8xcDh3WlZEZHZiOUplbTFW?=
 =?utf-8?B?Qml5cXpxTnlLaXpLTk5VbGppbUVLL1NldDhzVTNHeW5Jb252czhFYnR0YnVU?=
 =?utf-8?B?U1paWmFSaU45WDNEdkxKZ1NSeDg4c21lRVp2dHdyWXh6ZHFuRzVSQ1FWemRq?=
 =?utf-8?B?MGtNUndLenNoMW9xSEdDSzByVC9vaUltOHg5ZEt1V1NuUUYwMzRxNUZ6di9o?=
 =?utf-8?B?dEd2WHVTQVh6SEJ5YVNvN2t5THZ5UlNiRXRlM1MxZVUvU3doc3VuNlBQNEhh?=
 =?utf-8?B?T3Z3Qy8zS01vSFBPclJueUFhVXZ2cisyVmR1VUlWM0FvZGdHVVNvVmZJN0Vz?=
 =?utf-8?B?d3JFbmFPU0lkSnVtamhYR1o0ZEo2Z3lYMFgxV2pQWHJQejZ1cU1BcjhkYW9Z?=
 =?utf-8?B?WXRZWXdxOHRBR1FjZU9oNEtiOElacHlTeTFEeVVMUFZZMEFvMDJiQ0VBU21h?=
 =?utf-8?B?OGZFM0g2YjJEbUxGT3pURFhkd1d1b3RlZWlqdFJwclBva0dISDZjRFp5S1l3?=
 =?utf-8?B?dzNYZDNBUXVObGJ1UHRZMmo5VnpSd2Q0c1RKbi9Gek9QaFJIUG1Eb3g1UjFx?=
 =?utf-8?B?cEEvbDBxQjduejZLUkNaQkpvOVd2VEhtRzBZWFpJU2VvREs0QytoNWN6ZUd2?=
 =?utf-8?B?V0lsdHpBRkk4L0c2NkR0VUZZMFBBd0s0ejd1RVYrbHk4UzVyVXN2WUMvZnZP?=
 =?utf-8?B?aXI3TWd3MG5NNG01Vnh3aGl2ZFVsd2hzWng3SWxWTHdxc3o2NmNOUk5leDZX?=
 =?utf-8?B?YUhTc1U4RnF6UWVYV2lvMkhTbjZTNHZ2Q0k4aGVnOTBybTk0K29KUUxMWUFH?=
 =?utf-8?B?Y3ZKSklvM3NjbUNJTUxHWDN1cmkwdWFLWi9lSlcxYlpCYVRjYXNIWXVmT3Iy?=
 =?utf-8?B?b3hOTWFlb1FkY1dEdmxsUk5HVTFpNEkwdEtsc1BQT3U4aENJSHdjdlB5YXkz?=
 =?utf-8?B?WmFFWDRFa21vTFVBcHp6VzlWcXZmVFd1akdjS3R6TWpWeHVuOFBiRXd1NFBq?=
 =?utf-8?B?dzQwUGVPdTc0Rmh6NTlvdWM0NXdGL0dxSFRjVFp3ZWVidFVEK09aVU5sRlU1?=
 =?utf-8?B?MjI0c0tkZmNVRnlod0IwTER0ZEpXUXVJMGw3SkpPek1OMmxmM05hVEsvc3Za?=
 =?utf-8?B?SEpxZmZFUGdtVmE4UTR0bzh5eUdmYWMxVU5mbUF2NWdDcXc2ZjhRWWNITDZp?=
 =?utf-8?B?Q05iY1NhVWdkRVhXelRIVjkrRWxsaEw5WEhGQmsxdjkzT1E2RFQrRXlaamRh?=
 =?utf-8?B?cHVoUkhCQU5uUDFMOGg4b1Z1Ly9zNVpBRDBHRUkyYXhtRDRIRWZDQitTcHlS?=
 =?utf-8?B?K2JyaW5Na0FHeUZBU2RleWhqaUtYeVBsZk1KbmY5TUZXL3N1N2hLQ29BUWE2?=
 =?utf-8?B?TldBcmNJV0dBRUtITFdSdy9rTGtTTGltUEtXNThYSjJ0Y01FaEVsWXVESlNt?=
 =?utf-8?B?ckdtYWZ5RVFXU3haQWFleTFLb2xra0cxTjFMbitkRUE4OTNla3U4NnpsOXpu?=
 =?utf-8?B?N0FvT2todjEyTWRqNWV6L3I1RTEraDRlc1liZGFrdE1TeVhCd0RNRytURlhW?=
 =?utf-8?B?c2hrOWlyTEhXMDFhSDdsTW5sSzhzMU4wRWkrQm1pUWYxZmZhQUlaRVl2OXFs?=
 =?utf-8?B?aWdiUENjc1JSTlMwYWxnRmZBUEZvTTFuckJqODd5enl4ZjJoNGRFb1JYeUkx?=
 =?utf-8?Q?NoZ5gMGShLE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ed448c-3ea8-46fd-aa91-08db6c4889a4
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 19:58:20.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmhOvQolmtzc7k/sd9emPPklXOhfxNW0WpbZ5rB+Okkmbz1Htednka6nx3oVpQWrt0liA9FgDUOCiht5MP5tPrUQgGWaaYvbc3YmoqHMMTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7807
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_22,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306130174
X-Proofpoint-ORIG-GUID: yeGLKiGl852NcPOxu1bP0PNz8YxMk6cM
X-Proofpoint-GUID: yeGLKiGl852NcPOxu1bP0PNz8YxMk6cM
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 10:24, Eric DeVolder wrote:
> 
> 
> On 6/13/23 03:03, Greg KH wrote:
>> On Mon, Jun 12, 2023 at 05:07:08PM -0400, Eric DeVolder wrote:
>>> Introduce the crash_hotplug attribute for memory and CPUs for
>>> use by userspace.  These attributes directly facilitate the udev
>>> rule for managing userspace re-loading of the crash kernel upon
>>> hot un/plug changes.
>>>
>>> For memory, expose the crash_hotplug attribute to the
>>> /sys/devices/system/memory directory. For example:
>>>
>>>   # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>>>    looking at device '/devices/system/memory/memory81':
>>>      KERNEL=="memory81"
>>>      SUBSYSTEM=="memory"
>>>      DRIVER==""
>>>      ATTR{online}=="1"
>>>      ATTR{phys_device}=="0"
>>>      ATTR{phys_index}=="00000051"
>>>      ATTR{removable}=="1"
>>>      ATTR{state}=="online"
>>>      ATTR{valid_zones}=="Movable"
>>>
>>>    looking at parent device '/devices/system/memory':
>>>      KERNELS=="memory"
>>>      SUBSYSTEMS==""
>>>      DRIVERS==""
>>>      ATTRS{auto_online_blocks}=="offline"
>>>      ATTRS{block_size_bytes}=="8000000"
>>>      ATTRS{crash_hotplug}=="1"
>>>
>>> For CPUs, expose the crash_hotplug attribute to the
>>> /sys/devices/system/cpu directory. For example:
>>>
>>>   # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>>>    looking at device '/devices/system/cpu/cpu0':
>>>      KERNEL=="cpu0"
>>>      SUBSYSTEM=="cpu"
>>>      DRIVER=="processor"
>>>      ATTR{crash_notes}=="277c38600"
>>>      ATTR{crash_notes_size}=="368"
>>>      ATTR{online}=="1"
>>>
>>>    looking at parent device '/devices/system/cpu':
>>>      KERNELS=="cpu"
>>>      SUBSYSTEMS==""
>>>      DRIVERS==""
>>>      ATTRS{crash_hotplug}=="1"
>>>      ATTRS{isolated}==""
>>>      ATTRS{kernel_max}=="8191"
>>>      ATTRS{nohz_full}=="  (null)"
>>>      ATTRS{offline}=="4-7"
>>>      ATTRS{online}=="0-3"
>>>      ATTRS{possible}=="0-7"
>>>      ATTRS{present}=="0-3"
>>>
>>> With these sysfs attributes in place, it is possible to efficiently
>>> instruct the udev rule to skip crash kernel reloading for kernels
>>> configured with crash hotplug support.
>>>
>>> For example, the following is the proposed udev rule change for RHEL
>>> system 98-kexec.rules (as the first lines of the rule file):
>>>
>>>   # The kernel updates the crash elfcorehdr for CPU and memory changes
>>>   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>>
>>> When examined in the context of 98-kexec.rules, the above rules
>>> test if crash_hotplug is set, and if so, the userspace initiated
>>> unload-then-reload of the crash kernel is skipped.
>>>
>>> CPU and memory checks are separated in accordance with
>>> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
>>> If an architecture supports, for example, memory hotplug but not
>>> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
>>> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
>>> attribute file will NOT be present. Thus the udev rule skips
>>> userspace processing of memory hot un/plug events, but the udev
>>> rule will evaluate false for CPU events, thus allowing userspace to
>>> process CPU hot un/plug events (ie the unload-then-reload of the kdump
>>> capture kernel).
>>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
>>> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>>>   Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>>>   drivers/base/cpu.c                             | 14 ++++++++++++++
>>>   drivers/base/memory.c                          | 13 +++++++++++++
>>>   include/linux/kexec.h                          |  8 ++++++++
>>>   5 files changed, 61 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst 
>>> b/Documentation/admin-guide/mm/memory-hotplug.rst
>>> index 1b02fe5807cc..eb99d79223a3 100644
>>> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
>>> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
>>> @@ -291,6 +291,14 @@ The following files are currently defined:
>>>                  Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>>>                  kernel configuration option.
>>>   ``uevent``           read-write: generic udev file for device subsystems.
>>> +``crash_hotplug``      read-only: when changes to the system memory map
>>> +               occur due to hot un/plug of memory, this file contains
>>> +               '1' if the kernel updates the kdump capture kernel memory
>>> +               map itself (via elfcorehdr), or '0' if userspace must update
>>> +               the kdump capture kernel memory map.
>>> +
>>> +               Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
>>> +               configuration option.
>>>   ====================== =========================================================
>>>   .. note::
>>> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
>>> index f75778d37488..0c8dc3fe5f94 100644
>>> --- a/Documentation/core-api/cpu_hotplug.rst
>>> +++ b/Documentation/core-api/cpu_hotplug.rst
>>> @@ -750,6 +750,24 @@ will receive all events. A script like::
>>>   can process the event further.
>>> +When changes to the CPUs in the system occur, the sysfs file
>>> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
>>> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
>>> +or '0' if userspace must update the kdump capture kernel list of CPUs.
>>> +
>>> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
>>> +option.
>>> +
>>> +To skip userspace processing of CPU hot un/plug events for kdump
>>> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
>>> +file can be used in a udev rule as follows:
>>> +
>>> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>> +
>>> +For a cpu hot un/plug event, if the architecture supports kernel updates
>>> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
>>> +the unload-then-reload of the kdump capture kernel.
>>> +
>>>   Kernel Inline Documentations Reference
>>>   ======================================
>>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>>> index c1815b9dae68..06a0c22b37b8 100644
>>> --- a/drivers/base/cpu.c
>>> +++ b/drivers/base/cpu.c
>>> @@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>>>   static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>>>   #endif
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +#include <linux/kexec.h>
>>> +static ssize_t crash_hotplug_show(struct device *dev,
>>> +                     struct device_attribute *attr,
>>> +                     char *buf)
>>> +{
>>> +    return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
>>> +}
>>> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
>>> +#endif
>>> +
>>>   static void cpu_device_release(struct device *dev)
>>>   {
>>>       /*
>>> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>>>   #ifdef CONFIG_NO_HZ_FULL
>>>       &dev_attr_nohz_full.attr,
>>>   #endif
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +    &dev_attr_crash_hotplug.attr,
>>> +#endif
>>>   #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>>>       &dev_attr_modalias.attr,
>>>   #endif
>>> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
>>> index b456ac213610..24b8ef4c830c 100644
>>> --- a/drivers/base/memory.c
>>> +++ b/drivers/base/memory.c
>>> @@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>>>   static DEVICE_ATTR_RW(auto_online_blocks);
>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>> +#include <linux/kexec.h>
>>> +static ssize_t crash_hotplug_show(struct device *dev,
>>> +                       struct device_attribute *attr, char *buf)
>>> +{
>>> +    return sprintf(buf, "%d\n", crash_hotplug_memory_support());
>>> +}
>>
>> This sysfs file has to be documented in Documentation/ABI/ right?
> 
> I will add these entries.
> 
>>
>> And did you use checkpatch?  It should have told you to use sysfs_emit()
>> instead...
> I did use checkpatch, and it did not reveal that.
> 
> [root@localhost linux]# ./scripts/checkpatch.pl --patch 
> ../v23/0004-crash-memory-and-CPU-hotplug-sysfs-attributes.patch
> total: 0 errors, 0 warnings, 103 lines checked
> 
> ../v23/0004-crash-memory-and-CPU-hotplug-sysfs-attributes.patch has no obvious style problems and is 
> ready for submission.
> 
> This is not the first time it's been suggested to me that checkpatch should have caught a problem; 
> is there a different invocation than what I'm doing?
> 
>>
>>> +static DEVICE_ATTR_RO(crash_hotplug);
>>> +#endif
>>
>> All of these #ifdefs should all be removed and instead use the
>> is_visible() callback to determine if the attribute is shown or not,
>> using the IS_ENABLED() test in the function.
> 
> ok, I'll correct this.

I've been examining drivers/base/cacheinfo.c as a template for how to remove the
#ifdefs and use the is_visible() callback for the drivers/base/cpu|memory.c files.

I'm attempting to apply this technique to drivers/base/cpu.c. In this file, there
are features that are compiled in/out based on the CONFIG settings, for example 
CONFIG_ARCH_CPU_PROBE_RELEASE. My attempts at applying the technique thus far have
resulted in link-time errors for missing symbols, ie. arch_cpu_probe() and
arch_cpu_release().

As I understand it, to use IS_ENABLED(XYZ) to guard-band conditional code, the contents
of that code still needs to be compile-able (eg. no references to struct members with
surrounding #ifdef CONFIG_XYZ) and link-able (eg. any called functions must also be
compiled).

Given my understanding of the request and IS_ENABLED, I'm not seeing a path forward.
I'm thinking the approach works well in cacheinfo.c for example because cache info is
always compiled-in.

I suspect I am misunderstanding, and would appreciate a pointer/guidance.

Thanks!
eric


> 
> Thank you for looking at this!
> eric
> 
>>
>> thanks,
>>
>> greg k-h
